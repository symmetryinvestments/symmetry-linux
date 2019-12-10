module symmetry.linux.file;
import symmetry.linux.sildoc;

version(Posix):

int fdopen(string s, int mode)
{
	import core.sys.posix.fcntl: posix_open = open;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	import std.string:fromStringz,toStringz;
	import std.exception: enforce;
	import std.format: format;
	auto result = posix_open(s.toStringz,mode);
	enforce(result != -1, format!"error %s (%s) opening %s"(strerror(errno).fromStringz,errno,s));
	return result;
} 

void fdclose(int fd)
{
	import core.sys.posix.unistd: posix_close = close;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	import std.string:fromStringz,toStringz;
	import std.exception: enforce;
	import std.format: format;
	auto result = posix_close(fd);
	enforce(result != -1, format!"error %s (%s) closing file %s"(strerror(errno).fromStringz,errno,fd));
}


