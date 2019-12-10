module symmetry.linux.seccomp;
version(Posix):

import symmetry.linux.sildoc;

import std.conv : to;

extern(C) nothrow @nogc:

/**
 * Seccomp Library
 *
 * Copyright (c) 2012,2013 Red Hat <pmoore@redhat.com>
 * Author: Paul Moore <paul@paul-moore.com>
 */

/*
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of version 2.1 of the GNU Lesser General Public License as
 * published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
 * for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library; if not, see <http://www.gnu.org/licenses>.
 */


// #include <elf.h>
// #include <inttypes.h>
// #include <asm/unistd.h>
// #include <linux/audit.h>


/*
 * version information
 */

enum SCMP_VER_MAJOR	= 	2;
enum SCMP_VER_MINOR	=	4;
enum SCMP_VER_MICRO	=	1;

struct scmp_version
{
	uint major;
	uint minor;
	uint micro;
}

/*
 * types
 */

/**
 * Filter context/handle
 */
alias scmp_filter_ctx = void*;
alias scmp_filter_ctx_const = const(void)*;

/**
 * Filter attributes
 */
enum FilterAttribute
{
	min = 0,

	@SILdoc("default filter action")
	defaultAction = 1,

	@SILdoc("bad architecture action")
	badArchitectureAction = 2,
	
	@SILdoc("set NO_NEW_PRIVS on filter load")
	controlNoNewPrivileges = 3,

	@SILdoc("sync threads on filter load")
	controlSyncThreads = 4,

	@SILdoc("allow rules with a -1 syscall")
	apiTskip = 5,

	@SILdoc("log not-allowed actions")
	controlLog = 6,
	_SCMP_FLTATR_MAX,
}

/**
 * Comparison operators
 */
enum SecCompCompare
{
	min = 0,
	notEqual = 1,		/**< not equal */
	lessThan = 2,		/**< less than */
	lessThanEqual = 3,		/**< less than or equal */
	equal = 4,		/**< equal */
	greaterThanEqual = 5,		/**< greater than or equal */
	greaterThan = 6,		/**< greater than */
	maskedEquality = 7,		/**< masked equality */
	max,
}

/**
 * Argument datum
 */
alias scmp_datum_t= ulong;

/**
 * Argument / Value comparison definition
 */
struct SecCompArgCmp
{
	uint arg;	/**< argument number, starting at 0 */
	SecCompCompare op;	/**< the comparison op, e.g. SCMP_CMP_* */
	scmp_datum_t datum_a;
	scmp_datum_t datum_b;
}

/*
 * macros/defines
 */

/**
 * The native architecture token
 */
enum SCMP_ARCH_NATIVE	= 0;

/**
 * The x86 (32-bit) architecture token
 */
// enum SCMP_ARCH_X86		= AUDIT_ARCH_I386;

/**
 * The x86-64 (64-bit) architecture token
 */
//enum SCMP_ARCH_X86_64	= AUDIT_ARCH_X86_64;

/**
 * The x32 (32-bit x86_64) architecture token
 *
 * NOTE: this is different from the value used by the kernel because we need to
 * be able to distinguish between x32 and x86_64
 */
//enum SCMP_ARCH_X32		= (EM_X86_64|__AUDIT_ARCH_LE);

/**
 * The ARM architecture tokens
 */
//enum SCMP_ARCH_ARM		= AUDIT_ARCH_ARM;
/* AArch64 support for audit was merged in 3.17-rc1 */

/+
#ifndef AUDIT_ARCH_AARCH64
#ifndef EM_AARCH64
enum EM_AARCH64		183
#endif /* EM_AARCH64 */
enum AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
#endif /* AUDIT_ARCH_AARCH64 */
+/
//enum SCMP_ARCH_AARCH64	= AUDIT_ARCH_AARCH64;

/+
/**
 * The MIPS architecture tokens
 */
#ifndef __AUDIT_ARCH_CONVENTION_MIPS64_N32
enum __AUDIT_ARCH_CONVENTION_MIPS64_N32	0x20000000
#endif
#ifndef EM_MIPS
enum EM_MIPS			8
#endif
#ifndef AUDIT_ARCH_MIPS
enum AUDIT_ARCH_MIPS		(EM_MIPS)
#endif
#ifndef AUDIT_ARCH_MIPS64
enum AUDIT_ARCH_MIPS64	(EM_MIPS|__AUDIT_ARCH_64BIT)
#endif
+/


/+
/* MIPS64N32 support was merged in 3.15 */
#ifndef AUDIT_ARCH_MIPS64N32
enum AUDIT_ARCH_MIPS64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|\
				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
#endif
+/

/+
/* MIPSEL64N32 support was merged in 3.15 */
#ifndef AUDIT_ARCH_MIPSEL64N32
enum AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE|\
				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
#endif
+/

/+
enum SCMP_ARCH_MIPS		AUDIT_ARCH_MIPS
enum SCMP_ARCH_MIPS64	AUDIT_ARCH_MIPS64
enum SCMP_ARCH_MIPS64N32	AUDIT_ARCH_MIPS64N32
enum SCMP_ARCH_MIPSEL	AUDIT_ARCH_MIPSEL
enum SCMP_ARCH_MIPSEL64	AUDIT_ARCH_MIPSEL64
enum SCMP_ARCH_MIPSEL64N32	AUDIT_ARCH_MIPSEL64N32

/**
 * The PowerPC architecture tokens
 */
enum SCMP_ARCH_PPC		AUDIT_ARCH_PPC
enum SCMP_ARCH_PPC64		AUDIT_ARCH_PPC64
#ifndef AUDIT_ARCH_PPC64LE
enum AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
#endif
enum SCMP_ARCH_PPC64LE	AUDIT_ARCH_PPC64LE

/**
 * The S390 architecture tokens
 */
enum SCMP_ARCH_S390		AUDIT_ARCH_S390
enum SCMP_ARCH_S390X		AUDIT_ARCH_S390X

/**
 * The PA-RISC hppa architecture tokens
 */
enum SCMP_ARCH_PARISC	AUDIT_ARCH_PARISC
enum SCMP_ARCH_PARISC64	AUDIT_ARCH_PARISC64
+/
/+
/**
 * Convert a syscall name into the associated syscall number
 * @param x the syscall name
 */
