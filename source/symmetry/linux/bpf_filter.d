module symmetry.linux.bpf_filter;

version(Posix):
import symmetry.sildoc;
	
struct SockFilter
{
	ushort opCode;
	ubyte jumpDisplacementTrue;
	ubyte jumpDisplacementFalse;
	uint operand;
}

struct SockFilterProgram
{
	int len;
	SockFilter* filter;
}

extern(C) @nogc nothrow int prctl(int option, ulong arg2, ulong arg3, ulong arg4, ulong arg5);


void setSecCompModeFilter(SockFilter[] filterProgram)
{
	import symmetry.linux.seccomp;
	import core.sys.posix.sys.capabilities;
	import core.sys.linux.sys.capability;
	import core.sys.linux.sys.prctl;
	import core.sys.linux.seccomp;
	import std.exception : enforce;
	import std.format : format;
	import std.conv : to;
	SockFilterProgram prog = {
		len : filterProgram.length.to!int,
		filter : filterProgram.ptr,
	};
	enforce(!prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, cast(ulong)&prog,0,0),format!"prctl failed when setting to BPF filter mode");
}

void setNoNewPrivileges()
{
	import core.sys.posix.sys.capabilities;
	import core.sys.linux.sys.capability;
	import core.sys.linux.sys.prctl;
	import core.sys.linux.seccomp;
	import std.exception : enforce;
	import std.format : format;
	enforce(!prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0),format!"prctl failed when dropping ability to add new capabilities");
}

