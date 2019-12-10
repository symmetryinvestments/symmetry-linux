module symmetry.linux.util;
import symmetry.sildoc;

version(Posix):

void checkedWrite(T)(int fd, T value)
{
	import core.sys.posix.unistd: write;
	checkCondition!write(value.sizeof,fd,&value,value.sizeof);
}

T checkedRead(T)(int fd)
{
	import core.sys.posix.unistd: read;
	T ret;
	checkCondition!read(T.sizeof,fd,&ret, T.sizeof);
	return ret;
}


void checkCondition(alias fn,U, T...)(U condition, T args)
{
	import std.meta : staticMap;
	import std.string : join;
	import std.array : array;
	import std.exception : enforce;
	import std.format : format;
	import std.conv : to;
	import std.string : fromStringz, toStringz;
	import core.stdc.errno;
	import core.stdc.string:strerror;


	enforce(fn(args)==condition,
			format!"failed to call %s - error %s(%s)"
			(__traits(identifier,fn),
			 strerror(errno).fromStringz,errno));
}

void check(alias fn,T...)(T args)
{
	import std.exception : enforce;
	import std.format : format;
	import std.conv : to;
	import std.string : fromStringz, toStringz;
	import core.stdc.errno;
	import core.stdc.string:strerror;

	enforce(fn(args)==0,
			format!"failed to call %s - error %s(%s)"
			(__traits(identifier,fn),strerror(errno).fromStringz,errno));
}

