module symmetry.linux.process;
import symmetry.sildoc;

version(Posix):


extern(C) @nogc nothrow
{
    import std.conv : to;
	int clone(int function(void*), void* child_stack, int flags, void* arg, ...);
	int unshare(int flags) @trusted;

	enum CLONE_VM = 		0x100;
	enum CLONE_FS = 		0x200;
	enum CLONE_FILES = 		0x400;
	enum CLONE_SIGHAND = 	0x800;
	enum CLONE_PTRACE  = "00002000".to!int(16);
	enum CLONE_VFORK   = "00004000".to!int(16);
	enum CLONE_PARENT  = "00008000".to!int(16);
	enum CLONE_THREAD  = "00010000".to!int(16);
	enum CLONE_NEWNS   = "00020000".to!int(16);
	enum CLONE_SYSVSEM = "00040000".to!int(16);
	enum CLONE_SETTLS  = "00080000".to!int(16);
	enum CLONE_PARENT_SETTID  = "00100000".to!int(16);
	enum CLONE_CHILD_CLEARTID = "00200000".to!int(16);
	enum CLONE_DETACHED       = "00400000".to!int(16);
	enum CLONE_UNTRACED       = "00800000".to!int(16);
	enum CLONE_CHILD_SETTID   = "01000000".to!int(16);
	enum CLONE_NEWCGROUP      = "02000000".to!int(16);
	enum CLONE_NEWUTS         = "04000000".to!int(16);
	enum CLONE_NEWIPC         = "08000000".to!int(16);
	enum CLONE_NEWUSER        = "10000000".to!int(16);
	enum CLONE_NEWPID         = "20000000".to!int(16);
	enum CLONE_NEWNET         = "40000000".to!int(16);
	enum CLONE_IO             = "80000000".to!uint(16);
}


enum CloneFlag
{
	none = 0,

	@SILdoc("set if open files shared between processes")
	files = CLONE_FILES,

	@SILdoc("set if file system info shared between processes")
	fs = CLONE_FS,

	@SILdoc("set if signal handlers and blocked signals shared")
	sigHand = CLONE_SIGHAND,

	@SILdoc("set if VM shared between processes")
	vm = CLONE_VM,

	@SILdoc("set if we want to let tracing continue on the child too")
	ptrace = CLONE_PTRACE,

	@SILdoc("set if the parent wants the child to wake it up on mm_release")
  	vfork = CLONE_VFORK,

	@SILdoc("set if we want to have the same parent as the cloner")
	parent = CLONE_PARENT,

	@SILdoc("Same thread group?")
	thread = CLONE_THREAD,

	@SILdoc("New mount namespace group")
	newMountNamespace = CLONE_NEWNS,

	@SILdoc("share system V SEM_UNDO semantics")
	sysVSemantics = CLONE_SYSVSEM,

	@SILdoc("create a new TLS for the child")
	setTLS = CLONE_SETTLS,

	@SILdoc("set the TID in the parent")
	parentSetTID = CLONE_PARENT_SETTID,

	@SILdoc("clear the TID in the child")
	childClearTID = CLONE_CHILD_CLEARTID,
	
	@SILdoc("Unused, ignored")
	detached = CLONE_DETACHED,

	@SILdoc("set if the tracing process can't force CLONE_PTRACE on this clone")
	untraced = CLONE_UNTRACED,

	@SILdoc("set the TID in the child")
	childSetTID = CLONE_CHILD_SETTID,

	@SILdoc("New cgroup namespace")
	newCGroup = CLONE_NEWCGROUP,

	@SILdoc("New utsname namespace")
	newUTS = CLONE_NEWUTS,

	@SILdoc("New ipc namespace")
	newIPC = CLONE_NEWIPC,

	@SILdoc("New user namespace")
	newUser = CLONE_NEWUSER,

	@SILdoc("New pid namespace")
	newPid = CLONE_NEWPID,

	@SILdoc("New network namespace")
	newNet = CLONE_NEWNET,

	@SILdoc("Clone io context")
	io = CLONE_IO,
}

CloneFlag[] cloneFlagsFromPosix(int flags)
{
	import std.traits : EnumMembers;
	CloneFlag[] ret;
	static foreach(M;EnumMembers!CloneFlag)
	{
		if (flags & M)
			ret ~= M;
	}
	return ret;
}

string[] cloneFlags()
{
    import std.traits : EnumMembers;
    import std.conv : to;
    import std.array: Appender;
    Appender!(string[]) ret;
    static foreach(E;EnumMembers!CloneFlag)
        ret.put(E.to!string);
    return ret.data;
}

CloneFlag cloneFlag(string flagName)
{
    import std.traits : EnumMembers;
    import std.conv : to;
    static foreach(E;EnumMembers!CloneFlag)
    {
        if (E.to!string == flagName)
            return E;
    }
    throw new Exception ("unknown clone flag: " ~flagName);
}

int posixCloneFlags(CloneFlag[] cloneFlags)
{
	import std.conv : to;
	int i;
	foreach(flag;cloneFlags)
	{
		i |= flag.to!int;
	}
	return i;
}