enum SCMP_SYS(x)		(__NR_##x)

/* Helpers for the argument comparison macros, DO NOT USE directly */
enum _SCMP_VA_NUM_ARGS(...)	_SCMP_VA_NUM_ARGS_IMPL(__VA_ARGS__,2,1)
enum _SCMP_VA_NUM_ARGS_IMPL(_1,_2,N,...)	N
enum _SCMP_MACRO_DISPATCHER(func, ...) \
	_SCMP_MACRO_DISPATCHER_IMPL1(func, _SCMP_VA_NUM_ARGS(__VA_ARGS__))
enum _SCMP_MACRO_DISPATCHER_IMPL1(func, nargs) \
	_SCMP_MACRO_DISPATCHER_IMPL2(func, nargs)
enum _SCMP_MACRO_DISPATCHER_IMPL2(func, nargs) \
	func ## nargs
enum _SCMP_CMP32_1(x, y, z) \
	SCMP_CMP64(x, y, (uint)(z))
enum _SCMP_CMP32_2(x, y, z, q) \
	SCMP_CMP64(x, y, (uint)(z), (uint)(q))
+/
/**
 * Specify a 64-bit argument comparison struct for use in declaring rules
 * @param arg the argument number, starting at 0
 * @param op the comparison operator, e.g. SCMP_CMP_*
 * @param datum_a dependent on comparison
 * @param datum_b dependent on comparison, optional
 */
auto SCMP_CMP64(T...)(T args)
{
	return SecCompArgCmp(args);
}

// enum SCMP_CMP64(...)		((struct SecCompArgCmp){__VA_ARGS__})
alias SCMP_CMP		= SCMP_CMP64;

/+
/**
 * Specify a 32-bit argument comparison struct for use in declaring rules
 * @param arg the argument number, starting at 0
 * @param op the comparison operator, e.g. SCMP_CMP_*
 * @param datum_a dependent on comparison (32-bits)
 * @param datum_b dependent on comparison, optional (32-bits)
 */
//enum SCMP_CMP32(x, y, ...) \
//	_SCMP_MACRO_DISPATCHER(_SCMP_CMP32_, __VA_ARGS__)(x, y, __VA_ARGS__)
auto SCMP_CMP32(T...)(uint x, uint y, T args)
{
	return _SCMP_MACRO_DISPATCHER(_SCMP_CMP32_, __VA_ARGS__)(x, y, __VA_ARGS__)

/**
 * Specify a 64-bit argument comparison struct for argument 0
 */
enum SCMP_A0_64(...)		SCMP_CMP64(0, __VA_ARGS__)
enum SCMP_A0			SCMP_A0_64

/**
 * Specify a 32-bit argument comparison struct for argument 0
 */
enum SCMP_A0_32(x, ...)	SCMP_CMP32(0, x, __VA_ARGS__)

/**
 * Specify a 64-bit argument comparison struct for argument 1
 */
enum SCMP_A1_64(...)		SCMP_CMP64(1, __VA_ARGS__)
enum SCMP_A1			SCMP_A1_64

/**
 * Specify a 32-bit argument comparison struct for argument 1
 */
enum SCMP_A1_32(x, ...)	SCMP_CMP32(1, x, __VA_ARGS__)

/**
 * Specify a 64-bit argument comparison struct for argument 2
 */
enum SCMP_A2_64(...)		SCMP_CMP64(2, __VA_ARGS__)
enum SCMP_A2			SCMP_A2_64

/**
 * Specify a 32-bit argument comparison struct for argument 2
 */
enum SCMP_A2_32(x, ...)	SCMP_CMP32(2, x, __VA_ARGS__)

/**
 * Specify a 64-bit argument comparison struct for argument 3
 */
enum SCMP_A3_64(...)		SCMP_CMP64(3, __VA_ARGS__)
enum SCMP_A3			SCMP_A3_64

/**
 * Specify a 32-bit argument comparison struct for argument 3
 */
enum SCMP_A3_32(x, ...)	SCMP_CMP32(3, x, __VA_ARGS__)

/**
 * Specify a 64-bit argument comparison struct for argument 4
 */
enum SCMP_A4_64(...)		SCMP_CMP64(4, __VA_ARGS__)
enum SCMP_A4			SCMP_A4_64

/**
 * Specify a 32-bit argument comparison struct for argument 4
 */
enum SCMP_A4_32(x, ...)	SCMP_CMP32(4, x, __VA_ARGS__)

/**
 * Specify a 64-bit argument comparison struct for argument 5
 */
enum SCMP_A5_64(...)		SCMP_CMP64(5, __VA_ARGS__)
enum SCMP_A5			SCMP_A5_64

/**
 * Specify a 32-bit argument comparison struct for argument 5
 */
enum SCMP_A5_32(x, ...)	SCMP_CMP32(5, x, __VA_ARGS__)
+/
/*
 * seccomp actions
 */

/**
 * Kill the process
 */
enum SCMP_ACT_KILL_PROCESS	= "80000000".to!uint(16);
/**
 * Kill the thread
 */
enum SCMP_ACT_KILL_THREAD	= "00000000".to!uint(16);
/**
 * Kill the thread, defined for backward compatibility
 */
enum SCMP_ACT_KILL		= SCMP_ACT_KILL_THREAD;
/**
 * Throw a SIGSYS signal
 */
enum SCMP_ACT_TRAP		= "00030000".to!uint(16);
/**
 * Return the specified error code
 */
auto SCMP_ACT_ERRNO(uint x)
{
	enum exp1 = "00050000".to!uint(16);
   	enum exp2=  "0000ffff".to!uint(16);
	return exp1 | (x & exp2);
}

/**
 * Notify a tracing process with the specified value
 */
auto SCMP_ACT_TRACE(uint x)
{
	enum exp1 = "7ff00000".to!uint(16);
	enum exp2 = "0000ffff".to!uint(16);
	return exp1 | (x & exp2);
}

/**
 * Allow the syscall to be executed after the action has been logged
 */
enum SCMP_ACT_LOG		="7ffc0000".to!uint(16);
/**
 * Allow the syscall to be executed
 */
enum SCMP_ACT_ALLOW		= "7fff0000".to!uint(16);

enum SecCompAction
{
	@SILdoc("Kill the process")
	killProcess = SCMP_ACT_KILL_PROCESS,

	@SILdoc("Kill the thread")
	killThread = SCMP_ACT_KILL_THREAD,

	@SILdoc("Kill the thread, defined for backward compatibility")
	kill = SCMP_ACT_KILL_THREAD,

	@SILdoc("Throw a SIGSYS signal")
	trap = SCMP_ACT_TRAP,
	
	@SILdoc("Allow ths syscall to be executed after the action has been logged")
	log = SCMP_ACT_LOG,

	@SILdoc("Allow the syscall to be executed")
	allow = SCMP_ACT_ALLOW,
}

alias secCompActionReturnErrno = SCMP_ACT_ERRNO;
alias secCompActionTrace = SCMP_ACT_TRACE;

auto secCompActionFail()
{
	import core.stdc.errno : EPERM;
	return secCompActionReturnErrno(EPERM);
}

/*
 * functions
 */

@SILdoc("
Query the library version information:
	- This function returns a pointer to a populated scmp_version struct, the
	- caller does not need to free the structure when finished.")
const(scmp_version)* seccomp_version();

@SILdoc("
Query the library's level of API support
	This function returns an API level value indicating the current supported
	functionality.  It is important to note that this level of support is
	determined at runtime and therefore can change based on the running kernel
	and system configuration (e.g. any previously loaded seccomp filters).  This
	function can be called multiple times, but it only queries the system the
	first time it is called, the API level is cached and used in subsequent calls.

	The current API levels are described below:
		0 : reserved
		1 : base level
		2 : support for the SCMP_FLTATR_CTL_TSYNC filter attribute
		    uses the seccomp(2) syscall instead of the prctl(2) syscall
		3 : support for the SCMP_FLTATR_CTL_LOG filter attribute
			support for the SCMP_ACT_LOG action
			support for the SCMP_ACT_KILL_PROCESS action
")
uint seccomp_api_get();

 @SILdoc("
Set the library's level of API support
	This function forcibly sets the API level of the library at runtime.  Valid
	API levels are discussed in the description of the seccomp_api_get()
	function.  General use of this function is strongly discouraged.")
int seccomp_api_set(uint level);

@SILdoc("
Initialize the filter state
@param def_action the default filter action
	This function initializes the internal seccomp filter state and should
	be called before any other functions in this library to ensure the filter
	state is initialized.  Returns a filter context on success, NULL on failure.
")
scmp_filter_ctx seccomp_init(uint def_action);

/**
 * Reset the filter state
 * @param ctx the filter context
 * @param def_action the default filter action
 *
 * This function resets the given seccomp filter state and ensures the
 * filter state is reinitialized.  This function does not reset any seccomp
 * filters already loaded into the kernel.  Returns zero on success, negative
 * values on failure.
 *
 */
int seccomp_reset(scmp_filter_ctx ctx, uint def_action);

/**
 * Destroys the filter state and releases any resources
 * @param ctx the filter context
 *
 * This functions destroys the given seccomp filter state and releases any
 * resources, including memory, associated with the filter state.  This
 * function does not reset any seccomp filters already loaded into the kernel.
 * The filter context can no longer be used after calling this function.
 *
 */
void seccomp_release(scmp_filter_ctx ctx);

/**
 * Merge two filters
 * @param ctx_dst the destination filter context
 * @param ctx_src the source filter context
 *
 * This function merges two filter contexts into a single filter context and
 * destroys the second filter context.  The two filter contexts must have the
 * same attribute values and not contain any of the same architectures; if they
 * do, the merge operation will fail.  On success, the source filter context
 * will be destroyed and should no longer be used; it is not necessary to
 * call seccomp_release() on the source filter context.  Returns zero on
 * success, negative values on failure.
 *
 */
int seccomp_merge(scmp_filter_ctx ctx_dst, scmp_filter_ctx ctx_src);

/**
 * Resolve the architecture name to a architecture token
 * @param arch_name the architecture name
 *
 * This function resolves the given architecture name to a token suitable for
 * use with libseccomp, returns zero on failure.
 *
 */
uint seccomp_arch_resolve_name(const(char) *arch_name);

/**
 * Return the native architecture token
 *
 * This function returns the native architecture token value, e.g. SCMP_ARCH_*.
 *
 */
uint seccomp_arch_native();

/**
 * Check to see if an existing architecture is present in the filter
 * @param ctx the filter context
 * @param arch_token the architecture token, e.g. SCMP_ARCH_*
 *
 * This function tests to see if a given architecture is included in the filter
 * context.  If the architecture token is SCMP_ARCH_NATIVE then the native
 * architecture will be assumed.  Returns zero if the architecture exists in
 * the filter, -EEXIST if it is not present, and other negative values on
 * failure.
 *
 */
int seccomp_arch_exist(scmp_filter_ctx_const ctx, uint arch_token);

/**
 * Adds an architecture to the filter
 * @param ctx the filter context
 * @param arch_token the architecture token, e.g. SCMP_ARCH_*
 *
 * This function adds a new architecture to the given seccomp filter context.
 * Any new rules added after this function successfully returns will be added
 * to this architecture but existing rules will not be added to this
 * architecture.  If the architecture token is SCMP_ARCH_NATIVE then the native
 * architecture will be assumed.  Returns zero on success, -EEXIST if
 * specified architecture is already present, other negative values on failure.
 *
 */
int seccomp_arch_add(scmp_filter_ctx ctx, uint arch_token);

/**
 * Removes an architecture from the filter
 * @param ctx the filter context
 * @param arch_token the architecture token, e.g. SCMP_ARCH_*
 *
 * This function removes an architecture from the given seccomp filter context.
 * If the architecture token is SCMP_ARCH_NATIVE then the native architecture
 * will be assumed.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_arch_remove(scmp_filter_ctx ctx, uint arch_token);

/**
 * Loads the filter into the kernel
 * @param ctx the filter context
 *
 * This function loads the given seccomp filter context into the kernel.  If
 * the filter was loaded correctly, the kernel will be enforcing the filter
 * when this function returns.  Returns zero on success, negative values on
 * error.
 *
 */
int seccomp_load(scmp_filter_ctx_const ctx);

/**
 * Get the value of a filter attribute
 * @param ctx the filter context
 * @param attr the filter attribute name
 * @param value the filter attribute value
 *
 * This function fetches the value of the given attribute name and returns it
 * via @value.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_attr_get(scmp_filter_ctx_const ctx, FilterAttribute attr, uint *value);

/**
 * Set the value of a filter attribute
 * @param ctx the filter context
 * @param attr the filter attribute name
 * @param value the filter attribute value
 *
 * This function sets the value of the given attribute.  Returns zero on
 * success, negative values on failure.
 *
 */
int seccomp_attr_set(scmp_filter_ctx ctx, FilterAttribute attr, uint value);

/**
 * Resolve a syscall number to a name
 * @param arch_token the architecture token, e.g. SCMP_ARCH_*
 * @param num the syscall number
 *
 * Resolve the given syscall number to the syscall name for the given
 * architecture; it is up to the caller to free the returned string.  Returns
 * the syscall name on success, NULL on failure.
 *
 */
char *seccomp_syscall_resolve_num_arch(uint arch_token, int num);

/**
 * Resolve a syscall name to a number
 * @param arch_token the architecture token, e.g. SCMP_ARCH_*
 * @param name the syscall name
 *
 * Resolve the given syscall name to the syscall number for the given
 * architecture.  Returns the syscall number on success, including negative
 * pseudo syscall numbers (e.g. PseudoSyscall.*); returns __NR_SCMP_ERROR on failure.
 *
 */
int seccomp_syscall_resolve_name_arch(uint arch_token, const(char) *name);

/**
 * Resolve a syscall name to a number and perform any rewriting necessary
 * @param arch_token the architecture token, e.g. SCMP_ARCH_*
 * @param name the syscall name
 *
 * Resolve the given syscall name to the syscall number for the given
 * architecture and do any necessary syscall rewriting needed by the
 * architecture.  Returns the syscall number on success, including negative
 * pseudo syscall numbers (e.g. PseudoSyscall.*); returns __NR_SCMP_ERROR on failure.
 *
 */
int seccomp_syscall_resolve_name_rewrite(uint arch_token, const(char) *name);

/**
 * Resolve a syscall name to a number
 * @param name the syscall name
 *
 * Resolve the given syscall name to the syscall number.  Returns the syscall
 * number on success, including negative pseudo syscall numbers (e.g. PseudoSyscall.*);
 * returns __NR_SCMP_ERROR on failure.
 *
 */
int seccomp_syscall_resolve_name(const(char) *name);

/**
 * Set the priority of a given syscall
 * @param ctx the filter context
 * @param syscall the syscall number
 * @param priority priority value, higher value == higher priority
 *
 * This function sets the priority of the given syscall; this value is used
 * when generating the seccomp filter code such that higher priority syscalls
 * will incur less filter code overhead than the lower priority syscalls in the
 * filter.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_syscall_priority(scmp_filter_ctx ctx,
			     int syscall, ubyte priority);

/**
 * Add a new rule to the filter
 * @param ctx the filter context
 * @param action the filter action
 * @param syscall the syscall number
 * @param arg_cnt the number of argument filters in the argument filter chain
 * @param ... SecCompArgCmp structs (use of SCMP_ARG_CMP() recommended)
 *
 * This function adds a series of new argument/value checks to the seccomp
 * filter for the given syscall; multiple argument/value checks can be
 * specified and they will be chained together (AND'd together) in the filter.
 * If the specified rule needs to be adjusted due to architecture specifics it
 * will be adjusted without notification.  Returns zero on success, negative
 * values on failure.
 *
 */
int seccomp_rule_add(scmp_filter_ctx ctx,
		     uint action, int syscall, uint arg_cnt, ...);


/**
 * Add a new rule to the filter
 * @param ctx the filter context
 * @param action the filter action
 * @param syscall the syscall number
 * @param arg_cnt the number of elements in the arg_array parameter
 * @param arg_array array of SecCompArgCmp structs
 *
 * This function adds a series of new argument/value checks to the seccomp
 * filter for the given syscall; multiple argument/value checks can be
 * specified and they will be chained together (AND'd together) in the filter.
 * If the specified rule needs to be adjusted due to architecture specifics it
 * will be adjusted without notification.  Returns zero on success, negative
 * values on failure.
 *
 */
int seccomp_rule_add_array(scmp_filter_ctx ctx,
			   uint action, int syscall, uint arg_cnt,
			   const(SecCompArgCmp)* arg_array);

/**
 * Add a new rule to the filter
 * @param ctx the filter context
 * @param action the filter action
 * @param syscall the syscall number
 * @param arg_cnt the number of argument filters in the argument filter chain
 * @param ... SecCompArgCmp structs (use of SCMP_ARG_CMP() recommended)
 *
 * This function adds a series of new argument/value checks to the seccomp
 * filter for the given syscall; multiple argument/value checks can be
 * specified and they will be chained together (AND'd together) in the filter.
 * If the specified rule can not be represented on the architecture the
 * function will fail.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_rule_add_exact(scmp_filter_ctx ctx, uint action,
			   int syscall, uint arg_cnt, ...);

/**
 * Add a new rule to the filter
 * @param ctx the filter context
 * @param action the filter action
 * @param syscall the syscall number
 * @param arg_cnt  the number of elements in the arg_array parameter
 * @param arg_array array of SecCompArgCmp structs
 *
 * This function adds a series of new argument/value checks to the seccomp
 * filter for the given syscall; multiple argument/value checks can be
 * specified and they will be chained together (AND'd together) in the filter.
 * If the specified rule can not be represented on the architecture the
 * function will fail.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_rule_add_exact_array(scmp_filter_ctx ctx,
				 uint action, int syscall,
				 uint arg_cnt,
				 const(SecCompArgCmp)* arg_array);

/**
 * Generate seccomp Pseudo Filter Code (PFC) and export it to a file
 * @param ctx the filter context
 * @param fd the destination fd
 *
 * This function generates seccomp Pseudo Filter Code (PFC) and writes it to
 * the given fd.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_export_pfc(const scmp_filter_ctx ctx, int fd);

/**
 * Generate seccomp Berkley Packet Filter (BPF) code and export it to a file
 * @param ctx the filter context
 * @param fd the destination fd
 *
 * This function generates seccomp Berkley Packer Filter (BPF) code and writes
 * it to the given fd.  Returns zero on success, negative values on failure.
 *
 */
int seccomp_export_bpf(scmp_filter_ctx ctx, int fd);

/// pseudo syscall definitions
enum PseudoSyscall
{
	// NOTE - pseudo syscall values {-1..-99} are reserved
	error			= -1,
	undef			= -2,

	socket			= -101,
	bind			= -102,
	connect			= -103,
	listen			= -104,
	accept			= -105,
	getsockname		= -106,
	getpeername		= -107,
	socketpair		= -108,
	send		 	= -109,
	recv			= -110,
	sendto			= -111,
	recvfrom		= -112,
	shutdown		= -113,
	setsockopt		= -114,
	getsockopt		= -115,
	sendmsg			= -116,
	recvmsg			= -117,
	accept4			= -118,
	recvmmsg		= -119,
	sendmmsg		= -120,
	semop			= -201,
	semget			= -202,
	semctl			= -203,
	semtimedop		= -204,
	msgsnd			= -211,
	msgrcv			= -212,
	msgget			= -213,
	msgctl			= -214,
	shmat			= -221,
	shmdt			= -222,
	shmget			= -223,
	shmctl			= -224,
	arch_prctl		= -10001,
	bdflush			= -10002,
	break_			= -10003,
	chown32			= -10004,
	epoll_ctl_old	= -10005,
	epoll_wait_old	= -10006,
	fadvise64_64	= -10007,
	fchown32		= -10008,
	fcntl64			= -10009,
	fstat64			= -10010,
	fstatat64		= -10011,
	fstatfs64		= -10012,
	ftime			= -10013,
	ftruncate64		= -10014,
	getegid32		= -10015,
	geteuid32		= -10016,
	getgid32		= -10017,
	getgroups32		= -10018,
	getresgid32		= -10019,
	getresuid32		= -10020,
	getuid32		= -10021,
	gtty			= -10022,
	idle			= -10023,
	ipc				= -10024,
	lchown32		= -10025,
	_llseek			= -10026,
	lock			= -10027,
	lstat64			= -10028,
	mmap2			= -10029,
	mpx				= -10030,
	newfstatat		= -10031,
	_newselect		= -10032,
	nice			= -10033,
	oldfstat		= -10034,
	oldlstat		= -10035,
	oldolduname		= -10036,
	oldstat			= -10037,
	olduname		= -10038,
	prof			= -10039,
	profil			= -10040,
	readdir			= -10041,
	security		= -10042,
	sendfile64		= -10043,
	setfsgid32		= -10044,
	setfsuid32		= -10045,
	setgid32		= -10046,
	setgroups32		= -10047,
	setregid32		= -10048,
	setresgid32		= -10049,
	setresuid32		= -10050,
	setreuid32		= -10051,
	setuid32		= -10052,
	sgetmask		= -10053,
	sigaction		= -10054,
	signal			= -10055,
	sigpending		= -10056,
	sigprocmask		= -10057,
	sigreturn		= -10058,
	sigsuspend		= -10059,
	socketcall		= -10060,
	ssetmask		= -10061,
	stat64			= -10062,
	statfs64		= -10063,
	stime			= -10064,
	stty			= -10065,
	truncate64		= -10066,
	tuxcall			= -10067,
	ugetrlimit		= -10068,
	ulimit			= -10069,
	umount			= -10070,
	vm86			= -10071,
	vm86old			= -10072,
	waitpid			= -10073,
	create_module	= -10074,
	get_kernel_syms	= -10075,
	get_thread_area	= -10076,
	nfsservctl		= -10077,
	query_module	= -10078,
	set_thread_area	= -10079,
	sysctl			= -10080,
	uselib			= -10081,
	vserver			= -10082,
	arm_fadvise64_64= -10083,
	arm_sync_file_range	= -10084,
	pciconfig_iobase	= -10086,
	pciconfig_read	= -10087,
	pciconfig_write	= -10088,
	sync_file_range2 = -10089,
	syscall			= -10090,
	afs_syscall		= -10091,
	fadvise64		= -10092,
	getpmsg			= -10093,
	ioperm			= -10094,
	iopl			= -10095,
	migrate_pages	= -10097,
	modify_ldt		= -10098,
	putpmsg			= -10099,
	sync_file_range	= -10100,
	select			= -10101,
	vfork			= -10102,
	cachectl		= -10103,
	sysmips			= -10106,
	timerfd			= -10107,
	time			= -10108,
	getrandom		= -10109,
	memfd_create	= -10110,
	kexec_file_load	= -10111,
	sysfs			= -10145,
	oldwait4		= -10146,
	access			= -10147,
	alarm			= -10148,
	chmod			= -10149,
	chown			= -10150,
	creat			= -10151,
	dup2			= -10152,
	epoll_create	= -10153,
	epoll_wait		= -10154,
	eventfd			= -10155,
	fork			= -10156,
	futimesat		= -10157,
	getdents		= -10158,
	getpgrp			= -10159,
	inotify_init	= -10160,
	lchown			= -10161,
	link			= -10162,
	lstat			= -10163,
	mkdir			= -10164,
	mknod			= -10165,
	open			= -10166,
	pause			= -10167,
	pipe			= -10168,
	poll			= -10169,
	readlink		= -10170,
	rename			= -10171,
	rmdir			= -10172,
	signalfd		= -10173,
	stat			= -10174,
	symlink			= -10175,
	unlink			= -10176,
	ustat			= -10177,
	utime			= -10178,
	utimes			= -10179,
	getrlimit		= -10180,
	mmap			= -10181,
	breakpoint		= -10182,
	set_tls			= -10183,
	usr26			= -10184,
	usr32			= -10185,
	multiplexer		= -10186,
	rtas			= -10187,
	spu_create		= -10188,
	spu_run			= -10189,
	swapcontext		= -10190,
	sys_debug_setcontext = -10191,
	switch_endian	= -10191,
	get_mempolicy	= -10192,
	move_pages		= -10193,
	mbind			= -10194,
	set_mempolicy	= -10195,
	s390_runtime_instr = -10196,
	s390_pci_mmio_read = -10197,
	s390_pci_mmio_write	= -10198,
	membarrier		= -10199,
	userfaultfd		= -10200,
	pkey_mprotect	= -10201,
	pkey_alloc		= -10202,
	pkey_free		= -10203,
	get_tls			= -10204,
	s390_guarded_storage = -10205,
	s390_sthyi		= -10206,
	subpage_prot	= -10207,
	statx			= -10208,
	io_pgetevents	= -10209,
	rseq			= -10210,
}

version(X86_64)
{
	enum Syscall : int
	{
		_llseek = 		PseudoSyscall._llseek,
		_newselect =	PseudoSyscall._newselect,
		_sysctl = 		156,
		accept = 		43,
		accept4 = 		288,
		access = 	21,
		acct = 	163,
		add_key = 	248,
		adjtimex = 	159,
		afs_syscall = 	183,
		alarm = 	37,
		arm_fadvise64_64 = 	PseudoSyscall.arm_fadvise64_64,
		arm_sync_file_range = 	PseudoSyscall.arm_sync_file_range,
		arch_prctl = 	158,
		bdflush = 	PseudoSyscall.bdflush,
		bind = 	49,
		bpf = 	321,
		break_ = 	PseudoSyscall.break_,
		breakpoint = 	PseudoSyscall.breakpoint,
		brk = 	12,
		cachectl = 	PseudoSyscall.cachectl,
		//cacheflush = 	PseudoSyscall.cacheflush,
		capget = 	125,
		capset = 	126,
		chdir = 	80,
		chmod = 	90,
		chown = 	92,
		chown32 = 	PseudoSyscall.chown32,
		chroot = 	161,
		clock_adjtime = 	305,
		clock_getres = 	229,
		clock_gettime = 	228,
		clock_nanosleep = 	230,
		clock_settime = 	227,
		clone = 	56,
		close = 	3,
		connect = 	42,
		copy_file_range = 	326,
		creat = 	85,
		create_module = 	174,
		delete_module = 	176,
		dup = 	32,
		dup2 = 	33,
		dup3 = 	292,
		epoll_create = 	213,
		epoll_create1 = 	291,
		epoll_ctl = 	233,
		epoll_ctl_old = 	214,
		epoll_pwait = 	281,
		epoll_wait = 	232,
		epoll_wait_old = 	215,
		eventfd = 	284,
		eventfd2 = 	290,
		execve = 	59,
		execveat = 	322,
		exit = 	60,
		exit_group = 	231,
		faccessat = 	269,
		fadvise64 = 	221,
		fadvise64_64 = 	PseudoSyscall.fadvise64_64,
		fallocate = 	285,
		fanotify_init = 	300,
		fanotify_mark = 	301,
		fchdir = 	81,
		fchmod = 	91,
		fchmodat = 	268,
		fchown = 	93,
		fchown32 = 	PseudoSyscall.fchown32,
		fchownat = 	260,
		fcntl = 	72,
		fcntl64 = 	PseudoSyscall.fcntl64,
		fdatasync = 	75,
		fgetxattr = 	193,
		finit_module = 	313,
		flistxattr = 	196,
		flock = 	73,
		fork = 	57,
		fremovexattr = 	199,
		fsetxattr = 	190,
		fstat = 	5,
		fstat64 = 	PseudoSyscall.fstat64,
		fstatat64 = 	PseudoSyscall.fstatat64,
		fstatfs = 	138,
		fstatfs64 = 	PseudoSyscall.fstatfs64,
		fsync = 	74,
		ftime = 	PseudoSyscall.ftime,
		ftruncate = 	77,
		ftruncate64 = 	PseudoSyscall.ftruncate64,
		futex = 	202,
		futimesat = 	261,
		get_kernel_syms = 	177,
		get_mempolicy = 	239,
		get_robust_list = 	274,
		get_thread_area = 	211,
		get_tls = 	PseudoSyscall.get_tls,
		getcpu = 	309,
		getcwd = 	79,
		getdents = 	78,
		getdents64 = 	217,
		getegid = 	108,
		getegid32 = 	PseudoSyscall.getegid32,
		geteuid = 	107,
		geteuid32 = 	PseudoSyscall.geteuid32,
		getgid = 	104,
		getgid32 = 	PseudoSyscall.getgid32,
		getgroups = 	115,
		getgroups32 = 	PseudoSyscall.getgroups32,
		getitimer = 	36,
		getpeername = 	52,
		getpgid = 	121,
		getpgrp = 	111,
		getpid = 	39,
		getpmsg = 	181,
		getppid = 	110,
		getpriority = 	140,
		getrandom = 	318,
		getresgid = 	120,
		getresgid32 = 	PseudoSyscall.getresgid32,
		getresuid = 	118,
		getresuid32 = 	PseudoSyscall.getresuid32,
		getrlimit = 	97,
		getrusage = 	98,
		getsid = 	124,
		getsockname = 	51,
		getsockopt = 	55,
		gettid = 	186,
		gettimeofday = 	96,
		getuid = 	102,
		getuid32 = 	PseudoSyscall.getuid32,
		getxattr = 	191,
		gtty = 	PseudoSyscall.gtty,
		idle = 	PseudoSyscall.idle,
		init_module = 	175,
		inotify_add_watch = 	254,
		inotify_init = 	253,
		inotify_init1 = 	294,
		inotify_rm_watch = 	255,
		io_cancel = 	210,
		io_destroy = 	207,
		io_getevents = 	208,
		io_pgetevents = 	333,
		io_setup = 	206,
		io_submit = 	209,
		io_uring_setup = 	425,
		io_uring_enter = 	426,
		io_uring_register = 	427,
		ioctl = 	16,
		ioperm = 	173,
		iopl = 	172,
		ioprio_get = 	252,
		ioprio_set = 	251,
		ipc = 	PseudoSyscall.ipc,
		kcmp = 	312,
		kexec_file_load = 	320,
		kexec_load = 	246,
		keyctl = 	250,
		kill = 	62,
		lchown = 	94,
		lchown32 = 	PseudoSyscall.lchown32,
		lgetxattr = 	192,
		link = 	86,
		linkat = 	265,
		listen = 	50,
		listxattr = 	194,
		llistxattr = 	195,
		lock = 	PseudoSyscall.lock,
		lookup_dcookie = 	212,
		lremovexattr = 	198,
		lseek = 	8,
		lsetxattr = 	189,
		lstat = 	6,
		lstat64 = 	PseudoSyscall.lstat64,
		madvise = 	28,
		mbind = 	237,
		membarrier = 	324,
		memfd_create = 	319,
		migrate_pages = 	256,
		mincore = 	27,
		mkdir = 	83,
		mkdirat = 	258,
		mknod = 	133,
		mknodat = 	259,
		mlock = 	149,
		mlock2 = 	325,
		mlockall = 	151,
		mmap = 	9,
		mmap2 = 	PseudoSyscall.mmap2,
		modify_ldt = 	154,
		mount = 	165,
		move_pages = 	279,
		mprotect = 	10,
		mpx = 	PseudoSyscall.mpx,
		mq_getsetattr = 	245,
		mq_notify = 	244,
		mq_open = 	240,
		mq_timedreceive = 	243,
		mq_timedsend = 	242,
		mq_unlink = 	241,
		mremap = 	25,
		msgctl = 	71,
		msgget = 	68,
		msgrcv = 	70,
		msgsnd = 	69,
		msync = 	26,
		multiplexer = 	PseudoSyscall.multiplexer,
		munlock = 	150,
		munlockall = 	152,
		munmap = 	11,
		name_to_handle_at = 	303,
		nanosleep = 	35,
		newfstatat = 	262,
		nfsservctl = 	180,
		nice = 	PseudoSyscall.nice,
		oldfstat = 	PseudoSyscall.oldfstat,
		oldlstat = 	PseudoSyscall.oldlstat,
		oldolduname = 	PseudoSyscall.oldolduname,
		oldstat = 	PseudoSyscall.oldstat,
		olduname = 	PseudoSyscall.olduname,
		oldwait4 = 	PseudoSyscall.oldwait4,
		open = 	2,
		open_by_handle_at = 	304,
		openat = 	257,
		pause = 	34,
		pciconfig_iobase = 	PseudoSyscall.pciconfig_iobase,
		pciconfig_read = 	PseudoSyscall.pciconfig_read,
		pciconfig_write = 	PseudoSyscall.pciconfig_write,
		perf_event_open = 	298,
		personality = 	135,
		pipe = 	22,
		pipe2 = 	293,
		pivot_root = 	155,
		pkey_alloc = 	330,
		pkey_free = 	331,
		pkey_mprotect = 	329,
		poll = 	7,
		ppoll = 	271,
		prctl = 	157,
		pread64 = 	17,
		preadv = 	295,
		preadv2 = 	327,
		prlimit64 = 	302,
		process_vm_readv = 	310,
		process_vm_writev = 	311,
		prof = 	PseudoSyscall.prof,
		profil = 	PseudoSyscall.profil,
		pselect6 = 	270,
		ptrace = 	101,
		putpmsg = 	182,
		pwrite64 = 	18,
		pwritev = 	296,
		pwritev2 = 	328,
		query_module = 	178,
		quotactl = 	179,
		read = 	0,
		readahead = 	187,
		readdir = 	PseudoSyscall.readdir,
		readlink = 	89,
		readlinkat = 	267,
		readv = 	19,
		reboot = 	169,
		recv = 	PseudoSyscall.recv,
		recvfrom = 	45,
		recvmmsg = 	299,
		recvmsg = 	47,
		remap_file_pages = 	216,
		removexattr = 	197,
		rename = 	82,
		renameat = 	264,
		renameat2 = 	316,
		request_key = 	249,
		restart_syscall = 	219,
		rmdir = 	84,
		rseq = 	334,
		rt_sigaction = 	13,
		rt_sigpending = 	127,
		rt_sigprocmask = 	14,
		rt_sigqueueinfo = 	129,
		rt_sigreturn = 	15,
		rt_sigsuspend = 	130,
		rt_sigtimedwait = 	128,
		rt_tgsigqueueinfo = 	297,
		rtas = 	PseudoSyscall.rtas,
		s390_guarded_storage = 	PseudoSyscall.s390_guarded_storage,
		s390_pci_mmio_read = 	PseudoSyscall.s390_pci_mmio_read,
		s390_pci_mmio_write = 	PseudoSyscall.s390_pci_mmio_write,
		s390_runtime_instr = 	PseudoSyscall.s390_runtime_instr,
		s390_sthyi = 	PseudoSyscall.s390_sthyi,
		sched_get_priority_max = 	146,
		sched_get_priority_min = 	147,
		sched_getaffinity = 	204,
		sched_getattr = 	315,
		sched_getparam = 	143,
		sched_getscheduler = 	145,
		sched_rr_get_interval = 	148,
		sched_setaffinity = 	203,
		sched_setattr = 	314,
		sched_setparam = 	142,
		sched_setscheduler = 	144,
		sched_yield = 	24,
		seccomp = 	317,
		security = 	185,
		select = 	23,
		semctl = 	66,
		semget = 	64,
		semop = 	65,
		semtimedop = 	220,
		send = 	PseudoSyscall.send,
		sendfile = 	40,
		sendfile64 = 	PseudoSyscall.sendfile64,
		sendmmsg = 	307,
		sendmsg = 	46,
		sendto = 	44,
		set_mempolicy = 	238,
		set_robust_list = 	273,
		set_thread_area = 	205,
		set_tid_address = 	218,
		set_tls = 	PseudoSyscall.set_tls,
		setdomainname = 	171,
		setfsgid = 	123,
		setfsgid32 = 	PseudoSyscall.setfsgid32,
		setfsuid = 	122,
		setfsuid32 = 	PseudoSyscall.setfsuid32,
		setgid = 	106,
		setgid32 = 	PseudoSyscall.setgid32,
		setgroups = 	116,
		setgroups32 = 	PseudoSyscall.setgroups32,
		sethostname = 	170,
		setitimer = 	38,
		setns = 	308,
		setpgid = 	109,
		setpriority = 	141,
		setregid = 	114,
		setregid32 = 	PseudoSyscall.setregid32,
		setresgid = 	119,
		setresgid32 = 	PseudoSyscall.setresgid32,
		setresuid = 	117,
		setresuid32 = 	PseudoSyscall.setresuid32,
		setreuid = 	113,
		setreuid32 = 	PseudoSyscall.setreuid32,
		setrlimit = 	160,
		setsid = 	112,
		setsockopt = 	54,
		settimeofday = 	164,
		setuid = 	105,
		setuid32 = 	PseudoSyscall.setuid32,
		setxattr = 	188,
		sgetmask = 	PseudoSyscall.sgetmask,
		shmat = 	30,
		shmctl = 	31,
		shmdt = 	67,
		shmget = 	29,
		shutdown = 	48,
		sigaction = 	PseudoSyscall.sigaction,
		sigaltstack = 	131,
		signal = 	PseudoSyscall.signal,
		signalfd = 	282,
		signalfd4 = 	289,
		sigpending = 	PseudoSyscall.sigpending,
		sigprocmask = 	PseudoSyscall.sigprocmask,
		sigreturn = 	PseudoSyscall.sigreturn,
		sigsuspend = 	PseudoSyscall.sigsuspend,
		socket = 	41,
		socketcall = 	PseudoSyscall.socketcall,
		socketpair = 	53,
		splice = 	275,
		spu_create = 	PseudoSyscall.spu_create,
		spu_run = 	PseudoSyscall.spu_run,
		ssetmask = 	PseudoSyscall.ssetmask,
		stat = 	4,
		stat64 = 	PseudoSyscall.stat64,
		statfs = 	137,
		statfs64 = 	PseudoSyscall.statfs64,
		statx = 	332,
		stime = 	PseudoSyscall.stime,
		stty = 	PseudoSyscall.stty,
		subpage_prot = 	PseudoSyscall.subpage_prot,
		swapcontext = 	PseudoSyscall.swapcontext,
		swapoff = 	168,
		swapon = 	167,
		switch_endian = 	PseudoSyscall.switch_endian,
		symlink = 	88,
		symlinkat = 	266,
		sync = 	162,
		sync_file_range = 	277,
		sync_file_range2 = 	PseudoSyscall.sync_file_range2,
		syncfs = 	306,
		syscall = 	PseudoSyscall.syscall,
		sys_debug_setcontext = 	PseudoSyscall.sys_debug_setcontext,
		sysfs = 	139,
		sysinfo = 	99,
		syslog = 	103,
		sysmips = 	PseudoSyscall.sysmips,
		tee = 	276,
		tgkill = 	234,
		time = 	201,
		timer_create = 	222,
		timer_delete = 	226,
		timer_getoverrun = 	225,
		timer_gettime = 	224,
		timer_settime = 	223,
		timerfd = 	PseudoSyscall.timerfd,
		timerfd_create = 	283,
		timerfd_gettime = 	287,
		timerfd_settime = 	286,
		times = 	100,
		tkill = 	200,
		truncate = 	76,
		truncate64 = 	PseudoSyscall.truncate64,
		tuxcall = 	184,
		ugetrlimit = 	PseudoSyscall.ugetrlimit,
		ulimit = 	PseudoSyscall.ulimit,
		umask = 	95,
		umount = 	PseudoSyscall.umount,
		umount2 = 	166,
		uname = 	63,
		unlink = 	87,
		unlinkat = 	263,
		unshare = 	272,
		uselib = 	134,
		userfaultfd = 	323,
		usr26 = 	PseudoSyscall.usr26,
		usr32 = 	PseudoSyscall.usr32,
		ustat = 	136,
		utime = 	132,
		utimensat = 	280,
		utimes = 	235,
		vfork = 	58,
		vhangup = 	153,
		vm86 = 	PseudoSyscall.vm86,
		vm86old = 	PseudoSyscall.vm86old,
		vmsplice = 	278,
		vserver = 	236,
		wait4 = 	61,
		waitid = 	247,
		waitpid = 	PseudoSyscall.waitpid,
		write = 	1,
		writev = 	20,
	}
}
enum MAX_ERRNO		= 4095;

/+
enum SECCOMP_MODE_DISABLED	= 0;
enum SECCOMP_MODE_STRICT	= 1;
enum SECCOMP_MODE_FILTER	= 2;
+/
/*
 * All BPF programs must return a 32-bit value.
 * The bottom 16-bits are for optional return data.
 * The upper 16-bits are ordered from least permissive values to most.
 *
 * The ordering ensures that a min_t() over composed return values always
 * selects the least permissive choice.
 */
enum SECCOMP_RET_KILL_PROCESS = 0x80000000U; /* kill the process immediately */
enum SECCOMP_RET_KILL_THREAD	=0x00000000U; /* kill the thread immediately */
enum SECCOMP_RET_KILL	= SECCOMP_RET_KILL_THREAD; /* default to killing the thread */
enum SECCOMP_RET_TRAP	= 0x00030000U; /* disallow and force a SIGSYS */
enum SECCOMP_RET_ERRNO	= 0x00050000U; /* returns an errno */
enum SECCOMP_RET_USER_NOTIF	= 0x7fc00000U; /* notifies userspace */
enum SECCOMP_RET_TRACE	= 0x7ff00000U; /* pass to a tracer or disallow */
enum SECCOMP_RET_ALLOW	= 0x7fff0000U; /* allow */

/* Masks for the return value sections. */
enum SECCOMP_RET_ACTION	= 0x7fff0000U;
enum SECCOMP_RET_DATA	= 0x0000ffffU;

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

/* rename some of the socket filter types to make more sense */
alias bpf_instr_raw = void*; // sock_filter;
/+
/* no new privs defintions */
enum PR_SET_NO_NEW_PRIVS		= 38;
enum PR_GET_NO_NEW_PRIVS		= 39;
+/
enum SECCOMP_SET_MODE_STRICT		= 0;
enum SECCOMP_SET_MODE_FILTER		= 1;
enum SECCOMP_GET_ACTION_AVAIL		= 2;
enum SECCOMP_GET_NOTIF_SIZES		= 3;

enum SECCOMP_FILTER_FLAG_TSYNC		= (1UL << 0);
enum SECCOMP_FILTER_FLAG_LOG		= (1UL << 1);
enum SECCOMP_FILTER_FLAG_SPEC_ALLOW	= (1UL << 2);
enum SECCOMP_FILTER_FLAG_NEW_LISTENER	=(1UL << 3);
enum SECCOMP_RET_LOG			= 0x7ffc0000U;
enum SECCOMP_RET_ACTION_FULL	= 0xffff0000U;

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
	long val;
	int error;
	uint flags;
}

enum SECCOMP_IOC_MAGIC               = '!';
// enum SECCOMP_IO(nr)                  _IO(SECCOMP_IOC_MAGIC, nr)
//define SECCOMP_IOR(nr, type)           _IOR(SECCOMP_IOC_MAGIC, nr, type)
// enum SECCOMP_IOW(nr, type)           _IOW(SECCOMP_IOC_MAGIC, nr, type)
// enum SECCOMP_IOWR(nr, type)          _IOWR(SECCOMP_IOC_MAGIC, nr, type)

/* flags for seccomp notification fd ioctl */
// enum SECCOMP_IOCTL_NOTIF_RECV        SECCOMP_IOWR(0, struct seccomp_notif)
// enum SECCOMP_IOCTL_NOTIF_SEND        = SECCOMP_IOWR(1, \ seccomp_notif_resp)
// enum SECCOMP_IOCTL_NOTIF_ID_VALID    = SECCOMP_IOR(2, ulong)

int sys_chk_seccomp_syscall();
void sys_set_seccomp_syscall(int enable);
int sys_chk_seccomp_action(uint action);
void sys_set_seccomp_action(uint action, int enable);
int sys_chk_seccomp_flag(int flag);
void sys_set_seccomp_flag(int flag, int enable);
int sys_filter_load(db_filter_col* col);
int sys_notify_alloc(seccomp_notif** req, seccomp_notif_resp** resp);
int sys_notify_receive(int fd, seccomp_notif* req);
int sys_notify_respond(int fd, seccomp_notif_resp* resp);
int sys_notify_id_valid(int fd, ulong id);
int gen_pfc_generate(const db_filter_col* col, int fd);
struct bpf_program
{
	ushort blk_cnt;
	bpf_instr_raw* blks;
}
/+
#define BPF_PGM_SIZE(x) \
		((x)->blk_cnt * sizeof(*((x)->blks)))
+/

bpf_program* gen_bpf_generate(const db_filter_col* col);
void gen_bpf_release(bpf_program* program);

uint hash(const void *key, size_t length);

void *zmalloc(size_t size);

struct db_api_arg
{
	uint arg;
	SecCompCompare op;
	scmp_datum_t mask;
	scmp_datum_t datum;
	bool valid;
}

struct db_api_rule_list
{
	uint action;
	int syscall;
	bool strict;
	db_api_arg[ARG_COUNT_MAX]  args;

	db_api_rule_list* prev, next;
}

struct db_arg_chain_tree
{
	@SILdoc("argument number (a0 = 0, a1 = 1, etc.)")
	uint arg;

	@SILdoc("true to indicate this is the high 32-bit word of a 64-bit value")
	bool arg_h_flg;

	@SILdoc("argument bpf offset")
	uint arg_offset;

	@SILdoc("comparison operator")
	SecCompCompare op;
	SecCompCompare op_orig;
	
	@SILdoc("syscall argument value")
	uint mask;
	uint datum;
	scmp_datum_t datum_full;

	@SILdoc("actions")
	bool act_t_flg;
	bool act_f_flg;
	uint act_t;
	uint act_f;

	@SILdoc("list of nodes on this level")
	db_arg_chain_tree* lvl_prv, lvl_nxt;

	@SILdoc("next node in the chain")
	db_arg_chain_tree* nxt_t;
	db_arg_chain_tree* nxt_f;

	uint refcnt;
}

enum ARG_MASK_MAX = uint.max;

struct db_sys_list
{
	@SILdoc("native syscall number")
	uint num;

	@SILdoc("priority - higher is better")
	uint priority;

	@SILdoc("the argument chain heads")
	db_arg_chain_tree* chains;
	uint node_cnt;

	@SILdoc("action in the case of no argument chains")
	uint action;

	db_sys_list* next;

	@SILdoc("temporary use only by the BPF generator")
	db_sys_list* pri_prv, pri_nxt;

	bool valid;
}

struct db_filter_attr
{
	@SILdoc("action to take if we don't match an explicit allow/deny")
	uint act_default;
	
	@SILdoc("action to take if we don't match the architecture")
	uint act_badarch;

	@SILdoc("NO_NEW_PRIVS related attributes")
	uint nnp_enable;

	@SILdoc("SECCOMP_FILTER_FLAG_TSYNC related attributes")
	uint tsync_enable;

	@SILdoc("allow rules with a -1 syscall value")
	uint api_tskip;

	@SILdoc("SECCOMP_FILTER_FLAG_LOG related attributes")
	uint log_enable;

	@SILdoc("SPEC_ALLOW related attributes")
	uint spec_allow;
}

struct db_filter
{
	@SILdoc("target architecture")
	const(arch_def)* arch;

	@SILdoc("syscall filters, kept as a sorted single-linked list")
	db_sys_list *syscalls;

	@SILdoc("list of rules used to build the filters, kept in order")
	db_api_rule_list* rules;
}

struct db_filter_snap
{
	@SILdoc("individual filters")
	db_filter** filters;
	uint filter_cnt;

	db_filter_snap* next;
}

struct db_filter_col
{
	@SILdoc("verification / state")
	int state;

	@SILdoc("attributes")
	db_filter_attr attr;

	@SILdoc("individual filters")
	int endian;
	db_filter* *filters;
	uint filter_cnt;

	@SILdoc("transaction snapshots")
	db_filter_snap* snapshots;

	@SILdoc("notification fd that was returned from seccomp()")
	int notify_fd;
	bool notify_used;
}

/+
@SILdoc("
 Iterate over each item in the DB list
 @param iter the iterator
 @param list the list
 
* This macro acts as for()/while() conditional and iterates the following
* statement for each item in the given list.
")*
#define db_list_foreach(iter,list) \
	for (iter = (list); iter != NULL; iter = iter->next)
+/

db_api_rule_list* db_rule_dup(const(db_api_rule_list)* src);
db_filter_col* db_col_init(uint def_action);
int db_col_reset(db_filter_col* col, uint def_action);
void db_col_release(db_filter_col* col);
int db_col_valid(db_filter_col* col);
int db_col_action_valid(const db_filter_col* col, uint action);
int db_col_merge(db_filter_col* col_dst, db_filter_col* col_src);
int db_col_arch_exist(db_filter_col* col, uint arch_token);
int db_col_attr_get(const db_filter_col* col, FilterAttribute attr, uint *value);
int db_col_attr_set(db_filter_col* col, FilterAttribute attr, uint value);

int db_col_db_new(db_filter_col* col, const(arch_def)* arch);
int db_col_db_add(db_filter_col* col, db_filter* db);
int db_col_db_remove(db_filter_col* col, uint arch_token);

int db_col_rule_add(db_filter_col* col, bool strict, uint action, int syscall,
		    uint arg_cnt, const(SecCompArgCmp)* arg_array);

int db_col_syscall_priority(db_filter_col* col, int syscall, ubyte priority);
int db_col_transaction_start(db_filter_col* col);
void db_col_transaction_abort(db_filter_col* col);
void db_col_transaction_commit(db_filter_col* col);
int db_rule_add(db_filter* db, const(db_api_rule_list)* rule);


struct arch_def
{
	/* arch definition */
	uint token;
	uint token_bpf;
	enum ARCH_SIZE
	{
		unspec = 0,
		thirtyTwo = 32,
		sixtyFour = 64,	
	}
    ARCH_SIZE size;
	enum ArchEndian
	{
		unspec = 0,
		little = 1,
		big = 2,
	}
	ArchEndian	endian;

	/* arch specific functions */
	int function(const(char) *name) syscall_resolve_name;
	const(char)* function(int num) syscall_resolve_num;
	int function(int *syscall) syscall_rewrite;
	int function(db_filter* db, db_api_rule_list* rule) rule_add;
}

/* arch_def for the current architecture */
extern const(arch_def)* arch_def_native;

/* syscall name/num mapping */
struct arch_syscall_def
{
	const(char) *name;
	uint num;
}

/+
#define DATUM_MAX	((scmp_datum_t)-1)
#define D64_LO(x)	((uint32_t)((uint64_t)(x) & 0x00000000ffffffff))
#define D64_HI(x)	((uint32_t)((uint64_t)(x) >> 32))
+/

enum ARG_COUNT_MAX = 6;
int arch_valid(uint arch);
const(arch_def)* arch_def_lookup(uint token);
const(arch_def)* arch_def_lookup_name(const(char) *arch_name);
int arch_arg_offset_lo(const(arch_def)* arch, uint arg);
int arch_arg_offset_hi(const(arch_def)* arch, uint arg);
int arch_arg_offset(const(arch_def) *arch, uint arg);
int arch_syscall_resolve_name(const(arch_def)* arch, const(char) *name);
const(char) *arch_syscall_resolve_num(const(arch_def)* arch, int num);
int arch_syscall_translate(const(arch_def)* arch, int *syscall);
int arch_syscall_rewrite(const(arch_def)* arch, int *syscall);
int arch_filter_rule_add(db_filter* db,const(db_api_rule_list)* rule);

version(X86_64)
{
	extern const(arch_def) arch_def_x86_64;
	int x86_64_syscall_resolve_name(const(char) *name);
	const(char) *x86_64_syscall_resolve_num(int num);
	const(arch_syscall_def)* x86_64_syscall_iterate(uint spot);
}

/+

version(X86)
{
	extern const struct arch_def arch_def_x86;
	int x86_syscall_resolve_name(const(char) *name);
	const(char) *x86_syscall_resolve_num(int num);
	const struct arch_syscall_def *x86_syscall_iterate(uint spot);
	int x86_syscall_rewrite(int *syscall);
	int x86_rule_add(db_filter* db, struct db_api_rule_list *rule);
}

version(ARCHX32)
{
	enum X32_SYSCALL_BIT			= 0x40000000;
	extern const struct arch_def arch_def_x32;
	int x32_syscall_resolve_name(const(char) *name);
	const(char) *x32_syscall_resolve_num(int num);
	const struct arch_syscall_def *x32_syscall_iterate(uint spot);
}


version(ARM)
{
	extern const struct arch_def arch_def_arm;
	int arm_syscall_resolve_name(const(char) *name);
	const(char) *arm_syscall_resolve_num(int num);
	const struct arch_syscall_def *arm_syscall_iterate(uint spot);
}


version(AARCH64)
{
	extern const struct arch_def arch_def_aarch64;
	int aarch64_syscall_resolve_name(const(char) *name);
	const(char) *aarch64_syscall_resolve_num(int num);
	const(arch_syscall_def)* aarch64_syscall_iterate(uint spot);
}
+/

