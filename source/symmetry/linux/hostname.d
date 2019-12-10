module symmetry.linux.hostname;
import symmetry.sildoc;

version(Posix):


extern(C) @nogc nothrow int sethostname(const(char)* name, size_t len);

void setHostName(string hostName)
{
	import std.exception : enforce;
	import std.format : format;
	import std.string : toStringz,fromStringz;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	auto ret = sethostname(hostName.toStringz,hostName.length);
	enforce(ret == 0, format!"error %s(%s) setting hostname to %s"(strerror(errno).fromStringz,errno,hostName));
}

