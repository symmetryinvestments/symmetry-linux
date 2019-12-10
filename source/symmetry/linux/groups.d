module symmetry.linux.groups;
import symmetry.sildoc;

version(Posix):
import symmetry.linux.util;
import core.sys.posix.sys.types: pid_t,uid_t,gid_t;

void setGroups(gid_t[] list)
{
	import core.sys.linux.unistd;
	check!setgroups(list.length,list.ptr);
}

gid_t[] getGroups()
{
	import std.string : fromStringz, toStringz;
	import std.conv : to;
	import core.sys.linux.unistd : getgroups;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	import std.exception : enforce;
	import std.format : format;

	gid_t[4096] list;
	auto numGroups = getgroups(4096,list.ptr);
	enforce(numGroups!=-1,
			format!"failed to getgroups - error %s(%s)"
			(strerror(errno).fromStringz,errno));
	return list[0 .. numGroups].dup;
}

void setRealGroupID(gid_t realGroupID, gid_t effectiveGroupID, gid_t savedSetGroupID)
{
	import std.string : fromStringz, toStringz;
	import std.conv : to;
	//import core.sys.posix.unistd : setresgid;
	import core.sys.posix.unistd : setregid;
	import core.stdc.errno;
	import core.stdc.string:strerror;

	//FIXME?
	check!setregid(realGroupID, effectiveGroupID);
	//check!setresgid(realGroupID, effectiveGroupID, savedSetGroupID);
}
