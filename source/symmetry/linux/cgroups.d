module symmetry.linux.cgroups;
import symmetry.sildoc;

version(Posix):

import symmetry.linux.file : fdopen, fdclose;

struct ChildConfig
{
	int fd;
	string mountDir;
	string hostname;
	int uid;
	int gid;
}



enum MEMORY = "1073741824";
enum SHARES = "256";
enum PIDS = "64";
enum WEIGHT = "10";
enum FD_COUNT = 64;

struct CGroupSetting
{
	string name;
	string value;
}

struct CGroupControl
{
	string control;
	CGroupSetting[] settings;
}

enum CGroupSetting addToTasks = {
	name: "tasks",
};


CGroupControl[] cGroups = [
	CGroupControl("memory", [
					CGroupSetting("memory.limit_in_bytes",MEMORY),
					CGroupSetting("memory.kmem.limit_in_bytes",MEMORY),
					addToTasks,
	]),

	CGroupControl("cpu", [
					CGroupSetting("cpu.shares",SHARES),
					addToTasks,
	]),
	
	CGroupControl("pids", [
					CGroupSetting("pids.max",PIDS),
					addToTasks,
	]),

	CGroupControl("blkio", [
					CGroupSetting("blkio.weight",PIDS),
					addToTasks,
	]),
];

void resources(ChildConfig config)
{
	import std.stdio: stderr,writeln,writefln;
	import std.exception : enforce;
	import std.format : format;
	import std.file : mkdir;
	import core.sys.posix.unistd : write, close;
	import core.sys.posix.fcntl : O_WRONLY;
	import core.sys.posix.sys.resource: setrlimit, rlimit, RLIMIT_NOFILE;
	import std.string : fromStringz, toStringz;

	stderr.writeln("=> setting cgroups...");

	foreach(cGroup; cGroups)
	{
		stderr.writefln("%s...", cGroup.control);
		string dir = format!"/sys/fs/cgroup/%s/%s"(cGroup.control, config.hostname);
		mkdir(dir); // FIXME , S_IRUSR | S_IWUSR | S_IXUSR);

		foreach(cGroupSetting; cGroup.settings)
		{
			auto path = format!"%s/%s"(dir,cGroupSetting.name);
			auto fd = fdopen(path,O_WRONLY);
			enforce(fd !=-1, format!"opening %s failed"(path));
			auto result = write(fd, cGroupSetting.value.toStringz,cGroupSetting.value.length);
			enforce(result != -1,format!"writing to %s failed"(path));
			close(fd);
		}
	}
	stderr.writeln("done.");
	stderr.writeln("=> setting rlimit...");
	rlimit lim = {
		rlim_max: FD_COUNT,
		rlim_cur: FD_COUNT,
	};
	enforce(!setrlimit(RLIMIT_NOFILE, &lim), format!"failed");
	stderr.writeln("done");
}

void freeResources(ChildConfig config)
{
	import std.exception : enforce;
	import std.string : fromStringz, toStringz;
	import std.stdio : stderr,writeln,writefln;
	import std.format : format;
	import core.sys.posix.unistd : write, close;
	import core.sys.posix.fcntl: open, O_WRONLY;
	import std.file: rmdir;
	stderr.writeln("=> cleaning cgroups...");
	foreach(cGroup; cGroups)
	{
		int task_fd = 0;
		string dir = format!"/sys/fs/cgroup/%s/%s"(cGroup.control,config.hostname);
		string task = format!"/sys/fs/cgroup/%s/tasks"(cGroup.control);
		task_fd = open(task.toStringz, O_WRONLY);
		enforce(task_fd !=-1, format!"opening %s failed:"(task));
		scope(failure)
			close(task_fd);
		auto result = write(task_fd, "0".ptr, 2);
		enforce(result !=-1, format!"writing to %s failed"(task));
		close(task_fd);
		rmdir(dir);
	}
	stderr.writeln("done");
}
