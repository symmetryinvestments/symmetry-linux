module core.sys.linux.sys.capability; 
import core.sys.posix.sys.capabilities;

alias uid_t = uint;
alias pid_t = int;
alias gid_t = int;

/*
 * from <sys/capability.h>
 *
 * Copyright (C) 1997   Aleph One
 * Copyright (C) 1997-8,2008 Andrew G. Morgan <morgan@kernel.org>
 *
 * defunct POSIX.1e Standard: 25.2 Capabilities           <sys/capability.h>
 */


/*
 * This file complements the kernel file by providing prototype
 * information for the user library.
 */
// not sure why this is missing?  did I fail to push?
// import core.sys.posix.sys.capabilities;


/*
 * POSIX capability types
 */

/*
 * Opaque capability handle (defined internally by libcap)
 * internal capability representation
 */
alias cap_t = _cap_struct*;

// FIXME ?
struct _cap_struct {}

/* "external" capability representation is a (void *) */

/*
 * This is the type used to identify capabilities
 */

alias cap_value_t = int;

/*
 * Set identifiers
 */
enum
{
    CAP_EFFECTIVE = 0,                        /* Specifies the effective flag */
    CAP_PERMITTED = 1,                        /* Specifies the permitted flag */
    CAP_INHERITABLE = 2                     /* Specifies the inheritable flag */
}
alias cap_flag_t = int;

enum CapabilityFlag
{
	effective = CAP_EFFECTIVE,
	permitted = CAP_PERMITTED,
	inheritable = CAP_INHERITABLE,
}


/*
 * These are the states available to each capability
 */
enum
{
    CAP_CLEAR=0,                            /* The flag is cleared/disabled */
    CAP_SET=1                                    /* The flag is set/enabled */
}
alias cap_flag_value_t = int;

enum CapabilityState
{
	clear = CAP_CLEAR,
	set = CAP_SET,
}



/*
 * User-space capability manipulation routines
 */

/* libcap/cap_alloc.c */
extern(C) @nogc nothrow:
cap_t cap_dup(cap_t);
int cap_free(void *);
cap_t cap_init();

/* libcap/cap_flag.c */
int cap_get_flag(cap_t, cap_value_t, cap_flag_t, cap_flag_value_t*);
int cap_set_flag(cap_t, cap_flag_t, int, const(cap_value_t)*, cap_flag_value_t);
int cap_clear(cap_t);
int cap_clear_flag(cap_t, cap_flag_t);

/* libcap/cap_file.c */
cap_t   cap_get_fd(int);
cap_t   cap_get_file(const(char)*);
uid_t   cap_get_nsowner(cap_t);
int     cap_set_fd(int, cap_t);
int     cap_set_file(const(char) *, cap_t);
int     cap_set_nsowner(cap_t, uid_t);

/* libcap/cap_proc.c */
cap_t   cap_get_proc();
cap_t   cap_get_pid(pid_t);
int     cap_set_proc(cap_t);

int     cap_get_bound(cap_value_t);
int     cap_drop_bound(cap_value_t);
enum CAP_IS_SUPPORTED(cap_value_t cap)= (cap_get_bound(cap) >= 0);

int cap_get_ambient(cap_value_t);
int cap_set_ambient(cap_value_t, cap_flag_value_t);
int cap_reset_ambient();

// for some reason cap_get_ambient is not recognised
version(None)
{
    bool CAP_AMBIENT_SUPPORTED()
    {
    	return (cap_get_ambient(CAP_CHOWN) >= 0);
    }
}

/* libcap/cap_extint.c */
ptrdiff_t cap_size(cap_t);
ptrdiff_t cap_copy_ext(void*, cap_t, ptrdiff_t);
cap_t   cap_copy_int(const(void)*);

/* libcap/cap_text.c */
extern cap_t   cap_from_text(const char *);
extern char *  cap_to_text(cap_t, ptrdiff_t *);
extern int     cap_from_name(const char *, cap_value_t *);
extern char *  cap_to_name(cap_value_t);

bool CAP_DIFFERS(T,U)(T result, U flag)
{
	return (((result) & (1 << (flag))) != 0);
}

extern int     cap_compare(cap_t, cap_t);

struct CapUserHeader {}
alias cap_user_header_t = CapUserHeader*;
/* system calls - look to libc for function to system call mapping */
int capget(cap_user_header_t header, void* data); // cap_user_data_t data);
int capset(cap_user_header_t header, const(void)* data); // const cap_user_data_t) data);

/* deprecated - use cap_get_pid() */
int capgetp(pid_t pid, cap_t cap_d);

/* not valid with filesystem capability support - use cap_set_proc() */
int capsetp(pid_t pid, cap_t cap_d);
