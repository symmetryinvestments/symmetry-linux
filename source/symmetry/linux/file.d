module symmetry.linux.file;
import symmetry.sildoc;

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



int[] fnPipe()
{
	import core.sys.posix.unistd: posix_pipe=pipe;
	import core.stdc.errno;
	import core.stdc.string:strerror;
	import std.string:fromStringz,toStringz;
	import std.exception: enforce;
	import std.format: format;

	int[2] fd;
	auto result = posix_pipe(fd);
	enforce(result >=0, format!"error %s (%s) for pipe"(errno,strerror(errno).fromStringz));
	return fd.dup;
}


/// Returns true on success, or false if there was an error
// https://stackoverflow.com/questions/1543466/how-do-i-change-a-tcp-socket-to-be-non-blocking
bool setSocketBlockingEnabled(int fd, bool blocking)
{
	import core.sys.posix.fcntl : fcntl, F_GETFL, F_SETFL, O_NONBLOCK;
	if (fd < 0) return false;

	int flags = fcntl(fd, F_GETFL, 0);
	if (flags == -1) return false;
	flags = blocking ? (flags & ~O_NONBLOCK) : (flags | O_NONBLOCK);
	return fcntl(fd, F_SETFL, flags) == 0;
}

