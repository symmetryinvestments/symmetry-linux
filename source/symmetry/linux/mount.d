module symmetry.linux.mount;
import symmetry.sildoc;

version(Posix):

import core.sys.linux.mount : MountType;
@SILdoc("mount a filesystem")
void fnMount(string specialFile, string directory, string filesystemType, MountType[] mountFlags=[], string data = "")
{
	import std.string: toStringz, fromStringz;
	import core.sys.linux.mount;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	import std.exception : enforce;
	import std.format : format;

	auto special_file = (specialFile.length == 0) ? null : specialFile.toStringz;
	auto dir = (directory.length ==0) ? null : directory.toStringz;
	auto fstype = (filesystemType.length == 0) ? null : filesystemType.toStringz;
	ulong rwflag;
	foreach(flag;mountFlags)
		rwflag |= flag;

	auto result = mount(special_file, dir,fstype,rwflag,(data.length == 0) ? null : cast(void*)data.toStringz);
	enforce(result == 0, format!`mount(specialFile:"%s", directory:"%s", filesystemType: "%s", mountFlags: %s, data: (%s)) failed with error %s(%s)`(specialFile,directory,filesystemType,mountFlags,(data.length > 0) ? format!"%s bytes"(data.length) : "empty",errno,strerror(errno).fromStringz));
}

import core.sys.linux.mount : UmountFlag;
@SILdoc("unmount a filesystem")
void unmount(string specialFile, UmountFlag[] umountFlags = [])
{
	import std.string: toStringz, fromStringz;
	import core.sys.linux.mount;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	import std.exception : enforce;
	import std.format : format;

	int result;
	if (umountFlags.length == 0)
	{
		result = umount(specialFile.toStringz);
	}
	else
	{
		int flags;
		foreach(flag;umountFlags)
			flags |= flag;
		result = umount2(specialFile.toStringz,flags);
	}
	enforce(result == 0, format!`unmount(specialFile:"%s", umountFlags: %s) failed with error %s(%s)`(specialFile,umountFlags,errno,strerror(errno).fromStringz));
}


