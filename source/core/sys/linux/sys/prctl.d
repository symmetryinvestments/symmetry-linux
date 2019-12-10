module core.sys.linux.sys.prctl;
import std.conv : hexString;

/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

/* Values to pass as first argument to prctl() */

enum PR_SET_PDEATHSIG  = 1;  /* Second arg is a signal */
enum PR_GET_PDEATHSIG  = 2;  /* Second arg is a ptr to return the signal */

/* Get/set current->mm->dumpable */
enum PR_GET_DUMPABLE   = 3;
enum PR_SET_DUMPABLE   = 4;

/* Get/set unaligned access control bits (if meaningful) */
enum PR_GET_UNALIGN	  = 5;
enum PR_SET_UNALIGN	  = 6;
enum PR_UNALIGN_NOPRINT	= 1;	/* silently fix up unaligned user accesses */
enum PR_UNALIGN_SIGBUS	= 2;	/* generate SIGBUS on unaligned user access */

/* Get/set whether or not to drop capabilities on setuid() away from
 * uid 0 (as per security/commoncap.c) */
enum PR_GET_KEEPCAPS   = 7;
enum PR_SET_KEEPCAPS   = 8;

/* Get/set floating-point emulation control bits (if meaningful) */
enum PR_GET_FPEMU = 9;
enum PR_SET_FPEMU = 10;
enum PR_FPEMU_NOPRINT	= 1;	/* silently emulate fp operations accesses */
enum PR_FPEMU_SIGFPE	= 2;	/* don't emulate fp operations, send SIGFPE instead */

/* Get/set floating-point exception mode (if meaningful) */
enum PR_GET_FPEXC	= 11;
enum PR_SET_FPEXC	= 12;
enum PR_FP_EXC_SW_ENABLE=	hexString!"80";	/* Use FPEXC for FP exception enables */
enum PR_FP_EXC_DIV		= hexString!"010000";	/* floating point divide by zero */
enum PR_FP_EXC_OVF		= hexString!"020000";	/* floating point overflow */
enum PR_FP_EXC_UND		= hexString!"040000";	/* floating point underflow */
enum PR_FP_EXC_RES		= hexString!"080000";	/* floating point inexact result */
enum PR_FP_EXC_INV		= hexString!"100000";	/* floating point invalid operation */
enum PR_FP_EXC_DISABLED	= 0;	/* FP exceptions disabled */
enum PR_FP_EXC_NONRECOV	= 1;	/* async non-recoverable exc. mode */
enum PR_FP_EXC_ASYNC	= 2;	/* async recoverable exception mode */
enum PR_FP_EXC_PRECISE	= 3;	/* precise exception mode */

/* Get/set whether we use statistical process timing or accurate timestamp
 * based process timing */
enum PR_GET_TIMING   = 13;
enum PR_SET_TIMING   = 14;
enum PR_TIMING_STATISTICAL  =0;       /* Normal, traditional,
                                                   statistical process timing */
enum PR_TIMING_TIMESTAMP= 1;       /* Accurate timestamp based
                                                   process timing */

enum PR_SET_NAME    = 15;		/* Set process name */
enum PR_GET_NAME    = 16;		/* Get process name */

/* Get/set process endian */
enum PR_GET_ENDIAN	= 19;
enum PR_SET_ENDIAN	= 20;
enum PR_ENDIAN_BIG		= 0;
enum PR_ENDIAN_LITTLE	= 1;	/* True little endian mode */
enum PR_ENDIAN_PPC_LITTLE	= 2;	/* "PowerPC" pseudo little endian */

/* Get/set process seccomp mode */
enum PR_GET_SECCOMP	= 21;
enum PR_SET_SECCOMP	= 22;

/* Get/set the capability bounding set (as per security/commoncap.c) */
enum PR_CAPBSET_READ = 23;
enum PR_CAPBSET_DROP = 24;

/* Get/set the process' ability to use the timestamp counter instruction */
enum PR_GET_TSC = 25;
enum PR_SET_TSC = 26;
enum PR_TSC_ENABLE		= 1;	/* allow the use of the timestamp counter */
enum PR_TSC_SIGSEGV		= 2;	/* throw a SIGSEGV instead of reading the TSC */

/* Get/set securebits (as per security/commoncap.c) */
enum PR_GET_SECUREBITS = 27;
enum PR_SET_SECUREBITS = 28;

/*
 * Get/set the timerslack as used by poll/select/nanosleep
 * A value of 0 means "use default"
 */
enum PR_SET_TIMERSLACK = 29;
enum PR_GET_TIMERSLACK = 30;

enum PR_TASK_PERF_EVENTS_DISABLE	= 31;
enum PR_TASK_PERF_EVENTS_ENABLE		= 32;

/*
 * Set early/late kill mode for hwpoison memory corruption.
 * This influences when the process gets killed on a memory corruption.
 */
enum PR_MCE_KILL	= 33;
enum PR_MCE_KILL_CLEAR   = 0;
enum PR_MCE_KILL_SET     = 1;

enum PR_MCE_KILL_LATE    = 0;
enum PR_MCE_KILL_EARLY   = 1;
enum PR_MCE_KILL_DEFAULT = 2;

enum PR_MCE_KILL_GET = 34;

/*
 * Tune up process memory map specifics.
 */
