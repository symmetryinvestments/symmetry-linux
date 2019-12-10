module core.sys.linux.seccomp;
import std.conv : to;

/* Valid values for seccomp.mode and prctl(PR_SET_SECCOMP, <mode>) */
enum SECCOMP_MODE_DISABLED	=0; /* seccomp is not in use. */
enum SECCOMP_MODE_STRICT	= 1; /* uses hard-coded filter. */
enum SECCOMP_MODE_FILTER	= 2;  /* uses user-supplied filter. */

/* Valid operations for seccomp syscall. */
enum SECCOMP_SET_MODE_STRICT		= 0;
enum SECCOMP_SET_MODE_FILTER		= 1;
enum SECCOMP_GET_ACTION_AVAIL		= 2;
enum SECCOMP_GET_NOTIF_SIZES		= 3;

/* Valid flags for SECCOMP_SET_MODE_FILTER */
enum ulong SECCOMP_FILTER_FLAG_TSYNC			= (1UL << 0);
enum ulong SECCOMP_FILTER_FLAG_LOG			= (1UL << 1);
enum ulong SECCOMP_FILTER_FLAG_SPEC_ALLOW		= (1UL << 2);
enum ulong SECCOMP_FILTER_FLAG_NEW_LISTENER	= (1UL << 3);

/*
 * All BPF programs must return a 32-bit value.
 * The bottom 16-bits are for optional return data.
 * The upper 16-bits are ordered from least permissive values to most,
 * as a signed value (so 0x8000000 is negative).
 *
 * The ordering ensures that a min_t() over composed return values always
 * selects the least permissive choice.
 */
enum SECCOMP_RET_KILL_PROCESS = "80000000".to!uint(16); /* kill the process */
enum SECCOMP_RET_KILL_THREAD	 = "00000000".to!uint(16); /* kill the thread */
enum SECCOMP_RET_KILL	 = SECCOMP_RET_KILL_THREAD;
enum SECCOMP_RET_TRAP	 = "00030000".to!uint(16); /* disallow and force a SIGSYS */
enum SECCOMP_RET_ERRNO	 = "00050000".to!uint(16); /* returns an errno */
enum SECCOMP_RET_USER_NOTIF	 = "7fc00000".to!uint(16); /* notifies userspace */
enum SECCOMP_RET_TRACE	 = "7ff00000".to!uint(16); /* pass to a tracer or disallow */
enum SECCOMP_RET_LOG		 = "7ffc0000".to!uint(16); /* allow after logging */
enum SECCOMP_RET_ALLOW	 = "7fff0000".to!uint(16); /* allow */

/* Masks for the return value sections. */
enum SECCOMP_RET_ACTION_FULL	= "ffff0000".to!uint(16);
enum SECCOMP_RET_ACTION	= "7fff0000".to!uint(16);
enum SECCOMP_RET_DATA	= "0000ffff".to!uint(16);

/**
 * struct seccomp_data - the format the BPF program executes over.
 * @nr: the system call number
 * @arch: indicates system call convention as an AUDIT_ARCH_* value
 *        as defined in <linux/audit.h>.
 * @instruction_pointer: at the time of the system call.
 * @args: up to 6 system call arguments always stored as 64-bit values
 *        regardless of the architecture.
 */
struct seccomp_data
{
	int nr;
	uint arch;
	ulong instruction_pointer;
	ulong[6] args;
}

struct seccomp_notif_sizes
{
	ushort seccomp_notif;
	ushort seccomp_notif_resp;
	ushort seccomp_data;
}

struct seccomp_notif
{
	ulong id;
	uint pid;
	uint flags;
	seccomp_data data;
}

struct seccomp_notif_resp
{
	ulong id;
	ulong val;
	int error;
	uint flags;
}

enum SECCOMP_IOC_MAGIC		= '!';
enum SECCOMP_IO(nr)			= _IO(SECCOMP_IOC_MAGIC, nr);
enum SECCOMP_IOR(nr, type)		= _IOR(SECCOMP_IOC_MAGIC, nr, type);
enum SECCOMP_IOW(nr, type)	=	_IOW(SECCOMP_IOC_MAGIC, nr, type);
enum SECCOMP_IOWR(nr, type)	=	_IOWR(SECCOMP_IOC_MAGIC, nr, type);

/* Flags for seccomp notification fd ioctl. */
//enum SECCOMP_IOCTL_NOTIF_RECV	= SECCOMP_IOWR(0, seccomp_notif);
//enum SECCOMP_IOCTL_NOTIF_SEND	= SECCOMP_IOWR(1,	seccomp_notif_resp);
//enum SECCOMP_IOCTL_NOTIF_ID_VALID= 	SECCOMP_IOR(2, ulong);
