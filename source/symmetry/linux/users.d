module symmetry.linux.users;
import symmetry.sildoc;

version(Posix):
import symmetry.linux.util;
import core.sys.posix.sys.types: pid_t,uid_t,gid_t;

enum USERNS_OFFSET = 10000;
enum USERNS_COUNT = 2000;

void childUserIDMap(pid_t childPID, int fd)
{
	import std.format : format;
	static import std.file;

	int uidMap = 0;
	bool hasUserNameSpace = checkedRead!bool(fd);
	if (hasUserNameSpace)
	{
		foreach(entry;	["uid_map","gid_map"]	)
		{
			auto name = format!"/proc/%s/%s"(childPID,entry);
			std.file.write(name,format!"0 %s %s\n"(USERNS_OFFSET, USERNS_COUNT));
		}
	}
}

void setRealUserID(uid_t realUserID, uid_t effectiveUserID, uid_t savedSetUserID)
{
	import std.string : fromStringz, toStringz;
	import std.conv : to;
	import core.sys.posix.unistd : setreuid;
//	import core.sys.posix.unistd : setresuid;
	import core.stdc.errno;
	import core.stdc.string:strerror;

	//FIXME?
	check!setreuid(realUserID, effectiveUserID);
	//check!setresuid(realUserID, effectiveUserID, savedSetUserID);
}

