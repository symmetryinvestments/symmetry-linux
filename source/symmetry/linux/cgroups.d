module symmetry.linux.cgroups;
import symmetry.sildoc;

version(Posix):

import symmetry.linux.file : fdopen, fdclose;

struct CGroupSetting
{
	string name;
	string value;
}

alias CGroupSettings = CGroupSetting[];
alias CGroups = CGroupSettings[string];

enum CGroupSetting addToTasks = {
	name: "tasks",
};

struct ChildConfig
{
	int fd;
	string mountDir;
	string hostname;
	int uid;
	int gid;
	CGroups cGroups;
	int rlimitMax = 64;
	int rlimitCur = 64;
}

enum MEMORY = "1073741824";
enum SHARES = "256";
enum PIDS = "64";
enum WEIGHT = "10";

CGroups defaultCGroups = [
	"memory":	[		CGroupSetting("memory.limit_in_bytes",MEMORY),
					CGroupSetting("memory.kmem.limit_in_bytes",MEMORY),
					addToTasks,
			],

	"cpu":		[
					CGroupSetting("cpu.shares",SHARES),
					addToTasks,
			],
	
	"pids":		[
					CGroupSetting("pids.max",PIDS),
					addToTasks,
			],

	"blkio":	[
					CGroupSetting("blkio.weight",PIDS),
					addToTasks,
			],
];


void setCGroups(in ChildConfig config)
{
	import std.stdio: stderr,writeln,writefln;
	import std.exception : enforce;
	import std.format : format;
	import std.file : mkdir;
	import core.sys.posix.unistd : write, close;
	import core.sys.posix.fcntl : O_WRONLY;
	import core.sys.posix.sys.resource: setrlimit, rlimit, RLIMIT_NOFILE;
	import std.string : fromStringz, toStringz;

	version(Trace) stderr.writeln("=> setting cgroups...");

	foreach(cGroup; cGroups.byKeyValue)
	{
		version(Trace) stderr.writefln("%s...", cGroup.key);
		string dir = format!"/sys/fs/cgroup/%s/%s"(cGroup.key, config.hostname);
		mkdir(dir); // FIXME , S_IRUSR | S_IWUSR | S_IXUSR);

		foreach(cGroupSetting; cGroup.value)
		{
			auto path = format!"%s/%s"(dir,cGroupSetting.name);
			auto fd = fdopen(path,O_WRONLY);
			enforce(fd !=-1, format!"opening %s failed"(path));
			{
				scope(exit) close(fd);
				auto result = write(fd, cGroupSetting.value.toStringz,cGroupSetting.value.length);
				enforce(result != -1,format!"writing to %s failed"(path));
			}
		}
	}
	version(Trace) stderr.writeln("done.");
	version(Trace) stderr.writeln("=> setting rlimit...");
	rlimit lim = {
		rlim_max: config.rlimitMax,
		rlim_cur: config.rlimitCur,
	};
	enforce(!setrlimit(RLIMIT_NOFILE, &lim), format!"failed");
	version(Trace) stderr.writeln("done");
}

void freeCGroups(in ChildConfig config)
{
	import std.exception : enforce;
	import std.string : fromStringz, toStringz;
	import std.stdio : stderr,writeln,writefln;
	import std.format : format;
	import core.sys.posix.unistd : write, close;
	import core.sys.posix.fcntl: open, O_WRONLY;
	import std.file: rmdir;
	version(Trace) stderr.writeln("=> cleaning cgroups...");
	foreach(cGroup; cGroups.byKeyValue)
	{
		int task_fd = 0;
		string dir = format!"/sys/fs/cgroup/%s/%s"(cGroup.key,config.hostname);
		string task = format!"/sys/fs/cgroup/%s/tasks"(cGroup.key);
		task_fd = open(task.toStringz, O_WRONLY);
		enforce(task_fd !=-1, format!"opening %s failed:"(task));
		{
			scope(exit)
				close(task_fd);
			auto result = write(task_fd, "0".ptr, 2);
			enforce(result !=-1, format!"writing to %s failed"(task));
		}
		rmdir(dir);
	}
	version(Trace) stderr.writeln("freeResources done");
}