enum PR_SET_MM		= 35;
enum PR_SET_MM_START_CODE		= 1;
enum PR_SET_MM_END_CODE			= 2;
enum PR_SET_MM_START_DATA		= 3;
enum PR_SET_MM_END_DATA			= 4;
enum PR_SET_MM_START_STACK		= 5;
enum PR_SET_MM_START_BRK		= 6;
enum PR_SET_MM_BRK				= 7;
enum PR_SET_MM_ARG_START		= 8;
enum PR_SET_MM_ARG_END			= 9;
enum PR_SET_MM_ENV_START		= 10;
enum PR_SET_MM_ENV_END			= 11;
enum PR_SET_MM_AUXV				= 12;
enum PR_SET_MM_EXE_FILE			= 13;
enum PR_SET_MM_MAP				= 14;
enum PR_SET_MM_MAP_SIZE			= 15;

/*
 * This structure provides new memory descriptor
 * map which mostly modifies /proc/pid/stat[m]
 * output for a task. This mostly done in a
 * sake of checkpoint/restore functionality.
 */
alias __u64 = ulong;
alias __u32 = uint;

struct prctl_mm_map {
	__u64	start_code;		/* code section bounds */
	__u64	end_code;
	__u64	start_data;		/* data section bounds */
	__u64	end_data;
	__u64	start_brk;		/* heap for brk() syscall */
	__u64	brk;
	__u64	start_stack;		/* stack starts at */
	__u64	arg_start;		/* command line arguments bounds */
	__u64	arg_end;
	__u64	env_start;		/* environment variables bounds */
	__u64	env_end;
	__u64	*auxv;			/* auxiliary vector */
	__u32	auxv_size;		/* vector size */
	__u32	exe_fd;			/* /proc/$pid/exe link file */
};

/*
 * Set specific pid that is allowed to ptrace the current task.
 * A value of 0 mean "no process".
 */
enum PR_SET_PTRACER = hexString!"59616d61";
enum PR_SET_PTRACER_ANY = (cast(ulong)-1);

enum PR_SET_CHILD_SUBREAPER	= 36;
enum PR_GET_CHILD_SUBREAPER	= 37;

/*
 * If no_new_privs is set, then operations that grant new privileges (i.e.
 * execve) will either fail or not grant them.  This affects suid/sgid,
 * file capabilities, and LSMs.
 *
 * Operations that merely manipulate or drop existing privileges (setresuid,
 * capset, etc.) will still work.  Drop those privileges if you want them gone.
 *
 * Changing LSM security domain is considered a new privilege.  So, for example,
 * asking selinux for a specific new context (e.g. with runcon) will result
 * in execve returning -EPERM.
 *
 * See Documentation/userspace-api/no_new_privs.rst for more details.
 */
enum PR_SET_NO_NEW_PRIVS	= 38;
enum PR_GET_NO_NEW_PRIVS	= 39;

enum PR_GET_TID_ADDRESS	= 40;

enum PR_SET_THP_DISABLE	= 41;
enum PR_GET_THP_DISABLE	= 42;

/*
 * Tell the kernel to start/stop helping userspace manage bounds tables.
 */
enum PR_MPX_ENABLE_MANAGEMENT  = 43;
enum PR_MPX_DISABLE_MANAGEMENT = 44;

enum PR_SET_FP_MODE		= 45;
enum PR_GET_FP_MODE		= 46;
enum PR_FP_MODE_FR		= (1 << 0);	/* 64b FP registers */
enum PR_FP_MODE_FRE		= (1 << 1);	/* 32b compatibility */

/* Control the ambient capability set */
enum PR_CAP_AMBIENT			= 47;
enum PR_CAP_AMBIENT_IS_SET		= 1;
enum PR_CAP_AMBIENT_RAISE		= 2;
enum PR_CAP_AMBIENT_LOWER		= 3;
enum PR_CAP_AMBIENT_CLEAR_ALL	= 4;

/* arm64 Scalable Vector Extension controls */
/* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
enum PR_SVE_SET_VL		=	50;	/* set task vector length */
enum PR_SVE_SET_VL_ONEXEC=	(1 << 18); /* defer effect until exec */
enum PR_SVE_GET_VL			= 51;	/* get task vector length */
/* Bits common to PR_SVE_SET_VL and PR_SVE_GET_VL */
enum PR_SVE_VL_LEN_MASK		= hexString!"ffff";
enum PR_SVE_VL_INHERIT		= (1 << 17); /* inherit across exec */

/* Per task speculation control */
enum PR_GET_SPECULATION_CTRL		= 52;
enum PR_SET_SPECULATION_CTRL		= 53;
/* Speculation control variants */
enum PR_SPEC_STORE_BYPASS		= 0;
enum PR_SPEC_INDIRECT_BRANCH	= 1;

/* Return and control values for PR_SET/GET_SPECULATION_CTRL */
enum PR_SPEC_NOT_AFFECTED		= 0;
enum PR_SPEC_PRCTL			= (1UL << 0);
enum PR_SPEC_ENABLE			= (1UL << 1);
enum PR_SPEC_DISABLE		= (1UL << 2);
enum PR_SPEC_FORCE_DISABLE		= (1UL << 3);
enum PR_SPEC_DISABLE_NOEXEC		= (1UL << 4);

/* Reset arm64 pointer authentication keys */
enum PR_PAC_RESET_KEYS	= 54;
enum PR_PAC_APIAKEY			= (1UL << 0);
enum PR_PAC_APIBKEY			= (1UL << 1);
enum PR_PAC_APDAKEY			= (1UL << 2);
enum PR_PAC_APDBKEY			= (1UL << 3);
enum PR_PAC_APGAKEY			= (1UL << 4);
