module symmetry.linux.netns;

version(None):


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    alias size_t = c_ulong;
    int getentropy(void*, c_ulong) @nogc nothrow;
    char* crypt(const(char)*, const(char)*) @nogc nothrow;
    int fdatasync(int) @nogc nothrow;
    c_long syscall(c_long, ...) @nogc nothrow;
    void* sbrk(c_long) @nogc nothrow;
    int brk(void*) @nogc nothrow;
    int ftruncate(int, c_long) @nogc nothrow;
    int truncate(const(char)*, c_long) @nogc nothrow;
    int getdtablesize() @nogc nothrow;
    int getpagesize() @nogc nothrow;
    void sync() @nogc nothrow;
    c_long gethostid() @nogc nothrow;
    int fsync(int) @nogc nothrow;
    char* getpass(const(char)*) @nogc nothrow;
    int chroot(const(char)*) @nogc nothrow;
    int daemon(int, int) @nogc nothrow;
    void setusershell() @nogc nothrow;
    void endusershell() @nogc nothrow;
    char* getusershell() @nogc nothrow;
    int acct(const(char)*) @nogc nothrow;
    int profil(ushort*, c_ulong, c_ulong, uint) @nogc nothrow;
    int revoke(const(char)*) @nogc nothrow;
    int vhangup() @nogc nothrow;
    int setdomainname(const(char)*, c_ulong) @nogc nothrow;
    int getdomainname(char*, c_ulong) @nogc nothrow;
    int sethostid(c_long) @nogc nothrow;
    int sethostname(const(char)*, c_ulong) @nogc nothrow;
    int gethostname(char*, c_ulong) @nogc nothrow;
    int setlogin(const(char)*) @nogc nothrow;
    int getlogin_r(char*, c_ulong) @nogc nothrow;
    char* getlogin() @nogc nothrow;
    int tcsetpgrp(int, int) @nogc nothrow;
    int tcgetpgrp(int) @nogc nothrow;
    int rmdir(const(char)*) @nogc nothrow;
    int unlinkat(int, const(char)*, int) @nogc nothrow;
    int unlink(const(char)*) @nogc nothrow;
    c_long readlinkat(int, const(char)*, char*, c_ulong) @nogc nothrow;
    int symlinkat(const(char)*, int, const(char)*) @nogc nothrow;
    c_long readlink(const(char)*, char*, c_ulong) @nogc nothrow;
    int symlink(const(char)*, const(char)*) @nogc nothrow;
    int linkat(int, const(char)*, int, const(char)*, int) @nogc nothrow;
    int link(const(char)*, const(char)*) @nogc nothrow;
    int ttyslot() @nogc nothrow;
    int isatty(int) @nogc nothrow;
    int ttyname_r(int, char*, c_ulong) @nogc nothrow;
    char* ttyname(int) @nogc nothrow;
    int vfork() @nogc nothrow;
    int fork() @nogc nothrow;
    int setegid(uint) @nogc nothrow;
    int setregid(uint, uint) @nogc nothrow;
    int setgid(uint) @nogc nothrow;
    int seteuid(uint) @nogc nothrow;
    int setreuid(uint, uint) @nogc nothrow;
    int setuid(uint) @nogc nothrow;
    int getgroups(int, uint*) @nogc nothrow;
    uint getegid() @nogc nothrow;
    uint getgid() @nogc nothrow;
    uint geteuid() @nogc nothrow;
    uint getuid() @nogc nothrow;
    int getsid(int) @nogc nothrow;
    int setsid() @nogc nothrow;
    int setpgrp() @nogc nothrow;
    int setpgid(int, int) @nogc nothrow;
    int getpgid(int) @nogc nothrow;
    int __getpgid(int) @nogc nothrow;
    int getpgrp() @nogc nothrow;
    int getppid() @nogc nothrow;
    int getpid() @nogc nothrow;
    c_ulong confstr(int, char*, c_ulong) @nogc nothrow;
    c_long sysconf(int) @nogc nothrow;
    c_long fpathconf(int, int) @nogc nothrow;
    c_long pathconf(const(char)*, int) @nogc nothrow;
    void _exit(int) @nogc nothrow;
    int nice(int) @nogc nothrow;
    int execlp(const(char)*, const(char)*, ...) @nogc nothrow;
    int execvp(const(char)*, char**) @nogc nothrow;
    int execl(const(char)*, const(char)*, ...) @nogc nothrow;
    int execle(const(char)*, const(char)*, ...) @nogc nothrow;
    int execv(const(char)*, char**) @nogc nothrow;
    int fexecve(int, char**, char**) @nogc nothrow;
    int execve(const(char)*, char**, char**) @nogc nothrow;
    extern __gshared char** __environ;
    int dup2(int, int) @nogc nothrow;
    int dup(int) @nogc nothrow;
    char* getwd(char*) @nogc nothrow;
    char* getcwd(char*, c_ulong) @nogc nothrow;
    int fchdir(int) @nogc nothrow;
    int chdir(const(char)*) @nogc nothrow;
    int fchownat(int, const(char)*, uint, uint, int) @nogc nothrow;
    int lchown(const(char)*, uint, uint) @nogc nothrow;
    int fchown(int, uint, uint) @nogc nothrow;
    int chown(const(char)*, uint, uint) @nogc nothrow;
    int pause() @nogc nothrow;
    int usleep(uint) @nogc nothrow;
    uint ualarm(uint, uint) @nogc nothrow;
    uint sleep(uint) @nogc nothrow;
    uint alarm(uint) @nogc nothrow;
    int pipe(int*) @nogc nothrow;
    c_long pwrite(int, const(void)*, c_ulong, c_long) @nogc nothrow;
    c_long pread(int, void*, c_ulong, c_long) @nogc nothrow;
    c_long write(int, const(void)*, c_ulong) @nogc nothrow;
    c_long read(int, void*, c_ulong) @nogc nothrow;
    int close(int) @nogc nothrow;
    c_long lseek(int, c_long, int) @nogc nothrow;
    int faccessat(int, const(char)*, int, int) @nogc nothrow;
    int access(const(char)*, int) @nogc nothrow;
    alias useconds_t = uint;
    alias fsfilcnt_t = c_ulong;
    alias fsblkcnt_t = c_ulong;
    alias blkcnt_t = c_long;
    alias blksize_t = c_long;
    alias register_t = c_long;
    alias u_int64_t = c_ulong;
    alias u_int32_t = uint;
    alias u_int16_t = ushort;
    alias u_int8_t = ubyte;
    alias key_t = int;
    alias caddr_t = char*;
    alias daddr_t = int;
    alias ssize_t = c_long;
    alias id_t = uint;
    alias pid_t = int;
    alias off_t = c_long;
    alias uid_t = uint;
    alias nlink_t = c_ulong;
    alias mode_t = uint;
    alias gid_t = uint;
    alias dev_t = c_ulong;
    alias ino_t = c_ulong;
    alias loff_t = c_long;
    alias fsid_t = __fsid_t;
    alias u_quad_t = c_ulong;
    alias quad_t = c_long;
    alias u_long = c_ulong;
    alias u_int = uint;
    alias u_short = ushort;
    alias u_char = ubyte;
    int isfdtype(int, int) @nogc nothrow;
    int sockatmark(int) @nogc nothrow;
    int shutdown(int, int) @nogc nothrow;
    int accept(int, sockaddr*, uint*) @nogc nothrow;
    int listen(int, int) @nogc nothrow;
    int setsockopt(int, int, int, const(void)*, uint) @nogc nothrow;
    int getsockopt(int, int, int, void*, uint*) @nogc nothrow;
    c_long recvmsg(int, msghdr*, int) @nogc nothrow;
    c_long sendmsg(int, const(msghdr)*, int) @nogc nothrow;
    c_long recvfrom(int, void*, c_ulong, int, sockaddr*, uint*) @nogc nothrow;
    c_long sendto(int, const(void)*, c_ulong, int, const(sockaddr)*, uint) @nogc nothrow;
    c_long recv(int, void*, c_ulong, int) @nogc nothrow;
    c_long send(int, const(void)*, c_ulong, int) @nogc nothrow;
    alias __s8 = byte;
    alias __u8 = ubyte;
    alias __s16 = short;
    alias __u16 = ushort;
    alias __s32 = int;
    alias __u32 = uint;
    alias __s64 = long;
    alias __u64 = ulong;
    int getpeername(int, sockaddr*, uint*) @nogc nothrow;
    alias __kernel_long_t = c_long;
    alias __kernel_ulong_t = c_ulong;
    alias __kernel_ino_t = c_ulong;
    alias __kernel_mode_t = uint;
    alias __kernel_pid_t = int;
    alias __kernel_ipc_pid_t = int;
    alias __kernel_uid_t = uint;
    alias __kernel_gid_t = uint;
    alias __kernel_suseconds_t = c_long;
    alias __kernel_daddr_t = int;
    alias __kernel_uid32_t = uint;
    alias __kernel_gid32_t = uint;
    alias __kernel_size_t = c_ulong;
    alias __kernel_ssize_t = c_long;
    alias __kernel_ptrdiff_t = c_long;
    struct __kernel_fsid_t
    {
        int[2] val;
    }
    alias __kernel_off_t = c_long;
    alias __kernel_loff_t = long;
    alias __kernel_time_t = c_long;
    alias __kernel_time64_t = long;
    alias __kernel_clock_t = c_long;
    alias __kernel_timer_t = int;
    alias __kernel_clockid_t = int;
    alias __kernel_caddr_t = char*;
    alias __kernel_uid16_t = ushort;
    alias __kernel_gid16_t = ushort;
    int connect(int, const(sockaddr)*, uint) @nogc nothrow;
    int getsockname(int, sockaddr*, uint*) @nogc nothrow;
    int bind(int, const(sockaddr)*, uint) @nogc nothrow;
    int socketpair(int, int, int, int*) @nogc nothrow;
    int socket(int, int, int) @nogc nothrow;
    enum _Anonymous_0
    {
        SHUT_RD = 0,
        SHUT_WR = 1,
        SHUT_RDWR = 2,
    }
    enum SHUT_RD = _Anonymous_0.SHUT_RD;
    enum SHUT_WR = _Anonymous_0.SHUT_WR;
    enum SHUT_RDWR = _Anonymous_0.SHUT_RDWR;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    alias fd_mask = c_long;
    struct fd_set
    {
        c_long[16] __fds_bits;
    }
    alias __fd_mask = c_long;
    alias suseconds_t = c_long;
    alias __kernel_old_uid_t = ushort;
    alias __kernel_old_gid_t = ushort;
    alias __kernel_old_dev_t = c_ulong;
    static ushort __bswap_16(ushort) @nogc nothrow;
    static uint __bswap_32(uint) @nogc nothrow;
    static c_ulong __bswap_64(c_ulong) @nogc nothrow;
    enum _Anonymous_1
    {
        _PC_LINK_MAX = 0,
        _PC_MAX_CANON = 1,
        _PC_MAX_INPUT = 2,
        _PC_NAME_MAX = 3,
        _PC_PATH_MAX = 4,
        _PC_PIPE_BUF = 5,
        _PC_CHOWN_RESTRICTED = 6,
        _PC_NO_TRUNC = 7,
        _PC_VDISABLE = 8,
        _PC_SYNC_IO = 9,
        _PC_ASYNC_IO = 10,
        _PC_PRIO_IO = 11,
        _PC_SOCK_MAXBUF = 12,
        _PC_FILESIZEBITS = 13,
        _PC_REC_INCR_XFER_SIZE = 14,
        _PC_REC_MAX_XFER_SIZE = 15,
        _PC_REC_MIN_XFER_SIZE = 16,
        _PC_REC_XFER_ALIGN = 17,
        _PC_ALLOC_SIZE_MIN = 18,
        _PC_SYMLINK_MAX = 19,
        _PC_2_SYMLINKS = 20,
    }
    enum _PC_LINK_MAX = _Anonymous_1._PC_LINK_MAX;
    enum _PC_MAX_CANON = _Anonymous_1._PC_MAX_CANON;
    enum _PC_MAX_INPUT = _Anonymous_1._PC_MAX_INPUT;
    enum _PC_NAME_MAX = _Anonymous_1._PC_NAME_MAX;
    enum _PC_PATH_MAX = _Anonymous_1._PC_PATH_MAX;
    enum _PC_PIPE_BUF = _Anonymous_1._PC_PIPE_BUF;
    enum _PC_CHOWN_RESTRICTED = _Anonymous_1._PC_CHOWN_RESTRICTED;
    enum _PC_NO_TRUNC = _Anonymous_1._PC_NO_TRUNC;
    enum _PC_VDISABLE = _Anonymous_1._PC_VDISABLE;
    enum _PC_SYNC_IO = _Anonymous_1._PC_SYNC_IO;
    enum _PC_ASYNC_IO = _Anonymous_1._PC_ASYNC_IO;
    enum _PC_PRIO_IO = _Anonymous_1._PC_PRIO_IO;
    enum _PC_SOCK_MAXBUF = _Anonymous_1._PC_SOCK_MAXBUF;
    enum _PC_FILESIZEBITS = _Anonymous_1._PC_FILESIZEBITS;
    enum _PC_REC_INCR_XFER_SIZE = _Anonymous_1._PC_REC_INCR_XFER_SIZE;
    enum _PC_REC_MAX_XFER_SIZE = _Anonymous_1._PC_REC_MAX_XFER_SIZE;
    enum _PC_REC_MIN_XFER_SIZE = _Anonymous_1._PC_REC_MIN_XFER_SIZE;
    enum _PC_REC_XFER_ALIGN = _Anonymous_1._PC_REC_XFER_ALIGN;
    enum _PC_ALLOC_SIZE_MIN = _Anonymous_1._PC_ALLOC_SIZE_MIN;
    enum _PC_SYMLINK_MAX = _Anonymous_1._PC_SYMLINK_MAX;
    enum _PC_2_SYMLINKS = _Anonymous_1._PC_2_SYMLINKS;
    int __overflow(_IO_FILE*, int) @nogc nothrow;
    int __uflow(_IO_FILE*) @nogc nothrow;
    void funlockfile(_IO_FILE*) @nogc nothrow;
    int ftrylockfile(_IO_FILE*) @nogc nothrow;
    void flockfile(_IO_FILE*) @nogc nothrow;
    char* ctermid(char*) @nogc nothrow;
    enum _Anonymous_2
    {
        _SC_ARG_MAX = 0,
        _SC_CHILD_MAX = 1,
        _SC_CLK_TCK = 2,
        _SC_NGROUPS_MAX = 3,
        _SC_OPEN_MAX = 4,
        _SC_STREAM_MAX = 5,
        _SC_TZNAME_MAX = 6,
        _SC_JOB_CONTROL = 7,
        _SC_SAVED_IDS = 8,
        _SC_REALTIME_SIGNALS = 9,
        _SC_PRIORITY_SCHEDULING = 10,
        _SC_TIMERS = 11,
        _SC_ASYNCHRONOUS_IO = 12,
        _SC_PRIORITIZED_IO = 13,
        _SC_SYNCHRONIZED_IO = 14,
        _SC_FSYNC = 15,
        _SC_MAPPED_FILES = 16,
        _SC_MEMLOCK = 17,
        _SC_MEMLOCK_RANGE = 18,
        _SC_MEMORY_PROTECTION = 19,
        _SC_MESSAGE_PASSING = 20,
        _SC_SEMAPHORES = 21,
        _SC_SHARED_MEMORY_OBJECTS = 22,
        _SC_AIO_LISTIO_MAX = 23,
        _SC_AIO_MAX = 24,
        _SC_AIO_PRIO_DELTA_MAX = 25,
        _SC_DELAYTIMER_MAX = 26,
        _SC_MQ_OPEN_MAX = 27,
        _SC_MQ_PRIO_MAX = 28,
        _SC_VERSION = 29,
        _SC_PAGESIZE = 30,
        _SC_RTSIG_MAX = 31,
        _SC_SEM_NSEMS_MAX = 32,
        _SC_SEM_VALUE_MAX = 33,
        _SC_SIGQUEUE_MAX = 34,
        _SC_TIMER_MAX = 35,
        _SC_BC_BASE_MAX = 36,
        _SC_BC_DIM_MAX = 37,
        _SC_BC_SCALE_MAX = 38,
        _SC_BC_STRING_MAX = 39,
        _SC_COLL_WEIGHTS_MAX = 40,
        _SC_EQUIV_CLASS_MAX = 41,
        _SC_EXPR_NEST_MAX = 42,
        _SC_LINE_MAX = 43,
        _SC_RE_DUP_MAX = 44,
        _SC_CHARCLASS_NAME_MAX = 45,
        _SC_2_VERSION = 46,
        _SC_2_C_BIND = 47,
        _SC_2_C_DEV = 48,
        _SC_2_FORT_DEV = 49,
        _SC_2_FORT_RUN = 50,
        _SC_2_SW_DEV = 51,
        _SC_2_LOCALEDEF = 52,
        _SC_PII = 53,
        _SC_PII_XTI = 54,
        _SC_PII_SOCKET = 55,
        _SC_PII_INTERNET = 56,
        _SC_PII_OSI = 57,
        _SC_POLL = 58,
        _SC_SELECT = 59,
        _SC_UIO_MAXIOV = 60,
        _SC_IOV_MAX = 60,
        _SC_PII_INTERNET_STREAM = 61,
        _SC_PII_INTERNET_DGRAM = 62,
        _SC_PII_OSI_COTS = 63,
        _SC_PII_OSI_CLTS = 64,
        _SC_PII_OSI_M = 65,
        _SC_T_IOV_MAX = 66,
        _SC_THREADS = 67,
        _SC_THREAD_SAFE_FUNCTIONS = 68,
        _SC_GETGR_R_SIZE_MAX = 69,
        _SC_GETPW_R_SIZE_MAX = 70,
        _SC_LOGIN_NAME_MAX = 71,
        _SC_TTY_NAME_MAX = 72,
        _SC_THREAD_DESTRUCTOR_ITERATIONS = 73,
        _SC_THREAD_KEYS_MAX = 74,
        _SC_THREAD_STACK_MIN = 75,
        _SC_THREAD_THREADS_MAX = 76,
        _SC_THREAD_ATTR_STACKADDR = 77,
        _SC_THREAD_ATTR_STACKSIZE = 78,
        _SC_THREAD_PRIORITY_SCHEDULING = 79,
        _SC_THREAD_PRIO_INHERIT = 80,
        _SC_THREAD_PRIO_PROTECT = 81,
        _SC_THREAD_PROCESS_SHARED = 82,
        _SC_NPROCESSORS_CONF = 83,
        _SC_NPROCESSORS_ONLN = 84,
        _SC_PHYS_PAGES = 85,
        _SC_AVPHYS_PAGES = 86,
        _SC_ATEXIT_MAX = 87,
        _SC_PASS_MAX = 88,
        _SC_XOPEN_VERSION = 89,
        _SC_XOPEN_XCU_VERSION = 90,
        _SC_XOPEN_UNIX = 91,
        _SC_XOPEN_CRYPT = 92,
        _SC_XOPEN_ENH_I18N = 93,
        _SC_XOPEN_SHM = 94,
        _SC_2_CHAR_TERM = 95,
        _SC_2_C_VERSION = 96,
        _SC_2_UPE = 97,
        _SC_XOPEN_XPG2 = 98,
        _SC_XOPEN_XPG3 = 99,
        _SC_XOPEN_XPG4 = 100,
        _SC_CHAR_BIT = 101,
        _SC_CHAR_MAX = 102,
        _SC_CHAR_MIN = 103,
        _SC_INT_MAX = 104,
        _SC_INT_MIN = 105,
        _SC_LONG_BIT = 106,
        _SC_WORD_BIT = 107,
        _SC_MB_LEN_MAX = 108,
        _SC_NZERO = 109,
        _SC_SSIZE_MAX = 110,
        _SC_SCHAR_MAX = 111,
        _SC_SCHAR_MIN = 112,
        _SC_SHRT_MAX = 113,
        _SC_SHRT_MIN = 114,
        _SC_UCHAR_MAX = 115,
        _SC_UINT_MAX = 116,
        _SC_ULONG_MAX = 117,
        _SC_USHRT_MAX = 118,
        _SC_NL_ARGMAX = 119,
        _SC_NL_LANGMAX = 120,
        _SC_NL_MSGMAX = 121,
        _SC_NL_NMAX = 122,
        _SC_NL_SETMAX = 123,
        _SC_NL_TEXTMAX = 124,
        _SC_XBS5_ILP32_OFF32 = 125,
        _SC_XBS5_ILP32_OFFBIG = 126,
        _SC_XBS5_LP64_OFF64 = 127,
        _SC_XBS5_LPBIG_OFFBIG = 128,
        _SC_XOPEN_LEGACY = 129,
        _SC_XOPEN_REALTIME = 130,
        _SC_XOPEN_REALTIME_THREADS = 131,
        _SC_ADVISORY_INFO = 132,
        _SC_BARRIERS = 133,
        _SC_BASE = 134,
        _SC_C_LANG_SUPPORT = 135,
        _SC_C_LANG_SUPPORT_R = 136,
        _SC_CLOCK_SELECTION = 137,
        _SC_CPUTIME = 138,
        _SC_THREAD_CPUTIME = 139,
        _SC_DEVICE_IO = 140,
        _SC_DEVICE_SPECIFIC = 141,
        _SC_DEVICE_SPECIFIC_R = 142,
        _SC_FD_MGMT = 143,
        _SC_FIFO = 144,
        _SC_PIPE = 145,
        _SC_FILE_ATTRIBUTES = 146,
        _SC_FILE_LOCKING = 147,
        _SC_FILE_SYSTEM = 148,
        _SC_MONOTONIC_CLOCK = 149,
        _SC_MULTI_PROCESS = 150,
        _SC_SINGLE_PROCESS = 151,
        _SC_NETWORKING = 152,
        _SC_READER_WRITER_LOCKS = 153,
        _SC_SPIN_LOCKS = 154,
        _SC_REGEXP = 155,
        _SC_REGEX_VERSION = 156,
        _SC_SHELL = 157,
        _SC_SIGNALS = 158,
        _SC_SPAWN = 159,
        _SC_SPORADIC_SERVER = 160,
        _SC_THREAD_SPORADIC_SERVER = 161,
        _SC_SYSTEM_DATABASE = 162,
        _SC_SYSTEM_DATABASE_R = 163,
        _SC_TIMEOUTS = 164,
        _SC_TYPED_MEMORY_OBJECTS = 165,
        _SC_USER_GROUPS = 166,
        _SC_USER_GROUPS_R = 167,
        _SC_2_PBS = 168,
        _SC_2_PBS_ACCOUNTING = 169,
        _SC_2_PBS_LOCATE = 170,
        _SC_2_PBS_MESSAGE = 171,
        _SC_2_PBS_TRACK = 172,
        _SC_SYMLOOP_MAX = 173,
        _SC_STREAMS = 174,
        _SC_2_PBS_CHECKPOINT = 175,
        _SC_V6_ILP32_OFF32 = 176,
        _SC_V6_ILP32_OFFBIG = 177,
        _SC_V6_LP64_OFF64 = 178,
        _SC_V6_LPBIG_OFFBIG = 179,
        _SC_HOST_NAME_MAX = 180,
        _SC_TRACE = 181,
        _SC_TRACE_EVENT_FILTER = 182,
        _SC_TRACE_INHERIT = 183,
        _SC_TRACE_LOG = 184,
        _SC_LEVEL1_ICACHE_SIZE = 185,
        _SC_LEVEL1_ICACHE_ASSOC = 186,
        _SC_LEVEL1_ICACHE_LINESIZE = 187,
        _SC_LEVEL1_DCACHE_SIZE = 188,
        _SC_LEVEL1_DCACHE_ASSOC = 189,
        _SC_LEVEL1_DCACHE_LINESIZE = 190,
        _SC_LEVEL2_CACHE_SIZE = 191,
        _SC_LEVEL2_CACHE_ASSOC = 192,
        _SC_LEVEL2_CACHE_LINESIZE = 193,
        _SC_LEVEL3_CACHE_SIZE = 194,
        _SC_LEVEL3_CACHE_ASSOC = 195,
        _SC_LEVEL3_CACHE_LINESIZE = 196,
        _SC_LEVEL4_CACHE_SIZE = 197,
        _SC_LEVEL4_CACHE_ASSOC = 198,
        _SC_LEVEL4_CACHE_LINESIZE = 199,
        _SC_IPV6 = 235,
        _SC_RAW_SOCKETS = 236,
        _SC_V7_ILP32_OFF32 = 237,
        _SC_V7_ILP32_OFFBIG = 238,
        _SC_V7_LP64_OFF64 = 239,
        _SC_V7_LPBIG_OFFBIG = 240,
        _SC_SS_REPL_MAX = 241,
        _SC_TRACE_EVENT_NAME_MAX = 242,
        _SC_TRACE_NAME_MAX = 243,
        _SC_TRACE_SYS_MAX = 244,
        _SC_TRACE_USER_EVENT_MAX = 245,
        _SC_XOPEN_STREAMS = 246,
        _SC_THREAD_ROBUST_PRIO_INHERIT = 247,
        _SC_THREAD_ROBUST_PRIO_PROTECT = 248,
    }
    enum _SC_ARG_MAX = _Anonymous_2._SC_ARG_MAX;
    enum _SC_CHILD_MAX = _Anonymous_2._SC_CHILD_MAX;
    enum _SC_CLK_TCK = _Anonymous_2._SC_CLK_TCK;
    enum _SC_NGROUPS_MAX = _Anonymous_2._SC_NGROUPS_MAX;
    enum _SC_OPEN_MAX = _Anonymous_2._SC_OPEN_MAX;
    enum _SC_STREAM_MAX = _Anonymous_2._SC_STREAM_MAX;
    enum _SC_TZNAME_MAX = _Anonymous_2._SC_TZNAME_MAX;
    enum _SC_JOB_CONTROL = _Anonymous_2._SC_JOB_CONTROL;
    enum _SC_SAVED_IDS = _Anonymous_2._SC_SAVED_IDS;
    enum _SC_REALTIME_SIGNALS = _Anonymous_2._SC_REALTIME_SIGNALS;
    enum _SC_PRIORITY_SCHEDULING = _Anonymous_2._SC_PRIORITY_SCHEDULING;
    enum _SC_TIMERS = _Anonymous_2._SC_TIMERS;
    enum _SC_ASYNCHRONOUS_IO = _Anonymous_2._SC_ASYNCHRONOUS_IO;
    enum _SC_PRIORITIZED_IO = _Anonymous_2._SC_PRIORITIZED_IO;
    enum _SC_SYNCHRONIZED_IO = _Anonymous_2._SC_SYNCHRONIZED_IO;
    enum _SC_FSYNC = _Anonymous_2._SC_FSYNC;
    enum _SC_MAPPED_FILES = _Anonymous_2._SC_MAPPED_FILES;
    enum _SC_MEMLOCK = _Anonymous_2._SC_MEMLOCK;
    enum _SC_MEMLOCK_RANGE = _Anonymous_2._SC_MEMLOCK_RANGE;
    enum _SC_MEMORY_PROTECTION = _Anonymous_2._SC_MEMORY_PROTECTION;
    enum _SC_MESSAGE_PASSING = _Anonymous_2._SC_MESSAGE_PASSING;
    enum _SC_SEMAPHORES = _Anonymous_2._SC_SEMAPHORES;
    enum _SC_SHARED_MEMORY_OBJECTS = _Anonymous_2._SC_SHARED_MEMORY_OBJECTS;
    enum _SC_AIO_LISTIO_MAX = _Anonymous_2._SC_AIO_LISTIO_MAX;
    enum _SC_AIO_MAX = _Anonymous_2._SC_AIO_MAX;
    enum _SC_AIO_PRIO_DELTA_MAX = _Anonymous_2._SC_AIO_PRIO_DELTA_MAX;
    enum _SC_DELAYTIMER_MAX = _Anonymous_2._SC_DELAYTIMER_MAX;
    enum _SC_MQ_OPEN_MAX = _Anonymous_2._SC_MQ_OPEN_MAX;
    enum _SC_MQ_PRIO_MAX = _Anonymous_2._SC_MQ_PRIO_MAX;
    enum _SC_VERSION = _Anonymous_2._SC_VERSION;
    enum _SC_PAGESIZE = _Anonymous_2._SC_PAGESIZE;
    enum _SC_RTSIG_MAX = _Anonymous_2._SC_RTSIG_MAX;
    enum _SC_SEM_NSEMS_MAX = _Anonymous_2._SC_SEM_NSEMS_MAX;
    enum _SC_SEM_VALUE_MAX = _Anonymous_2._SC_SEM_VALUE_MAX;
    enum _SC_SIGQUEUE_MAX = _Anonymous_2._SC_SIGQUEUE_MAX;
    enum _SC_TIMER_MAX = _Anonymous_2._SC_TIMER_MAX;
    enum _SC_BC_BASE_MAX = _Anonymous_2._SC_BC_BASE_MAX;
    enum _SC_BC_DIM_MAX = _Anonymous_2._SC_BC_DIM_MAX;
    enum _SC_BC_SCALE_MAX = _Anonymous_2._SC_BC_SCALE_MAX;
    enum _SC_BC_STRING_MAX = _Anonymous_2._SC_BC_STRING_MAX;
    enum _SC_COLL_WEIGHTS_MAX = _Anonymous_2._SC_COLL_WEIGHTS_MAX;
    enum _SC_EQUIV_CLASS_MAX = _Anonymous_2._SC_EQUIV_CLASS_MAX;
    enum _SC_EXPR_NEST_MAX = _Anonymous_2._SC_EXPR_NEST_MAX;
    enum _SC_LINE_MAX = _Anonymous_2._SC_LINE_MAX;
    enum _SC_RE_DUP_MAX = _Anonymous_2._SC_RE_DUP_MAX;
    enum _SC_CHARCLASS_NAME_MAX = _Anonymous_2._SC_CHARCLASS_NAME_MAX;
    enum _SC_2_VERSION = _Anonymous_2._SC_2_VERSION;
    enum _SC_2_C_BIND = _Anonymous_2._SC_2_C_BIND;
    enum _SC_2_C_DEV = _Anonymous_2._SC_2_C_DEV;
    enum _SC_2_FORT_DEV = _Anonymous_2._SC_2_FORT_DEV;
    enum _SC_2_FORT_RUN = _Anonymous_2._SC_2_FORT_RUN;
    enum _SC_2_SW_DEV = _Anonymous_2._SC_2_SW_DEV;
    enum _SC_2_LOCALEDEF = _Anonymous_2._SC_2_LOCALEDEF;
    enum _SC_PII = _Anonymous_2._SC_PII;
    enum _SC_PII_XTI = _Anonymous_2._SC_PII_XTI;
    enum _SC_PII_SOCKET = _Anonymous_2._SC_PII_SOCKET;
    enum _SC_PII_INTERNET = _Anonymous_2._SC_PII_INTERNET;
    enum _SC_PII_OSI = _Anonymous_2._SC_PII_OSI;
    enum _SC_POLL = _Anonymous_2._SC_POLL;
    enum _SC_SELECT = _Anonymous_2._SC_SELECT;
    enum _SC_UIO_MAXIOV = _Anonymous_2._SC_UIO_MAXIOV;
    enum _SC_IOV_MAX = _Anonymous_2._SC_IOV_MAX;
    enum _SC_PII_INTERNET_STREAM = _Anonymous_2._SC_PII_INTERNET_STREAM;
    enum _SC_PII_INTERNET_DGRAM = _Anonymous_2._SC_PII_INTERNET_DGRAM;
    enum _SC_PII_OSI_COTS = _Anonymous_2._SC_PII_OSI_COTS;
    enum _SC_PII_OSI_CLTS = _Anonymous_2._SC_PII_OSI_CLTS;
    enum _SC_PII_OSI_M = _Anonymous_2._SC_PII_OSI_M;
    enum _SC_T_IOV_MAX = _Anonymous_2._SC_T_IOV_MAX;
    enum _SC_THREADS = _Anonymous_2._SC_THREADS;
    enum _SC_THREAD_SAFE_FUNCTIONS = _Anonymous_2._SC_THREAD_SAFE_FUNCTIONS;
    enum _SC_GETGR_R_SIZE_MAX = _Anonymous_2._SC_GETGR_R_SIZE_MAX;
    enum _SC_GETPW_R_SIZE_MAX = _Anonymous_2._SC_GETPW_R_SIZE_MAX;
    enum _SC_LOGIN_NAME_MAX = _Anonymous_2._SC_LOGIN_NAME_MAX;
    enum _SC_TTY_NAME_MAX = _Anonymous_2._SC_TTY_NAME_MAX;
    enum _SC_THREAD_DESTRUCTOR_ITERATIONS = _Anonymous_2._SC_THREAD_DESTRUCTOR_ITERATIONS;
    enum _SC_THREAD_KEYS_MAX = _Anonymous_2._SC_THREAD_KEYS_MAX;
    enum _SC_THREAD_STACK_MIN = _Anonymous_2._SC_THREAD_STACK_MIN;
    enum _SC_THREAD_THREADS_MAX = _Anonymous_2._SC_THREAD_THREADS_MAX;
    enum _SC_THREAD_ATTR_STACKADDR = _Anonymous_2._SC_THREAD_ATTR_STACKADDR;
    enum _SC_THREAD_ATTR_STACKSIZE = _Anonymous_2._SC_THREAD_ATTR_STACKSIZE;
    enum _SC_THREAD_PRIORITY_SCHEDULING = _Anonymous_2._SC_THREAD_PRIORITY_SCHEDULING;
    enum _SC_THREAD_PRIO_INHERIT = _Anonymous_2._SC_THREAD_PRIO_INHERIT;
    enum _SC_THREAD_PRIO_PROTECT = _Anonymous_2._SC_THREAD_PRIO_PROTECT;
    enum _SC_THREAD_PROCESS_SHARED = _Anonymous_2._SC_THREAD_PROCESS_SHARED;
    enum _SC_NPROCESSORS_CONF = _Anonymous_2._SC_NPROCESSORS_CONF;
    enum _SC_NPROCESSORS_ONLN = _Anonymous_2._SC_NPROCESSORS_ONLN;
    enum _SC_PHYS_PAGES = _Anonymous_2._SC_PHYS_PAGES;
    enum _SC_AVPHYS_PAGES = _Anonymous_2._SC_AVPHYS_PAGES;
    enum _SC_ATEXIT_MAX = _Anonymous_2._SC_ATEXIT_MAX;
    enum _SC_PASS_MAX = _Anonymous_2._SC_PASS_MAX;
    enum _SC_XOPEN_VERSION = _Anonymous_2._SC_XOPEN_VERSION;
    enum _SC_XOPEN_XCU_VERSION = _Anonymous_2._SC_XOPEN_XCU_VERSION;
    enum _SC_XOPEN_UNIX = _Anonymous_2._SC_XOPEN_UNIX;
    enum _SC_XOPEN_CRYPT = _Anonymous_2._SC_XOPEN_CRYPT;
    enum _SC_XOPEN_ENH_I18N = _Anonymous_2._SC_XOPEN_ENH_I18N;
    enum _SC_XOPEN_SHM = _Anonymous_2._SC_XOPEN_SHM;
    enum _SC_2_CHAR_TERM = _Anonymous_2._SC_2_CHAR_TERM;
    enum _SC_2_C_VERSION = _Anonymous_2._SC_2_C_VERSION;
    enum _SC_2_UPE = _Anonymous_2._SC_2_UPE;
    enum _SC_XOPEN_XPG2 = _Anonymous_2._SC_XOPEN_XPG2;
    enum _SC_XOPEN_XPG3 = _Anonymous_2._SC_XOPEN_XPG3;
    enum _SC_XOPEN_XPG4 = _Anonymous_2._SC_XOPEN_XPG4;
    enum _SC_CHAR_BIT = _Anonymous_2._SC_CHAR_BIT;
    enum _SC_CHAR_MAX = _Anonymous_2._SC_CHAR_MAX;
    enum _SC_CHAR_MIN = _Anonymous_2._SC_CHAR_MIN;
    enum _SC_INT_MAX = _Anonymous_2._SC_INT_MAX;
    enum _SC_INT_MIN = _Anonymous_2._SC_INT_MIN;
    enum _SC_LONG_BIT = _Anonymous_2._SC_LONG_BIT;
    enum _SC_WORD_BIT = _Anonymous_2._SC_WORD_BIT;
    enum _SC_MB_LEN_MAX = _Anonymous_2._SC_MB_LEN_MAX;
    enum _SC_NZERO = _Anonymous_2._SC_NZERO;
    enum _SC_SSIZE_MAX = _Anonymous_2._SC_SSIZE_MAX;
    enum _SC_SCHAR_MAX = _Anonymous_2._SC_SCHAR_MAX;
    enum _SC_SCHAR_MIN = _Anonymous_2._SC_SCHAR_MIN;
    enum _SC_SHRT_MAX = _Anonymous_2._SC_SHRT_MAX;
    enum _SC_SHRT_MIN = _Anonymous_2._SC_SHRT_MIN;
    enum _SC_UCHAR_MAX = _Anonymous_2._SC_UCHAR_MAX;
    enum _SC_UINT_MAX = _Anonymous_2._SC_UINT_MAX;
    enum _SC_ULONG_MAX = _Anonymous_2._SC_ULONG_MAX;
    enum _SC_USHRT_MAX = _Anonymous_2._SC_USHRT_MAX;
    enum _SC_NL_ARGMAX = _Anonymous_2._SC_NL_ARGMAX;
    enum _SC_NL_LANGMAX = _Anonymous_2._SC_NL_LANGMAX;
    enum _SC_NL_MSGMAX = _Anonymous_2._SC_NL_MSGMAX;
    enum _SC_NL_NMAX = _Anonymous_2._SC_NL_NMAX;
    enum _SC_NL_SETMAX = _Anonymous_2._SC_NL_SETMAX;
    enum _SC_NL_TEXTMAX = _Anonymous_2._SC_NL_TEXTMAX;
    enum _SC_XBS5_ILP32_OFF32 = _Anonymous_2._SC_XBS5_ILP32_OFF32;
    enum _SC_XBS5_ILP32_OFFBIG = _Anonymous_2._SC_XBS5_ILP32_OFFBIG;
    enum _SC_XBS5_LP64_OFF64 = _Anonymous_2._SC_XBS5_LP64_OFF64;
    enum _SC_XBS5_LPBIG_OFFBIG = _Anonymous_2._SC_XBS5_LPBIG_OFFBIG;
    enum _SC_XOPEN_LEGACY = _Anonymous_2._SC_XOPEN_LEGACY;
    enum _SC_XOPEN_REALTIME = _Anonymous_2._SC_XOPEN_REALTIME;
    enum _SC_XOPEN_REALTIME_THREADS = _Anonymous_2._SC_XOPEN_REALTIME_THREADS;
    enum _SC_ADVISORY_INFO = _Anonymous_2._SC_ADVISORY_INFO;
    enum _SC_BARRIERS = _Anonymous_2._SC_BARRIERS;
    enum _SC_BASE = _Anonymous_2._SC_BASE;
    enum _SC_C_LANG_SUPPORT = _Anonymous_2._SC_C_LANG_SUPPORT;
    enum _SC_C_LANG_SUPPORT_R = _Anonymous_2._SC_C_LANG_SUPPORT_R;
    enum _SC_CLOCK_SELECTION = _Anonymous_2._SC_CLOCK_SELECTION;
    enum _SC_CPUTIME = _Anonymous_2._SC_CPUTIME;
    enum _SC_THREAD_CPUTIME = _Anonymous_2._SC_THREAD_CPUTIME;
    enum _SC_DEVICE_IO = _Anonymous_2._SC_DEVICE_IO;
    enum _SC_DEVICE_SPECIFIC = _Anonymous_2._SC_DEVICE_SPECIFIC;
    enum _SC_DEVICE_SPECIFIC_R = _Anonymous_2._SC_DEVICE_SPECIFIC_R;
    enum _SC_FD_MGMT = _Anonymous_2._SC_FD_MGMT;
    enum _SC_FIFO = _Anonymous_2._SC_FIFO;
    enum _SC_PIPE = _Anonymous_2._SC_PIPE;
    enum _SC_FILE_ATTRIBUTES = _Anonymous_2._SC_FILE_ATTRIBUTES;
    enum _SC_FILE_LOCKING = _Anonymous_2._SC_FILE_LOCKING;
    enum _SC_FILE_SYSTEM = _Anonymous_2._SC_FILE_SYSTEM;
    enum _SC_MONOTONIC_CLOCK = _Anonymous_2._SC_MONOTONIC_CLOCK;
    enum _SC_MULTI_PROCESS = _Anonymous_2._SC_MULTI_PROCESS;
    enum _SC_SINGLE_PROCESS = _Anonymous_2._SC_SINGLE_PROCESS;
    enum _SC_NETWORKING = _Anonymous_2._SC_NETWORKING;
    enum _SC_READER_WRITER_LOCKS = _Anonymous_2._SC_READER_WRITER_LOCKS;
    enum _SC_SPIN_LOCKS = _Anonymous_2._SC_SPIN_LOCKS;
    enum _SC_REGEXP = _Anonymous_2._SC_REGEXP;
    enum _SC_REGEX_VERSION = _Anonymous_2._SC_REGEX_VERSION;
    enum _SC_SHELL = _Anonymous_2._SC_SHELL;
    enum _SC_SIGNALS = _Anonymous_2._SC_SIGNALS;
    enum _SC_SPAWN = _Anonymous_2._SC_SPAWN;
    enum _SC_SPORADIC_SERVER = _Anonymous_2._SC_SPORADIC_SERVER;
    enum _SC_THREAD_SPORADIC_SERVER = _Anonymous_2._SC_THREAD_SPORADIC_SERVER;
    enum _SC_SYSTEM_DATABASE = _Anonymous_2._SC_SYSTEM_DATABASE;
    enum _SC_SYSTEM_DATABASE_R = _Anonymous_2._SC_SYSTEM_DATABASE_R;
    enum _SC_TIMEOUTS = _Anonymous_2._SC_TIMEOUTS;
    enum _SC_TYPED_MEMORY_OBJECTS = _Anonymous_2._SC_TYPED_MEMORY_OBJECTS;
    enum _SC_USER_GROUPS = _Anonymous_2._SC_USER_GROUPS;
    enum _SC_USER_GROUPS_R = _Anonymous_2._SC_USER_GROUPS_R;
    enum _SC_2_PBS = _Anonymous_2._SC_2_PBS;
    enum _SC_2_PBS_ACCOUNTING = _Anonymous_2._SC_2_PBS_ACCOUNTING;
    enum _SC_2_PBS_LOCATE = _Anonymous_2._SC_2_PBS_LOCATE;
    enum _SC_2_PBS_MESSAGE = _Anonymous_2._SC_2_PBS_MESSAGE;
    enum _SC_2_PBS_TRACK = _Anonymous_2._SC_2_PBS_TRACK;
    enum _SC_SYMLOOP_MAX = _Anonymous_2._SC_SYMLOOP_MAX;
    enum _SC_STREAMS = _Anonymous_2._SC_STREAMS;
    enum _SC_2_PBS_CHECKPOINT = _Anonymous_2._SC_2_PBS_CHECKPOINT;
    enum _SC_V6_ILP32_OFF32 = _Anonymous_2._SC_V6_ILP32_OFF32;
    enum _SC_V6_ILP32_OFFBIG = _Anonymous_2._SC_V6_ILP32_OFFBIG;
    enum _SC_V6_LP64_OFF64 = _Anonymous_2._SC_V6_LP64_OFF64;
    enum _SC_V6_LPBIG_OFFBIG = _Anonymous_2._SC_V6_LPBIG_OFFBIG;
    enum _SC_HOST_NAME_MAX = _Anonymous_2._SC_HOST_NAME_MAX;
    enum _SC_TRACE = _Anonymous_2._SC_TRACE;
    enum _SC_TRACE_EVENT_FILTER = _Anonymous_2._SC_TRACE_EVENT_FILTER;
    enum _SC_TRACE_INHERIT = _Anonymous_2._SC_TRACE_INHERIT;
    enum _SC_TRACE_LOG = _Anonymous_2._SC_TRACE_LOG;
    enum _SC_LEVEL1_ICACHE_SIZE = _Anonymous_2._SC_LEVEL1_ICACHE_SIZE;
    enum _SC_LEVEL1_ICACHE_ASSOC = _Anonymous_2._SC_LEVEL1_ICACHE_ASSOC;
    enum _SC_LEVEL1_ICACHE_LINESIZE = _Anonymous_2._SC_LEVEL1_ICACHE_LINESIZE;
    enum _SC_LEVEL1_DCACHE_SIZE = _Anonymous_2._SC_LEVEL1_DCACHE_SIZE;
    enum _SC_LEVEL1_DCACHE_ASSOC = _Anonymous_2._SC_LEVEL1_DCACHE_ASSOC;
    enum _SC_LEVEL1_DCACHE_LINESIZE = _Anonymous_2._SC_LEVEL1_DCACHE_LINESIZE;
    enum _SC_LEVEL2_CACHE_SIZE = _Anonymous_2._SC_LEVEL2_CACHE_SIZE;
    enum _SC_LEVEL2_CACHE_ASSOC = _Anonymous_2._SC_LEVEL2_CACHE_ASSOC;
    enum _SC_LEVEL2_CACHE_LINESIZE = _Anonymous_2._SC_LEVEL2_CACHE_LINESIZE;
    enum _SC_LEVEL3_CACHE_SIZE = _Anonymous_2._SC_LEVEL3_CACHE_SIZE;
    enum _SC_LEVEL3_CACHE_ASSOC = _Anonymous_2._SC_LEVEL3_CACHE_ASSOC;
    enum _SC_LEVEL3_CACHE_LINESIZE = _Anonymous_2._SC_LEVEL3_CACHE_LINESIZE;
    enum _SC_LEVEL4_CACHE_SIZE = _Anonymous_2._SC_LEVEL4_CACHE_SIZE;
    enum _SC_LEVEL4_CACHE_ASSOC = _Anonymous_2._SC_LEVEL4_CACHE_ASSOC;
    enum _SC_LEVEL4_CACHE_LINESIZE = _Anonymous_2._SC_LEVEL4_CACHE_LINESIZE;
    enum _SC_IPV6 = _Anonymous_2._SC_IPV6;
    enum _SC_RAW_SOCKETS = _Anonymous_2._SC_RAW_SOCKETS;
    enum _SC_V7_ILP32_OFF32 = _Anonymous_2._SC_V7_ILP32_OFF32;
    enum _SC_V7_ILP32_OFFBIG = _Anonymous_2._SC_V7_ILP32_OFFBIG;
    enum _SC_V7_LP64_OFF64 = _Anonymous_2._SC_V7_LP64_OFF64;
    enum _SC_V7_LPBIG_OFFBIG = _Anonymous_2._SC_V7_LPBIG_OFFBIG;
    enum _SC_SS_REPL_MAX = _Anonymous_2._SC_SS_REPL_MAX;
    enum _SC_TRACE_EVENT_NAME_MAX = _Anonymous_2._SC_TRACE_EVENT_NAME_MAX;
    enum _SC_TRACE_NAME_MAX = _Anonymous_2._SC_TRACE_NAME_MAX;
    enum _SC_TRACE_SYS_MAX = _Anonymous_2._SC_TRACE_SYS_MAX;
    enum _SC_TRACE_USER_EVENT_MAX = _Anonymous_2._SC_TRACE_USER_EVENT_MAX;
    enum _SC_XOPEN_STREAMS = _Anonymous_2._SC_XOPEN_STREAMS;
    enum _SC_THREAD_ROBUST_PRIO_INHERIT = _Anonymous_2._SC_THREAD_ROBUST_PRIO_INHERIT;
    enum _SC_THREAD_ROBUST_PRIO_PROTECT = _Anonymous_2._SC_THREAD_ROBUST_PRIO_PROTECT;
    int pclose(_IO_FILE*) @nogc nothrow;
    _IO_FILE* popen(const(char)*, const(char)*) @nogc nothrow;
    int fileno_unlocked(_IO_FILE*) @nogc nothrow;
    int fileno(_IO_FILE*) @nogc nothrow;
    void perror(const(char)*) @nogc nothrow;
    int ferror_unlocked(_IO_FILE*) @nogc nothrow;
    int feof_unlocked(_IO_FILE*) @nogc nothrow;
    void clearerr_unlocked(_IO_FILE*) @nogc nothrow;
    int ferror(_IO_FILE*) @nogc nothrow;
    int feof(_IO_FILE*) @nogc nothrow;
    void clearerr(_IO_FILE*) @nogc nothrow;
    int fsetpos(_IO_FILE*, const(_G_fpos_t)*) @nogc nothrow;
    int fgetpos(_IO_FILE*, _G_fpos_t*) @nogc nothrow;
    c_long ftello(_IO_FILE*) @nogc nothrow;
    int fseeko(_IO_FILE*, c_long, int) @nogc nothrow;
    void rewind(_IO_FILE*) @nogc nothrow;
    c_long ftell(_IO_FILE*) @nogc nothrow;
    int fseek(_IO_FILE*, c_long, int) @nogc nothrow;
    c_ulong fwrite_unlocked(const(void)*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fread_unlocked(void*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fwrite(const(void)*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fread(void*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    int ungetc(int, _IO_FILE*) @nogc nothrow;
    int puts(const(char)*) @nogc nothrow;
    int fputs(const(char)*, _IO_FILE*) @nogc nothrow;
    c_long getline(char**, c_ulong*, _IO_FILE*) @nogc nothrow;
    c_long getdelim(char**, c_ulong*, int, _IO_FILE*) @nogc nothrow;
    c_long __getdelim(char**, c_ulong*, int, _IO_FILE*) @nogc nothrow;
    char* fgets(char*, int, _IO_FILE*) @nogc nothrow;
    int putw(int, _IO_FILE*) @nogc nothrow;
    int getw(_IO_FILE*) @nogc nothrow;
    int putchar_unlocked(int) @nogc nothrow;
    int putc_unlocked(int, _IO_FILE*) @nogc nothrow;
    int fputc_unlocked(int, _IO_FILE*) @nogc nothrow;
    int putchar(int) @nogc nothrow;
    int putc(int, _IO_FILE*) @nogc nothrow;
    int fputc(int, _IO_FILE*) @nogc nothrow;
    int fgetc_unlocked(_IO_FILE*) @nogc nothrow;
    int getchar_unlocked() @nogc nothrow;
    int getc_unlocked(_IO_FILE*) @nogc nothrow;
    int getchar() @nogc nothrow;
    int getc(_IO_FILE*) @nogc nothrow;
    int fgetc(_IO_FILE*) @nogc nothrow;
    int vsscanf(const(char)*, const(char)*, va_list*) @nogc nothrow;
    int vscanf(const(char)*, va_list*) @nogc nothrow;
    int vfscanf(_IO_FILE*, const(char)*, va_list*) @nogc nothrow;
    int sscanf(const(char)*, const(char)*, ...) @nogc nothrow;
    int scanf(const(char)*, ...) @nogc nothrow;
    int fscanf(_IO_FILE*, const(char)*, ...) @nogc nothrow;
    int dprintf(int, const(char)*, ...) @nogc nothrow;
    int vdprintf(int, const(char)*, va_list*) @nogc nothrow;
    int vsnprintf(char*, c_ulong, const(char)*, va_list*) @nogc nothrow;
    int snprintf(char*, c_ulong, const(char)*, ...) @nogc nothrow;
    int vsprintf(char*, const(char)*, va_list*) @nogc nothrow;
    int vprintf(const(char)*, va_list*) @nogc nothrow;
    int vfprintf(_IO_FILE*, const(char)*, va_list*) @nogc nothrow;
    int sprintf(char*, const(char)*, ...) @nogc nothrow;
    int printf(const(char)*, ...) @nogc nothrow;
    int fprintf(_IO_FILE*, const(char)*, ...) @nogc nothrow;
    void setlinebuf(_IO_FILE*) @nogc nothrow;
    void setbuffer(_IO_FILE*, char*, c_ulong) @nogc nothrow;
    int setvbuf(_IO_FILE*, char*, int, c_ulong) @nogc nothrow;
    void setbuf(_IO_FILE*, char*) @nogc nothrow;
    _IO_FILE* open_memstream(char**, c_ulong*) @nogc nothrow;
    _IO_FILE* fmemopen(void*, c_ulong, const(char)*) @nogc nothrow;
    _IO_FILE* fdopen(int, const(char)*) @nogc nothrow;
    _IO_FILE* freopen(const(char)*, const(char)*, _IO_FILE*) @nogc nothrow;
    _IO_FILE* fopen(const(char)*, const(char)*) @nogc nothrow;
    int fflush_unlocked(_IO_FILE*) @nogc nothrow;
    int fflush(_IO_FILE*) @nogc nothrow;
    int fclose(_IO_FILE*) @nogc nothrow;
    char* tempnam(const(char)*, const(char)*) @nogc nothrow;
    char* tmpnam_r(char*) @nogc nothrow;
    char* tmpnam(char*) @nogc nothrow;
    _IO_FILE* tmpfile() @nogc nothrow;
    int renameat(int, const(char)*, int, const(char)*) @nogc nothrow;
    int rename(const(char)*, const(char)*) @nogc nothrow;
    int remove(const(char)*) @nogc nothrow;
    extern __gshared _IO_FILE* stderr;
    extern __gshared _IO_FILE* stdout;
    extern __gshared _IO_FILE* stdin;
    alias fpos_t = _G_fpos_t;
    alias uintmax_t = c_ulong;
    alias intmax_t = c_long;
    alias uintptr_t = c_ulong;
    alias intptr_t = c_long;
    alias uint_fast64_t = c_ulong;
    enum _Anonymous_3
    {
        _CS_PATH = 0,
        _CS_V6_WIDTH_RESTRICTED_ENVS = 1,
        _CS_GNU_LIBC_VERSION = 2,
        _CS_GNU_LIBPTHREAD_VERSION = 3,
        _CS_V5_WIDTH_RESTRICTED_ENVS = 4,
        _CS_V7_WIDTH_RESTRICTED_ENVS = 5,
        _CS_LFS_CFLAGS = 1000,
        _CS_LFS_LDFLAGS = 1001,
        _CS_LFS_LIBS = 1002,
        _CS_LFS_LINTFLAGS = 1003,
        _CS_LFS64_CFLAGS = 1004,
        _CS_LFS64_LDFLAGS = 1005,
        _CS_LFS64_LIBS = 1006,
        _CS_LFS64_LINTFLAGS = 1007,
        _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,
        _CS_XBS5_ILP32_OFF32_LDFLAGS = 1101,
        _CS_XBS5_ILP32_OFF32_LIBS = 1102,
        _CS_XBS5_ILP32_OFF32_LINTFLAGS = 1103,
        _CS_XBS5_ILP32_OFFBIG_CFLAGS = 1104,
        _CS_XBS5_ILP32_OFFBIG_LDFLAGS = 1105,
        _CS_XBS5_ILP32_OFFBIG_LIBS = 1106,
        _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = 1107,
        _CS_XBS5_LP64_OFF64_CFLAGS = 1108,
        _CS_XBS5_LP64_OFF64_LDFLAGS = 1109,
        _CS_XBS5_LP64_OFF64_LIBS = 1110,
        _CS_XBS5_LP64_OFF64_LINTFLAGS = 1111,
        _CS_XBS5_LPBIG_OFFBIG_CFLAGS = 1112,
        _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = 1113,
        _CS_XBS5_LPBIG_OFFBIG_LIBS = 1114,
        _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = 1115,
        _CS_POSIX_V6_ILP32_OFF32_CFLAGS = 1116,
        _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = 1117,
        _CS_POSIX_V6_ILP32_OFF32_LIBS = 1118,
        _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = 1119,
        _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = 1120,
        _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = 1121,
        _CS_POSIX_V6_ILP32_OFFBIG_LIBS = 1122,
        _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = 1123,
        _CS_POSIX_V6_LP64_OFF64_CFLAGS = 1124,
        _CS_POSIX_V6_LP64_OFF64_LDFLAGS = 1125,
        _CS_POSIX_V6_LP64_OFF64_LIBS = 1126,
        _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = 1127,
        _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = 1128,
        _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = 1129,
        _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = 1130,
        _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = 1131,
        _CS_POSIX_V7_ILP32_OFF32_CFLAGS = 1132,
        _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = 1133,
        _CS_POSIX_V7_ILP32_OFF32_LIBS = 1134,
        _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = 1135,
        _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = 1136,
        _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = 1137,
        _CS_POSIX_V7_ILP32_OFFBIG_LIBS = 1138,
        _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = 1139,
        _CS_POSIX_V7_LP64_OFF64_CFLAGS = 1140,
        _CS_POSIX_V7_LP64_OFF64_LDFLAGS = 1141,
        _CS_POSIX_V7_LP64_OFF64_LIBS = 1142,
        _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = 1143,
        _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = 1144,
        _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = 1145,
        _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = 1146,
        _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = 1147,
        _CS_V6_ENV = 1148,
        _CS_V7_ENV = 1149,
    }
    enum _CS_PATH = _Anonymous_3._CS_PATH;
    enum _CS_V6_WIDTH_RESTRICTED_ENVS = _Anonymous_3._CS_V6_WIDTH_RESTRICTED_ENVS;
    enum _CS_GNU_LIBC_VERSION = _Anonymous_3._CS_GNU_LIBC_VERSION;
    enum _CS_GNU_LIBPTHREAD_VERSION = _Anonymous_3._CS_GNU_LIBPTHREAD_VERSION;
    enum _CS_V5_WIDTH_RESTRICTED_ENVS = _Anonymous_3._CS_V5_WIDTH_RESTRICTED_ENVS;
    enum _CS_V7_WIDTH_RESTRICTED_ENVS = _Anonymous_3._CS_V7_WIDTH_RESTRICTED_ENVS;
    enum _CS_LFS_CFLAGS = _Anonymous_3._CS_LFS_CFLAGS;
    enum _CS_LFS_LDFLAGS = _Anonymous_3._CS_LFS_LDFLAGS;
    enum _CS_LFS_LIBS = _Anonymous_3._CS_LFS_LIBS;
    enum _CS_LFS_LINTFLAGS = _Anonymous_3._CS_LFS_LINTFLAGS;
    enum _CS_LFS64_CFLAGS = _Anonymous_3._CS_LFS64_CFLAGS;
    enum _CS_LFS64_LDFLAGS = _Anonymous_3._CS_LFS64_LDFLAGS;
    enum _CS_LFS64_LIBS = _Anonymous_3._CS_LFS64_LIBS;
    enum _CS_LFS64_LINTFLAGS = _Anonymous_3._CS_LFS64_LINTFLAGS;
    enum _CS_XBS5_ILP32_OFF32_CFLAGS = _Anonymous_3._CS_XBS5_ILP32_OFF32_CFLAGS;
    enum _CS_XBS5_ILP32_OFF32_LDFLAGS = _Anonymous_3._CS_XBS5_ILP32_OFF32_LDFLAGS;
    enum _CS_XBS5_ILP32_OFF32_LIBS = _Anonymous_3._CS_XBS5_ILP32_OFF32_LIBS;
    enum _CS_XBS5_ILP32_OFF32_LINTFLAGS = _Anonymous_3._CS_XBS5_ILP32_OFF32_LINTFLAGS;
    enum _CS_XBS5_ILP32_OFFBIG_CFLAGS = _Anonymous_3._CS_XBS5_ILP32_OFFBIG_CFLAGS;
    enum _CS_XBS5_ILP32_OFFBIG_LDFLAGS = _Anonymous_3._CS_XBS5_ILP32_OFFBIG_LDFLAGS;
    enum _CS_XBS5_ILP32_OFFBIG_LIBS = _Anonymous_3._CS_XBS5_ILP32_OFFBIG_LIBS;
    enum _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = _Anonymous_3._CS_XBS5_ILP32_OFFBIG_LINTFLAGS;
    enum _CS_XBS5_LP64_OFF64_CFLAGS = _Anonymous_3._CS_XBS5_LP64_OFF64_CFLAGS;
    enum _CS_XBS5_LP64_OFF64_LDFLAGS = _Anonymous_3._CS_XBS5_LP64_OFF64_LDFLAGS;
    enum _CS_XBS5_LP64_OFF64_LIBS = _Anonymous_3._CS_XBS5_LP64_OFF64_LIBS;
    enum _CS_XBS5_LP64_OFF64_LINTFLAGS = _Anonymous_3._CS_XBS5_LP64_OFF64_LINTFLAGS;
    enum _CS_XBS5_LPBIG_OFFBIG_CFLAGS = _Anonymous_3._CS_XBS5_LPBIG_OFFBIG_CFLAGS;
    enum _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = _Anonymous_3._CS_XBS5_LPBIG_OFFBIG_LDFLAGS;
    enum _CS_XBS5_LPBIG_OFFBIG_LIBS = _Anonymous_3._CS_XBS5_LPBIG_OFFBIG_LIBS;
    enum _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = _Anonymous_3._CS_XBS5_LPBIG_OFFBIG_LINTFLAGS;
    enum _CS_POSIX_V6_ILP32_OFF32_CFLAGS = _Anonymous_3._CS_POSIX_V6_ILP32_OFF32_CFLAGS;
    enum _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = _Anonymous_3._CS_POSIX_V6_ILP32_OFF32_LDFLAGS;
    enum _CS_POSIX_V6_ILP32_OFF32_LIBS = _Anonymous_3._CS_POSIX_V6_ILP32_OFF32_LIBS;
    enum _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = _Anonymous_3._CS_POSIX_V6_ILP32_OFF32_LINTFLAGS;
    enum _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = _Anonymous_3._CS_POSIX_V6_ILP32_OFFBIG_CFLAGS;
    enum _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = _Anonymous_3._CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS;
    enum _CS_POSIX_V6_ILP32_OFFBIG_LIBS = _Anonymous_3._CS_POSIX_V6_ILP32_OFFBIG_LIBS;
    enum _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = _Anonymous_3._CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS;
    enum _CS_POSIX_V6_LP64_OFF64_CFLAGS = _Anonymous_3._CS_POSIX_V6_LP64_OFF64_CFLAGS;
    enum _CS_POSIX_V6_LP64_OFF64_LDFLAGS = _Anonymous_3._CS_POSIX_V6_LP64_OFF64_LDFLAGS;
    enum _CS_POSIX_V6_LP64_OFF64_LIBS = _Anonymous_3._CS_POSIX_V6_LP64_OFF64_LIBS;
    enum _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = _Anonymous_3._CS_POSIX_V6_LP64_OFF64_LINTFLAGS;
    enum _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = _Anonymous_3._CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS;
    enum _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = _Anonymous_3._CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS;
    enum _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = _Anonymous_3._CS_POSIX_V6_LPBIG_OFFBIG_LIBS;
    enum _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = _Anonymous_3._CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS;
    enum _CS_POSIX_V7_ILP32_OFF32_CFLAGS = _Anonymous_3._CS_POSIX_V7_ILP32_OFF32_CFLAGS;
    enum _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = _Anonymous_3._CS_POSIX_V7_ILP32_OFF32_LDFLAGS;
    enum _CS_POSIX_V7_ILP32_OFF32_LIBS = _Anonymous_3._CS_POSIX_V7_ILP32_OFF32_LIBS;
    enum _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = _Anonymous_3._CS_POSIX_V7_ILP32_OFF32_LINTFLAGS;
    enum _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = _Anonymous_3._CS_POSIX_V7_ILP32_OFFBIG_CFLAGS;
    enum _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = _Anonymous_3._CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS;
    enum _CS_POSIX_V7_ILP32_OFFBIG_LIBS = _Anonymous_3._CS_POSIX_V7_ILP32_OFFBIG_LIBS;
    enum _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = _Anonymous_3._CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS;
    enum _CS_POSIX_V7_LP64_OFF64_CFLAGS = _Anonymous_3._CS_POSIX_V7_LP64_OFF64_CFLAGS;
    enum _CS_POSIX_V7_LP64_OFF64_LDFLAGS = _Anonymous_3._CS_POSIX_V7_LP64_OFF64_LDFLAGS;
    enum _CS_POSIX_V7_LP64_OFF64_LIBS = _Anonymous_3._CS_POSIX_V7_LP64_OFF64_LIBS;
    enum _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = _Anonymous_3._CS_POSIX_V7_LP64_OFF64_LINTFLAGS;
    enum _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = _Anonymous_3._CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS;
    enum _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = _Anonymous_3._CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS;
    enum _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = _Anonymous_3._CS_POSIX_V7_LPBIG_OFFBIG_LIBS;
    enum _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = _Anonymous_3._CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS;
    enum _CS_V6_ENV = _Anonymous_3._CS_V6_ENV;
    enum _CS_V7_ENV = _Anonymous_3._CS_V7_ENV;
    alias uint_fast32_t = c_ulong;
    alias uint_fast16_t = c_ulong;
    alias uint_fast8_t = ubyte;
    alias int_fast64_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast16_t = c_long;
    alias int_fast8_t = byte;
    alias uint_least64_t = c_ulong;
    alias uint_least32_t = uint;
    alias uint_least16_t = ushort;
    alias uint_least8_t = ubyte;
    alias int_least64_t = c_long;
    alias int_least32_t = int;
    alias int_least16_t = short;
    alias int_least8_t = byte;
    void if_freenameindex(if_nameindex*) @nogc nothrow;
    pragma(mangle, "if_nameindex") if_nameindex* if_nameindex_() @nogc nothrow;
    char* if_indextoname(uint, char*) @nogc nothrow;
    uint if_nametoindex(const(char)*) @nogc nothrow;
    struct ifconf
    {
        int ifc_len;
        static union _Anonymous_4
        {
            char* ifcu_buf;
            ifreq* ifcu_req;
        }
        _Anonymous_4 ifc_ifcu;
    }
    struct ifreq
    {
        static union _Anonymous_5
        {
            char[16] ifrn_name;
        }
        _Anonymous_5 ifr_ifrn;
        static union _Anonymous_6
        {
            sockaddr ifru_addr;
            sockaddr ifru_dstaddr;
            sockaddr ifru_broadaddr;
            sockaddr ifru_netmask;
            sockaddr ifru_hwaddr;
            short ifru_flags;
            int ifru_ivalue;
            int ifru_mtu;
            ifmap ifru_map;
            char[16] ifru_slave;
            char[16] ifru_newname;
            char* ifru_data;
        }
        _Anonymous_6 ifr_ifru;
    }
    struct ifmap
    {
        c_ulong mem_start;
        c_ulong mem_end;
        ushort base_addr;
        ubyte irq;
        ubyte dma;
        ubyte port;
    }
    struct ifaddr
    {
        sockaddr ifa_addr;
        static union _Anonymous_7
        {
            sockaddr ifu_broadaddr;
            sockaddr ifu_dstaddr;
        }
        _Anonymous_7 ifa_ifu;
        iface* ifa_ifp;
        ifaddr* ifa_next;
    }
    enum _Anonymous_8
    {
        IFF_UP = 1,
        IFF_BROADCAST = 2,
        IFF_DEBUG = 4,
        IFF_LOOPBACK = 8,
        IFF_POINTOPOINT = 16,
        IFF_NOTRAILERS = 32,
        IFF_RUNNING = 64,
        IFF_NOARP = 128,
        IFF_PROMISC = 256,
        IFF_ALLMULTI = 512,
        IFF_MASTER = 1024,
        IFF_SLAVE = 2048,
        IFF_MULTICAST = 4096,
        IFF_PORTSEL = 8192,
        IFF_AUTOMEDIA = 16384,
        IFF_DYNAMIC = 32768,
    }
    enum IFF_UP = _Anonymous_8.IFF_UP;
    enum IFF_BROADCAST = _Anonymous_8.IFF_BROADCAST;
    enum IFF_DEBUG = _Anonymous_8.IFF_DEBUG;
    enum IFF_LOOPBACK = _Anonymous_8.IFF_LOOPBACK;
    enum IFF_POINTOPOINT = _Anonymous_8.IFF_POINTOPOINT;
    enum IFF_NOTRAILERS = _Anonymous_8.IFF_NOTRAILERS;
    enum IFF_RUNNING = _Anonymous_8.IFF_RUNNING;
    enum IFF_NOARP = _Anonymous_8.IFF_NOARP;
    enum IFF_PROMISC = _Anonymous_8.IFF_PROMISC;
    enum IFF_ALLMULTI = _Anonymous_8.IFF_ALLMULTI;
    enum IFF_MASTER = _Anonymous_8.IFF_MASTER;
    enum IFF_SLAVE = _Anonymous_8.IFF_SLAVE;
    enum IFF_MULTICAST = _Anonymous_8.IFF_MULTICAST;
    enum IFF_PORTSEL = _Anonymous_8.IFF_PORTSEL;
    enum IFF_AUTOMEDIA = _Anonymous_8.IFF_AUTOMEDIA;
    enum IFF_DYNAMIC = _Anonymous_8.IFF_DYNAMIC;
    struct if_nameindex
    {
        uint if_index;
        char* if_name;
    }
    enum _Anonymous_9
    {
        VETH_INFO_UNSPEC = 0,
        VETH_INFO_PEER = 1,
        __VETH_INFO_MAX = 2,
    }
    enum VETH_INFO_UNSPEC = _Anonymous_9.VETH_INFO_UNSPEC;
    enum VETH_INFO_PEER = _Anonymous_9.VETH_INFO_PEER;
    enum __VETH_INFO_MAX = _Anonymous_9.__VETH_INFO_MAX;
    alias __poll_t = uint;
    alias __wsum = uint;
    alias __sum16 = ushort;
    alias __be64 = ulong;
    alias __le64 = ulong;
    alias __be32 = uint;
    alias __le32 = uint;
    alias __be16 = ushort;
    alias __le16 = ushort;
    struct sysinfo
    {
        c_long uptime;
        c_ulong[3] loads;
        c_ulong totalram;
        c_ulong freeram;
        c_ulong sharedram;
        c_ulong bufferram;
        c_ulong totalswap;
        c_ulong freeswap;
        ushort procs;
        ushort pad;
        c_ulong totalhigh;
        c_ulong freehigh;
        uint mem_unit;
        char[0] _f;
    }
    struct __kernel_sockaddr_storage
    {
        static union _Anonymous_10
        {
            static struct _Anonymous_11
            {
                ushort ss_family;
                char[126] __data;
            }
            _Anonymous_11 _anonymous_12;
            auto ss_family() @property @nogc pure nothrow { return _anonymous_12.ss_family; }
            void ss_family(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_12.ss_family = val; }
            auto __data() @property @nogc pure nothrow { return _anonymous_12.__data; }
            void __data(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_12.__data = val; }
            void* __align;
        }
        _Anonymous_10 _anonymous_13;
        auto ss_family() @property @nogc pure nothrow { return _anonymous_13.ss_family; }
        void ss_family(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.ss_family = val; }
        auto __data() @property @nogc pure nothrow { return _anonymous_13.__data; }
        void __data(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.__data = val; }
        auto __align() @property @nogc pure nothrow { return _anonymous_13.__align; }
        void __align(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.__align = val; }
    }
    alias __kernel_sa_family_t = ushort;
    enum _Anonymous_14
    {
        TCA_ROOT_UNSPEC = 0,
        TCA_ROOT_TAB = 1,
        TCA_ROOT_FLAGS = 2,
        TCA_ROOT_COUNT = 3,
        TCA_ROOT_TIME_DELTA = 4,
        __TCA_ROOT_MAX = 5,
    }
    enum TCA_ROOT_UNSPEC = _Anonymous_14.TCA_ROOT_UNSPEC;
    enum TCA_ROOT_TAB = _Anonymous_14.TCA_ROOT_TAB;
    enum TCA_ROOT_FLAGS = _Anonymous_14.TCA_ROOT_FLAGS;
    enum TCA_ROOT_COUNT = _Anonymous_14.TCA_ROOT_COUNT;
    enum TCA_ROOT_TIME_DELTA = _Anonymous_14.TCA_ROOT_TIME_DELTA;
    enum __TCA_ROOT_MAX = _Anonymous_14.__TCA_ROOT_MAX;
    struct tcamsg
    {
        ubyte tca_family;
        ubyte tca__pad1;
        ushort tca__pad2;
    }
    enum rtnetlink_groups
    {
        RTNLGRP_NONE = 0,
        RTNLGRP_LINK = 1,
        RTNLGRP_NOTIFY = 2,
        RTNLGRP_NEIGH = 3,
        RTNLGRP_TC = 4,
        RTNLGRP_IPV4_IFADDR = 5,
        RTNLGRP_IPV4_MROUTE = 6,
        RTNLGRP_IPV4_ROUTE = 7,
        RTNLGRP_IPV4_RULE = 8,
        RTNLGRP_IPV6_IFADDR = 9,
        RTNLGRP_IPV6_MROUTE = 10,
        RTNLGRP_IPV6_ROUTE = 11,
        RTNLGRP_IPV6_IFINFO = 12,
        RTNLGRP_DECnet_IFADDR = 13,
        RTNLGRP_NOP2 = 14,
        RTNLGRP_DECnet_ROUTE = 15,
        RTNLGRP_DECnet_RULE = 16,
        RTNLGRP_NOP4 = 17,
        RTNLGRP_IPV6_PREFIX = 18,
        RTNLGRP_IPV6_RULE = 19,
        RTNLGRP_ND_USEROPT = 20,
        RTNLGRP_PHONET_IFADDR = 21,
        RTNLGRP_PHONET_ROUTE = 22,
        RTNLGRP_DCB = 23,
        RTNLGRP_IPV4_NETCONF = 24,
        RTNLGRP_IPV6_NETCONF = 25,
        RTNLGRP_MDB = 26,
        RTNLGRP_MPLS_ROUTE = 27,
        RTNLGRP_NSID = 28,
        RTNLGRP_MPLS_NETCONF = 29,
        RTNLGRP_IPV4_MROUTE_R = 30,
        RTNLGRP_IPV6_MROUTE_R = 31,
        RTNLGRP_NEXTHOP = 32,
        __RTNLGRP_MAX = 33,
    }
    enum RTNLGRP_NONE = rtnetlink_groups.RTNLGRP_NONE;
    enum RTNLGRP_LINK = rtnetlink_groups.RTNLGRP_LINK;
    enum RTNLGRP_NOTIFY = rtnetlink_groups.RTNLGRP_NOTIFY;
    enum RTNLGRP_NEIGH = rtnetlink_groups.RTNLGRP_NEIGH;
    enum RTNLGRP_TC = rtnetlink_groups.RTNLGRP_TC;
    enum RTNLGRP_IPV4_IFADDR = rtnetlink_groups.RTNLGRP_IPV4_IFADDR;
    enum RTNLGRP_IPV4_MROUTE = rtnetlink_groups.RTNLGRP_IPV4_MROUTE;
    enum RTNLGRP_IPV4_ROUTE = rtnetlink_groups.RTNLGRP_IPV4_ROUTE;
    enum RTNLGRP_IPV4_RULE = rtnetlink_groups.RTNLGRP_IPV4_RULE;
    enum RTNLGRP_IPV6_IFADDR = rtnetlink_groups.RTNLGRP_IPV6_IFADDR;
    enum RTNLGRP_IPV6_MROUTE = rtnetlink_groups.RTNLGRP_IPV6_MROUTE;
    enum RTNLGRP_IPV6_ROUTE = rtnetlink_groups.RTNLGRP_IPV6_ROUTE;
    enum RTNLGRP_IPV6_IFINFO = rtnetlink_groups.RTNLGRP_IPV6_IFINFO;
    enum RTNLGRP_DECnet_IFADDR = rtnetlink_groups.RTNLGRP_DECnet_IFADDR;
    enum RTNLGRP_NOP2 = rtnetlink_groups.RTNLGRP_NOP2;
    enum RTNLGRP_DECnet_ROUTE = rtnetlink_groups.RTNLGRP_DECnet_ROUTE;
    enum RTNLGRP_DECnet_RULE = rtnetlink_groups.RTNLGRP_DECnet_RULE;
    enum RTNLGRP_NOP4 = rtnetlink_groups.RTNLGRP_NOP4;
    enum RTNLGRP_IPV6_PREFIX = rtnetlink_groups.RTNLGRP_IPV6_PREFIX;
    enum RTNLGRP_IPV6_RULE = rtnetlink_groups.RTNLGRP_IPV6_RULE;
    enum RTNLGRP_ND_USEROPT = rtnetlink_groups.RTNLGRP_ND_USEROPT;
    enum RTNLGRP_PHONET_IFADDR = rtnetlink_groups.RTNLGRP_PHONET_IFADDR;
    enum RTNLGRP_PHONET_ROUTE = rtnetlink_groups.RTNLGRP_PHONET_ROUTE;
    enum RTNLGRP_DCB = rtnetlink_groups.RTNLGRP_DCB;
    enum RTNLGRP_IPV4_NETCONF = rtnetlink_groups.RTNLGRP_IPV4_NETCONF;
    enum RTNLGRP_IPV6_NETCONF = rtnetlink_groups.RTNLGRP_IPV6_NETCONF;
    enum RTNLGRP_MDB = rtnetlink_groups.RTNLGRP_MDB;
    enum RTNLGRP_MPLS_ROUTE = rtnetlink_groups.RTNLGRP_MPLS_ROUTE;
    enum RTNLGRP_NSID = rtnetlink_groups.RTNLGRP_NSID;
    enum RTNLGRP_MPLS_NETCONF = rtnetlink_groups.RTNLGRP_MPLS_NETCONF;
    enum RTNLGRP_IPV4_MROUTE_R = rtnetlink_groups.RTNLGRP_IPV4_MROUTE_R;
    enum RTNLGRP_IPV6_MROUTE_R = rtnetlink_groups.RTNLGRP_IPV6_MROUTE_R;
    enum RTNLGRP_NEXTHOP = rtnetlink_groups.RTNLGRP_NEXTHOP;
    enum __RTNLGRP_MAX = rtnetlink_groups.__RTNLGRP_MAX;
    enum _Anonymous_15
    {
        NDUSEROPT_UNSPEC = 0,
        NDUSEROPT_SRCADDR = 1,
        __NDUSEROPT_MAX = 2,
    }
    enum NDUSEROPT_UNSPEC = _Anonymous_15.NDUSEROPT_UNSPEC;
    enum NDUSEROPT_SRCADDR = _Anonymous_15.NDUSEROPT_SRCADDR;
    enum __NDUSEROPT_MAX = _Anonymous_15.__NDUSEROPT_MAX;
    struct nduseroptmsg
    {
        ubyte nduseropt_family;
        ubyte nduseropt_pad1;
        ushort nduseropt_opts_len;
        int nduseropt_ifindex;
        ubyte nduseropt_icmp_type;
        ubyte nduseropt_icmp_code;
        ushort nduseropt_pad2;
        uint nduseropt_pad3;
    }
    enum _Anonymous_16
    {
        TCA_UNSPEC = 0,
        TCA_KIND = 1,
        TCA_OPTIONS = 2,
        TCA_STATS = 3,
        TCA_XSTATS = 4,
        TCA_RATE = 5,
        TCA_FCNT = 6,
        TCA_STATS2 = 7,
        TCA_STAB = 8,
        TCA_PAD = 9,
        TCA_DUMP_INVISIBLE = 10,
        TCA_CHAIN = 11,
        TCA_HW_OFFLOAD = 12,
        TCA_INGRESS_BLOCK = 13,
        TCA_EGRESS_BLOCK = 14,
        __TCA_MAX = 15,
    }
    enum TCA_UNSPEC = _Anonymous_16.TCA_UNSPEC;
    enum TCA_KIND = _Anonymous_16.TCA_KIND;
    enum TCA_OPTIONS = _Anonymous_16.TCA_OPTIONS;
    enum TCA_STATS = _Anonymous_16.TCA_STATS;
    enum TCA_XSTATS = _Anonymous_16.TCA_XSTATS;
    enum TCA_RATE = _Anonymous_16.TCA_RATE;
    enum TCA_FCNT = _Anonymous_16.TCA_FCNT;
    enum TCA_STATS2 = _Anonymous_16.TCA_STATS2;
    enum TCA_STAB = _Anonymous_16.TCA_STAB;
    enum TCA_PAD = _Anonymous_16.TCA_PAD;
    enum TCA_DUMP_INVISIBLE = _Anonymous_16.TCA_DUMP_INVISIBLE;
    enum TCA_CHAIN = _Anonymous_16.TCA_CHAIN;
    enum TCA_HW_OFFLOAD = _Anonymous_16.TCA_HW_OFFLOAD;
    enum TCA_INGRESS_BLOCK = _Anonymous_16.TCA_INGRESS_BLOCK;
    enum TCA_EGRESS_BLOCK = _Anonymous_16.TCA_EGRESS_BLOCK;
    enum __TCA_MAX = _Anonymous_16.__TCA_MAX;
    struct tcmsg
    {
        ubyte tcm_family;
        ubyte tcm__pad1;
        ushort tcm__pad2;
        int tcm_ifindex;
        uint tcm_handle;
        uint tcm_parent;
        uint tcm_info;
    }
    struct prefix_cacheinfo
    {
        uint preferred_time;
        uint valid_time;
    }
    enum _Anonymous_17
    {
        PREFIX_UNSPEC = 0,
        PREFIX_ADDRESS = 1,
        PREFIX_CACHEINFO = 2,
        __PREFIX_MAX = 3,
    }
    enum PREFIX_UNSPEC = _Anonymous_17.PREFIX_UNSPEC;
    enum PREFIX_ADDRESS = _Anonymous_17.PREFIX_ADDRESS;
    enum PREFIX_CACHEINFO = _Anonymous_17.PREFIX_CACHEINFO;
    enum __PREFIX_MAX = _Anonymous_17.__PREFIX_MAX;
    struct prefixmsg
    {
        ubyte prefix_family;
        ubyte prefix_pad1;
        ushort prefix_pad2;
        int prefix_ifindex;
        ubyte prefix_type;
        ubyte prefix_len;
        ubyte prefix_flags;
        ubyte prefix_pad3;
    }
    struct ifinfomsg
    {
        ubyte ifi_family;
        ubyte __ifi_pad;
        ushort ifi_type;
        int ifi_index;
        uint ifi_flags;
        uint ifi_change;
    }
    struct rtgenmsg
    {
        ubyte rtgen_family;
    }
    struct rta_mfc_stats
    {
        ulong mfcs_packets;
        ulong mfcs_bytes;
        ulong mfcs_wrong_if;
    }
    struct rta_session
    {
        ubyte proto;
        ubyte pad1;
        ushort pad2;
        static union _Anonymous_18
        {
            static struct _Anonymous_19
            {
                ushort sport;
                ushort dport;
            }
            _Anonymous_19 ports;
            static struct _Anonymous_20
            {
                ubyte type;
                ubyte code;
                ushort ident;
            }
            _Anonymous_20 icmpt;
            uint spi;
        }
        _Anonymous_18 u;
    }
    enum _Anonymous_21
    {
        RTAX_UNSPEC = 0,
        RTAX_LOCK = 1,
        RTAX_MTU = 2,
        RTAX_WINDOW = 3,
        RTAX_RTT = 4,
        RTAX_RTTVAR = 5,
        RTAX_SSTHRESH = 6,
        RTAX_CWND = 7,
        RTAX_ADVMSS = 8,
        RTAX_REORDERING = 9,
        RTAX_HOPLIMIT = 10,
        RTAX_INITCWND = 11,
        RTAX_FEATURES = 12,
        RTAX_RTO_MIN = 13,
        RTAX_INITRWND = 14,
        RTAX_QUICKACK = 15,
        RTAX_CC_ALGO = 16,
        RTAX_FASTOPEN_NO_COOKIE = 17,
        __RTAX_MAX = 18,
    }
    enum RTAX_UNSPEC = _Anonymous_21.RTAX_UNSPEC;
    enum RTAX_LOCK = _Anonymous_21.RTAX_LOCK;
    enum RTAX_MTU = _Anonymous_21.RTAX_MTU;
    enum RTAX_WINDOW = _Anonymous_21.RTAX_WINDOW;
    enum RTAX_RTT = _Anonymous_21.RTAX_RTT;
    enum RTAX_RTTVAR = _Anonymous_21.RTAX_RTTVAR;
    enum RTAX_SSTHRESH = _Anonymous_21.RTAX_SSTHRESH;
    enum RTAX_CWND = _Anonymous_21.RTAX_CWND;
    enum RTAX_ADVMSS = _Anonymous_21.RTAX_ADVMSS;
    enum RTAX_REORDERING = _Anonymous_21.RTAX_REORDERING;
    enum RTAX_HOPLIMIT = _Anonymous_21.RTAX_HOPLIMIT;
    enum RTAX_INITCWND = _Anonymous_21.RTAX_INITCWND;
    enum RTAX_FEATURES = _Anonymous_21.RTAX_FEATURES;
    enum RTAX_RTO_MIN = _Anonymous_21.RTAX_RTO_MIN;
    enum RTAX_INITRWND = _Anonymous_21.RTAX_INITRWND;
    enum RTAX_QUICKACK = _Anonymous_21.RTAX_QUICKACK;
    enum RTAX_CC_ALGO = _Anonymous_21.RTAX_CC_ALGO;
    enum RTAX_FASTOPEN_NO_COOKIE = _Anonymous_21.RTAX_FASTOPEN_NO_COOKIE;
    enum __RTAX_MAX = _Anonymous_21.__RTAX_MAX;
    struct rta_cacheinfo
    {
        uint rta_clntref;
        uint rta_lastuse;
        int rta_expires;
        uint rta_error;
        uint rta_used;
        uint rta_id;
        uint rta_ts;
        uint rta_tsage;
    }
    struct rtvia
    {
        ushort rtvia_family;
        ubyte[0] rtvia_addr;
    }
    struct rtnexthop
    {
        ushort rtnh_len;
        ubyte rtnh_flags;
        ubyte rtnh_hops;
        int rtnh_ifindex;
    }
    enum rtattr_type_t
    {
        RTA_UNSPEC = 0,
        RTA_DST = 1,
        RTA_SRC = 2,
        RTA_IIF = 3,
        RTA_OIF = 4,
        RTA_GATEWAY = 5,
        RTA_PRIORITY = 6,
        RTA_PREFSRC = 7,
        RTA_METRICS = 8,
        RTA_MULTIPATH = 9,
        RTA_PROTOINFO = 10,
        RTA_FLOW = 11,
        RTA_CACHEINFO = 12,
        RTA_SESSION = 13,
        RTA_MP_ALGO = 14,
        RTA_TABLE = 15,
        RTA_MARK = 16,
        RTA_MFC_STATS = 17,
        RTA_VIA = 18,
        RTA_NEWDST = 19,
        RTA_PREF = 20,
        RTA_ENCAP_TYPE = 21,
        RTA_ENCAP = 22,
        RTA_EXPIRES = 23,
        RTA_PAD = 24,
        RTA_UID = 25,
        RTA_TTL_PROPAGATE = 26,
        RTA_IP_PROTO = 27,
        RTA_SPORT = 28,
        RTA_DPORT = 29,
        RTA_NH_ID = 30,
        __RTA_MAX = 31,
    }
    enum RTA_UNSPEC = rtattr_type_t.RTA_UNSPEC;
    enum RTA_DST = rtattr_type_t.RTA_DST;
    enum RTA_SRC = rtattr_type_t.RTA_SRC;
    enum RTA_IIF = rtattr_type_t.RTA_IIF;
    enum RTA_OIF = rtattr_type_t.RTA_OIF;
    enum RTA_GATEWAY = rtattr_type_t.RTA_GATEWAY;
    enum RTA_PRIORITY = rtattr_type_t.RTA_PRIORITY;
    enum RTA_PREFSRC = rtattr_type_t.RTA_PREFSRC;
    enum RTA_METRICS = rtattr_type_t.RTA_METRICS;
    enum RTA_MULTIPATH = rtattr_type_t.RTA_MULTIPATH;
    enum RTA_PROTOINFO = rtattr_type_t.RTA_PROTOINFO;
    enum RTA_FLOW = rtattr_type_t.RTA_FLOW;
    enum RTA_CACHEINFO = rtattr_type_t.RTA_CACHEINFO;
    enum RTA_SESSION = rtattr_type_t.RTA_SESSION;
    enum RTA_MP_ALGO = rtattr_type_t.RTA_MP_ALGO;
    enum RTA_TABLE = rtattr_type_t.RTA_TABLE;
    enum RTA_MARK = rtattr_type_t.RTA_MARK;
    enum RTA_MFC_STATS = rtattr_type_t.RTA_MFC_STATS;
    enum RTA_VIA = rtattr_type_t.RTA_VIA;
    enum RTA_NEWDST = rtattr_type_t.RTA_NEWDST;
    enum RTA_PREF = rtattr_type_t.RTA_PREF;
    enum RTA_ENCAP_TYPE = rtattr_type_t.RTA_ENCAP_TYPE;
    enum RTA_ENCAP = rtattr_type_t.RTA_ENCAP;
    enum RTA_EXPIRES = rtattr_type_t.RTA_EXPIRES;
    enum RTA_PAD = rtattr_type_t.RTA_PAD;
    enum RTA_UID = rtattr_type_t.RTA_UID;
    enum RTA_TTL_PROPAGATE = rtattr_type_t.RTA_TTL_PROPAGATE;
    enum RTA_IP_PROTO = rtattr_type_t.RTA_IP_PROTO;
    enum RTA_SPORT = rtattr_type_t.RTA_SPORT;
    enum RTA_DPORT = rtattr_type_t.RTA_DPORT;
    enum RTA_NH_ID = rtattr_type_t.RTA_NH_ID;
    enum __RTA_MAX = rtattr_type_t.__RTA_MAX;
    enum rt_class_t
    {
        RT_TABLE_UNSPEC = 0,
        RT_TABLE_COMPAT = 252,
        RT_TABLE_DEFAULT = 253,
        RT_TABLE_MAIN = 254,
        RT_TABLE_LOCAL = 255,
        RT_TABLE_MAX = -1,
    }
    enum RT_TABLE_UNSPEC = rt_class_t.RT_TABLE_UNSPEC;
    enum RT_TABLE_COMPAT = rt_class_t.RT_TABLE_COMPAT;
    enum RT_TABLE_DEFAULT = rt_class_t.RT_TABLE_DEFAULT;
    enum RT_TABLE_MAIN = rt_class_t.RT_TABLE_MAIN;
    enum RT_TABLE_LOCAL = rt_class_t.RT_TABLE_LOCAL;
    enum RT_TABLE_MAX = rt_class_t.RT_TABLE_MAX;
    enum rt_scope_t
    {
        RT_SCOPE_UNIVERSE = 0,
        RT_SCOPE_SITE = 200,
        RT_SCOPE_LINK = 253,
        RT_SCOPE_HOST = 254,
        RT_SCOPE_NOWHERE = 255,
    }
    enum RT_SCOPE_UNIVERSE = rt_scope_t.RT_SCOPE_UNIVERSE;
    enum RT_SCOPE_SITE = rt_scope_t.RT_SCOPE_SITE;
    enum RT_SCOPE_LINK = rt_scope_t.RT_SCOPE_LINK;
    enum RT_SCOPE_HOST = rt_scope_t.RT_SCOPE_HOST;
    enum RT_SCOPE_NOWHERE = rt_scope_t.RT_SCOPE_NOWHERE;
    enum _Anonymous_22
    {
        RTN_UNSPEC = 0,
        RTN_UNICAST = 1,
        RTN_LOCAL = 2,
        RTN_BROADCAST = 3,
        RTN_ANYCAST = 4,
        RTN_MULTICAST = 5,
        RTN_BLACKHOLE = 6,
        RTN_UNREACHABLE = 7,
        RTN_PROHIBIT = 8,
        RTN_THROW = 9,
        RTN_NAT = 10,
        RTN_XRESOLVE = 11,
        __RTN_MAX = 12,
    }
    enum RTN_UNSPEC = _Anonymous_22.RTN_UNSPEC;
    enum RTN_UNICAST = _Anonymous_22.RTN_UNICAST;
    enum RTN_LOCAL = _Anonymous_22.RTN_LOCAL;
    enum RTN_BROADCAST = _Anonymous_22.RTN_BROADCAST;
    enum RTN_ANYCAST = _Anonymous_22.RTN_ANYCAST;
    enum RTN_MULTICAST = _Anonymous_22.RTN_MULTICAST;
    enum RTN_BLACKHOLE = _Anonymous_22.RTN_BLACKHOLE;
    enum RTN_UNREACHABLE = _Anonymous_22.RTN_UNREACHABLE;
    enum RTN_PROHIBIT = _Anonymous_22.RTN_PROHIBIT;
    enum RTN_THROW = _Anonymous_22.RTN_THROW;
    enum RTN_NAT = _Anonymous_22.RTN_NAT;
    enum RTN_XRESOLVE = _Anonymous_22.RTN_XRESOLVE;
    enum __RTN_MAX = _Anonymous_22.__RTN_MAX;
    struct rtmsg
    {
        ubyte rtm_family;
        ubyte rtm_dst_len;
        ubyte rtm_src_len;
        ubyte rtm_tos;
        ubyte rtm_table;
        ubyte rtm_protocol;
        ubyte rtm_scope;
        ubyte rtm_type;
        uint rtm_flags;
    }
    struct rtattr
    {
        ushort rta_len;
        ushort rta_type;
    }
    enum _Anonymous_23
    {
        RTM_BASE = 16,
        RTM_NEWLINK = 16,
        RTM_DELLINK = 17,
        RTM_GETLINK = 18,
        RTM_SETLINK = 19,
        RTM_NEWADDR = 20,
        RTM_DELADDR = 21,
        RTM_GETADDR = 22,
        RTM_NEWROUTE = 24,
        RTM_DELROUTE = 25,
        RTM_GETROUTE = 26,
        RTM_NEWNEIGH = 28,
        RTM_DELNEIGH = 29,
        RTM_GETNEIGH = 30,
        RTM_NEWRULE = 32,
        RTM_DELRULE = 33,
        RTM_GETRULE = 34,
        RTM_NEWQDISC = 36,
        RTM_DELQDISC = 37,
        RTM_GETQDISC = 38,
        RTM_NEWTCLASS = 40,
        RTM_DELTCLASS = 41,
        RTM_GETTCLASS = 42,
        RTM_NEWTFILTER = 44,
        RTM_DELTFILTER = 45,
        RTM_GETTFILTER = 46,
        RTM_NEWACTION = 48,
        RTM_DELACTION = 49,
        RTM_GETACTION = 50,
        RTM_NEWPREFIX = 52,
        RTM_GETMULTICAST = 58,
        RTM_GETANYCAST = 62,
        RTM_NEWNEIGHTBL = 64,
        RTM_GETNEIGHTBL = 66,
        RTM_SETNEIGHTBL = 67,
        RTM_NEWNDUSEROPT = 68,
        RTM_NEWADDRLABEL = 72,
        RTM_DELADDRLABEL = 73,
        RTM_GETADDRLABEL = 74,
        RTM_GETDCB = 78,
        RTM_SETDCB = 79,
        RTM_NEWNETCONF = 80,
        RTM_DELNETCONF = 81,
        RTM_GETNETCONF = 82,
        RTM_NEWMDB = 84,
        RTM_DELMDB = 85,
        RTM_GETMDB = 86,
        RTM_NEWNSID = 88,
        RTM_DELNSID = 89,
        RTM_GETNSID = 90,
        RTM_NEWSTATS = 92,
        RTM_GETSTATS = 94,
        RTM_NEWCACHEREPORT = 96,
        RTM_NEWCHAIN = 100,
        RTM_DELCHAIN = 101,
        RTM_GETCHAIN = 102,
        RTM_NEWNEXTHOP = 104,
        RTM_DELNEXTHOP = 105,
        RTM_GETNEXTHOP = 106,
        __RTM_MAX = 107,
    }
    enum RTM_BASE = _Anonymous_23.RTM_BASE;
    enum RTM_NEWLINK = _Anonymous_23.RTM_NEWLINK;
    enum RTM_DELLINK = _Anonymous_23.RTM_DELLINK;
    enum RTM_GETLINK = _Anonymous_23.RTM_GETLINK;
    enum RTM_SETLINK = _Anonymous_23.RTM_SETLINK;
    enum RTM_NEWADDR = _Anonymous_23.RTM_NEWADDR;
    enum RTM_DELADDR = _Anonymous_23.RTM_DELADDR;
    enum RTM_GETADDR = _Anonymous_23.RTM_GETADDR;
    enum RTM_NEWROUTE = _Anonymous_23.RTM_NEWROUTE;
    enum RTM_DELROUTE = _Anonymous_23.RTM_DELROUTE;
    enum RTM_GETROUTE = _Anonymous_23.RTM_GETROUTE;
    enum RTM_NEWNEIGH = _Anonymous_23.RTM_NEWNEIGH;
    enum RTM_DELNEIGH = _Anonymous_23.RTM_DELNEIGH;
    enum RTM_GETNEIGH = _Anonymous_23.RTM_GETNEIGH;
    enum RTM_NEWRULE = _Anonymous_23.RTM_NEWRULE;
    enum RTM_DELRULE = _Anonymous_23.RTM_DELRULE;
    enum RTM_GETRULE = _Anonymous_23.RTM_GETRULE;
    enum RTM_NEWQDISC = _Anonymous_23.RTM_NEWQDISC;
    enum RTM_DELQDISC = _Anonymous_23.RTM_DELQDISC;
    enum RTM_GETQDISC = _Anonymous_23.RTM_GETQDISC;
    enum RTM_NEWTCLASS = _Anonymous_23.RTM_NEWTCLASS;
    enum RTM_DELTCLASS = _Anonymous_23.RTM_DELTCLASS;
    enum RTM_GETTCLASS = _Anonymous_23.RTM_GETTCLASS;
    enum RTM_NEWTFILTER = _Anonymous_23.RTM_NEWTFILTER;
    enum RTM_DELTFILTER = _Anonymous_23.RTM_DELTFILTER;
    enum RTM_GETTFILTER = _Anonymous_23.RTM_GETTFILTER;
    enum RTM_NEWACTION = _Anonymous_23.RTM_NEWACTION;
    enum RTM_DELACTION = _Anonymous_23.RTM_DELACTION;
    enum RTM_GETACTION = _Anonymous_23.RTM_GETACTION;
    enum RTM_NEWPREFIX = _Anonymous_23.RTM_NEWPREFIX;
    enum RTM_GETMULTICAST = _Anonymous_23.RTM_GETMULTICAST;
    enum RTM_GETANYCAST = _Anonymous_23.RTM_GETANYCAST;
    enum RTM_NEWNEIGHTBL = _Anonymous_23.RTM_NEWNEIGHTBL;
    enum RTM_GETNEIGHTBL = _Anonymous_23.RTM_GETNEIGHTBL;
    enum RTM_SETNEIGHTBL = _Anonymous_23.RTM_SETNEIGHTBL;
    enum RTM_NEWNDUSEROPT = _Anonymous_23.RTM_NEWNDUSEROPT;
    enum RTM_NEWADDRLABEL = _Anonymous_23.RTM_NEWADDRLABEL;
    enum RTM_DELADDRLABEL = _Anonymous_23.RTM_DELADDRLABEL;
    enum RTM_GETADDRLABEL = _Anonymous_23.RTM_GETADDRLABEL;
    enum RTM_GETDCB = _Anonymous_23.RTM_GETDCB;
    enum RTM_SETDCB = _Anonymous_23.RTM_SETDCB;
    enum RTM_NEWNETCONF = _Anonymous_23.RTM_NEWNETCONF;
    enum RTM_DELNETCONF = _Anonymous_23.RTM_DELNETCONF;
    enum RTM_GETNETCONF = _Anonymous_23.RTM_GETNETCONF;
    enum RTM_NEWMDB = _Anonymous_23.RTM_NEWMDB;
    enum RTM_DELMDB = _Anonymous_23.RTM_DELMDB;
    enum RTM_GETMDB = _Anonymous_23.RTM_GETMDB;
    enum RTM_NEWNSID = _Anonymous_23.RTM_NEWNSID;
    enum RTM_DELNSID = _Anonymous_23.RTM_DELNSID;
    enum RTM_GETNSID = _Anonymous_23.RTM_GETNSID;
    enum RTM_NEWSTATS = _Anonymous_23.RTM_NEWSTATS;
    enum RTM_GETSTATS = _Anonymous_23.RTM_GETSTATS;
    enum RTM_NEWCACHEREPORT = _Anonymous_23.RTM_NEWCACHEREPORT;
    enum RTM_NEWCHAIN = _Anonymous_23.RTM_NEWCHAIN;
    enum RTM_DELCHAIN = _Anonymous_23.RTM_DELCHAIN;
    enum RTM_GETCHAIN = _Anonymous_23.RTM_GETCHAIN;
    enum RTM_NEWNEXTHOP = _Anonymous_23.RTM_NEWNEXTHOP;
    enum RTM_DELNEXTHOP = _Anonymous_23.RTM_DELNEXTHOP;
    enum RTM_GETNEXTHOP = _Anonymous_23.RTM_GETNEXTHOP;
    enum __RTM_MAX = _Anonymous_23.__RTM_MAX;
    alias __kernel_mqd_t = int;
    alias __kernel_key_t = int;
    alias __kernel_sighandler_t = void function(int);
    struct __kernel_fd_set
    {
        c_ulong[16] fds_bits;
    }
    struct nla_bitfield32
    {
        uint value;
        uint selector;
    }
    struct nlattr
    {
        ushort nla_len;
        ushort nla_type;
    }
    enum _Anonymous_24
    {
        NETLINK_UNCONNECTED = 0,
        NETLINK_CONNECTED = 1,
    }
    enum NETLINK_UNCONNECTED = _Anonymous_24.NETLINK_UNCONNECTED;
    enum NETLINK_CONNECTED = _Anonymous_24.NETLINK_CONNECTED;
    enum nl_mmap_status
    {
        NL_MMAP_STATUS_UNUSED = 0,
        NL_MMAP_STATUS_RESERVED = 1,
        NL_MMAP_STATUS_VALID = 2,
        NL_MMAP_STATUS_COPY = 3,
        NL_MMAP_STATUS_SKIP = 4,
    }
    enum NL_MMAP_STATUS_UNUSED = nl_mmap_status.NL_MMAP_STATUS_UNUSED;
    enum NL_MMAP_STATUS_RESERVED = nl_mmap_status.NL_MMAP_STATUS_RESERVED;
    enum NL_MMAP_STATUS_VALID = nl_mmap_status.NL_MMAP_STATUS_VALID;
    enum NL_MMAP_STATUS_COPY = nl_mmap_status.NL_MMAP_STATUS_COPY;
    enum NL_MMAP_STATUS_SKIP = nl_mmap_status.NL_MMAP_STATUS_SKIP;
    struct nl_mmap_hdr
    {
        uint nm_status;
        uint nm_len;
        uint nm_group;
        uint nm_pid;
        uint nm_uid;
        uint nm_gid;
    }
    struct nl_mmap_req
    {
        uint nm_block_size;
        uint nm_block_nr;
        uint nm_frame_size;
        uint nm_frame_nr;
    }
    struct nl_pktinfo
    {
        uint group;
    }
    enum nlmsgerr_attrs
    {
        NLMSGERR_ATTR_UNUSED = 0,
        NLMSGERR_ATTR_MSG = 1,
        NLMSGERR_ATTR_OFFS = 2,
        NLMSGERR_ATTR_COOKIE = 3,
        __NLMSGERR_ATTR_MAX = 4,
        NLMSGERR_ATTR_MAX = 3,
    }
    enum NLMSGERR_ATTR_UNUSED = nlmsgerr_attrs.NLMSGERR_ATTR_UNUSED;
    enum NLMSGERR_ATTR_MSG = nlmsgerr_attrs.NLMSGERR_ATTR_MSG;
    enum NLMSGERR_ATTR_OFFS = nlmsgerr_attrs.NLMSGERR_ATTR_OFFS;
    enum NLMSGERR_ATTR_COOKIE = nlmsgerr_attrs.NLMSGERR_ATTR_COOKIE;
    enum __NLMSGERR_ATTR_MAX = nlmsgerr_attrs.__NLMSGERR_ATTR_MAX;
    enum NLMSGERR_ATTR_MAX = nlmsgerr_attrs.NLMSGERR_ATTR_MAX;
    struct nlmsgerr
    {
        int error;
        nlmsghdr msg;
    }
    struct nlmsghdr
    {
        uint nlmsg_len;
        ushort nlmsg_type;
        ushort nlmsg_flags;
        uint nlmsg_seq;
        uint nlmsg_pid;
    }
    struct sockaddr_nl
    {
        ushort nl_family;
        ushort nl_pad;
        uint nl_pid;
        uint nl_groups;
    }
    enum _Anonymous_25
    {
        NDTA_UNSPEC = 0,
        NDTA_NAME = 1,
        NDTA_THRESH1 = 2,
        NDTA_THRESH2 = 3,
        NDTA_THRESH3 = 4,
        NDTA_CONFIG = 5,
        NDTA_PARMS = 6,
        NDTA_STATS = 7,
        NDTA_GC_INTERVAL = 8,
        NDTA_PAD = 9,
        __NDTA_MAX = 10,
    }
    enum NDTA_UNSPEC = _Anonymous_25.NDTA_UNSPEC;
    enum NDTA_NAME = _Anonymous_25.NDTA_NAME;
    enum NDTA_THRESH1 = _Anonymous_25.NDTA_THRESH1;
    enum NDTA_THRESH2 = _Anonymous_25.NDTA_THRESH2;
    enum NDTA_THRESH3 = _Anonymous_25.NDTA_THRESH3;
    enum NDTA_CONFIG = _Anonymous_25.NDTA_CONFIG;
    enum NDTA_PARMS = _Anonymous_25.NDTA_PARMS;
    enum NDTA_STATS = _Anonymous_25.NDTA_STATS;
    enum NDTA_GC_INTERVAL = _Anonymous_25.NDTA_GC_INTERVAL;
    enum NDTA_PAD = _Anonymous_25.NDTA_PAD;
    enum __NDTA_MAX = _Anonymous_25.__NDTA_MAX;
    struct ndt_config
    {
        ushort ndtc_key_len;
        ushort ndtc_entry_size;
        uint ndtc_entries;
        uint ndtc_last_flush;
        uint ndtc_last_rand;
        uint ndtc_hash_rnd;
        uint ndtc_hash_mask;
        uint ndtc_hash_chain_gc;
        uint ndtc_proxy_qlen;
    }
    struct ndtmsg
    {
        ubyte ndtm_family;
        ubyte ndtm_pad1;
        ushort ndtm_pad2;
    }
    enum _Anonymous_26
    {
        NDTPA_UNSPEC = 0,
        NDTPA_IFINDEX = 1,
        NDTPA_REFCNT = 2,
        NDTPA_REACHABLE_TIME = 3,
        NDTPA_BASE_REACHABLE_TIME = 4,
        NDTPA_RETRANS_TIME = 5,
        NDTPA_GC_STALETIME = 6,
        NDTPA_DELAY_PROBE_TIME = 7,
        NDTPA_QUEUE_LEN = 8,
        NDTPA_APP_PROBES = 9,
        NDTPA_UCAST_PROBES = 10,
        NDTPA_MCAST_PROBES = 11,
        NDTPA_ANYCAST_DELAY = 12,
        NDTPA_PROXY_DELAY = 13,
        NDTPA_PROXY_QLEN = 14,
        NDTPA_LOCKTIME = 15,
        NDTPA_QUEUE_LENBYTES = 16,
        NDTPA_MCAST_REPROBES = 17,
        NDTPA_PAD = 18,
        __NDTPA_MAX = 19,
    }
    enum NDTPA_UNSPEC = _Anonymous_26.NDTPA_UNSPEC;
    enum NDTPA_IFINDEX = _Anonymous_26.NDTPA_IFINDEX;
    enum NDTPA_REFCNT = _Anonymous_26.NDTPA_REFCNT;
    enum NDTPA_REACHABLE_TIME = _Anonymous_26.NDTPA_REACHABLE_TIME;
    enum NDTPA_BASE_REACHABLE_TIME = _Anonymous_26.NDTPA_BASE_REACHABLE_TIME;
    enum NDTPA_RETRANS_TIME = _Anonymous_26.NDTPA_RETRANS_TIME;
    enum NDTPA_GC_STALETIME = _Anonymous_26.NDTPA_GC_STALETIME;
    enum NDTPA_DELAY_PROBE_TIME = _Anonymous_26.NDTPA_DELAY_PROBE_TIME;
    enum NDTPA_QUEUE_LEN = _Anonymous_26.NDTPA_QUEUE_LEN;
    enum NDTPA_APP_PROBES = _Anonymous_26.NDTPA_APP_PROBES;
    enum NDTPA_UCAST_PROBES = _Anonymous_26.NDTPA_UCAST_PROBES;
    enum NDTPA_MCAST_PROBES = _Anonymous_26.NDTPA_MCAST_PROBES;
    enum NDTPA_ANYCAST_DELAY = _Anonymous_26.NDTPA_ANYCAST_DELAY;
    enum NDTPA_PROXY_DELAY = _Anonymous_26.NDTPA_PROXY_DELAY;
    enum NDTPA_PROXY_QLEN = _Anonymous_26.NDTPA_PROXY_QLEN;
    enum NDTPA_LOCKTIME = _Anonymous_26.NDTPA_LOCKTIME;
    enum NDTPA_QUEUE_LENBYTES = _Anonymous_26.NDTPA_QUEUE_LENBYTES;
    enum NDTPA_MCAST_REPROBES = _Anonymous_26.NDTPA_MCAST_REPROBES;
    enum NDTPA_PAD = _Anonymous_26.NDTPA_PAD;
    enum __NDTPA_MAX = _Anonymous_26.__NDTPA_MAX;
    struct ndt_stats
    {
        ulong ndts_allocs;
        ulong ndts_destroys;
        ulong ndts_hash_grows;
        ulong ndts_res_failed;
        ulong ndts_lookups;
        ulong ndts_hits;
        ulong ndts_rcv_probes_mcast;
        ulong ndts_rcv_probes_ucast;
        ulong ndts_periodic_gc_runs;
        ulong ndts_forced_gc_runs;
        ulong ndts_table_fulls;
    }
    struct nda_cacheinfo
    {
        uint ndm_confirmed;
        uint ndm_used;
        uint ndm_updated;
        uint ndm_refcnt;
    }
    enum _Anonymous_27
    {
        NDA_UNSPEC = 0,
        NDA_DST = 1,
        NDA_LLADDR = 2,
        NDA_CACHEINFO = 3,
        NDA_PROBES = 4,
        NDA_VLAN = 5,
        NDA_PORT = 6,
        NDA_VNI = 7,
        NDA_IFINDEX = 8,
        NDA_MASTER = 9,
        NDA_LINK_NETNSID = 10,
        NDA_SRC_VNI = 11,
        NDA_PROTOCOL = 12,
        __NDA_MAX = 13,
    }
    enum NDA_UNSPEC = _Anonymous_27.NDA_UNSPEC;
    enum NDA_DST = _Anonymous_27.NDA_DST;
    enum NDA_LLADDR = _Anonymous_27.NDA_LLADDR;
    enum NDA_CACHEINFO = _Anonymous_27.NDA_CACHEINFO;
    enum NDA_PROBES = _Anonymous_27.NDA_PROBES;
    enum NDA_VLAN = _Anonymous_27.NDA_VLAN;
    enum NDA_PORT = _Anonymous_27.NDA_PORT;
    enum NDA_VNI = _Anonymous_27.NDA_VNI;
    enum NDA_IFINDEX = _Anonymous_27.NDA_IFINDEX;
    enum NDA_MASTER = _Anonymous_27.NDA_MASTER;
    enum NDA_LINK_NETNSID = _Anonymous_27.NDA_LINK_NETNSID;
    enum NDA_SRC_VNI = _Anonymous_27.NDA_SRC_VNI;
    enum NDA_PROTOCOL = _Anonymous_27.NDA_PROTOCOL;
    enum __NDA_MAX = _Anonymous_27.__NDA_MAX;
    struct ndmsg
    {
        ubyte ndm_family;
        ubyte ndm_pad1;
        ushort ndm_pad2;
        int ndm_ifindex;
        ushort ndm_state;
        ubyte ndm_flags;
        ubyte ndm_type;
    }
    struct ifla_rmnet_flags
    {
        uint flags;
        uint mask;
    }
    enum _Anonymous_28
    {
        IFLA_RMNET_UNSPEC = 0,
        IFLA_RMNET_MUX_ID = 1,
        IFLA_RMNET_FLAGS = 2,
        __IFLA_RMNET_MAX = 3,
    }
    enum IFLA_RMNET_UNSPEC = _Anonymous_28.IFLA_RMNET_UNSPEC;
    enum IFLA_RMNET_MUX_ID = _Anonymous_28.IFLA_RMNET_MUX_ID;
    enum IFLA_RMNET_FLAGS = _Anonymous_28.IFLA_RMNET_FLAGS;
    enum __IFLA_RMNET_MAX = _Anonymous_28.__IFLA_RMNET_MAX;
    enum _Anonymous_29
    {
        IFLA_TUN_UNSPEC = 0,
        IFLA_TUN_OWNER = 1,
        IFLA_TUN_GROUP = 2,
        IFLA_TUN_TYPE = 3,
        IFLA_TUN_PI = 4,
        IFLA_TUN_VNET_HDR = 5,
        IFLA_TUN_PERSIST = 6,
        IFLA_TUN_MULTI_QUEUE = 7,
        IFLA_TUN_NUM_QUEUES = 8,
        IFLA_TUN_NUM_DISABLED_QUEUES = 9,
        __IFLA_TUN_MAX = 10,
    }
    enum IFLA_TUN_UNSPEC = _Anonymous_29.IFLA_TUN_UNSPEC;
    enum IFLA_TUN_OWNER = _Anonymous_29.IFLA_TUN_OWNER;
    enum IFLA_TUN_GROUP = _Anonymous_29.IFLA_TUN_GROUP;
    enum IFLA_TUN_TYPE = _Anonymous_29.IFLA_TUN_TYPE;
    enum IFLA_TUN_PI = _Anonymous_29.IFLA_TUN_PI;
    enum IFLA_TUN_VNET_HDR = _Anonymous_29.IFLA_TUN_VNET_HDR;
    enum IFLA_TUN_PERSIST = _Anonymous_29.IFLA_TUN_PERSIST;
    enum IFLA_TUN_MULTI_QUEUE = _Anonymous_29.IFLA_TUN_MULTI_QUEUE;
    enum IFLA_TUN_NUM_QUEUES = _Anonymous_29.IFLA_TUN_NUM_QUEUES;
    enum IFLA_TUN_NUM_DISABLED_QUEUES = _Anonymous_29.IFLA_TUN_NUM_DISABLED_QUEUES;
    enum __IFLA_TUN_MAX = _Anonymous_29.__IFLA_TUN_MAX;
    enum _Anonymous_30
    {
        IFLA_EVENT_NONE = 0,
        IFLA_EVENT_REBOOT = 1,
        IFLA_EVENT_FEATURES = 2,
        IFLA_EVENT_BONDING_FAILOVER = 3,
        IFLA_EVENT_NOTIFY_PEERS = 4,
        IFLA_EVENT_IGMP_RESEND = 5,
        IFLA_EVENT_BONDING_OPTIONS = 6,
    }
    enum IFLA_EVENT_NONE = _Anonymous_30.IFLA_EVENT_NONE;
    enum IFLA_EVENT_REBOOT = _Anonymous_30.IFLA_EVENT_REBOOT;
    enum IFLA_EVENT_FEATURES = _Anonymous_30.IFLA_EVENT_FEATURES;
    enum IFLA_EVENT_BONDING_FAILOVER = _Anonymous_30.IFLA_EVENT_BONDING_FAILOVER;
    enum IFLA_EVENT_NOTIFY_PEERS = _Anonymous_30.IFLA_EVENT_NOTIFY_PEERS;
    enum IFLA_EVENT_IGMP_RESEND = _Anonymous_30.IFLA_EVENT_IGMP_RESEND;
    enum IFLA_EVENT_BONDING_OPTIONS = _Anonymous_30.IFLA_EVENT_BONDING_OPTIONS;
    enum _Anonymous_31
    {
        IFLA_XDP_UNSPEC = 0,
        IFLA_XDP_FD = 1,
        IFLA_XDP_ATTACHED = 2,
        IFLA_XDP_FLAGS = 3,
        IFLA_XDP_PROG_ID = 4,
        IFLA_XDP_DRV_PROG_ID = 5,
        IFLA_XDP_SKB_PROG_ID = 6,
        IFLA_XDP_HW_PROG_ID = 7,
        __IFLA_XDP_MAX = 8,
    }
    enum IFLA_XDP_UNSPEC = _Anonymous_31.IFLA_XDP_UNSPEC;
    enum IFLA_XDP_FD = _Anonymous_31.IFLA_XDP_FD;
    enum IFLA_XDP_ATTACHED = _Anonymous_31.IFLA_XDP_ATTACHED;
    enum IFLA_XDP_FLAGS = _Anonymous_31.IFLA_XDP_FLAGS;
    enum IFLA_XDP_PROG_ID = _Anonymous_31.IFLA_XDP_PROG_ID;
    enum IFLA_XDP_DRV_PROG_ID = _Anonymous_31.IFLA_XDP_DRV_PROG_ID;
    enum IFLA_XDP_SKB_PROG_ID = _Anonymous_31.IFLA_XDP_SKB_PROG_ID;
    enum IFLA_XDP_HW_PROG_ID = _Anonymous_31.IFLA_XDP_HW_PROG_ID;
    enum __IFLA_XDP_MAX = _Anonymous_31.__IFLA_XDP_MAX;
    enum _Anonymous_32
    {
        XDP_ATTACHED_NONE = 0,
        XDP_ATTACHED_DRV = 1,
        XDP_ATTACHED_SKB = 2,
        XDP_ATTACHED_HW = 3,
        XDP_ATTACHED_MULTI = 4,
    }
    enum XDP_ATTACHED_NONE = _Anonymous_32.XDP_ATTACHED_NONE;
    enum XDP_ATTACHED_DRV = _Anonymous_32.XDP_ATTACHED_DRV;
    enum XDP_ATTACHED_SKB = _Anonymous_32.XDP_ATTACHED_SKB;
    enum XDP_ATTACHED_HW = _Anonymous_32.XDP_ATTACHED_HW;
    enum XDP_ATTACHED_MULTI = _Anonymous_32.XDP_ATTACHED_MULTI;
    enum _Anonymous_33
    {
        IFLA_OFFLOAD_XSTATS_UNSPEC = 0,
        IFLA_OFFLOAD_XSTATS_CPU_HIT = 1,
        __IFLA_OFFLOAD_XSTATS_MAX = 2,
    }
    enum IFLA_OFFLOAD_XSTATS_UNSPEC = _Anonymous_33.IFLA_OFFLOAD_XSTATS_UNSPEC;
    enum IFLA_OFFLOAD_XSTATS_CPU_HIT = _Anonymous_33.IFLA_OFFLOAD_XSTATS_CPU_HIT;
    enum __IFLA_OFFLOAD_XSTATS_MAX = _Anonymous_33.__IFLA_OFFLOAD_XSTATS_MAX;
    enum _Anonymous_34
    {
        LINK_XSTATS_TYPE_UNSPEC = 0,
        LINK_XSTATS_TYPE_BRIDGE = 1,
        LINK_XSTATS_TYPE_BOND = 2,
        __LINK_XSTATS_TYPE_MAX = 3,
    }
    enum LINK_XSTATS_TYPE_UNSPEC = _Anonymous_34.LINK_XSTATS_TYPE_UNSPEC;
    enum LINK_XSTATS_TYPE_BRIDGE = _Anonymous_34.LINK_XSTATS_TYPE_BRIDGE;
    enum LINK_XSTATS_TYPE_BOND = _Anonymous_34.LINK_XSTATS_TYPE_BOND;
    enum __LINK_XSTATS_TYPE_MAX = _Anonymous_34.__LINK_XSTATS_TYPE_MAX;
    enum _Anonymous_35
    {
        IFLA_STATS_UNSPEC = 0,
        IFLA_STATS_LINK_64 = 1,
        IFLA_STATS_LINK_XSTATS = 2,
        IFLA_STATS_LINK_XSTATS_SLAVE = 3,
        IFLA_STATS_LINK_OFFLOAD_XSTATS = 4,
        IFLA_STATS_AF_SPEC = 5,
        __IFLA_STATS_MAX = 6,
    }
    enum IFLA_STATS_UNSPEC = _Anonymous_35.IFLA_STATS_UNSPEC;
    enum IFLA_STATS_LINK_64 = _Anonymous_35.IFLA_STATS_LINK_64;
    enum IFLA_STATS_LINK_XSTATS = _Anonymous_35.IFLA_STATS_LINK_XSTATS;
    enum IFLA_STATS_LINK_XSTATS_SLAVE = _Anonymous_35.IFLA_STATS_LINK_XSTATS_SLAVE;
    enum IFLA_STATS_LINK_OFFLOAD_XSTATS = _Anonymous_35.IFLA_STATS_LINK_OFFLOAD_XSTATS;
    enum IFLA_STATS_AF_SPEC = _Anonymous_35.IFLA_STATS_AF_SPEC;
    enum __IFLA_STATS_MAX = _Anonymous_35.__IFLA_STATS_MAX;
    struct if_stats_msg
    {
        ubyte family;
        ubyte pad1;
        ushort pad2;
        uint ifindex;
        uint filter_mask;
    }
    enum _Anonymous_36
    {
        IFLA_HSR_UNSPEC = 0,
        IFLA_HSR_SLAVE1 = 1,
        IFLA_HSR_SLAVE2 = 2,
        IFLA_HSR_MULTICAST_SPEC = 3,
        IFLA_HSR_SUPERVISION_ADDR = 4,
        IFLA_HSR_SEQ_NR = 5,
        IFLA_HSR_VERSION = 6,
        __IFLA_HSR_MAX = 7,
    }
    enum IFLA_HSR_UNSPEC = _Anonymous_36.IFLA_HSR_UNSPEC;
    enum IFLA_HSR_SLAVE1 = _Anonymous_36.IFLA_HSR_SLAVE1;
    enum IFLA_HSR_SLAVE2 = _Anonymous_36.IFLA_HSR_SLAVE2;
    enum IFLA_HSR_MULTICAST_SPEC = _Anonymous_36.IFLA_HSR_MULTICAST_SPEC;
    enum IFLA_HSR_SUPERVISION_ADDR = _Anonymous_36.IFLA_HSR_SUPERVISION_ADDR;
    enum IFLA_HSR_SEQ_NR = _Anonymous_36.IFLA_HSR_SEQ_NR;
    enum IFLA_HSR_VERSION = _Anonymous_36.IFLA_HSR_VERSION;
    enum __IFLA_HSR_MAX = _Anonymous_36.__IFLA_HSR_MAX;
    enum _Anonymous_37
    {
        IPOIB_MODE_DATAGRAM = 0,
        IPOIB_MODE_CONNECTED = 1,
    }
    enum IPOIB_MODE_DATAGRAM = _Anonymous_37.IPOIB_MODE_DATAGRAM;
    enum IPOIB_MODE_CONNECTED = _Anonymous_37.IPOIB_MODE_CONNECTED;
    enum _Anonymous_38
    {
        IFLA_IPOIB_UNSPEC = 0,
        IFLA_IPOIB_PKEY = 1,
        IFLA_IPOIB_MODE = 2,
        IFLA_IPOIB_UMCAST = 3,
        __IFLA_IPOIB_MAX = 4,
    }
    enum IFLA_IPOIB_UNSPEC = _Anonymous_38.IFLA_IPOIB_UNSPEC;
    enum IFLA_IPOIB_PKEY = _Anonymous_38.IFLA_IPOIB_PKEY;
    enum IFLA_IPOIB_MODE = _Anonymous_38.IFLA_IPOIB_MODE;
    enum IFLA_IPOIB_UMCAST = _Anonymous_38.IFLA_IPOIB_UMCAST;
    enum __IFLA_IPOIB_MAX = _Anonymous_38.__IFLA_IPOIB_MAX;
    struct ifla_port_vsi
    {
        ubyte vsi_mgr_id;
        ubyte[3] vsi_type_id;
        ubyte vsi_type_version;
        ubyte[3] pad;
    }
    enum _Anonymous_39
    {
        PORT_VDP_RESPONSE_SUCCESS = 0,
        PORT_VDP_RESPONSE_INVALID_FORMAT = 1,
        PORT_VDP_RESPONSE_INSUFFICIENT_RESOURCES = 2,
        PORT_VDP_RESPONSE_UNUSED_VTID = 3,
        PORT_VDP_RESPONSE_VTID_VIOLATION = 4,
        PORT_VDP_RESPONSE_VTID_VERSION_VIOALTION = 5,
        PORT_VDP_RESPONSE_OUT_OF_SYNC = 6,
        PORT_PROFILE_RESPONSE_SUCCESS = 256,
        PORT_PROFILE_RESPONSE_INPROGRESS = 257,
        PORT_PROFILE_RESPONSE_INVALID = 258,
        PORT_PROFILE_RESPONSE_BADSTATE = 259,
        PORT_PROFILE_RESPONSE_INSUFFICIENT_RESOURCES = 260,
        PORT_PROFILE_RESPONSE_ERROR = 261,
    }
    enum PORT_VDP_RESPONSE_SUCCESS = _Anonymous_39.PORT_VDP_RESPONSE_SUCCESS;
    enum PORT_VDP_RESPONSE_INVALID_FORMAT = _Anonymous_39.PORT_VDP_RESPONSE_INVALID_FORMAT;
    enum PORT_VDP_RESPONSE_INSUFFICIENT_RESOURCES = _Anonymous_39.PORT_VDP_RESPONSE_INSUFFICIENT_RESOURCES;
    enum PORT_VDP_RESPONSE_UNUSED_VTID = _Anonymous_39.PORT_VDP_RESPONSE_UNUSED_VTID;
    enum PORT_VDP_RESPONSE_VTID_VIOLATION = _Anonymous_39.PORT_VDP_RESPONSE_VTID_VIOLATION;
    enum PORT_VDP_RESPONSE_VTID_VERSION_VIOALTION = _Anonymous_39.PORT_VDP_RESPONSE_VTID_VERSION_VIOALTION;
    enum PORT_VDP_RESPONSE_OUT_OF_SYNC = _Anonymous_39.PORT_VDP_RESPONSE_OUT_OF_SYNC;
    enum PORT_PROFILE_RESPONSE_SUCCESS = _Anonymous_39.PORT_PROFILE_RESPONSE_SUCCESS;
    enum PORT_PROFILE_RESPONSE_INPROGRESS = _Anonymous_39.PORT_PROFILE_RESPONSE_INPROGRESS;
    enum PORT_PROFILE_RESPONSE_INVALID = _Anonymous_39.PORT_PROFILE_RESPONSE_INVALID;
    enum PORT_PROFILE_RESPONSE_BADSTATE = _Anonymous_39.PORT_PROFILE_RESPONSE_BADSTATE;
    enum PORT_PROFILE_RESPONSE_INSUFFICIENT_RESOURCES = _Anonymous_39.PORT_PROFILE_RESPONSE_INSUFFICIENT_RESOURCES;
    enum PORT_PROFILE_RESPONSE_ERROR = _Anonymous_39.PORT_PROFILE_RESPONSE_ERROR;
    enum _Anonymous_40
    {
        PORT_REQUEST_PREASSOCIATE = 0,
        PORT_REQUEST_PREASSOCIATE_RR = 1,
        PORT_REQUEST_ASSOCIATE = 2,
        PORT_REQUEST_DISASSOCIATE = 3,
    }
    enum PORT_REQUEST_PREASSOCIATE = _Anonymous_40.PORT_REQUEST_PREASSOCIATE;
    enum PORT_REQUEST_PREASSOCIATE_RR = _Anonymous_40.PORT_REQUEST_PREASSOCIATE_RR;
    enum PORT_REQUEST_ASSOCIATE = _Anonymous_40.PORT_REQUEST_ASSOCIATE;
    enum PORT_REQUEST_DISASSOCIATE = _Anonymous_40.PORT_REQUEST_DISASSOCIATE;
    enum _Anonymous_41
    {
        IFLA_PORT_UNSPEC = 0,
        IFLA_PORT_VF = 1,
        IFLA_PORT_PROFILE = 2,
        IFLA_PORT_VSI_TYPE = 3,
        IFLA_PORT_INSTANCE_UUID = 4,
        IFLA_PORT_HOST_UUID = 5,
        IFLA_PORT_REQUEST = 6,
        IFLA_PORT_RESPONSE = 7,
        __IFLA_PORT_MAX = 8,
    }
    enum IFLA_PORT_UNSPEC = _Anonymous_41.IFLA_PORT_UNSPEC;
    enum IFLA_PORT_VF = _Anonymous_41.IFLA_PORT_VF;
    enum IFLA_PORT_PROFILE = _Anonymous_41.IFLA_PORT_PROFILE;
    enum IFLA_PORT_VSI_TYPE = _Anonymous_41.IFLA_PORT_VSI_TYPE;
    enum IFLA_PORT_INSTANCE_UUID = _Anonymous_41.IFLA_PORT_INSTANCE_UUID;
    enum IFLA_PORT_HOST_UUID = _Anonymous_41.IFLA_PORT_HOST_UUID;
    enum IFLA_PORT_REQUEST = _Anonymous_41.IFLA_PORT_REQUEST;
    enum IFLA_PORT_RESPONSE = _Anonymous_41.IFLA_PORT_RESPONSE;
    enum __IFLA_PORT_MAX = _Anonymous_41.__IFLA_PORT_MAX;
    struct flock
    {
        short l_type;
        short l_whence;
        c_long l_start;
        c_long l_len;
        int l_pid;
    }
    enum _Anonymous_42
    {
        IFLA_VF_PORT_UNSPEC = 0,
        IFLA_VF_PORT = 1,
        __IFLA_VF_PORT_MAX = 2,
    }
    enum IFLA_VF_PORT_UNSPEC = _Anonymous_42.IFLA_VF_PORT_UNSPEC;
    enum IFLA_VF_PORT = _Anonymous_42.IFLA_VF_PORT;
    enum __IFLA_VF_PORT_MAX = _Anonymous_42.__IFLA_VF_PORT_MAX;
    extern __gshared char* optarg;
    extern __gshared int optind;
    extern __gshared int opterr;
    extern __gshared int optopt;
    int getopt(int, char**, const(char)*) @nogc nothrow;
    struct ifla_vf_trust
    {
        uint vf;
        uint setting;
    }
    enum _Anonymous_43
    {
        IFLA_VF_STATS_RX_PACKETS = 0,
        IFLA_VF_STATS_TX_PACKETS = 1,
        IFLA_VF_STATS_RX_BYTES = 2,
        IFLA_VF_STATS_TX_BYTES = 3,
        IFLA_VF_STATS_BROADCAST = 4,
        IFLA_VF_STATS_MULTICAST = 5,
        IFLA_VF_STATS_PAD = 6,
        IFLA_VF_STATS_RX_DROPPED = 7,
        IFLA_VF_STATS_TX_DROPPED = 8,
        __IFLA_VF_STATS_MAX = 9,
    }
    enum IFLA_VF_STATS_RX_PACKETS = _Anonymous_43.IFLA_VF_STATS_RX_PACKETS;
    enum IFLA_VF_STATS_TX_PACKETS = _Anonymous_43.IFLA_VF_STATS_TX_PACKETS;
    enum IFLA_VF_STATS_RX_BYTES = _Anonymous_43.IFLA_VF_STATS_RX_BYTES;
    enum IFLA_VF_STATS_TX_BYTES = _Anonymous_43.IFLA_VF_STATS_TX_BYTES;
    enum IFLA_VF_STATS_BROADCAST = _Anonymous_43.IFLA_VF_STATS_BROADCAST;
    enum IFLA_VF_STATS_MULTICAST = _Anonymous_43.IFLA_VF_STATS_MULTICAST;
    enum IFLA_VF_STATS_PAD = _Anonymous_43.IFLA_VF_STATS_PAD;
    enum IFLA_VF_STATS_RX_DROPPED = _Anonymous_43.IFLA_VF_STATS_RX_DROPPED;
    enum IFLA_VF_STATS_TX_DROPPED = _Anonymous_43.IFLA_VF_STATS_TX_DROPPED;
    enum __IFLA_VF_STATS_MAX = _Anonymous_43.__IFLA_VF_STATS_MAX;
    struct ifla_vf_rss_query_en
    {
        uint vf;
        uint setting;
    }
    struct ifla_vf_link_state
    {
        uint vf;
        uint link_state;
    }
    enum _Anonymous_44
    {
        IFLA_VF_LINK_STATE_AUTO = 0,
        IFLA_VF_LINK_STATE_ENABLE = 1,
        IFLA_VF_LINK_STATE_DISABLE = 2,
        __IFLA_VF_LINK_STATE_MAX = 3,
    }
    enum IFLA_VF_LINK_STATE_AUTO = _Anonymous_44.IFLA_VF_LINK_STATE_AUTO;
    enum IFLA_VF_LINK_STATE_ENABLE = _Anonymous_44.IFLA_VF_LINK_STATE_ENABLE;
    enum IFLA_VF_LINK_STATE_DISABLE = _Anonymous_44.IFLA_VF_LINK_STATE_DISABLE;
    enum __IFLA_VF_LINK_STATE_MAX = _Anonymous_44.__IFLA_VF_LINK_STATE_MAX;
    struct ifla_vf_guid
    {
        uint vf;
        ulong guid;
    }
    struct ifla_vf_spoofchk
    {
        uint vf;
        uint setting;
    }
    struct ifla_vf_rate
    {
        uint vf;
        uint min_tx_rate;
        uint max_tx_rate;
    }
    struct ifla_vf_tx_rate
    {
        uint vf;
        uint rate;
    }
    struct ifla_vf_vlan_info
    {
        uint vf;
        uint vlan;
        uint qos;
        ushort vlan_proto;
    }
    enum _Anonymous_45
    {
        IFLA_VF_VLAN_INFO_UNSPEC = 0,
        IFLA_VF_VLAN_INFO = 1,
        __IFLA_VF_VLAN_INFO_MAX = 2,
    }
    enum IFLA_VF_VLAN_INFO_UNSPEC = _Anonymous_45.IFLA_VF_VLAN_INFO_UNSPEC;
    enum IFLA_VF_VLAN_INFO = _Anonymous_45.IFLA_VF_VLAN_INFO;
    enum __IFLA_VF_VLAN_INFO_MAX = _Anonymous_45.__IFLA_VF_VLAN_INFO_MAX;
    struct ifla_vf_vlan
    {
        uint vf;
        uint vlan;
        uint qos;
    }
    struct ifla_vf_broadcast
    {
        ubyte[32] broadcast;
    }
    struct ifla_vf_mac
    {
        uint vf;
        ubyte[32] mac;
    }
    enum _Anonymous_46
    {
        IFLA_VF_UNSPEC = 0,
        IFLA_VF_MAC = 1,
        IFLA_VF_VLAN = 2,
        IFLA_VF_TX_RATE = 3,
        IFLA_VF_SPOOFCHK = 4,
        IFLA_VF_LINK_STATE = 5,
        IFLA_VF_RATE = 6,
        IFLA_VF_RSS_QUERY_EN = 7,
        IFLA_VF_STATS = 8,
        IFLA_VF_TRUST = 9,
        IFLA_VF_IB_NODE_GUID = 10,
        IFLA_VF_IB_PORT_GUID = 11,
        IFLA_VF_VLAN_LIST = 12,
        IFLA_VF_BROADCAST = 13,
        __IFLA_VF_MAX = 14,
    }
    enum IFLA_VF_UNSPEC = _Anonymous_46.IFLA_VF_UNSPEC;
    enum IFLA_VF_MAC = _Anonymous_46.IFLA_VF_MAC;
    enum IFLA_VF_VLAN = _Anonymous_46.IFLA_VF_VLAN;
    enum IFLA_VF_TX_RATE = _Anonymous_46.IFLA_VF_TX_RATE;
    enum IFLA_VF_SPOOFCHK = _Anonymous_46.IFLA_VF_SPOOFCHK;
    enum IFLA_VF_LINK_STATE = _Anonymous_46.IFLA_VF_LINK_STATE;
    enum IFLA_VF_RATE = _Anonymous_46.IFLA_VF_RATE;
    enum IFLA_VF_RSS_QUERY_EN = _Anonymous_46.IFLA_VF_RSS_QUERY_EN;
    enum IFLA_VF_STATS = _Anonymous_46.IFLA_VF_STATS;
    enum IFLA_VF_TRUST = _Anonymous_46.IFLA_VF_TRUST;
    enum IFLA_VF_IB_NODE_GUID = _Anonymous_46.IFLA_VF_IB_NODE_GUID;
    enum IFLA_VF_IB_PORT_GUID = _Anonymous_46.IFLA_VF_IB_PORT_GUID;
    enum IFLA_VF_VLAN_LIST = _Anonymous_46.IFLA_VF_VLAN_LIST;
    enum IFLA_VF_BROADCAST = _Anonymous_46.IFLA_VF_BROADCAST;
    enum __IFLA_VF_MAX = _Anonymous_46.__IFLA_VF_MAX;
    enum _Anonymous_47
    {
        IFLA_VF_INFO_UNSPEC = 0,
        IFLA_VF_INFO = 1,
        __IFLA_VF_INFO_MAX = 2,
    }
    enum IFLA_VF_INFO_UNSPEC = _Anonymous_47.IFLA_VF_INFO_UNSPEC;
    enum IFLA_VF_INFO = _Anonymous_47.IFLA_VF_INFO;
    enum __IFLA_VF_INFO_MAX = _Anonymous_47.__IFLA_VF_INFO_MAX;
    enum _Anonymous_48
    {
        IFLA_BOND_SLAVE_UNSPEC = 0,
        IFLA_BOND_SLAVE_STATE = 1,
        IFLA_BOND_SLAVE_MII_STATUS = 2,
        IFLA_BOND_SLAVE_LINK_FAILURE_COUNT = 3,
        IFLA_BOND_SLAVE_PERM_HWADDR = 4,
        IFLA_BOND_SLAVE_QUEUE_ID = 5,
        IFLA_BOND_SLAVE_AD_AGGREGATOR_ID = 6,
        IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE = 7,
        IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE = 8,
        __IFLA_BOND_SLAVE_MAX = 9,
    }
    enum IFLA_BOND_SLAVE_UNSPEC = _Anonymous_48.IFLA_BOND_SLAVE_UNSPEC;
    enum IFLA_BOND_SLAVE_STATE = _Anonymous_48.IFLA_BOND_SLAVE_STATE;
    enum IFLA_BOND_SLAVE_MII_STATUS = _Anonymous_48.IFLA_BOND_SLAVE_MII_STATUS;
    enum IFLA_BOND_SLAVE_LINK_FAILURE_COUNT = _Anonymous_48.IFLA_BOND_SLAVE_LINK_FAILURE_COUNT;
    enum IFLA_BOND_SLAVE_PERM_HWADDR = _Anonymous_48.IFLA_BOND_SLAVE_PERM_HWADDR;
    enum IFLA_BOND_SLAVE_QUEUE_ID = _Anonymous_48.IFLA_BOND_SLAVE_QUEUE_ID;
    enum IFLA_BOND_SLAVE_AD_AGGREGATOR_ID = _Anonymous_48.IFLA_BOND_SLAVE_AD_AGGREGATOR_ID;
    enum IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE = _Anonymous_48.IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE;
    enum IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE = _Anonymous_48.IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE;
    enum __IFLA_BOND_SLAVE_MAX = _Anonymous_48.__IFLA_BOND_SLAVE_MAX;
    enum _Anonymous_49
    {
        IFLA_BOND_AD_INFO_UNSPEC = 0,
        IFLA_BOND_AD_INFO_AGGREGATOR = 1,
        IFLA_BOND_AD_INFO_NUM_PORTS = 2,
        IFLA_BOND_AD_INFO_ACTOR_KEY = 3,
        IFLA_BOND_AD_INFO_PARTNER_KEY = 4,
        IFLA_BOND_AD_INFO_PARTNER_MAC = 5,
        __IFLA_BOND_AD_INFO_MAX = 6,
    }
    enum IFLA_BOND_AD_INFO_UNSPEC = _Anonymous_49.IFLA_BOND_AD_INFO_UNSPEC;
    enum IFLA_BOND_AD_INFO_AGGREGATOR = _Anonymous_49.IFLA_BOND_AD_INFO_AGGREGATOR;
    enum IFLA_BOND_AD_INFO_NUM_PORTS = _Anonymous_49.IFLA_BOND_AD_INFO_NUM_PORTS;
    enum IFLA_BOND_AD_INFO_ACTOR_KEY = _Anonymous_49.IFLA_BOND_AD_INFO_ACTOR_KEY;
    enum IFLA_BOND_AD_INFO_PARTNER_KEY = _Anonymous_49.IFLA_BOND_AD_INFO_PARTNER_KEY;
    enum IFLA_BOND_AD_INFO_PARTNER_MAC = _Anonymous_49.IFLA_BOND_AD_INFO_PARTNER_MAC;
    enum __IFLA_BOND_AD_INFO_MAX = _Anonymous_49.__IFLA_BOND_AD_INFO_MAX;
    enum _Anonymous_50
    {
        IFLA_BOND_UNSPEC = 0,
        IFLA_BOND_MODE = 1,
        IFLA_BOND_ACTIVE_SLAVE = 2,
        IFLA_BOND_MIIMON = 3,
        IFLA_BOND_UPDELAY = 4,
        IFLA_BOND_DOWNDELAY = 5,
        IFLA_BOND_USE_CARRIER = 6,
        IFLA_BOND_ARP_INTERVAL = 7,
        IFLA_BOND_ARP_IP_TARGET = 8,
        IFLA_BOND_ARP_VALIDATE = 9,
        IFLA_BOND_ARP_ALL_TARGETS = 10,
        IFLA_BOND_PRIMARY = 11,
        IFLA_BOND_PRIMARY_RESELECT = 12,
        IFLA_BOND_FAIL_OVER_MAC = 13,
        IFLA_BOND_XMIT_HASH_POLICY = 14,
        IFLA_BOND_RESEND_IGMP = 15,
        IFLA_BOND_NUM_PEER_NOTIF = 16,
        IFLA_BOND_ALL_SLAVES_ACTIVE = 17,
        IFLA_BOND_MIN_LINKS = 18,
        IFLA_BOND_LP_INTERVAL = 19,
        IFLA_BOND_PACKETS_PER_SLAVE = 20,
        IFLA_BOND_AD_LACP_RATE = 21,
        IFLA_BOND_AD_SELECT = 22,
        IFLA_BOND_AD_INFO = 23,
        IFLA_BOND_AD_ACTOR_SYS_PRIO = 24,
        IFLA_BOND_AD_USER_PORT_KEY = 25,
        IFLA_BOND_AD_ACTOR_SYSTEM = 26,
        IFLA_BOND_TLB_DYNAMIC_LB = 27,
        IFLA_BOND_PEER_NOTIF_DELAY = 28,
        __IFLA_BOND_MAX = 29,
    }
    enum IFLA_BOND_UNSPEC = _Anonymous_50.IFLA_BOND_UNSPEC;
    enum IFLA_BOND_MODE = _Anonymous_50.IFLA_BOND_MODE;
    enum IFLA_BOND_ACTIVE_SLAVE = _Anonymous_50.IFLA_BOND_ACTIVE_SLAVE;
    enum IFLA_BOND_MIIMON = _Anonymous_50.IFLA_BOND_MIIMON;
    enum IFLA_BOND_UPDELAY = _Anonymous_50.IFLA_BOND_UPDELAY;
    enum IFLA_BOND_DOWNDELAY = _Anonymous_50.IFLA_BOND_DOWNDELAY;
    enum IFLA_BOND_USE_CARRIER = _Anonymous_50.IFLA_BOND_USE_CARRIER;
    enum IFLA_BOND_ARP_INTERVAL = _Anonymous_50.IFLA_BOND_ARP_INTERVAL;
    enum IFLA_BOND_ARP_IP_TARGET = _Anonymous_50.IFLA_BOND_ARP_IP_TARGET;
    enum IFLA_BOND_ARP_VALIDATE = _Anonymous_50.IFLA_BOND_ARP_VALIDATE;
    enum IFLA_BOND_ARP_ALL_TARGETS = _Anonymous_50.IFLA_BOND_ARP_ALL_TARGETS;
    enum IFLA_BOND_PRIMARY = _Anonymous_50.IFLA_BOND_PRIMARY;
    enum IFLA_BOND_PRIMARY_RESELECT = _Anonymous_50.IFLA_BOND_PRIMARY_RESELECT;
    enum IFLA_BOND_FAIL_OVER_MAC = _Anonymous_50.IFLA_BOND_FAIL_OVER_MAC;
    enum IFLA_BOND_XMIT_HASH_POLICY = _Anonymous_50.IFLA_BOND_XMIT_HASH_POLICY;
    enum IFLA_BOND_RESEND_IGMP = _Anonymous_50.IFLA_BOND_RESEND_IGMP;
    enum IFLA_BOND_NUM_PEER_NOTIF = _Anonymous_50.IFLA_BOND_NUM_PEER_NOTIF;
    enum IFLA_BOND_ALL_SLAVES_ACTIVE = _Anonymous_50.IFLA_BOND_ALL_SLAVES_ACTIVE;
    enum IFLA_BOND_MIN_LINKS = _Anonymous_50.IFLA_BOND_MIN_LINKS;
    enum IFLA_BOND_LP_INTERVAL = _Anonymous_50.IFLA_BOND_LP_INTERVAL;
    enum IFLA_BOND_PACKETS_PER_SLAVE = _Anonymous_50.IFLA_BOND_PACKETS_PER_SLAVE;
    enum IFLA_BOND_AD_LACP_RATE = _Anonymous_50.IFLA_BOND_AD_LACP_RATE;
    enum IFLA_BOND_AD_SELECT = _Anonymous_50.IFLA_BOND_AD_SELECT;
    enum IFLA_BOND_AD_INFO = _Anonymous_50.IFLA_BOND_AD_INFO;
    enum IFLA_BOND_AD_ACTOR_SYS_PRIO = _Anonymous_50.IFLA_BOND_AD_ACTOR_SYS_PRIO;
    enum IFLA_BOND_AD_USER_PORT_KEY = _Anonymous_50.IFLA_BOND_AD_USER_PORT_KEY;
    enum IFLA_BOND_AD_ACTOR_SYSTEM = _Anonymous_50.IFLA_BOND_AD_ACTOR_SYSTEM;
    enum IFLA_BOND_TLB_DYNAMIC_LB = _Anonymous_50.IFLA_BOND_TLB_DYNAMIC_LB;
    enum IFLA_BOND_PEER_NOTIF_DELAY = _Anonymous_50.IFLA_BOND_PEER_NOTIF_DELAY;
    enum __IFLA_BOND_MAX = _Anonymous_50.__IFLA_BOND_MAX;
    enum _Anonymous_51
    {
        IFLA_GTP_UNSPEC = 0,
        IFLA_GTP_FD0 = 1,
        IFLA_GTP_FD1 = 2,
        IFLA_GTP_PDP_HASHSIZE = 3,
        IFLA_GTP_ROLE = 4,
        __IFLA_GTP_MAX = 5,
    }
    enum IFLA_GTP_UNSPEC = _Anonymous_51.IFLA_GTP_UNSPEC;
    enum IFLA_GTP_FD0 = _Anonymous_51.IFLA_GTP_FD0;
    enum IFLA_GTP_FD1 = _Anonymous_51.IFLA_GTP_FD1;
    enum IFLA_GTP_PDP_HASHSIZE = _Anonymous_51.IFLA_GTP_PDP_HASHSIZE;
    enum IFLA_GTP_ROLE = _Anonymous_51.IFLA_GTP_ROLE;
    enum __IFLA_GTP_MAX = _Anonymous_51.__IFLA_GTP_MAX;
    enum ifla_gtp_role
    {
        GTP_ROLE_GGSN = 0,
        GTP_ROLE_SGSN = 1,
    }
    enum GTP_ROLE_GGSN = ifla_gtp_role.GTP_ROLE_GGSN;
    enum GTP_ROLE_SGSN = ifla_gtp_role.GTP_ROLE_SGSN;
    enum _Anonymous_52
    {
        IFLA_PPP_UNSPEC = 0,
        IFLA_PPP_DEV_FD = 1,
        __IFLA_PPP_MAX = 2,
    }
    enum IFLA_PPP_UNSPEC = _Anonymous_52.IFLA_PPP_UNSPEC;
    enum IFLA_PPP_DEV_FD = _Anonymous_52.IFLA_PPP_DEV_FD;
    enum __IFLA_PPP_MAX = _Anonymous_52.__IFLA_PPP_MAX;
    enum ifla_geneve_df
    {
        GENEVE_DF_UNSET = 0,
        GENEVE_DF_SET = 1,
        GENEVE_DF_INHERIT = 2,
        __GENEVE_DF_END = 3,
        GENEVE_DF_MAX = 2,
    }
    enum GENEVE_DF_UNSET = ifla_geneve_df.GENEVE_DF_UNSET;
    enum GENEVE_DF_SET = ifla_geneve_df.GENEVE_DF_SET;
    enum GENEVE_DF_INHERIT = ifla_geneve_df.GENEVE_DF_INHERIT;
    enum __GENEVE_DF_END = ifla_geneve_df.__GENEVE_DF_END;
    enum GENEVE_DF_MAX = ifla_geneve_df.GENEVE_DF_MAX;
    enum _Anonymous_53
    {
        IFLA_GENEVE_UNSPEC = 0,
        IFLA_GENEVE_ID = 1,
        IFLA_GENEVE_REMOTE = 2,
        IFLA_GENEVE_TTL = 3,
        IFLA_GENEVE_TOS = 4,
        IFLA_GENEVE_PORT = 5,
        IFLA_GENEVE_COLLECT_METADATA = 6,
        IFLA_GENEVE_REMOTE6 = 7,
        IFLA_GENEVE_UDP_CSUM = 8,
        IFLA_GENEVE_UDP_ZERO_CSUM6_TX = 9,
        IFLA_GENEVE_UDP_ZERO_CSUM6_RX = 10,
        IFLA_GENEVE_LABEL = 11,
        IFLA_GENEVE_TTL_INHERIT = 12,
        IFLA_GENEVE_DF = 13,
        __IFLA_GENEVE_MAX = 14,
    }
    enum IFLA_GENEVE_UNSPEC = _Anonymous_53.IFLA_GENEVE_UNSPEC;
    enum IFLA_GENEVE_ID = _Anonymous_53.IFLA_GENEVE_ID;
    enum IFLA_GENEVE_REMOTE = _Anonymous_53.IFLA_GENEVE_REMOTE;
    enum IFLA_GENEVE_TTL = _Anonymous_53.IFLA_GENEVE_TTL;
    enum IFLA_GENEVE_TOS = _Anonymous_53.IFLA_GENEVE_TOS;
    enum IFLA_GENEVE_PORT = _Anonymous_53.IFLA_GENEVE_PORT;
    enum IFLA_GENEVE_COLLECT_METADATA = _Anonymous_53.IFLA_GENEVE_COLLECT_METADATA;
    enum IFLA_GENEVE_REMOTE6 = _Anonymous_53.IFLA_GENEVE_REMOTE6;
    enum IFLA_GENEVE_UDP_CSUM = _Anonymous_53.IFLA_GENEVE_UDP_CSUM;
    enum IFLA_GENEVE_UDP_ZERO_CSUM6_TX = _Anonymous_53.IFLA_GENEVE_UDP_ZERO_CSUM6_TX;
    enum IFLA_GENEVE_UDP_ZERO_CSUM6_RX = _Anonymous_53.IFLA_GENEVE_UDP_ZERO_CSUM6_RX;
    enum IFLA_GENEVE_LABEL = _Anonymous_53.IFLA_GENEVE_LABEL;
    enum IFLA_GENEVE_TTL_INHERIT = _Anonymous_53.IFLA_GENEVE_TTL_INHERIT;
    enum IFLA_GENEVE_DF = _Anonymous_53.IFLA_GENEVE_DF;
    enum __IFLA_GENEVE_MAX = _Anonymous_53.__IFLA_GENEVE_MAX;
    enum ifla_vxlan_df
    {
        VXLAN_DF_UNSET = 0,
        VXLAN_DF_SET = 1,
        VXLAN_DF_INHERIT = 2,
        __VXLAN_DF_END = 3,
        VXLAN_DF_MAX = 2,
    }
    enum VXLAN_DF_UNSET = ifla_vxlan_df.VXLAN_DF_UNSET;
    enum VXLAN_DF_SET = ifla_vxlan_df.VXLAN_DF_SET;
    enum VXLAN_DF_INHERIT = ifla_vxlan_df.VXLAN_DF_INHERIT;
    enum __VXLAN_DF_END = ifla_vxlan_df.__VXLAN_DF_END;
    enum VXLAN_DF_MAX = ifla_vxlan_df.VXLAN_DF_MAX;
    struct ifla_vxlan_port_range
    {
        ushort low;
        ushort high;
    }
    enum _Anonymous_54
    {
        IFLA_VXLAN_UNSPEC = 0,
        IFLA_VXLAN_ID = 1,
        IFLA_VXLAN_GROUP = 2,
        IFLA_VXLAN_LINK = 3,
        IFLA_VXLAN_LOCAL = 4,
        IFLA_VXLAN_TTL = 5,
        IFLA_VXLAN_TOS = 6,
        IFLA_VXLAN_LEARNING = 7,
        IFLA_VXLAN_AGEING = 8,
        IFLA_VXLAN_LIMIT = 9,
        IFLA_VXLAN_PORT_RANGE = 10,
        IFLA_VXLAN_PROXY = 11,
        IFLA_VXLAN_RSC = 12,
        IFLA_VXLAN_L2MISS = 13,
        IFLA_VXLAN_L3MISS = 14,
        IFLA_VXLAN_PORT = 15,
        IFLA_VXLAN_GROUP6 = 16,
        IFLA_VXLAN_LOCAL6 = 17,
        IFLA_VXLAN_UDP_CSUM = 18,
        IFLA_VXLAN_UDP_ZERO_CSUM6_TX = 19,
        IFLA_VXLAN_UDP_ZERO_CSUM6_RX = 20,
        IFLA_VXLAN_REMCSUM_TX = 21,
        IFLA_VXLAN_REMCSUM_RX = 22,
        IFLA_VXLAN_GBP = 23,
        IFLA_VXLAN_REMCSUM_NOPARTIAL = 24,
        IFLA_VXLAN_COLLECT_METADATA = 25,
        IFLA_VXLAN_LABEL = 26,
        IFLA_VXLAN_GPE = 27,
        IFLA_VXLAN_TTL_INHERIT = 28,
        IFLA_VXLAN_DF = 29,
        __IFLA_VXLAN_MAX = 30,
    }
    enum IFLA_VXLAN_UNSPEC = _Anonymous_54.IFLA_VXLAN_UNSPEC;
    enum IFLA_VXLAN_ID = _Anonymous_54.IFLA_VXLAN_ID;
    enum IFLA_VXLAN_GROUP = _Anonymous_54.IFLA_VXLAN_GROUP;
    enum IFLA_VXLAN_LINK = _Anonymous_54.IFLA_VXLAN_LINK;
    enum IFLA_VXLAN_LOCAL = _Anonymous_54.IFLA_VXLAN_LOCAL;
    enum IFLA_VXLAN_TTL = _Anonymous_54.IFLA_VXLAN_TTL;
    enum IFLA_VXLAN_TOS = _Anonymous_54.IFLA_VXLAN_TOS;
    enum IFLA_VXLAN_LEARNING = _Anonymous_54.IFLA_VXLAN_LEARNING;
    enum IFLA_VXLAN_AGEING = _Anonymous_54.IFLA_VXLAN_AGEING;
    enum IFLA_VXLAN_LIMIT = _Anonymous_54.IFLA_VXLAN_LIMIT;
    enum IFLA_VXLAN_PORT_RANGE = _Anonymous_54.IFLA_VXLAN_PORT_RANGE;
    enum IFLA_VXLAN_PROXY = _Anonymous_54.IFLA_VXLAN_PROXY;
    enum IFLA_VXLAN_RSC = _Anonymous_54.IFLA_VXLAN_RSC;
    enum IFLA_VXLAN_L2MISS = _Anonymous_54.IFLA_VXLAN_L2MISS;
    enum IFLA_VXLAN_L3MISS = _Anonymous_54.IFLA_VXLAN_L3MISS;
    enum IFLA_VXLAN_PORT = _Anonymous_54.IFLA_VXLAN_PORT;
    enum IFLA_VXLAN_GROUP6 = _Anonymous_54.IFLA_VXLAN_GROUP6;
    enum IFLA_VXLAN_LOCAL6 = _Anonymous_54.IFLA_VXLAN_LOCAL6;
    enum IFLA_VXLAN_UDP_CSUM = _Anonymous_54.IFLA_VXLAN_UDP_CSUM;
    enum IFLA_VXLAN_UDP_ZERO_CSUM6_TX = _Anonymous_54.IFLA_VXLAN_UDP_ZERO_CSUM6_TX;
    enum IFLA_VXLAN_UDP_ZERO_CSUM6_RX = _Anonymous_54.IFLA_VXLAN_UDP_ZERO_CSUM6_RX;
    enum IFLA_VXLAN_REMCSUM_TX = _Anonymous_54.IFLA_VXLAN_REMCSUM_TX;
    enum IFLA_VXLAN_REMCSUM_RX = _Anonymous_54.IFLA_VXLAN_REMCSUM_RX;
    enum IFLA_VXLAN_GBP = _Anonymous_54.IFLA_VXLAN_GBP;
    enum IFLA_VXLAN_REMCSUM_NOPARTIAL = _Anonymous_54.IFLA_VXLAN_REMCSUM_NOPARTIAL;
    enum IFLA_VXLAN_COLLECT_METADATA = _Anonymous_54.IFLA_VXLAN_COLLECT_METADATA;
    enum IFLA_VXLAN_LABEL = _Anonymous_54.IFLA_VXLAN_LABEL;
    enum IFLA_VXLAN_GPE = _Anonymous_54.IFLA_VXLAN_GPE;
    enum IFLA_VXLAN_TTL_INHERIT = _Anonymous_54.IFLA_VXLAN_TTL_INHERIT;
    enum IFLA_VXLAN_DF = _Anonymous_54.IFLA_VXLAN_DF;
    enum __IFLA_VXLAN_MAX = _Anonymous_54.__IFLA_VXLAN_MAX;
    enum ipvlan_mode
    {
        IPVLAN_MODE_L2 = 0,
        IPVLAN_MODE_L3 = 1,
        IPVLAN_MODE_L3S = 2,
        IPVLAN_MODE_MAX = 3,
    }
    enum IPVLAN_MODE_L2 = ipvlan_mode.IPVLAN_MODE_L2;
    enum IPVLAN_MODE_L3 = ipvlan_mode.IPVLAN_MODE_L3;
    enum IPVLAN_MODE_L3S = ipvlan_mode.IPVLAN_MODE_L3S;
    enum IPVLAN_MODE_MAX = ipvlan_mode.IPVLAN_MODE_MAX;
    enum _Anonymous_55
    {
        IFLA_IPVLAN_UNSPEC = 0,
        IFLA_IPVLAN_MODE = 1,
        IFLA_IPVLAN_FLAGS = 2,
        __IFLA_IPVLAN_MAX = 3,
    }
    enum IFLA_IPVLAN_UNSPEC = _Anonymous_55.IFLA_IPVLAN_UNSPEC;
    enum IFLA_IPVLAN_MODE = _Anonymous_55.IFLA_IPVLAN_MODE;
    enum IFLA_IPVLAN_FLAGS = _Anonymous_55.IFLA_IPVLAN_FLAGS;
    enum __IFLA_IPVLAN_MAX = _Anonymous_55.__IFLA_IPVLAN_MAX;
    enum macsec_validation_type
    {
        MACSEC_VALIDATE_DISABLED = 0,
        MACSEC_VALIDATE_CHECK = 1,
        MACSEC_VALIDATE_STRICT = 2,
        __MACSEC_VALIDATE_END = 3,
        MACSEC_VALIDATE_MAX = 2,
    }
    enum MACSEC_VALIDATE_DISABLED = macsec_validation_type.MACSEC_VALIDATE_DISABLED;
    enum MACSEC_VALIDATE_CHECK = macsec_validation_type.MACSEC_VALIDATE_CHECK;
    enum MACSEC_VALIDATE_STRICT = macsec_validation_type.MACSEC_VALIDATE_STRICT;
    enum __MACSEC_VALIDATE_END = macsec_validation_type.__MACSEC_VALIDATE_END;
    enum MACSEC_VALIDATE_MAX = macsec_validation_type.MACSEC_VALIDATE_MAX;
    enum _Anonymous_56
    {
        IFLA_XFRM_UNSPEC = 0,
        IFLA_XFRM_LINK = 1,
        IFLA_XFRM_IF_ID = 2,
        __IFLA_XFRM_MAX = 3,
    }
    enum IFLA_XFRM_UNSPEC = _Anonymous_56.IFLA_XFRM_UNSPEC;
    enum IFLA_XFRM_LINK = _Anonymous_56.IFLA_XFRM_LINK;
    enum IFLA_XFRM_IF_ID = _Anonymous_56.IFLA_XFRM_IF_ID;
    enum __IFLA_XFRM_MAX = _Anonymous_56.__IFLA_XFRM_MAX;
    enum _Anonymous_57
    {
        IFLA_MACSEC_UNSPEC = 0,
        IFLA_MACSEC_SCI = 1,
        IFLA_MACSEC_PORT = 2,
        IFLA_MACSEC_ICV_LEN = 3,
        IFLA_MACSEC_CIPHER_SUITE = 4,
        IFLA_MACSEC_WINDOW = 5,
        IFLA_MACSEC_ENCODING_SA = 6,
        IFLA_MACSEC_ENCRYPT = 7,
        IFLA_MACSEC_PROTECT = 8,
        IFLA_MACSEC_INC_SCI = 9,
        IFLA_MACSEC_ES = 10,
        IFLA_MACSEC_SCB = 11,
        IFLA_MACSEC_REPLAY_PROTECT = 12,
        IFLA_MACSEC_VALIDATION = 13,
        IFLA_MACSEC_PAD = 14,
        __IFLA_MACSEC_MAX = 15,
    }
    enum IFLA_MACSEC_UNSPEC = _Anonymous_57.IFLA_MACSEC_UNSPEC;
    enum IFLA_MACSEC_SCI = _Anonymous_57.IFLA_MACSEC_SCI;
    enum IFLA_MACSEC_PORT = _Anonymous_57.IFLA_MACSEC_PORT;
    enum IFLA_MACSEC_ICV_LEN = _Anonymous_57.IFLA_MACSEC_ICV_LEN;
    enum IFLA_MACSEC_CIPHER_SUITE = _Anonymous_57.IFLA_MACSEC_CIPHER_SUITE;
    enum IFLA_MACSEC_WINDOW = _Anonymous_57.IFLA_MACSEC_WINDOW;
    enum IFLA_MACSEC_ENCODING_SA = _Anonymous_57.IFLA_MACSEC_ENCODING_SA;
    enum IFLA_MACSEC_ENCRYPT = _Anonymous_57.IFLA_MACSEC_ENCRYPT;
    enum IFLA_MACSEC_PROTECT = _Anonymous_57.IFLA_MACSEC_PROTECT;
    enum IFLA_MACSEC_INC_SCI = _Anonymous_57.IFLA_MACSEC_INC_SCI;
    enum IFLA_MACSEC_ES = _Anonymous_57.IFLA_MACSEC_ES;
    enum IFLA_MACSEC_SCB = _Anonymous_57.IFLA_MACSEC_SCB;
    enum IFLA_MACSEC_REPLAY_PROTECT = _Anonymous_57.IFLA_MACSEC_REPLAY_PROTECT;
    enum IFLA_MACSEC_VALIDATION = _Anonymous_57.IFLA_MACSEC_VALIDATION;
    enum IFLA_MACSEC_PAD = _Anonymous_57.IFLA_MACSEC_PAD;
    enum __IFLA_MACSEC_MAX = _Anonymous_57.__IFLA_MACSEC_MAX;
    enum _Anonymous_58
    {
        IFLA_VRF_PORT_UNSPEC = 0,
        IFLA_VRF_PORT_TABLE = 1,
        __IFLA_VRF_PORT_MAX = 2,
    }
    enum IFLA_VRF_PORT_UNSPEC = _Anonymous_58.IFLA_VRF_PORT_UNSPEC;
    enum IFLA_VRF_PORT_TABLE = _Anonymous_58.IFLA_VRF_PORT_TABLE;
    enum __IFLA_VRF_PORT_MAX = _Anonymous_58.__IFLA_VRF_PORT_MAX;
    enum _Anonymous_59
    {
        IFLA_VRF_UNSPEC = 0,
        IFLA_VRF_TABLE = 1,
        __IFLA_VRF_MAX = 2,
    }
    enum IFLA_VRF_UNSPEC = _Anonymous_59.IFLA_VRF_UNSPEC;
    enum IFLA_VRF_TABLE = _Anonymous_59.IFLA_VRF_TABLE;
    enum __IFLA_VRF_MAX = _Anonymous_59.__IFLA_VRF_MAX;
    enum macvlan_macaddr_mode
    {
        MACVLAN_MACADDR_ADD = 0,
        MACVLAN_MACADDR_DEL = 1,
        MACVLAN_MACADDR_FLUSH = 2,
        MACVLAN_MACADDR_SET = 3,
    }
    enum MACVLAN_MACADDR_ADD = macvlan_macaddr_mode.MACVLAN_MACADDR_ADD;
    enum MACVLAN_MACADDR_DEL = macvlan_macaddr_mode.MACVLAN_MACADDR_DEL;
    enum MACVLAN_MACADDR_FLUSH = macvlan_macaddr_mode.MACVLAN_MACADDR_FLUSH;
    enum MACVLAN_MACADDR_SET = macvlan_macaddr_mode.MACVLAN_MACADDR_SET;
    enum macvlan_mode
    {
        MACVLAN_MODE_PRIVATE = 1,
        MACVLAN_MODE_VEPA = 2,
        MACVLAN_MODE_BRIDGE = 4,
        MACVLAN_MODE_PASSTHRU = 8,
        MACVLAN_MODE_SOURCE = 16,
    }
    enum MACVLAN_MODE_PRIVATE = macvlan_mode.MACVLAN_MODE_PRIVATE;
    enum MACVLAN_MODE_VEPA = macvlan_mode.MACVLAN_MODE_VEPA;
    enum MACVLAN_MODE_BRIDGE = macvlan_mode.MACVLAN_MODE_BRIDGE;
    enum MACVLAN_MODE_PASSTHRU = macvlan_mode.MACVLAN_MODE_PASSTHRU;
    enum MACVLAN_MODE_SOURCE = macvlan_mode.MACVLAN_MODE_SOURCE;
    enum _Anonymous_60
    {
        IFLA_MACVLAN_UNSPEC = 0,
        IFLA_MACVLAN_MODE = 1,
        IFLA_MACVLAN_FLAGS = 2,
        IFLA_MACVLAN_MACADDR_MODE = 3,
        IFLA_MACVLAN_MACADDR = 4,
        IFLA_MACVLAN_MACADDR_DATA = 5,
        IFLA_MACVLAN_MACADDR_COUNT = 6,
        __IFLA_MACVLAN_MAX = 7,
    }
    enum IFLA_MACVLAN_UNSPEC = _Anonymous_60.IFLA_MACVLAN_UNSPEC;
    enum IFLA_MACVLAN_MODE = _Anonymous_60.IFLA_MACVLAN_MODE;
    enum IFLA_MACVLAN_FLAGS = _Anonymous_60.IFLA_MACVLAN_FLAGS;
    enum IFLA_MACVLAN_MACADDR_MODE = _Anonymous_60.IFLA_MACVLAN_MACADDR_MODE;
    enum IFLA_MACVLAN_MACADDR = _Anonymous_60.IFLA_MACVLAN_MACADDR;
    enum IFLA_MACVLAN_MACADDR_DATA = _Anonymous_60.IFLA_MACVLAN_MACADDR_DATA;
    enum IFLA_MACVLAN_MACADDR_COUNT = _Anonymous_60.IFLA_MACVLAN_MACADDR_COUNT;
    enum __IFLA_MACVLAN_MAX = _Anonymous_60.__IFLA_MACVLAN_MAX;
    struct ifla_vlan_qos_mapping
    {
        uint from;
        uint to;
    }
    enum _Anonymous_61
    {
        IFLA_VLAN_QOS_UNSPEC = 0,
        IFLA_VLAN_QOS_MAPPING = 1,
        __IFLA_VLAN_QOS_MAX = 2,
    }
    enum IFLA_VLAN_QOS_UNSPEC = _Anonymous_61.IFLA_VLAN_QOS_UNSPEC;
    enum IFLA_VLAN_QOS_MAPPING = _Anonymous_61.IFLA_VLAN_QOS_MAPPING;
    enum __IFLA_VLAN_QOS_MAX = _Anonymous_61.__IFLA_VLAN_QOS_MAX;
    struct ifla_vlan_flags
    {
        uint flags;
        uint mask;
    }
    enum _Anonymous_62
    {
        IFLA_VLAN_UNSPEC = 0,
        IFLA_VLAN_ID = 1,
        IFLA_VLAN_FLAGS = 2,
        IFLA_VLAN_EGRESS_QOS = 3,
        IFLA_VLAN_INGRESS_QOS = 4,
        IFLA_VLAN_PROTOCOL = 5,
        __IFLA_VLAN_MAX = 6,
    }
    enum IFLA_VLAN_UNSPEC = _Anonymous_62.IFLA_VLAN_UNSPEC;
    enum IFLA_VLAN_ID = _Anonymous_62.IFLA_VLAN_ID;
    enum IFLA_VLAN_FLAGS = _Anonymous_62.IFLA_VLAN_FLAGS;
    enum IFLA_VLAN_EGRESS_QOS = _Anonymous_62.IFLA_VLAN_EGRESS_QOS;
    enum IFLA_VLAN_INGRESS_QOS = _Anonymous_62.IFLA_VLAN_INGRESS_QOS;
    enum IFLA_VLAN_PROTOCOL = _Anonymous_62.IFLA_VLAN_PROTOCOL;
    enum __IFLA_VLAN_MAX = _Anonymous_62.__IFLA_VLAN_MAX;
    enum _Anonymous_63
    {
        IFLA_INFO_UNSPEC = 0,
        IFLA_INFO_KIND = 1,
        IFLA_INFO_DATA = 2,
        IFLA_INFO_XSTATS = 3,
        IFLA_INFO_SLAVE_KIND = 4,
        IFLA_INFO_SLAVE_DATA = 5,
        __IFLA_INFO_MAX = 6,
    }
    enum IFLA_INFO_UNSPEC = _Anonymous_63.IFLA_INFO_UNSPEC;
    enum IFLA_INFO_KIND = _Anonymous_63.IFLA_INFO_KIND;
    enum IFLA_INFO_DATA = _Anonymous_63.IFLA_INFO_DATA;
    enum IFLA_INFO_XSTATS = _Anonymous_63.IFLA_INFO_XSTATS;
    enum IFLA_INFO_SLAVE_KIND = _Anonymous_63.IFLA_INFO_SLAVE_KIND;
    enum IFLA_INFO_SLAVE_DATA = _Anonymous_63.IFLA_INFO_SLAVE_DATA;
    enum __IFLA_INFO_MAX = _Anonymous_63.__IFLA_INFO_MAX;
    struct ifla_cacheinfo
    {
        uint max_reasm_len;
        uint tstamp;
        uint reachable_time;
        uint retrans_time;
    }
    enum _Anonymous_64
    {
        IFLA_BRPORT_UNSPEC = 0,
        IFLA_BRPORT_STATE = 1,
        IFLA_BRPORT_PRIORITY = 2,
        IFLA_BRPORT_COST = 3,
        IFLA_BRPORT_MODE = 4,
        IFLA_BRPORT_GUARD = 5,
        IFLA_BRPORT_PROTECT = 6,
        IFLA_BRPORT_FAST_LEAVE = 7,
        IFLA_BRPORT_LEARNING = 8,
        IFLA_BRPORT_UNICAST_FLOOD = 9,
        IFLA_BRPORT_PROXYARP = 10,
        IFLA_BRPORT_LEARNING_SYNC = 11,
        IFLA_BRPORT_PROXYARP_WIFI = 12,
        IFLA_BRPORT_ROOT_ID = 13,
        IFLA_BRPORT_BRIDGE_ID = 14,
        IFLA_BRPORT_DESIGNATED_PORT = 15,
        IFLA_BRPORT_DESIGNATED_COST = 16,
        IFLA_BRPORT_ID = 17,
        IFLA_BRPORT_NO = 18,
        IFLA_BRPORT_TOPOLOGY_CHANGE_ACK = 19,
        IFLA_BRPORT_CONFIG_PENDING = 20,
        IFLA_BRPORT_MESSAGE_AGE_TIMER = 21,
        IFLA_BRPORT_FORWARD_DELAY_TIMER = 22,
        IFLA_BRPORT_HOLD_TIMER = 23,
        IFLA_BRPORT_FLUSH = 24,
        IFLA_BRPORT_MULTICAST_ROUTER = 25,
        IFLA_BRPORT_PAD = 26,
        IFLA_BRPORT_MCAST_FLOOD = 27,
        IFLA_BRPORT_MCAST_TO_UCAST = 28,
        IFLA_BRPORT_VLAN_TUNNEL = 29,
        IFLA_BRPORT_BCAST_FLOOD = 30,
        IFLA_BRPORT_GROUP_FWD_MASK = 31,
        IFLA_BRPORT_NEIGH_SUPPRESS = 32,
        IFLA_BRPORT_ISOLATED = 33,
        IFLA_BRPORT_BACKUP_PORT = 34,
        __IFLA_BRPORT_MAX = 35,
    }
    enum IFLA_BRPORT_UNSPEC = _Anonymous_64.IFLA_BRPORT_UNSPEC;
    enum IFLA_BRPORT_STATE = _Anonymous_64.IFLA_BRPORT_STATE;
    enum IFLA_BRPORT_PRIORITY = _Anonymous_64.IFLA_BRPORT_PRIORITY;
    enum IFLA_BRPORT_COST = _Anonymous_64.IFLA_BRPORT_COST;
    enum IFLA_BRPORT_MODE = _Anonymous_64.IFLA_BRPORT_MODE;
    enum IFLA_BRPORT_GUARD = _Anonymous_64.IFLA_BRPORT_GUARD;
    enum IFLA_BRPORT_PROTECT = _Anonymous_64.IFLA_BRPORT_PROTECT;
    enum IFLA_BRPORT_FAST_LEAVE = _Anonymous_64.IFLA_BRPORT_FAST_LEAVE;
    enum IFLA_BRPORT_LEARNING = _Anonymous_64.IFLA_BRPORT_LEARNING;
    enum IFLA_BRPORT_UNICAST_FLOOD = _Anonymous_64.IFLA_BRPORT_UNICAST_FLOOD;
    enum IFLA_BRPORT_PROXYARP = _Anonymous_64.IFLA_BRPORT_PROXYARP;
    enum IFLA_BRPORT_LEARNING_SYNC = _Anonymous_64.IFLA_BRPORT_LEARNING_SYNC;
    enum IFLA_BRPORT_PROXYARP_WIFI = _Anonymous_64.IFLA_BRPORT_PROXYARP_WIFI;
    enum IFLA_BRPORT_ROOT_ID = _Anonymous_64.IFLA_BRPORT_ROOT_ID;
    enum IFLA_BRPORT_BRIDGE_ID = _Anonymous_64.IFLA_BRPORT_BRIDGE_ID;
    enum IFLA_BRPORT_DESIGNATED_PORT = _Anonymous_64.IFLA_BRPORT_DESIGNATED_PORT;
    enum IFLA_BRPORT_DESIGNATED_COST = _Anonymous_64.IFLA_BRPORT_DESIGNATED_COST;
    enum IFLA_BRPORT_ID = _Anonymous_64.IFLA_BRPORT_ID;
    enum IFLA_BRPORT_NO = _Anonymous_64.IFLA_BRPORT_NO;
    enum IFLA_BRPORT_TOPOLOGY_CHANGE_ACK = _Anonymous_64.IFLA_BRPORT_TOPOLOGY_CHANGE_ACK;
    enum IFLA_BRPORT_CONFIG_PENDING = _Anonymous_64.IFLA_BRPORT_CONFIG_PENDING;
    enum IFLA_BRPORT_MESSAGE_AGE_TIMER = _Anonymous_64.IFLA_BRPORT_MESSAGE_AGE_TIMER;
    enum IFLA_BRPORT_FORWARD_DELAY_TIMER = _Anonymous_64.IFLA_BRPORT_FORWARD_DELAY_TIMER;
    enum IFLA_BRPORT_HOLD_TIMER = _Anonymous_64.IFLA_BRPORT_HOLD_TIMER;
    enum IFLA_BRPORT_FLUSH = _Anonymous_64.IFLA_BRPORT_FLUSH;
    enum IFLA_BRPORT_MULTICAST_ROUTER = _Anonymous_64.IFLA_BRPORT_MULTICAST_ROUTER;
    enum IFLA_BRPORT_PAD = _Anonymous_64.IFLA_BRPORT_PAD;
    enum IFLA_BRPORT_MCAST_FLOOD = _Anonymous_64.IFLA_BRPORT_MCAST_FLOOD;
    enum IFLA_BRPORT_MCAST_TO_UCAST = _Anonymous_64.IFLA_BRPORT_MCAST_TO_UCAST;
    enum IFLA_BRPORT_VLAN_TUNNEL = _Anonymous_64.IFLA_BRPORT_VLAN_TUNNEL;
    enum IFLA_BRPORT_BCAST_FLOOD = _Anonymous_64.IFLA_BRPORT_BCAST_FLOOD;
    enum IFLA_BRPORT_GROUP_FWD_MASK = _Anonymous_64.IFLA_BRPORT_GROUP_FWD_MASK;
    enum IFLA_BRPORT_NEIGH_SUPPRESS = _Anonymous_64.IFLA_BRPORT_NEIGH_SUPPRESS;
    enum IFLA_BRPORT_ISOLATED = _Anonymous_64.IFLA_BRPORT_ISOLATED;
    enum IFLA_BRPORT_BACKUP_PORT = _Anonymous_64.IFLA_BRPORT_BACKUP_PORT;
    enum __IFLA_BRPORT_MAX = _Anonymous_64.__IFLA_BRPORT_MAX;
    enum _Anonymous_65
    {
        BRIDGE_MODE_UNSPEC = 0,
        BRIDGE_MODE_HAIRPIN = 1,
    }
    enum BRIDGE_MODE_UNSPEC = _Anonymous_65.BRIDGE_MODE_UNSPEC;
    enum BRIDGE_MODE_HAIRPIN = _Anonymous_65.BRIDGE_MODE_HAIRPIN;
    struct ifla_bridge_id
    {
        ubyte[2] prio;
        ubyte[6] addr;
    }
    enum _Anonymous_66
    {
        IFLA_BR_UNSPEC = 0,
        IFLA_BR_FORWARD_DELAY = 1,
        IFLA_BR_HELLO_TIME = 2,
        IFLA_BR_MAX_AGE = 3,
        IFLA_BR_AGEING_TIME = 4,
        IFLA_BR_STP_STATE = 5,
        IFLA_BR_PRIORITY = 6,
        IFLA_BR_VLAN_FILTERING = 7,
        IFLA_BR_VLAN_PROTOCOL = 8,
        IFLA_BR_GROUP_FWD_MASK = 9,
        IFLA_BR_ROOT_ID = 10,
        IFLA_BR_BRIDGE_ID = 11,
        IFLA_BR_ROOT_PORT = 12,
        IFLA_BR_ROOT_PATH_COST = 13,
        IFLA_BR_TOPOLOGY_CHANGE = 14,
        IFLA_BR_TOPOLOGY_CHANGE_DETECTED = 15,
        IFLA_BR_HELLO_TIMER = 16,
        IFLA_BR_TCN_TIMER = 17,
        IFLA_BR_TOPOLOGY_CHANGE_TIMER = 18,
        IFLA_BR_GC_TIMER = 19,
        IFLA_BR_GROUP_ADDR = 20,
        IFLA_BR_FDB_FLUSH = 21,
        IFLA_BR_MCAST_ROUTER = 22,
        IFLA_BR_MCAST_SNOOPING = 23,
        IFLA_BR_MCAST_QUERY_USE_IFADDR = 24,
        IFLA_BR_MCAST_QUERIER = 25,
        IFLA_BR_MCAST_HASH_ELASTICITY = 26,
        IFLA_BR_MCAST_HASH_MAX = 27,
        IFLA_BR_MCAST_LAST_MEMBER_CNT = 28,
        IFLA_BR_MCAST_STARTUP_QUERY_CNT = 29,
        IFLA_BR_MCAST_LAST_MEMBER_INTVL = 30,
        IFLA_BR_MCAST_MEMBERSHIP_INTVL = 31,
        IFLA_BR_MCAST_QUERIER_INTVL = 32,
        IFLA_BR_MCAST_QUERY_INTVL = 33,
        IFLA_BR_MCAST_QUERY_RESPONSE_INTVL = 34,
        IFLA_BR_MCAST_STARTUP_QUERY_INTVL = 35,
        IFLA_BR_NF_CALL_IPTABLES = 36,
        IFLA_BR_NF_CALL_IP6TABLES = 37,
        IFLA_BR_NF_CALL_ARPTABLES = 38,
        IFLA_BR_VLAN_DEFAULT_PVID = 39,
        IFLA_BR_PAD = 40,
        IFLA_BR_VLAN_STATS_ENABLED = 41,
        IFLA_BR_MCAST_STATS_ENABLED = 42,
        IFLA_BR_MCAST_IGMP_VERSION = 43,
        IFLA_BR_MCAST_MLD_VERSION = 44,
        IFLA_BR_VLAN_STATS_PER_PORT = 45,
        IFLA_BR_MULTI_BOOLOPT = 46,
        __IFLA_BR_MAX = 47,
    }
    enum IFLA_BR_UNSPEC = _Anonymous_66.IFLA_BR_UNSPEC;
    enum IFLA_BR_FORWARD_DELAY = _Anonymous_66.IFLA_BR_FORWARD_DELAY;
    enum IFLA_BR_HELLO_TIME = _Anonymous_66.IFLA_BR_HELLO_TIME;
    enum IFLA_BR_MAX_AGE = _Anonymous_66.IFLA_BR_MAX_AGE;
    enum IFLA_BR_AGEING_TIME = _Anonymous_66.IFLA_BR_AGEING_TIME;
    enum IFLA_BR_STP_STATE = _Anonymous_66.IFLA_BR_STP_STATE;
    enum IFLA_BR_PRIORITY = _Anonymous_66.IFLA_BR_PRIORITY;
    enum IFLA_BR_VLAN_FILTERING = _Anonymous_66.IFLA_BR_VLAN_FILTERING;
    enum IFLA_BR_VLAN_PROTOCOL = _Anonymous_66.IFLA_BR_VLAN_PROTOCOL;
    enum IFLA_BR_GROUP_FWD_MASK = _Anonymous_66.IFLA_BR_GROUP_FWD_MASK;
    enum IFLA_BR_ROOT_ID = _Anonymous_66.IFLA_BR_ROOT_ID;
    enum IFLA_BR_BRIDGE_ID = _Anonymous_66.IFLA_BR_BRIDGE_ID;
    enum IFLA_BR_ROOT_PORT = _Anonymous_66.IFLA_BR_ROOT_PORT;
    enum IFLA_BR_ROOT_PATH_COST = _Anonymous_66.IFLA_BR_ROOT_PATH_COST;
    enum IFLA_BR_TOPOLOGY_CHANGE = _Anonymous_66.IFLA_BR_TOPOLOGY_CHANGE;
    enum IFLA_BR_TOPOLOGY_CHANGE_DETECTED = _Anonymous_66.IFLA_BR_TOPOLOGY_CHANGE_DETECTED;
    enum IFLA_BR_HELLO_TIMER = _Anonymous_66.IFLA_BR_HELLO_TIMER;
    enum IFLA_BR_TCN_TIMER = _Anonymous_66.IFLA_BR_TCN_TIMER;
    enum IFLA_BR_TOPOLOGY_CHANGE_TIMER = _Anonymous_66.IFLA_BR_TOPOLOGY_CHANGE_TIMER;
    enum IFLA_BR_GC_TIMER = _Anonymous_66.IFLA_BR_GC_TIMER;
    enum IFLA_BR_GROUP_ADDR = _Anonymous_66.IFLA_BR_GROUP_ADDR;
    enum IFLA_BR_FDB_FLUSH = _Anonymous_66.IFLA_BR_FDB_FLUSH;
    enum IFLA_BR_MCAST_ROUTER = _Anonymous_66.IFLA_BR_MCAST_ROUTER;
    enum IFLA_BR_MCAST_SNOOPING = _Anonymous_66.IFLA_BR_MCAST_SNOOPING;
    enum IFLA_BR_MCAST_QUERY_USE_IFADDR = _Anonymous_66.IFLA_BR_MCAST_QUERY_USE_IFADDR;
    enum IFLA_BR_MCAST_QUERIER = _Anonymous_66.IFLA_BR_MCAST_QUERIER;
    enum IFLA_BR_MCAST_HASH_ELASTICITY = _Anonymous_66.IFLA_BR_MCAST_HASH_ELASTICITY;
    enum IFLA_BR_MCAST_HASH_MAX = _Anonymous_66.IFLA_BR_MCAST_HASH_MAX;
    enum IFLA_BR_MCAST_LAST_MEMBER_CNT = _Anonymous_66.IFLA_BR_MCAST_LAST_MEMBER_CNT;
    enum IFLA_BR_MCAST_STARTUP_QUERY_CNT = _Anonymous_66.IFLA_BR_MCAST_STARTUP_QUERY_CNT;
    enum IFLA_BR_MCAST_LAST_MEMBER_INTVL = _Anonymous_66.IFLA_BR_MCAST_LAST_MEMBER_INTVL;
    enum IFLA_BR_MCAST_MEMBERSHIP_INTVL = _Anonymous_66.IFLA_BR_MCAST_MEMBERSHIP_INTVL;
    enum IFLA_BR_MCAST_QUERIER_INTVL = _Anonymous_66.IFLA_BR_MCAST_QUERIER_INTVL;
    enum IFLA_BR_MCAST_QUERY_INTVL = _Anonymous_66.IFLA_BR_MCAST_QUERY_INTVL;
    enum IFLA_BR_MCAST_QUERY_RESPONSE_INTVL = _Anonymous_66.IFLA_BR_MCAST_QUERY_RESPONSE_INTVL;
    enum IFLA_BR_MCAST_STARTUP_QUERY_INTVL = _Anonymous_66.IFLA_BR_MCAST_STARTUP_QUERY_INTVL;
    enum IFLA_BR_NF_CALL_IPTABLES = _Anonymous_66.IFLA_BR_NF_CALL_IPTABLES;
    enum IFLA_BR_NF_CALL_IP6TABLES = _Anonymous_66.IFLA_BR_NF_CALL_IP6TABLES;
    enum IFLA_BR_NF_CALL_ARPTABLES = _Anonymous_66.IFLA_BR_NF_CALL_ARPTABLES;
    enum IFLA_BR_VLAN_DEFAULT_PVID = _Anonymous_66.IFLA_BR_VLAN_DEFAULT_PVID;
    enum IFLA_BR_PAD = _Anonymous_66.IFLA_BR_PAD;
    enum IFLA_BR_VLAN_STATS_ENABLED = _Anonymous_66.IFLA_BR_VLAN_STATS_ENABLED;
    enum IFLA_BR_MCAST_STATS_ENABLED = _Anonymous_66.IFLA_BR_MCAST_STATS_ENABLED;
    enum IFLA_BR_MCAST_IGMP_VERSION = _Anonymous_66.IFLA_BR_MCAST_IGMP_VERSION;
    enum IFLA_BR_MCAST_MLD_VERSION = _Anonymous_66.IFLA_BR_MCAST_MLD_VERSION;
    enum IFLA_BR_VLAN_STATS_PER_PORT = _Anonymous_66.IFLA_BR_VLAN_STATS_PER_PORT;
    enum IFLA_BR_MULTI_BOOLOPT = _Anonymous_66.IFLA_BR_MULTI_BOOLOPT;
    enum __IFLA_BR_MAX = _Anonymous_66.__IFLA_BR_MAX;
    enum in6_addr_gen_mode
    {
        IN6_ADDR_GEN_MODE_EUI64 = 0,
        IN6_ADDR_GEN_MODE_NONE = 1,
        IN6_ADDR_GEN_MODE_STABLE_PRIVACY = 2,
        IN6_ADDR_GEN_MODE_RANDOM = 3,
    }
    enum IN6_ADDR_GEN_MODE_EUI64 = in6_addr_gen_mode.IN6_ADDR_GEN_MODE_EUI64;
    enum IN6_ADDR_GEN_MODE_NONE = in6_addr_gen_mode.IN6_ADDR_GEN_MODE_NONE;
    enum IN6_ADDR_GEN_MODE_STABLE_PRIVACY = in6_addr_gen_mode.IN6_ADDR_GEN_MODE_STABLE_PRIVACY;
    enum IN6_ADDR_GEN_MODE_RANDOM = in6_addr_gen_mode.IN6_ADDR_GEN_MODE_RANDOM;
    enum _Anonymous_67
    {
        IFLA_INET6_UNSPEC = 0,
        IFLA_INET6_FLAGS = 1,
        IFLA_INET6_CONF = 2,
        IFLA_INET6_STATS = 3,
        IFLA_INET6_MCAST = 4,
        IFLA_INET6_CACHEINFO = 5,
        IFLA_INET6_ICMP6STATS = 6,
        IFLA_INET6_TOKEN = 7,
        IFLA_INET6_ADDR_GEN_MODE = 8,
        __IFLA_INET6_MAX = 9,
    }
    enum IFLA_INET6_UNSPEC = _Anonymous_67.IFLA_INET6_UNSPEC;
    enum IFLA_INET6_FLAGS = _Anonymous_67.IFLA_INET6_FLAGS;
    enum IFLA_INET6_CONF = _Anonymous_67.IFLA_INET6_CONF;
    enum IFLA_INET6_STATS = _Anonymous_67.IFLA_INET6_STATS;
    enum IFLA_INET6_MCAST = _Anonymous_67.IFLA_INET6_MCAST;
    enum IFLA_INET6_CACHEINFO = _Anonymous_67.IFLA_INET6_CACHEINFO;
    enum IFLA_INET6_ICMP6STATS = _Anonymous_67.IFLA_INET6_ICMP6STATS;
    enum IFLA_INET6_TOKEN = _Anonymous_67.IFLA_INET6_TOKEN;
    enum IFLA_INET6_ADDR_GEN_MODE = _Anonymous_67.IFLA_INET6_ADDR_GEN_MODE;
    enum __IFLA_INET6_MAX = _Anonymous_67.__IFLA_INET6_MAX;
    enum _Anonymous_68
    {
        IFLA_INET_UNSPEC = 0,
        IFLA_INET_CONF = 1,
        __IFLA_INET_MAX = 2,
    }
    enum IFLA_INET_UNSPEC = _Anonymous_68.IFLA_INET_UNSPEC;
    enum IFLA_INET_CONF = _Anonymous_68.IFLA_INET_CONF;
    enum __IFLA_INET_MAX = _Anonymous_68.__IFLA_INET_MAX;
    enum _Anonymous_69
    {
        IFLA_UNSPEC = 0,
        IFLA_ADDRESS = 1,
        IFLA_BROADCAST = 2,
        IFLA_IFNAME = 3,
        IFLA_MTU = 4,
        IFLA_LINK = 5,
        IFLA_QDISC = 6,
        IFLA_STATS = 7,
        IFLA_COST = 8,
        IFLA_PRIORITY = 9,
        IFLA_MASTER = 10,
        IFLA_WIRELESS = 11,
        IFLA_PROTINFO = 12,
        IFLA_TXQLEN = 13,
        IFLA_MAP = 14,
        IFLA_WEIGHT = 15,
        IFLA_OPERSTATE = 16,
        IFLA_LINKMODE = 17,
        IFLA_LINKINFO = 18,
        IFLA_NET_NS_PID = 19,
        IFLA_IFALIAS = 20,
        IFLA_NUM_VF = 21,
        IFLA_VFINFO_LIST = 22,
        IFLA_STATS64 = 23,
        IFLA_VF_PORTS = 24,
        IFLA_PORT_SELF = 25,
        IFLA_AF_SPEC = 26,
        IFLA_GROUP = 27,
        IFLA_NET_NS_FD = 28,
        IFLA_EXT_MASK = 29,
        IFLA_PROMISCUITY = 30,
        IFLA_NUM_TX_QUEUES = 31,
        IFLA_NUM_RX_QUEUES = 32,
        IFLA_CARRIER = 33,
        IFLA_PHYS_PORT_ID = 34,
        IFLA_CARRIER_CHANGES = 35,
        IFLA_PHYS_SWITCH_ID = 36,
        IFLA_LINK_NETNSID = 37,
        IFLA_PHYS_PORT_NAME = 38,
        IFLA_PROTO_DOWN = 39,
        IFLA_GSO_MAX_SEGS = 40,
        IFLA_GSO_MAX_SIZE = 41,
        IFLA_PAD = 42,
        IFLA_XDP = 43,
        IFLA_EVENT = 44,
        IFLA_NEW_NETNSID = 45,
        IFLA_IF_NETNSID = 46,
        IFLA_TARGET_NETNSID = 46,
        IFLA_CARRIER_UP_COUNT = 47,
        IFLA_CARRIER_DOWN_COUNT = 48,
        IFLA_NEW_IFINDEX = 49,
        IFLA_MIN_MTU = 50,
        IFLA_MAX_MTU = 51,
        __IFLA_MAX = 52,
    }
    enum IFLA_UNSPEC = _Anonymous_69.IFLA_UNSPEC;
    enum IFLA_ADDRESS = _Anonymous_69.IFLA_ADDRESS;
    enum IFLA_BROADCAST = _Anonymous_69.IFLA_BROADCAST;
    enum IFLA_IFNAME = _Anonymous_69.IFLA_IFNAME;
    enum IFLA_MTU = _Anonymous_69.IFLA_MTU;
    enum IFLA_LINK = _Anonymous_69.IFLA_LINK;
    enum IFLA_QDISC = _Anonymous_69.IFLA_QDISC;
    enum IFLA_STATS = _Anonymous_69.IFLA_STATS;
    enum IFLA_COST = _Anonymous_69.IFLA_COST;
    enum IFLA_PRIORITY = _Anonymous_69.IFLA_PRIORITY;
    enum IFLA_MASTER = _Anonymous_69.IFLA_MASTER;
    enum IFLA_WIRELESS = _Anonymous_69.IFLA_WIRELESS;
    enum IFLA_PROTINFO = _Anonymous_69.IFLA_PROTINFO;
    enum IFLA_TXQLEN = _Anonymous_69.IFLA_TXQLEN;
    enum IFLA_MAP = _Anonymous_69.IFLA_MAP;
    enum IFLA_WEIGHT = _Anonymous_69.IFLA_WEIGHT;
    enum IFLA_OPERSTATE = _Anonymous_69.IFLA_OPERSTATE;
    enum IFLA_LINKMODE = _Anonymous_69.IFLA_LINKMODE;
    enum IFLA_LINKINFO = _Anonymous_69.IFLA_LINKINFO;
    enum IFLA_NET_NS_PID = _Anonymous_69.IFLA_NET_NS_PID;
    enum IFLA_IFALIAS = _Anonymous_69.IFLA_IFALIAS;
    enum IFLA_NUM_VF = _Anonymous_69.IFLA_NUM_VF;
    enum IFLA_VFINFO_LIST = _Anonymous_69.IFLA_VFINFO_LIST;
    enum IFLA_STATS64 = _Anonymous_69.IFLA_STATS64;
    enum IFLA_VF_PORTS = _Anonymous_69.IFLA_VF_PORTS;
    enum IFLA_PORT_SELF = _Anonymous_69.IFLA_PORT_SELF;
    enum IFLA_AF_SPEC = _Anonymous_69.IFLA_AF_SPEC;
    enum IFLA_GROUP = _Anonymous_69.IFLA_GROUP;
    enum IFLA_NET_NS_FD = _Anonymous_69.IFLA_NET_NS_FD;
    enum IFLA_EXT_MASK = _Anonymous_69.IFLA_EXT_MASK;
    enum IFLA_PROMISCUITY = _Anonymous_69.IFLA_PROMISCUITY;
    enum IFLA_NUM_TX_QUEUES = _Anonymous_69.IFLA_NUM_TX_QUEUES;
    enum IFLA_NUM_RX_QUEUES = _Anonymous_69.IFLA_NUM_RX_QUEUES;
    enum IFLA_CARRIER = _Anonymous_69.IFLA_CARRIER;
    enum IFLA_PHYS_PORT_ID = _Anonymous_69.IFLA_PHYS_PORT_ID;
    enum IFLA_CARRIER_CHANGES = _Anonymous_69.IFLA_CARRIER_CHANGES;
    enum IFLA_PHYS_SWITCH_ID = _Anonymous_69.IFLA_PHYS_SWITCH_ID;
    enum IFLA_LINK_NETNSID = _Anonymous_69.IFLA_LINK_NETNSID;
    enum IFLA_PHYS_PORT_NAME = _Anonymous_69.IFLA_PHYS_PORT_NAME;
    enum IFLA_PROTO_DOWN = _Anonymous_69.IFLA_PROTO_DOWN;
    enum IFLA_GSO_MAX_SEGS = _Anonymous_69.IFLA_GSO_MAX_SEGS;
    enum IFLA_GSO_MAX_SIZE = _Anonymous_69.IFLA_GSO_MAX_SIZE;
    enum IFLA_PAD = _Anonymous_69.IFLA_PAD;
    enum IFLA_XDP = _Anonymous_69.IFLA_XDP;
    enum IFLA_EVENT = _Anonymous_69.IFLA_EVENT;
    enum IFLA_NEW_NETNSID = _Anonymous_69.IFLA_NEW_NETNSID;
    enum IFLA_IF_NETNSID = _Anonymous_69.IFLA_IF_NETNSID;
    enum IFLA_TARGET_NETNSID = _Anonymous_69.IFLA_TARGET_NETNSID;
    enum IFLA_CARRIER_UP_COUNT = _Anonymous_69.IFLA_CARRIER_UP_COUNT;
    enum IFLA_CARRIER_DOWN_COUNT = _Anonymous_69.IFLA_CARRIER_DOWN_COUNT;
    enum IFLA_NEW_IFINDEX = _Anonymous_69.IFLA_NEW_IFINDEX;
    enum IFLA_MIN_MTU = _Anonymous_69.IFLA_MIN_MTU;
    enum IFLA_MAX_MTU = _Anonymous_69.IFLA_MAX_MTU;
    enum __IFLA_MAX = _Anonymous_69.__IFLA_MAX;
    struct rtnl_link_ifmap
    {
        ulong mem_start;
        ulong mem_end;
        ulong base_addr;
        ushort irq;
        ubyte dma;
        ubyte port;
    }
    struct rtnl_link_stats64
    {
        ulong rx_packets;
        ulong tx_packets;
        ulong rx_bytes;
        ulong tx_bytes;
        ulong rx_errors;
        ulong tx_errors;
        ulong rx_dropped;
        ulong tx_dropped;
        ulong multicast;
        ulong collisions;
        ulong rx_length_errors;
        ulong rx_over_errors;
        ulong rx_crc_errors;
        ulong rx_frame_errors;
        ulong rx_fifo_errors;
        ulong rx_missed_errors;
        ulong tx_aborted_errors;
        ulong tx_carrier_errors;
        ulong tx_fifo_errors;
        ulong tx_heartbeat_errors;
        ulong tx_window_errors;
        ulong rx_compressed;
        ulong tx_compressed;
        ulong rx_nohandler;
    }
    struct rtnl_link_stats
    {
        uint rx_packets;
        uint tx_packets;
        uint rx_bytes;
        uint tx_bytes;
        uint rx_errors;
        uint tx_errors;
        uint rx_dropped;
        uint tx_dropped;
        uint multicast;
        uint collisions;
        uint rx_length_errors;
        uint rx_over_errors;
        uint rx_crc_errors;
        uint rx_frame_errors;
        uint rx_fifo_errors;
        uint rx_missed_errors;
        uint tx_aborted_errors;
        uint tx_carrier_errors;
        uint tx_fifo_errors;
        uint tx_heartbeat_errors;
        uint tx_window_errors;
        uint rx_compressed;
        uint tx_compressed;
        uint rx_nohandler;
    }
    struct ifa_cacheinfo
    {
        uint ifa_prefered;
        uint ifa_valid;
        uint cstamp;
        uint tstamp;
    }
    enum _Anonymous_70
    {
        IFA_UNSPEC = 0,
        IFA_ADDRESS = 1,
        IFA_LOCAL = 2,
        IFA_LABEL = 3,
        IFA_BROADCAST = 4,
        IFA_ANYCAST = 5,
        IFA_CACHEINFO = 6,
        IFA_MULTICAST = 7,
        IFA_FLAGS = 8,
        IFA_RT_PRIORITY = 9,
        IFA_TARGET_NETNSID = 10,
        __IFA_MAX = 11,
    }
    enum IFA_UNSPEC = _Anonymous_70.IFA_UNSPEC;
    enum IFA_ADDRESS = _Anonymous_70.IFA_ADDRESS;
    enum IFA_LOCAL = _Anonymous_70.IFA_LOCAL;
    enum IFA_LABEL = _Anonymous_70.IFA_LABEL;
    enum IFA_BROADCAST = _Anonymous_70.IFA_BROADCAST;
    enum IFA_ANYCAST = _Anonymous_70.IFA_ANYCAST;
    enum IFA_CACHEINFO = _Anonymous_70.IFA_CACHEINFO;
    enum IFA_MULTICAST = _Anonymous_70.IFA_MULTICAST;
    enum IFA_FLAGS = _Anonymous_70.IFA_FLAGS;
    enum IFA_RT_PRIORITY = _Anonymous_70.IFA_RT_PRIORITY;
    enum IFA_TARGET_NETNSID = _Anonymous_70.IFA_TARGET_NETNSID;
    enum __IFA_MAX = _Anonymous_70.__IFA_MAX;
    struct ifaddrmsg
    {
        ubyte ifa_family;
        ubyte ifa_prefixlen;
        ubyte ifa_flags;
        ubyte ifa_scope;
        uint ifa_index;
    }
    struct nl_dump_params
    {
        nl_dump_type dp_type;
        int dp_prefix;
        int dp_print_index;
        int dp_dump_msgtype;
        void function(nl_dump_params*, char*) dp_cb;
        void function(nl_dump_params*, int) dp_nl_cb;
        void* dp_data;
        _IO_FILE* dp_fd;
        char* dp_buf;
        c_ulong dp_buflen;
        int dp_pre_dump;
        int dp_ivar;
        uint dp_line;
    }
    enum nl_dump_type
    {
        NL_DUMP_LINE = 0,
        NL_DUMP_DETAILS = 1,
        NL_DUMP_STATS = 2,
        __NL_DUMP_MAX = 3,
    }
    enum NL_DUMP_LINE = nl_dump_type.NL_DUMP_LINE;
    enum NL_DUMP_DETAILS = nl_dump_type.NL_DUMP_DETAILS;
    enum NL_DUMP_STATS = nl_dump_type.NL_DUMP_STATS;
    enum __NL_DUMP_MAX = nl_dump_type.__NL_DUMP_MAX;
    void nl_socket_disable_msg_peek(nl_sock*) @nogc nothrow;
    void nl_socket_enable_msg_peek(nl_sock*) @nogc nothrow;
    int nl_socket_set_nonblocking(const(nl_sock)*) @nogc nothrow;
    int nl_socket_set_fd(nl_sock*, int, int) @nogc nothrow;
    int nl_socket_get_fd(const(nl_sock)*) @nogc nothrow;
    void nl_socket_enable_auto_ack(nl_sock*) @nogc nothrow;
    void nl_socket_disable_auto_ack(nl_sock*) @nogc nothrow;
    uint nl_socket_use_seq(nl_sock*) @nogc nothrow;
    void nl_socket_disable_seq_check(nl_sock*) @nogc nothrow;
    int nl_socket_recv_pktinfo(nl_sock*, int) @nogc nothrow;
    int nl_socket_set_passcred(nl_sock*, int) @nogc nothrow;
    c_ulong nl_socket_get_msg_buf_size(nl_sock*) @nogc nothrow;
    int nl_socket_set_msg_buf_size(nl_sock*, c_ulong) @nogc nothrow;
    int nl_socket_set_buffer_size(nl_sock*, int, int) @nogc nothrow;
    int nl_socket_modify_err_cb(nl_sock*, nl_cb_kind, int function(sockaddr_nl*, nlmsgerr*, void*), void*) @nogc nothrow;
    int nl_socket_modify_cb(nl_sock*, nl_cb_type, nl_cb_kind, int function(nl_msg*, void*), void*) @nogc nothrow;
    void nl_socket_set_cb(nl_sock*, nl_cb*) @nogc nothrow;
    nl_cb* nl_socket_get_cb(const(nl_sock)*) @nogc nothrow;
    void nl_socket_set_peer_groups(nl_sock*, uint) @nogc nothrow;
    uint nl_socket_get_peer_groups(const(nl_sock)*) @nogc nothrow;
    void nl_socket_set_peer_port(nl_sock*, uint) @nogc nothrow;
    uint nl_socket_get_peer_port(const(nl_sock)*) @nogc nothrow;
    void nl_join_groups(nl_sock*, int) @nogc nothrow;
    int nl_socket_drop_membership(nl_sock*, int) @nogc nothrow;
    struct __pthread_rwlock_arch_t
    {
        uint __readers;
        uint __writers;
        uint __wrphase_futex;
        uint __writers_futex;
        uint __pad3;
        uint __pad4;
        int __cur_writer;
        int __shared;
        byte __rwelision;
        ubyte[7] __pad1;
        c_ulong __pad2;
        uint __flags;
    }
    int nl_socket_drop_memberships(nl_sock*, int, ...) @nogc nothrow;
    int nl_socket_add_membership(nl_sock*, int) @nogc nothrow;
    int nl_socket_add_memberships(nl_sock*, int, ...) @nogc nothrow;
    alias pthread_t = c_ulong;
    union pthread_mutexattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_condattr_t
    {
        char[4] __size;
        int __align;
    }
    alias pthread_key_t = uint;
    alias pthread_once_t = int;
    union pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }
    void nl_socket_set_local_port(nl_sock*, uint) @nogc nothrow;
    union pthread_mutex_t
    {
        __pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }
    union pthread_cond_t
    {
        __pthread_cond_s __data;
        char[48] __size;
        long __align;
    }
    union pthread_rwlock_t
    {
        __pthread_rwlock_arch_t __data;
        char[56] __size;
        c_long __align;
    }
    union pthread_rwlockattr_t
    {
        char[8] __size;
        c_long __align;
    }
    alias pthread_spinlock_t = int;
    union pthread_barrier_t
    {
        char[32] __size;
        c_long __align;
    }
    union pthread_barrierattr_t
    {
        char[4] __size;
        int __align;
    }
    uint nl_socket_get_local_port(const(nl_sock)*) @nogc nothrow;
    void nl_socket_free(nl_sock*) @nogc nothrow;
    nl_sock* nl_socket_alloc_cb(nl_cb*) @nogc nothrow;
    nl_sock* nl_socket_alloc() @nogc nothrow;
    alias sa_family_t = ushort;
    alias socklen_t = uint;
    nl_cb_type nl_cb_active_type(nl_cb*) @nogc nothrow;
    void nl_cb_overwrite_send(nl_cb*, int function(nl_sock*, nl_msg*)) @nogc nothrow;
    void nl_cb_overwrite_recv(nl_cb*, int function(nl_sock*, sockaddr_nl*, ubyte**, ucred**)) @nogc nothrow;
    void nl_cb_overwrite_recvmsgs(nl_cb*, int function(nl_sock*, nl_cb*)) @nogc nothrow;
    int nl_cb_err(nl_cb*, nl_cb_kind, int function(sockaddr_nl*, nlmsgerr*, void*), void*) @nogc nothrow;
    int nl_cb_set_all(nl_cb*, nl_cb_kind, int function(nl_msg*, void*), void*) @nogc nothrow;
    int nl_cb_set(nl_cb*, nl_cb_type, nl_cb_kind, int function(nl_msg*, void*), void*) @nogc nothrow;
    void nl_cb_put(nl_cb*) @nogc nothrow;
    nl_cb* nl_cb_get(nl_cb*) @nogc nothrow;
    nl_cb* nl_cb_clone(nl_cb*) @nogc nothrow;
    nl_cb* nl_cb_alloc(nl_cb_kind) @nogc nothrow;
    enum nl_cb_type
    {
        NL_CB_VALID = 0,
        NL_CB_FINISH = 1,
        NL_CB_OVERRUN = 2,
        NL_CB_SKIPPED = 3,
        NL_CB_ACK = 4,
        NL_CB_MSG_IN = 5,
        NL_CB_MSG_OUT = 6,
        NL_CB_INVALID = 7,
        NL_CB_SEQ_CHECK = 8,
        NL_CB_SEND_ACK = 9,
        NL_CB_DUMP_INTR = 10,
        __NL_CB_TYPE_MAX = 11,
    }
    enum NL_CB_VALID = nl_cb_type.NL_CB_VALID;
    enum NL_CB_FINISH = nl_cb_type.NL_CB_FINISH;
    enum NL_CB_OVERRUN = nl_cb_type.NL_CB_OVERRUN;
    enum NL_CB_SKIPPED = nl_cb_type.NL_CB_SKIPPED;
    enum NL_CB_ACK = nl_cb_type.NL_CB_ACK;
    enum NL_CB_MSG_IN = nl_cb_type.NL_CB_MSG_IN;
    enum NL_CB_MSG_OUT = nl_cb_type.NL_CB_MSG_OUT;
    enum NL_CB_INVALID = nl_cb_type.NL_CB_INVALID;
    enum NL_CB_SEQ_CHECK = nl_cb_type.NL_CB_SEQ_CHECK;
    enum NL_CB_SEND_ACK = nl_cb_type.NL_CB_SEND_ACK;
    enum NL_CB_DUMP_INTR = nl_cb_type.NL_CB_DUMP_INTR;
    enum __NL_CB_TYPE_MAX = nl_cb_type.__NL_CB_TYPE_MAX;
    enum nl_cb_kind
    {
        NL_CB_DEFAULT = 0,
        NL_CB_VERBOSE = 1,
        NL_CB_DEBUG = 2,
        NL_CB_CUSTOM = 3,
        __NL_CB_KIND_MAX = 4,
    }
    enum NL_CB_DEFAULT = nl_cb_kind.NL_CB_DEFAULT;
    enum NL_CB_VERBOSE = nl_cb_kind.NL_CB_VERBOSE;
    enum NL_CB_DEBUG = nl_cb_kind.NL_CB_DEBUG;
    enum NL_CB_CUSTOM = nl_cb_kind.NL_CB_CUSTOM;
    enum __NL_CB_KIND_MAX = nl_cb_kind.__NL_CB_KIND_MAX;
    enum nl_cb_action
    {
        NL_OK = 0,
        NL_SKIP = 1,
        NL_STOP = 2,
    }
    enum NL_OK = nl_cb_action.NL_OK;
    enum NL_SKIP = nl_cb_action.NL_SKIP;
    enum NL_STOP = nl_cb_action.NL_STOP;
    alias nl_recvmsg_err_cb_t = int function(sockaddr_nl*, nlmsgerr*, void*);
    alias nl_recvmsg_msg_cb_t = int function(nl_msg*, void*);
    struct nl_msg;
    struct nl_sock;
    struct nl_cb;
    struct ucred;
    int posix_fallocate(int, c_long, c_long) @nogc nothrow;
    int posix_fadvise(int, c_long, c_long, int) @nogc nothrow;
    int lockf(int, int, c_long) @nogc nothrow;
    int creat(const(char)*, uint) @nogc nothrow;
    int openat(int, const(char)*, int, ...) @nogc nothrow;
    int open(const(char)*, int, ...) @nogc nothrow;
    int fcntl(int, int, ...) @nogc nothrow;
    int* __errno_location() @nogc nothrow;
    struct sockaddr
    {
        ushort sa_family;
        char[14] sa_data;
    }
    struct sockaddr_storage
    {
        ushort ss_family;
        char[118] __ss_padding;
        c_ulong __ss_align;
    }
    enum _Anonymous_71
    {
        MSG_OOB = 1,
        MSG_PEEK = 2,
        MSG_DONTROUTE = 4,
        MSG_CTRUNC = 8,
        MSG_PROXY = 16,
        MSG_TRUNC = 32,
        MSG_DONTWAIT = 64,
        MSG_EOR = 128,
        MSG_WAITALL = 256,
        MSG_FIN = 512,
        MSG_SYN = 1024,
        MSG_CONFIRM = 2048,
        MSG_RST = 4096,
        MSG_ERRQUEUE = 8192,
        MSG_NOSIGNAL = 16384,
        MSG_MORE = 32768,
        MSG_WAITFORONE = 65536,
        MSG_BATCH = 262144,
        MSG_ZEROCOPY = 67108864,
        MSG_FASTOPEN = 536870912,
        MSG_CMSG_CLOEXEC = 1073741824,
    }
    enum MSG_OOB = _Anonymous_71.MSG_OOB;
    enum MSG_PEEK = _Anonymous_71.MSG_PEEK;
    enum MSG_DONTROUTE = _Anonymous_71.MSG_DONTROUTE;
    enum MSG_CTRUNC = _Anonymous_71.MSG_CTRUNC;
    enum MSG_PROXY = _Anonymous_71.MSG_PROXY;
    enum MSG_TRUNC = _Anonymous_71.MSG_TRUNC;
    enum MSG_DONTWAIT = _Anonymous_71.MSG_DONTWAIT;
    enum MSG_EOR = _Anonymous_71.MSG_EOR;
    enum MSG_WAITALL = _Anonymous_71.MSG_WAITALL;
    enum MSG_FIN = _Anonymous_71.MSG_FIN;
    enum MSG_SYN = _Anonymous_71.MSG_SYN;
    enum MSG_CONFIRM = _Anonymous_71.MSG_CONFIRM;
    enum MSG_RST = _Anonymous_71.MSG_RST;
    enum MSG_ERRQUEUE = _Anonymous_71.MSG_ERRQUEUE;
    enum MSG_NOSIGNAL = _Anonymous_71.MSG_NOSIGNAL;
    enum MSG_MORE = _Anonymous_71.MSG_MORE;
    enum MSG_WAITFORONE = _Anonymous_71.MSG_WAITFORONE;
    enum MSG_BATCH = _Anonymous_71.MSG_BATCH;
    enum MSG_ZEROCOPY = _Anonymous_71.MSG_ZEROCOPY;
    enum MSG_FASTOPEN = _Anonymous_71.MSG_FASTOPEN;
    enum MSG_CMSG_CLOEXEC = _Anonymous_71.MSG_CMSG_CLOEXEC;
    static c_ulong __uint64_identity(c_ulong) @nogc nothrow;
    static uint __uint32_identity(uint) @nogc nothrow;
    static ushort __uint16_identity(ushort) @nogc nothrow;
    struct msghdr
    {
        void* msg_name;
        uint msg_namelen;
        iovec* msg_iov;
        c_ulong msg_iovlen;
        void* msg_control;
        c_ulong msg_controllen;
        int msg_flags;
    }
    struct cmsghdr
    {
        c_ulong cmsg_len;
        int cmsg_level;
        int cmsg_type;
        ubyte[0] __cmsg_data;
    }
    alias timer_t = void*;
    alias time_t = c_long;
    struct timeval
    {
        c_long tv_sec;
        c_long tv_usec;
    }
    cmsghdr* __cmsg_nxthdr(msghdr*, cmsghdr*) @nogc nothrow;
    enum _Anonymous_72
    {
        SCM_RIGHTS = 1,
    }
    enum SCM_RIGHTS = _Anonymous_72.SCM_RIGHTS;
    struct linger
    {
        int l_onoff;
        int l_linger;
    }
    enum __socket_type
    {
        SOCK_STREAM = 1,
        SOCK_DGRAM = 2,
        SOCK_RAW = 3,
        SOCK_RDM = 4,
        SOCK_SEQPACKET = 5,
        SOCK_DCCP = 6,
        SOCK_PACKET = 10,
        SOCK_CLOEXEC = 524288,
        SOCK_NONBLOCK = 2048,
    }
    enum SOCK_STREAM = __socket_type.SOCK_STREAM;
    enum SOCK_DGRAM = __socket_type.SOCK_DGRAM;
    enum SOCK_RAW = __socket_type.SOCK_RAW;
    enum SOCK_RDM = __socket_type.SOCK_RDM;
    enum SOCK_SEQPACKET = __socket_type.SOCK_SEQPACKET;
    enum SOCK_DCCP = __socket_type.SOCK_DCCP;
    enum SOCK_PACKET = __socket_type.SOCK_PACKET;
    enum SOCK_CLOEXEC = __socket_type.SOCK_CLOEXEC;
    enum SOCK_NONBLOCK = __socket_type.SOCK_NONBLOCK;
    struct timespec
    {
        c_long tv_sec;
        c_long tv_nsec;
    }
    struct osockaddr
    {
        ushort sa_family;
        ubyte[14] sa_data;
    }
    struct iovec
    {
        void* iov_base;
        c_ulong iov_len;
    }
    alias _IO_lock_t = void;
    struct _IO_wide_data;
    struct _IO_codecvt;
    struct _IO_marker;
    alias sigset_t = __sigset_t;
    alias clockid_t = int;
    struct stat
    {
        c_ulong st_dev;
        c_ulong st_ino;
        c_ulong st_nlink;
        uint st_mode;
        uint st_uid;
        uint st_gid;
        int __pad0;
        c_ulong st_rdev;
        c_long st_size;
        c_long st_blksize;
        c_long st_blocks;
        timespec st_atim;
        timespec st_mtim;
        timespec st_ctim;
        c_long[3] __glibc_reserved;
    }
    alias clock_t = c_long;
    struct __sigset_t
    {
        c_ulong[16] __val;
    }
    struct __mbstate_t
    {
        int __count;
        static union _Anonymous_73
        {
            uint __wch;
            char[4] __wchb;
        }
        _Anonymous_73 __value;
    }
    struct _G_fpos_t
    {
        c_long __pos;
        __mbstate_t __state;
    }
    alias __fpos_t = _G_fpos_t;
    struct _G_fpos64_t
    {
        c_long __pos;
        __mbstate_t __state;
    }
    alias __fpos64_t = _G_fpos64_t;
    alias __FILE = _IO_FILE;
    struct _IO_FILE
    {
        int _flags;
        char* _IO_read_ptr;
        char* _IO_read_end;
        char* _IO_read_base;
        char* _IO_write_base;
        char* _IO_write_ptr;
        char* _IO_write_end;
        char* _IO_buf_base;
        char* _IO_buf_end;
        char* _IO_save_base;
        char* _IO_backup_base;
        char* _IO_save_end;
        _IO_marker* _markers;
        _IO_FILE* _chain;
        int _fileno;
        int _flags2;
        c_long _old_offset;
        ushort _cur_column;
        byte _vtable_offset;
        char[1] _shortbuf;
        void* _lock;
        c_long _offset;
        _IO_codecvt* _codecvt;
        _IO_wide_data* _wide_data;
        _IO_FILE* _freeres_list;
        void* _freeres_buf;
        c_ulong __pad5;
        int _mode;
        char[20] _unused2;
    }
    alias FILE = _IO_FILE;
    alias __sig_atomic_t = int;
    alias __socklen_t = uint;
    alias int8_t = byte;
    alias int16_t = short;
    alias int32_t = int;
    alias int64_t = c_long;
    alias uint8_t = ubyte;
    alias uint16_t = ushort;
    alias uint32_t = uint;
    alias uint64_t = ulong;
    alias __intptr_t = c_long;
    alias __caddr_t = char*;
    alias __loff_t = c_long;
    extern __gshared int sys_nerr;
    extern __gshared const(const(char)*)[0] sys_errlist;
    alias __syscall_ulong_t = c_ulong;
    alias __pthread_list_t = __pthread_internal_list;
    struct __pthread_internal_list
    {
        __pthread_internal_list* __prev;
        __pthread_internal_list* __next;
    }
    struct __pthread_mutex_s
    {
        int __lock;
        uint __count;
        int __owner;
        uint __nusers;
        int __kind;
        short __spins;
        short __elision;
        __pthread_internal_list __list;
    }
    alias __syscall_slong_t = c_long;
    struct __pthread_cond_s
    {
        static union _Anonymous_74
        {
            ulong __wseq;
            static struct _Anonymous_75
            {
                uint __low;
                uint __high;
            }
            _Anonymous_75 __wseq32;
        }
        _Anonymous_74 _anonymous_76;
        auto __wseq() @property @nogc pure nothrow { return _anonymous_76.__wseq; }
        void __wseq(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_76.__wseq = val; }
        auto __wseq32() @property @nogc pure nothrow { return _anonymous_76.__wseq32; }
        void __wseq32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_76.__wseq32 = val; }
        static union _Anonymous_77
        {
            ulong __g1_start;
            static struct _Anonymous_78
            {
                uint __low;
                uint __high;
            }
            _Anonymous_78 __g1_start32;
        }
        _Anonymous_77 _anonymous_79;
        auto __g1_start() @property @nogc pure nothrow { return _anonymous_79.__g1_start; }
        void __g1_start(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_79.__g1_start = val; }
        auto __g1_start32() @property @nogc pure nothrow { return _anonymous_79.__g1_start32; }
        void __g1_start32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_79.__g1_start32 = val; }
        uint[2] __g_refs;
        uint[2] __g_size;
        uint __g1_orig_size;
        uint __wrefs;
        uint[2] __g_signals;
    }
    alias __ssize_t = c_long;
    alias __u_char = ubyte;
    alias __u_short = ushort;
    alias __u_int = uint;
    alias __u_long = c_ulong;
    alias __int8_t = byte;
    alias __uint8_t = ubyte;
    alias __int16_t = short;
    alias __uint16_t = ushort;
    alias __int32_t = int;
    alias __uint32_t = uint;
    alias __int64_t = c_long;
    alias __uint64_t = c_ulong;
    alias __int_least8_t = byte;
    alias __uint_least8_t = ubyte;
    alias __int_least16_t = short;
    alias __uint_least16_t = ushort;
    alias __int_least32_t = int;
    alias __uint_least32_t = uint;
    alias __int_least64_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __quad_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __intmax_t = c_long;
    alias __uintmax_t = c_ulong;
    alias __fsword_t = c_long;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsblkcnt_t = c_ulong;
    alias __dev_t = c_ulong;
    alias __uid_t = uint;
    alias __gid_t = uint;
    alias __ino_t = c_ulong;
    alias __ino64_t = c_ulong;
    alias __mode_t = uint;
    alias __nlink_t = c_ulong;
    alias __off_t = c_long;
    alias __off64_t = c_long;
    alias __pid_t = int;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __clock_t = c_long;
    alias __rlim_t = c_ulong;
    alias __rlim64_t = c_ulong;
    alias __id_t = uint;
    alias __time_t = c_long;
    alias __useconds_t = uint;
    alias __suseconds_t = c_long;
    alias __daddr_t = int;
    alias __key_t = int;
    alias __clockid_t = int;
    alias __timer_t = void*;
    alias __blksize_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blkcnt64_t = c_long;



    static if(!is(typeof(__STD_TYPE))) {
        private enum enumMixinStr___STD_TYPE = `enum __STD_TYPE = typedef;`;
        static if(is(typeof({ mixin(enumMixinStr___STD_TYPE); }))) {
            mixin(enumMixinStr___STD_TYPE);
        }
    }




    static if(!is(typeof(__U64_TYPE))) {
        private enum enumMixinStr___U64_TYPE = `enum __U64_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___U64_TYPE); }))) {
            mixin(enumMixinStr___U64_TYPE);
        }
    }




    static if(!is(typeof(__S64_TYPE))) {
        private enum enumMixinStr___S64_TYPE = `enum __S64_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___S64_TYPE); }))) {
            mixin(enumMixinStr___S64_TYPE);
        }
    }




    static if(!is(typeof(__ULONG32_TYPE))) {
        private enum enumMixinStr___ULONG32_TYPE = `enum __ULONG32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONG32_TYPE); }))) {
            mixin(enumMixinStr___ULONG32_TYPE);
        }
    }




    static if(!is(typeof(__SLONG32_TYPE))) {
        private enum enumMixinStr___SLONG32_TYPE = `enum __SLONG32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONG32_TYPE); }))) {
            mixin(enumMixinStr___SLONG32_TYPE);
        }
    }




    static if(!is(typeof(__UWORD_TYPE))) {
        private enum enumMixinStr___UWORD_TYPE = `enum __UWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UWORD_TYPE); }))) {
            mixin(enumMixinStr___UWORD_TYPE);
        }
    }




    static if(!is(typeof(__SWORD_TYPE))) {
        private enum enumMixinStr___SWORD_TYPE = `enum __SWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SWORD_TYPE); }))) {
            mixin(enumMixinStr___SWORD_TYPE);
        }
    }




    static if(!is(typeof(__UQUAD_TYPE))) {
        private enum enumMixinStr___UQUAD_TYPE = `enum __UQUAD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UQUAD_TYPE); }))) {
            mixin(enumMixinStr___UQUAD_TYPE);
        }
    }




    static if(!is(typeof(__SQUAD_TYPE))) {
        private enum enumMixinStr___SQUAD_TYPE = `enum __SQUAD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SQUAD_TYPE); }))) {
            mixin(enumMixinStr___SQUAD_TYPE);
        }
    }




    static if(!is(typeof(__ULONGWORD_TYPE))) {
        private enum enumMixinStr___ULONGWORD_TYPE = `enum __ULONGWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONGWORD_TYPE); }))) {
            mixin(enumMixinStr___ULONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__SLONGWORD_TYPE))) {
        private enum enumMixinStr___SLONGWORD_TYPE = `enum __SLONGWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONGWORD_TYPE); }))) {
            mixin(enumMixinStr___SLONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__U32_TYPE))) {
        private enum enumMixinStr___U32_TYPE = `enum __U32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___U32_TYPE); }))) {
            mixin(enumMixinStr___U32_TYPE);
        }
    }




    static if(!is(typeof(__S32_TYPE))) {
        private enum enumMixinStr___S32_TYPE = `enum __S32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___S32_TYPE); }))) {
            mixin(enumMixinStr___S32_TYPE);
        }
    }




    static if(!is(typeof(__U16_TYPE))) {
        private enum enumMixinStr___U16_TYPE = `enum __U16_TYPE = unsigned short int;`;
        static if(is(typeof({ mixin(enumMixinStr___U16_TYPE); }))) {
            mixin(enumMixinStr___U16_TYPE);
        }
    }




    static if(!is(typeof(__S16_TYPE))) {
        private enum enumMixinStr___S16_TYPE = `enum __S16_TYPE = short int;`;
        static if(is(typeof({ mixin(enumMixinStr___S16_TYPE); }))) {
            mixin(enumMixinStr___S16_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TYPES_H))) {
        private enum enumMixinStr__BITS_TYPES_H = `enum _BITS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES_H); }))) {
            mixin(enumMixinStr__BITS_TYPES_H);
        }
    }




    static if(!is(typeof(__TIMESIZE))) {
        private enum enumMixinStr___TIMESIZE = `enum __TIMESIZE = __WORDSIZE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMESIZE); }))) {
            mixin(enumMixinStr___TIMESIZE);
        }
    }




    static if(!is(typeof(__TIME64_T_TYPE))) {
        private enum enumMixinStr___TIME64_T_TYPE = `enum __TIME64_T_TYPE = __TIME_T_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME64_T_TYPE); }))) {
            mixin(enumMixinStr___TIME64_T_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TIME64_H))) {
        private enum enumMixinStr__BITS_TIME64_H = `enum _BITS_TIME64_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TIME64_H); }))) {
            mixin(enumMixinStr__BITS_TIME64_H);
        }
    }




    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        private enum enumMixinStr___PTHREAD_MUTEX_HAVE_PREV = `enum __PTHREAD_MUTEX_HAVE_PREV = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_MUTEX_HAVE_PREV); }))) {
            mixin(enumMixinStr___PTHREAD_MUTEX_HAVE_PREV);
        }
    }




    static if(!is(typeof(__PTHREAD_SPINS))) {
        private enum enumMixinStr___PTHREAD_SPINS = `enum __PTHREAD_SPINS = 0 , 0;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_SPINS); }))) {
            mixin(enumMixinStr___PTHREAD_SPINS);
        }
    }




    static if(!is(typeof(__PTHREAD_SPINS_DATA))) {
        private enum enumMixinStr___PTHREAD_SPINS_DATA = `enum __PTHREAD_SPINS_DATA = short __spins ; short __elision;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_SPINS_DATA); }))) {
            mixin(enumMixinStr___PTHREAD_SPINS_DATA);
        }
    }




    static if(!is(typeof(_THREAD_SHARED_TYPES_H))) {
        private enum enumMixinStr__THREAD_SHARED_TYPES_H = `enum _THREAD_SHARED_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__THREAD_SHARED_TYPES_H); }))) {
            mixin(enumMixinStr__THREAD_SHARED_TYPES_H);
        }
    }




    static if(!is(typeof(FOPEN_MAX))) {
        private enum enumMixinStr_FOPEN_MAX = `enum FOPEN_MAX = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_FOPEN_MAX); }))) {
            mixin(enumMixinStr_FOPEN_MAX);
        }
    }




    static if(!is(typeof(L_ctermid))) {
        private enum enumMixinStr_L_ctermid = `enum L_ctermid = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_L_ctermid); }))) {
            mixin(enumMixinStr_L_ctermid);
        }
    }




    static if(!is(typeof(FILENAME_MAX))) {
        private enum enumMixinStr_FILENAME_MAX = `enum FILENAME_MAX = 4096;`;
        static if(is(typeof({ mixin(enumMixinStr_FILENAME_MAX); }))) {
            mixin(enumMixinStr_FILENAME_MAX);
        }
    }




    static if(!is(typeof(TMP_MAX))) {
        private enum enumMixinStr_TMP_MAX = `enum TMP_MAX = 238328;`;
        static if(is(typeof({ mixin(enumMixinStr_TMP_MAX); }))) {
            mixin(enumMixinStr_TMP_MAX);
        }
    }




    static if(!is(typeof(L_tmpnam))) {
        private enum enumMixinStr_L_tmpnam = `enum L_tmpnam = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_L_tmpnam); }))) {
            mixin(enumMixinStr_L_tmpnam);
        }
    }




    static if(!is(typeof(_BITS_STDIO_LIM_H))) {
        private enum enumMixinStr__BITS_STDIO_LIM_H = `enum _BITS_STDIO_LIM_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDIO_LIM_H); }))) {
            mixin(enumMixinStr__BITS_STDIO_LIM_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_UINTN_H))) {
        private enum enumMixinStr__BITS_STDINT_UINTN_H = `enum _BITS_STDINT_UINTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_UINTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_UINTN_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_INTN_H))) {
        private enum enumMixinStr__BITS_STDINT_INTN_H = `enum _BITS_STDINT_INTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_INTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_INTN_H);
        }
    }




    static if(!is(typeof(UTIME_OMIT))) {
        private enum enumMixinStr_UTIME_OMIT = `enum UTIME_OMIT = ( ( 1l << 30 ) - 2l );`;
        static if(is(typeof({ mixin(enumMixinStr_UTIME_OMIT); }))) {
            mixin(enumMixinStr_UTIME_OMIT);
        }
    }




    static if(!is(typeof(UTIME_NOW))) {
        private enum enumMixinStr_UTIME_NOW = `enum UTIME_NOW = ( ( 1l << 30 ) - 1l );`;
        static if(is(typeof({ mixin(enumMixinStr_UTIME_NOW); }))) {
            mixin(enumMixinStr_UTIME_NOW);
        }
    }




    static if(!is(typeof(__S_IEXEC))) {
        private enum enumMixinStr___S_IEXEC = `enum __S_IEXEC = std.conv.octal!100;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IEXEC); }))) {
            mixin(enumMixinStr___S_IEXEC);
        }
    }




    static if(!is(typeof(__S_IWRITE))) {
        private enum enumMixinStr___S_IWRITE = `enum __S_IWRITE = std.conv.octal!200;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IWRITE); }))) {
            mixin(enumMixinStr___S_IWRITE);
        }
    }




    static if(!is(typeof(__S_IREAD))) {
        private enum enumMixinStr___S_IREAD = `enum __S_IREAD = std.conv.octal!400;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IREAD); }))) {
            mixin(enumMixinStr___S_IREAD);
        }
    }




    static if(!is(typeof(__FILE_defined))) {
        private enum enumMixinStr___FILE_defined = `enum __FILE_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___FILE_defined); }))) {
            mixin(enumMixinStr___FILE_defined);
        }
    }




    static if(!is(typeof(__S_ISVTX))) {
        private enum enumMixinStr___S_ISVTX = `enum __S_ISVTX = std.conv.octal!1000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_ISVTX); }))) {
            mixin(enumMixinStr___S_ISVTX);
        }
    }




    static if(!is(typeof(____FILE_defined))) {
        private enum enumMixinStr_____FILE_defined = `enum ____FILE_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_____FILE_defined); }))) {
            mixin(enumMixinStr_____FILE_defined);
        }
    }




    static if(!is(typeof(__S_ISGID))) {
        private enum enumMixinStr___S_ISGID = `enum __S_ISGID = std.conv.octal!2000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_ISGID); }))) {
            mixin(enumMixinStr___S_ISGID);
        }
    }




    static if(!is(typeof(__S_ISUID))) {
        private enum enumMixinStr___S_ISUID = `enum __S_ISUID = std.conv.octal!4000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_ISUID); }))) {
            mixin(enumMixinStr___S_ISUID);
        }
    }




    static if(!is(typeof(_____fpos64_t_defined))) {
        private enum enumMixinStr______fpos64_t_defined = `enum _____fpos64_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr______fpos64_t_defined); }))) {
            mixin(enumMixinStr______fpos64_t_defined);
        }
    }
    static if(!is(typeof(__S_IFSOCK))) {
        private enum enumMixinStr___S_IFSOCK = `enum __S_IFSOCK = std.conv.octal!140000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFSOCK); }))) {
            mixin(enumMixinStr___S_IFSOCK);
        }
    }




    static if(!is(typeof(_____fpos_t_defined))) {
        private enum enumMixinStr______fpos_t_defined = `enum _____fpos_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr______fpos_t_defined); }))) {
            mixin(enumMixinStr______fpos_t_defined);
        }
    }




    static if(!is(typeof(__S_IFLNK))) {
        private enum enumMixinStr___S_IFLNK = `enum __S_IFLNK = std.conv.octal!120000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFLNK); }))) {
            mixin(enumMixinStr___S_IFLNK);
        }
    }




    static if(!is(typeof(__S_IFIFO))) {
        private enum enumMixinStr___S_IFIFO = `enum __S_IFIFO = std.conv.octal!10000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFIFO); }))) {
            mixin(enumMixinStr___S_IFIFO);
        }
    }




    static if(!is(typeof(__S_IFREG))) {
        private enum enumMixinStr___S_IFREG = `enum __S_IFREG = std.conv.octal!100000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFREG); }))) {
            mixin(enumMixinStr___S_IFREG);
        }
    }




    static if(!is(typeof(__S_IFBLK))) {
        private enum enumMixinStr___S_IFBLK = `enum __S_IFBLK = std.conv.octal!60000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFBLK); }))) {
            mixin(enumMixinStr___S_IFBLK);
        }
    }




    static if(!is(typeof(____mbstate_t_defined))) {
        private enum enumMixinStr_____mbstate_t_defined = `enum ____mbstate_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_____mbstate_t_defined); }))) {
            mixin(enumMixinStr_____mbstate_t_defined);
        }
    }




    static if(!is(typeof(__S_IFCHR))) {
        private enum enumMixinStr___S_IFCHR = `enum __S_IFCHR = std.conv.octal!20000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFCHR); }))) {
            mixin(enumMixinStr___S_IFCHR);
        }
    }




    static if(!is(typeof(__S_IFDIR))) {
        private enum enumMixinStr___S_IFDIR = `enum __S_IFDIR = std.conv.octal!40000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFDIR); }))) {
            mixin(enumMixinStr___S_IFDIR);
        }
    }




    static if(!is(typeof(__S_IFMT))) {
        private enum enumMixinStr___S_IFMT = `enum __S_IFMT = std.conv.octal!170000;`;
        static if(is(typeof({ mixin(enumMixinStr___S_IFMT); }))) {
            mixin(enumMixinStr___S_IFMT);
        }
    }
    static if(!is(typeof(_SIGSET_NWORDS))) {
        private enum enumMixinStr__SIGSET_NWORDS = `enum _SIGSET_NWORDS = ( 1024 / ( 8 * ( unsigned long int ) .sizeof ) );`;
        static if(is(typeof({ mixin(enumMixinStr__SIGSET_NWORDS); }))) {
            mixin(enumMixinStr__SIGSET_NWORDS);
        }
    }
    static if(!is(typeof(st_ctime))) {
        private enum enumMixinStr_st_ctime = `enum st_ctime = st_ctim . tv_sec;`;
        static if(is(typeof({ mixin(enumMixinStr_st_ctime); }))) {
            mixin(enumMixinStr_st_ctime);
        }
    }




    static if(!is(typeof(__clock_t_defined))) {
        private enum enumMixinStr___clock_t_defined = `enum __clock_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___clock_t_defined); }))) {
            mixin(enumMixinStr___clock_t_defined);
        }
    }




    static if(!is(typeof(st_mtime))) {
        private enum enumMixinStr_st_mtime = `enum st_mtime = st_mtim . tv_sec;`;
        static if(is(typeof({ mixin(enumMixinStr_st_mtime); }))) {
            mixin(enumMixinStr_st_mtime);
        }
    }




    static if(!is(typeof(st_atime))) {
        private enum enumMixinStr_st_atime = `enum st_atime = st_atim . tv_sec;`;
        static if(is(typeof({ mixin(enumMixinStr_st_atime); }))) {
            mixin(enumMixinStr_st_atime);
        }
    }




    static if(!is(typeof(__clockid_t_defined))) {
        private enum enumMixinStr___clockid_t_defined = `enum __clockid_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___clockid_t_defined); }))) {
            mixin(enumMixinStr___clockid_t_defined);
        }
    }




    static if(!is(typeof(_STAT_VER))) {
        private enum enumMixinStr__STAT_VER = `enum _STAT_VER = _STAT_VER_LINUX;`;
        static if(is(typeof({ mixin(enumMixinStr__STAT_VER); }))) {
            mixin(enumMixinStr__STAT_VER);
        }
    }




    static if(!is(typeof(_MKNOD_VER_LINUX))) {
        private enum enumMixinStr__MKNOD_VER_LINUX = `enum _MKNOD_VER_LINUX = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__MKNOD_VER_LINUX); }))) {
            mixin(enumMixinStr__MKNOD_VER_LINUX);
        }
    }




    static if(!is(typeof(__sigset_t_defined))) {
        private enum enumMixinStr___sigset_t_defined = `enum __sigset_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___sigset_t_defined); }))) {
            mixin(enumMixinStr___sigset_t_defined);
        }
    }




    static if(!is(typeof(_STAT_VER_LINUX))) {
        private enum enumMixinStr__STAT_VER_LINUX = `enum _STAT_VER_LINUX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STAT_VER_LINUX); }))) {
            mixin(enumMixinStr__STAT_VER_LINUX);
        }
    }




    static if(!is(typeof(_STAT_VER_KERNEL))) {
        private enum enumMixinStr__STAT_VER_KERNEL = `enum _STAT_VER_KERNEL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__STAT_VER_KERNEL); }))) {
            mixin(enumMixinStr__STAT_VER_KERNEL);
        }
    }




    static if(!is(typeof(__struct_FILE_defined))) {
        private enum enumMixinStr___struct_FILE_defined = `enum __struct_FILE_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___struct_FILE_defined); }))) {
            mixin(enumMixinStr___struct_FILE_defined);
        }
    }




    static if(!is(typeof(_BITS_STAT_H))) {
        private enum enumMixinStr__BITS_STAT_H = `enum _BITS_STAT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STAT_H); }))) {
            mixin(enumMixinStr__BITS_STAT_H);
        }
    }




    static if(!is(typeof(SOCK_NONBLOCK))) {
        private enum enumMixinStr_SOCK_NONBLOCK = `enum SOCK_NONBLOCK = SOCK_NONBLOCK;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_NONBLOCK); }))) {
            mixin(enumMixinStr_SOCK_NONBLOCK);
        }
    }




    static if(!is(typeof(SOCK_CLOEXEC))) {
        private enum enumMixinStr_SOCK_CLOEXEC = `enum SOCK_CLOEXEC = SOCK_CLOEXEC;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_CLOEXEC); }))) {
            mixin(enumMixinStr_SOCK_CLOEXEC);
        }
    }




    static if(!is(typeof(SOCK_PACKET))) {
        private enum enumMixinStr_SOCK_PACKET = `enum SOCK_PACKET = SOCK_PACKET;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_PACKET); }))) {
            mixin(enumMixinStr_SOCK_PACKET);
        }
    }




    static if(!is(typeof(SOCK_DCCP))) {
        private enum enumMixinStr_SOCK_DCCP = `enum SOCK_DCCP = SOCK_DCCP;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_DCCP); }))) {
            mixin(enumMixinStr_SOCK_DCCP);
        }
    }
    static if(!is(typeof(_IO_EOF_SEEN))) {
        private enum enumMixinStr__IO_EOF_SEEN = `enum _IO_EOF_SEEN = 0x0010;`;
        static if(is(typeof({ mixin(enumMixinStr__IO_EOF_SEEN); }))) {
            mixin(enumMixinStr__IO_EOF_SEEN);
        }
    }






    static if(!is(typeof(_IO_ERR_SEEN))) {
        private enum enumMixinStr__IO_ERR_SEEN = `enum _IO_ERR_SEEN = 0x0020;`;
        static if(is(typeof({ mixin(enumMixinStr__IO_ERR_SEEN); }))) {
            mixin(enumMixinStr__IO_ERR_SEEN);
        }
    }






    static if(!is(typeof(_IO_USER_LOCK))) {
        private enum enumMixinStr__IO_USER_LOCK = `enum _IO_USER_LOCK = 0x8000;`;
        static if(is(typeof({ mixin(enumMixinStr__IO_USER_LOCK); }))) {
            mixin(enumMixinStr__IO_USER_LOCK);
        }
    }




    static if(!is(typeof(__iovec_defined))) {
        private enum enumMixinStr___iovec_defined = `enum __iovec_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___iovec_defined); }))) {
            mixin(enumMixinStr___iovec_defined);
        }
    }






    static if(!is(typeof(SOCK_SEQPACKET))) {
        private enum enumMixinStr_SOCK_SEQPACKET = `enum SOCK_SEQPACKET = SOCK_SEQPACKET;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_SEQPACKET); }))) {
            mixin(enumMixinStr_SOCK_SEQPACKET);
        }
    }




    static if(!is(typeof(SOCK_RDM))) {
        private enum enumMixinStr_SOCK_RDM = `enum SOCK_RDM = SOCK_RDM;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_RDM); }))) {
            mixin(enumMixinStr_SOCK_RDM);
        }
    }




    static if(!is(typeof(__osockaddr_defined))) {
        private enum enumMixinStr___osockaddr_defined = `enum __osockaddr_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___osockaddr_defined); }))) {
            mixin(enumMixinStr___osockaddr_defined);
        }
    }




    static if(!is(typeof(SOCK_RAW))) {
        private enum enumMixinStr_SOCK_RAW = `enum SOCK_RAW = SOCK_RAW;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_RAW); }))) {
            mixin(enumMixinStr_SOCK_RAW);
        }
    }




    static if(!is(typeof(_STRUCT_TIMESPEC))) {
        private enum enumMixinStr__STRUCT_TIMESPEC = `enum _STRUCT_TIMESPEC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STRUCT_TIMESPEC); }))) {
            mixin(enumMixinStr__STRUCT_TIMESPEC);
        }
    }




    static if(!is(typeof(SOCK_DGRAM))) {
        private enum enumMixinStr_SOCK_DGRAM = `enum SOCK_DGRAM = SOCK_DGRAM;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_DGRAM); }))) {
            mixin(enumMixinStr_SOCK_DGRAM);
        }
    }




    static if(!is(typeof(SOCK_STREAM))) {
        private enum enumMixinStr_SOCK_STREAM = `enum SOCK_STREAM = SOCK_STREAM;`;
        static if(is(typeof({ mixin(enumMixinStr_SOCK_STREAM); }))) {
            mixin(enumMixinStr_SOCK_STREAM);
        }
    }




    static if(!is(typeof(__timeval_defined))) {
        private enum enumMixinStr___timeval_defined = `enum __timeval_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___timeval_defined); }))) {
            mixin(enumMixinStr___timeval_defined);
        }
    }




    static if(!is(typeof(SCM_RIGHTS))) {
        private enum enumMixinStr_SCM_RIGHTS = `enum SCM_RIGHTS = SCM_RIGHTS;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_RIGHTS); }))) {
            mixin(enumMixinStr_SCM_RIGHTS);
        }
    }






    static if(!is(typeof(__time_t_defined))) {
        private enum enumMixinStr___time_t_defined = `enum __time_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___time_t_defined); }))) {
            mixin(enumMixinStr___time_t_defined);
        }
    }
    static if(!is(typeof(__timer_t_defined))) {
        private enum enumMixinStr___timer_t_defined = `enum __timer_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___timer_t_defined); }))) {
            mixin(enumMixinStr___timer_t_defined);
        }
    }
    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        private enum enumMixinStr__BITS_TYPESIZES_H = `enum _BITS_TYPESIZES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPESIZES_H); }))) {
            mixin(enumMixinStr__BITS_TYPESIZES_H);
        }
    }




    static if(!is(typeof(MSG_CMSG_CLOEXEC))) {
        private enum enumMixinStr_MSG_CMSG_CLOEXEC = `enum MSG_CMSG_CLOEXEC = MSG_CMSG_CLOEXEC;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_CMSG_CLOEXEC); }))) {
            mixin(enumMixinStr_MSG_CMSG_CLOEXEC);
        }
    }




    static if(!is(typeof(__SYSCALL_SLONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_SLONG_TYPE = `enum __SYSCALL_SLONG_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_SLONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_SLONG_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_ULONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_ULONG_TYPE = `enum __SYSCALL_ULONG_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_ULONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_ULONG_TYPE);
        }
    }




    static if(!is(typeof(__DEV_T_TYPE))) {
        private enum enumMixinStr___DEV_T_TYPE = `enum __DEV_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___DEV_T_TYPE); }))) {
            mixin(enumMixinStr___DEV_T_TYPE);
        }
    }




    static if(!is(typeof(__UID_T_TYPE))) {
        private enum enumMixinStr___UID_T_TYPE = `enum __UID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___UID_T_TYPE); }))) {
            mixin(enumMixinStr___UID_T_TYPE);
        }
    }




    static if(!is(typeof(__GID_T_TYPE))) {
        private enum enumMixinStr___GID_T_TYPE = `enum __GID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___GID_T_TYPE); }))) {
            mixin(enumMixinStr___GID_T_TYPE);
        }
    }




    static if(!is(typeof(__INO_T_TYPE))) {
        private enum enumMixinStr___INO_T_TYPE = `enum __INO_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_TYPE); }))) {
            mixin(enumMixinStr___INO_T_TYPE);
        }
    }




    static if(!is(typeof(__INO64_T_TYPE))) {
        private enum enumMixinStr___INO64_T_TYPE = `enum __INO64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___INO64_T_TYPE); }))) {
            mixin(enumMixinStr___INO64_T_TYPE);
        }
    }




    static if(!is(typeof(__MODE_T_TYPE))) {
        private enum enumMixinStr___MODE_T_TYPE = `enum __MODE_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___MODE_T_TYPE); }))) {
            mixin(enumMixinStr___MODE_T_TYPE);
        }
    }




    static if(!is(typeof(MSG_FASTOPEN))) {
        private enum enumMixinStr_MSG_FASTOPEN = `enum MSG_FASTOPEN = MSG_FASTOPEN;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_FASTOPEN); }))) {
            mixin(enumMixinStr_MSG_FASTOPEN);
        }
    }




    static if(!is(typeof(__NLINK_T_TYPE))) {
        private enum enumMixinStr___NLINK_T_TYPE = `enum __NLINK_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___NLINK_T_TYPE); }))) {
            mixin(enumMixinStr___NLINK_T_TYPE);
        }
    }




    static if(!is(typeof(__FSWORD_T_TYPE))) {
        private enum enumMixinStr___FSWORD_T_TYPE = `enum __FSWORD_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSWORD_T_TYPE); }))) {
            mixin(enumMixinStr___FSWORD_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_TYPE))) {
        private enum enumMixinStr___OFF_T_TYPE = `enum __OFF_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_TYPE); }))) {
            mixin(enumMixinStr___OFF_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF64_T_TYPE))) {
        private enum enumMixinStr___OFF64_T_TYPE = `enum __OFF64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF64_T_TYPE); }))) {
            mixin(enumMixinStr___OFF64_T_TYPE);
        }
    }




    static if(!is(typeof(__PID_T_TYPE))) {
        private enum enumMixinStr___PID_T_TYPE = `enum __PID_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___PID_T_TYPE); }))) {
            mixin(enumMixinStr___PID_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM_T_TYPE))) {
        private enum enumMixinStr___RLIM_T_TYPE = `enum __RLIM_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM64_T_TYPE))) {
        private enum enumMixinStr___RLIM64_T_TYPE = `enum __RLIM64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM64_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM64_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT_T_TYPE))) {
        private enum enumMixinStr___BLKCNT_T_TYPE = `enum __BLKCNT_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT64_T_TYPE))) {
        private enum enumMixinStr___BLKCNT64_T_TYPE = `enum __BLKCNT64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT_T_TYPE = `enum __FSBLKCNT_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT64_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT64_T_TYPE = `enum __FSBLKCNT64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT_T_TYPE = `enum __FSFILCNT_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT64_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT64_T_TYPE = `enum __FSFILCNT64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__ID_T_TYPE))) {
        private enum enumMixinStr___ID_T_TYPE = `enum __ID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ID_T_TYPE); }))) {
            mixin(enumMixinStr___ID_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCK_T_TYPE))) {
        private enum enumMixinStr___CLOCK_T_TYPE = `enum __CLOCK_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCK_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCK_T_TYPE);
        }
    }




    static if(!is(typeof(__TIME_T_TYPE))) {
        private enum enumMixinStr___TIME_T_TYPE = `enum __TIME_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME_T_TYPE); }))) {
            mixin(enumMixinStr___TIME_T_TYPE);
        }
    }




    static if(!is(typeof(__USECONDS_T_TYPE))) {
        private enum enumMixinStr___USECONDS_T_TYPE = `enum __USECONDS_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___USECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___USECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS_T_TYPE = `enum __SUSECONDS_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__DADDR_T_TYPE))) {
        private enum enumMixinStr___DADDR_T_TYPE = `enum __DADDR_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___DADDR_T_TYPE); }))) {
            mixin(enumMixinStr___DADDR_T_TYPE);
        }
    }




    static if(!is(typeof(__KEY_T_TYPE))) {
        private enum enumMixinStr___KEY_T_TYPE = `enum __KEY_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___KEY_T_TYPE); }))) {
            mixin(enumMixinStr___KEY_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCKID_T_TYPE))) {
        private enum enumMixinStr___CLOCKID_T_TYPE = `enum __CLOCKID_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCKID_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCKID_T_TYPE);
        }
    }




    static if(!is(typeof(__TIMER_T_TYPE))) {
        private enum enumMixinStr___TIMER_T_TYPE = `enum __TIMER_T_TYPE = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMER_T_TYPE); }))) {
            mixin(enumMixinStr___TIMER_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKSIZE_T_TYPE))) {
        private enum enumMixinStr___BLKSIZE_T_TYPE = `enum __BLKSIZE_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___BLKSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__FSID_T_TYPE))) {
        private enum enumMixinStr___FSID_T_TYPE = `enum __FSID_T_TYPE = { int __val [ 2 ] ; };`;
        static if(is(typeof({ mixin(enumMixinStr___FSID_T_TYPE); }))) {
            mixin(enumMixinStr___FSID_T_TYPE);
        }
    }




    static if(!is(typeof(__SSIZE_T_TYPE))) {
        private enum enumMixinStr___SSIZE_T_TYPE = `enum __SSIZE_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___SSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__CPU_MASK_TYPE))) {
        private enum enumMixinStr___CPU_MASK_TYPE = `enum __CPU_MASK_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___CPU_MASK_TYPE); }))) {
            mixin(enumMixinStr___CPU_MASK_TYPE);
        }
    }




    static if(!is(typeof(MSG_ZEROCOPY))) {
        private enum enumMixinStr_MSG_ZEROCOPY = `enum MSG_ZEROCOPY = MSG_ZEROCOPY;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_ZEROCOPY); }))) {
            mixin(enumMixinStr_MSG_ZEROCOPY);
        }
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        private enum enumMixinStr___OFF_T_MATCHES_OFF64_T = `enum __OFF_T_MATCHES_OFF64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T); }))) {
            mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T);
        }
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        private enum enumMixinStr___INO_T_MATCHES_INO64_T = `enum __INO_T_MATCHES_INO64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_MATCHES_INO64_T); }))) {
            mixin(enumMixinStr___INO_T_MATCHES_INO64_T);
        }
    }




    static if(!is(typeof(__RLIM_T_MATCHES_RLIM64_T))) {
        private enum enumMixinStr___RLIM_T_MATCHES_RLIM64_T = `enum __RLIM_T_MATCHES_RLIM64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T); }))) {
            mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T);
        }
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        private enum enumMixinStr___FD_SETSIZE = `enum __FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr___FD_SETSIZE); }))) {
            mixin(enumMixinStr___FD_SETSIZE);
        }
    }




    static if(!is(typeof(MSG_BATCH))) {
        private enum enumMixinStr_MSG_BATCH = `enum MSG_BATCH = MSG_BATCH;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_BATCH); }))) {
            mixin(enumMixinStr_MSG_BATCH);
        }
    }




    static if(!is(typeof(_BITS_UINTN_IDENTITY_H))) {
        private enum enumMixinStr__BITS_UINTN_IDENTITY_H = `enum _BITS_UINTN_IDENTITY_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_UINTN_IDENTITY_H); }))) {
            mixin(enumMixinStr__BITS_UINTN_IDENTITY_H);
        }
    }




    static if(!is(typeof(MSG_WAITFORONE))) {
        private enum enumMixinStr_MSG_WAITFORONE = `enum MSG_WAITFORONE = MSG_WAITFORONE;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_WAITFORONE); }))) {
            mixin(enumMixinStr_MSG_WAITFORONE);
        }
    }




    static if(!is(typeof(MSG_MORE))) {
        private enum enumMixinStr_MSG_MORE = `enum MSG_MORE = MSG_MORE;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_MORE); }))) {
            mixin(enumMixinStr_MSG_MORE);
        }
    }




    static if(!is(typeof(MSG_NOSIGNAL))) {
        private enum enumMixinStr_MSG_NOSIGNAL = `enum MSG_NOSIGNAL = MSG_NOSIGNAL;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_NOSIGNAL); }))) {
            mixin(enumMixinStr_MSG_NOSIGNAL);
        }
    }




    static if(!is(typeof(MSG_ERRQUEUE))) {
        private enum enumMixinStr_MSG_ERRQUEUE = `enum MSG_ERRQUEUE = MSG_ERRQUEUE;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_ERRQUEUE); }))) {
            mixin(enumMixinStr_MSG_ERRQUEUE);
        }
    }




    static if(!is(typeof(MSG_RST))) {
        private enum enumMixinStr_MSG_RST = `enum MSG_RST = MSG_RST;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_RST); }))) {
            mixin(enumMixinStr_MSG_RST);
        }
    }




    static if(!is(typeof(_BITS_WCHAR_H))) {
        private enum enumMixinStr__BITS_WCHAR_H = `enum _BITS_WCHAR_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_WCHAR_H); }))) {
            mixin(enumMixinStr__BITS_WCHAR_H);
        }
    }




    static if(!is(typeof(MSG_CONFIRM))) {
        private enum enumMixinStr_MSG_CONFIRM = `enum MSG_CONFIRM = MSG_CONFIRM;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_CONFIRM); }))) {
            mixin(enumMixinStr_MSG_CONFIRM);
        }
    }




    static if(!is(typeof(__WCHAR_MAX))) {
        private enum enumMixinStr___WCHAR_MAX = `enum __WCHAR_MAX = 0x7fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MAX); }))) {
            mixin(enumMixinStr___WCHAR_MAX);
        }
    }




    static if(!is(typeof(__WCHAR_MIN))) {
        private enum enumMixinStr___WCHAR_MIN = `enum __WCHAR_MIN = ( - 0x7fffffff - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MIN); }))) {
            mixin(enumMixinStr___WCHAR_MIN);
        }
    }




    static if(!is(typeof(MSG_SYN))) {
        private enum enumMixinStr_MSG_SYN = `enum MSG_SYN = MSG_SYN;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_SYN); }))) {
            mixin(enumMixinStr_MSG_SYN);
        }
    }




    static if(!is(typeof(MSG_FIN))) {
        private enum enumMixinStr_MSG_FIN = `enum MSG_FIN = MSG_FIN;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_FIN); }))) {
            mixin(enumMixinStr_MSG_FIN);
        }
    }




    static if(!is(typeof(MSG_WAITALL))) {
        private enum enumMixinStr_MSG_WAITALL = `enum MSG_WAITALL = MSG_WAITALL;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_WAITALL); }))) {
            mixin(enumMixinStr_MSG_WAITALL);
        }
    }




    static if(!is(typeof(MSG_EOR))) {
        private enum enumMixinStr_MSG_EOR = `enum MSG_EOR = MSG_EOR;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_EOR); }))) {
            mixin(enumMixinStr_MSG_EOR);
        }
    }




    static if(!is(typeof(MSG_DONTWAIT))) {
        private enum enumMixinStr_MSG_DONTWAIT = `enum MSG_DONTWAIT = MSG_DONTWAIT;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_DONTWAIT); }))) {
            mixin(enumMixinStr_MSG_DONTWAIT);
        }
    }




    static if(!is(typeof(MSG_TRUNC))) {
        private enum enumMixinStr_MSG_TRUNC = `enum MSG_TRUNC = MSG_TRUNC;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_TRUNC); }))) {
            mixin(enumMixinStr_MSG_TRUNC);
        }
    }




    static if(!is(typeof(__WORDSIZE))) {
        private enum enumMixinStr___WORDSIZE = `enum __WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE); }))) {
            mixin(enumMixinStr___WORDSIZE);
        }
    }




    static if(!is(typeof(MSG_PROXY))) {
        private enum enumMixinStr_MSG_PROXY = `enum MSG_PROXY = MSG_PROXY;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_PROXY); }))) {
            mixin(enumMixinStr_MSG_PROXY);
        }
    }




    static if(!is(typeof(MSG_CTRUNC))) {
        private enum enumMixinStr_MSG_CTRUNC = `enum MSG_CTRUNC = MSG_CTRUNC;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_CTRUNC); }))) {
            mixin(enumMixinStr_MSG_CTRUNC);
        }
    }




    static if(!is(typeof(MSG_DONTROUTE))) {
        private enum enumMixinStr_MSG_DONTROUTE = `enum MSG_DONTROUTE = MSG_DONTROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_DONTROUTE); }))) {
            mixin(enumMixinStr_MSG_DONTROUTE);
        }
    }




    static if(!is(typeof(MSG_PEEK))) {
        private enum enumMixinStr_MSG_PEEK = `enum MSG_PEEK = MSG_PEEK;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_PEEK); }))) {
            mixin(enumMixinStr_MSG_PEEK);
        }
    }




    static if(!is(typeof(MSG_OOB))) {
        private enum enumMixinStr_MSG_OOB = `enum MSG_OOB = MSG_OOB;`;
        static if(is(typeof({ mixin(enumMixinStr_MSG_OOB); }))) {
            mixin(enumMixinStr_MSG_OOB);
        }
    }




    static if(!is(typeof(_SS_PADSIZE))) {
        private enum enumMixinStr__SS_PADSIZE = `enum _SS_PADSIZE = ( _SS_SIZE - __SOCKADDR_COMMON_SIZE - ( __ss_aligntype ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr__SS_PADSIZE); }))) {
            mixin(enumMixinStr__SS_PADSIZE);
        }
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        private enum enumMixinStr___WORDSIZE_TIME64_COMPAT32 = `enum __WORDSIZE_TIME64_COMPAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32); }))) {
            mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32);
        }
    }




    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        private enum enumMixinStr___SYSCALL_WORDSIZE = `enum __SYSCALL_WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_WORDSIZE); }))) {
            mixin(enumMixinStr___SYSCALL_WORDSIZE);
        }
    }




    static if(!is(typeof(_ENDIAN_H))) {
        private enum enumMixinStr__ENDIAN_H = `enum _ENDIAN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ENDIAN_H); }))) {
            mixin(enumMixinStr__ENDIAN_H);
        }
    }




    static if(!is(typeof(__ss_aligntype))) {
        private enum enumMixinStr___ss_aligntype = `enum __ss_aligntype = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___ss_aligntype); }))) {
            mixin(enumMixinStr___ss_aligntype);
        }
    }




    static if(!is(typeof(__LITTLE_ENDIAN))) {
        private enum enumMixinStr___LITTLE_ENDIAN = `enum __LITTLE_ENDIAN = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr___LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr___LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(__BIG_ENDIAN))) {
        private enum enumMixinStr___BIG_ENDIAN = `enum __BIG_ENDIAN = 4321;`;
        static if(is(typeof({ mixin(enumMixinStr___BIG_ENDIAN); }))) {
            mixin(enumMixinStr___BIG_ENDIAN);
        }
    }




    static if(!is(typeof(__PDP_ENDIAN))) {
        private enum enumMixinStr___PDP_ENDIAN = `enum __PDP_ENDIAN = 3412;`;
        static if(is(typeof({ mixin(enumMixinStr___PDP_ENDIAN); }))) {
            mixin(enumMixinStr___PDP_ENDIAN);
        }
    }




    static if(!is(typeof(SOMAXCONN))) {
        private enum enumMixinStr_SOMAXCONN = `enum SOMAXCONN = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_SOMAXCONN); }))) {
            mixin(enumMixinStr_SOMAXCONN);
        }
    }




    static if(!is(typeof(__FLOAT_WORD_ORDER))) {
        private enum enumMixinStr___FLOAT_WORD_ORDER = `enum __FLOAT_WORD_ORDER = __BYTE_ORDER;`;
        static if(is(typeof({ mixin(enumMixinStr___FLOAT_WORD_ORDER); }))) {
            mixin(enumMixinStr___FLOAT_WORD_ORDER);
        }
    }




    static if(!is(typeof(SOL_XDP))) {
        private enum enumMixinStr_SOL_XDP = `enum SOL_XDP = 283;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_XDP); }))) {
            mixin(enumMixinStr_SOL_XDP);
        }
    }




    static if(!is(typeof(LITTLE_ENDIAN))) {
        private enum enumMixinStr_LITTLE_ENDIAN = `enum LITTLE_ENDIAN = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr_LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr_LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(BIG_ENDIAN))) {
        private enum enumMixinStr_BIG_ENDIAN = `enum BIG_ENDIAN = 4321;`;
        static if(is(typeof({ mixin(enumMixinStr_BIG_ENDIAN); }))) {
            mixin(enumMixinStr_BIG_ENDIAN);
        }
    }




    static if(!is(typeof(PDP_ENDIAN))) {
        private enum enumMixinStr_PDP_ENDIAN = `enum PDP_ENDIAN = 3412;`;
        static if(is(typeof({ mixin(enumMixinStr_PDP_ENDIAN); }))) {
            mixin(enumMixinStr_PDP_ENDIAN);
        }
    }




    static if(!is(typeof(BYTE_ORDER))) {
        private enum enumMixinStr_BYTE_ORDER = `enum BYTE_ORDER = __BYTE_ORDER;`;
        static if(is(typeof({ mixin(enumMixinStr_BYTE_ORDER); }))) {
            mixin(enumMixinStr_BYTE_ORDER);
        }
    }




    static if(!is(typeof(SOL_TLS))) {
        private enum enumMixinStr_SOL_TLS = `enum SOL_TLS = 282;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_TLS); }))) {
            mixin(enumMixinStr_SOL_TLS);
        }
    }




    static if(!is(typeof(SOL_KCM))) {
        private enum enumMixinStr_SOL_KCM = `enum SOL_KCM = 281;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_KCM); }))) {
            mixin(enumMixinStr_SOL_KCM);
        }
    }






    static if(!is(typeof(SOL_NFC))) {
        private enum enumMixinStr_SOL_NFC = `enum SOL_NFC = 280;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_NFC); }))) {
            mixin(enumMixinStr_SOL_NFC);
        }
    }




    static if(!is(typeof(SOL_ALG))) {
        private enum enumMixinStr_SOL_ALG = `enum SOL_ALG = 279;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_ALG); }))) {
            mixin(enumMixinStr_SOL_ALG);
        }
    }




    static if(!is(typeof(SOL_CAIF))) {
        private enum enumMixinStr_SOL_CAIF = `enum SOL_CAIF = 278;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_CAIF); }))) {
            mixin(enumMixinStr_SOL_CAIF);
        }
    }




    static if(!is(typeof(SOL_IUCV))) {
        private enum enumMixinStr_SOL_IUCV = `enum SOL_IUCV = 277;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_IUCV); }))) {
            mixin(enumMixinStr_SOL_IUCV);
        }
    }




    static if(!is(typeof(SOL_RDS))) {
        private enum enumMixinStr_SOL_RDS = `enum SOL_RDS = 276;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_RDS); }))) {
            mixin(enumMixinStr_SOL_RDS);
        }
    }
    static if(!is(typeof(_ERRNO_H))) {
        private enum enumMixinStr__ERRNO_H = `enum _ERRNO_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ERRNO_H); }))) {
            mixin(enumMixinStr__ERRNO_H);
        }
    }




    static if(!is(typeof(SOL_PNPIPE))) {
        private enum enumMixinStr_SOL_PNPIPE = `enum SOL_PNPIPE = 275;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_PNPIPE); }))) {
            mixin(enumMixinStr_SOL_PNPIPE);
        }
    }




    static if(!is(typeof(SOL_BLUETOOTH))) {
        private enum enumMixinStr_SOL_BLUETOOTH = `enum SOL_BLUETOOTH = 274;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_BLUETOOTH); }))) {
            mixin(enumMixinStr_SOL_BLUETOOTH);
        }
    }




    static if(!is(typeof(SOL_PPPOL2TP))) {
        private enum enumMixinStr_SOL_PPPOL2TP = `enum SOL_PPPOL2TP = 273;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_PPPOL2TP); }))) {
            mixin(enumMixinStr_SOL_PPPOL2TP);
        }
    }




    static if(!is(typeof(SOL_RXRPC))) {
        private enum enumMixinStr_SOL_RXRPC = `enum SOL_RXRPC = 272;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_RXRPC); }))) {
            mixin(enumMixinStr_SOL_RXRPC);
        }
    }




    static if(!is(typeof(SOL_TIPC))) {
        private enum enumMixinStr_SOL_TIPC = `enum SOL_TIPC = 271;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_TIPC); }))) {
            mixin(enumMixinStr_SOL_TIPC);
        }
    }




    static if(!is(typeof(SOL_NETLINK))) {
        private enum enumMixinStr_SOL_NETLINK = `enum SOL_NETLINK = 270;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_NETLINK); }))) {
            mixin(enumMixinStr_SOL_NETLINK);
        }
    }




    static if(!is(typeof(errno))) {
        private enum enumMixinStr_errno = `enum errno = ( * __errno_location ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_errno); }))) {
            mixin(enumMixinStr_errno);
        }
    }




    static if(!is(typeof(SOL_DCCP))) {
        private enum enumMixinStr_SOL_DCCP = `enum SOL_DCCP = 269;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_DCCP); }))) {
            mixin(enumMixinStr_SOL_DCCP);
        }
    }




    static if(!is(typeof(_FCNTL_H))) {
        private enum enumMixinStr__FCNTL_H = `enum _FCNTL_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FCNTL_H); }))) {
            mixin(enumMixinStr__FCNTL_H);
        }
    }




    static if(!is(typeof(SOL_LLC))) {
        private enum enumMixinStr_SOL_LLC = `enum SOL_LLC = 268;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_LLC); }))) {
            mixin(enumMixinStr_SOL_LLC);
        }
    }




    static if(!is(typeof(SOL_NETBEUI))) {
        private enum enumMixinStr_SOL_NETBEUI = `enum SOL_NETBEUI = 267;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_NETBEUI); }))) {
            mixin(enumMixinStr_SOL_NETBEUI);
        }
    }




    static if(!is(typeof(SOL_IRDA))) {
        private enum enumMixinStr_SOL_IRDA = `enum SOL_IRDA = 266;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_IRDA); }))) {
            mixin(enumMixinStr_SOL_IRDA);
        }
    }




    static if(!is(typeof(SOL_AAL))) {
        private enum enumMixinStr_SOL_AAL = `enum SOL_AAL = 265;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_AAL); }))) {
            mixin(enumMixinStr_SOL_AAL);
        }
    }




    static if(!is(typeof(SOL_ATM))) {
        private enum enumMixinStr_SOL_ATM = `enum SOL_ATM = 264;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_ATM); }))) {
            mixin(enumMixinStr_SOL_ATM);
        }
    }






    static if(!is(typeof(SOL_PACKET))) {
        private enum enumMixinStr_SOL_PACKET = `enum SOL_PACKET = 263;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_PACKET); }))) {
            mixin(enumMixinStr_SOL_PACKET);
        }
    }




    static if(!is(typeof(SOL_X25))) {
        private enum enumMixinStr_SOL_X25 = `enum SOL_X25 = 262;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_X25); }))) {
            mixin(enumMixinStr_SOL_X25);
        }
    }




    static if(!is(typeof(SOL_DECNET))) {
        private enum enumMixinStr_SOL_DECNET = `enum SOL_DECNET = 261;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_DECNET); }))) {
            mixin(enumMixinStr_SOL_DECNET);
        }
    }




    static if(!is(typeof(SOL_RAW))) {
        private enum enumMixinStr_SOL_RAW = `enum SOL_RAW = 255;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_RAW); }))) {
            mixin(enumMixinStr_SOL_RAW);
        }
    }




    static if(!is(typeof(AF_MAX))) {
        private enum enumMixinStr_AF_MAX = `enum AF_MAX = PF_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_MAX); }))) {
            mixin(enumMixinStr_AF_MAX);
        }
    }




    static if(!is(typeof(AF_XDP))) {
        private enum enumMixinStr_AF_XDP = `enum AF_XDP = PF_XDP;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_XDP); }))) {
            mixin(enumMixinStr_AF_XDP);
        }
    }




    static if(!is(typeof(AF_SMC))) {
        private enum enumMixinStr_AF_SMC = `enum AF_SMC = PF_SMC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_SMC); }))) {
            mixin(enumMixinStr_AF_SMC);
        }
    }




    static if(!is(typeof(S_IFMT))) {
        private enum enumMixinStr_S_IFMT = `enum S_IFMT = std.conv.octal!170000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFMT); }))) {
            mixin(enumMixinStr_S_IFMT);
        }
    }




    static if(!is(typeof(S_IFDIR))) {
        private enum enumMixinStr_S_IFDIR = `enum S_IFDIR = std.conv.octal!40000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFDIR); }))) {
            mixin(enumMixinStr_S_IFDIR);
        }
    }




    static if(!is(typeof(S_IFCHR))) {
        private enum enumMixinStr_S_IFCHR = `enum S_IFCHR = std.conv.octal!20000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFCHR); }))) {
            mixin(enumMixinStr_S_IFCHR);
        }
    }




    static if(!is(typeof(S_IFBLK))) {
        private enum enumMixinStr_S_IFBLK = `enum S_IFBLK = std.conv.octal!60000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFBLK); }))) {
            mixin(enumMixinStr_S_IFBLK);
        }
    }




    static if(!is(typeof(S_IFREG))) {
        private enum enumMixinStr_S_IFREG = `enum S_IFREG = std.conv.octal!100000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFREG); }))) {
            mixin(enumMixinStr_S_IFREG);
        }
    }




    static if(!is(typeof(AF_QIPCRTR))) {
        private enum enumMixinStr_AF_QIPCRTR = `enum AF_QIPCRTR = PF_QIPCRTR;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_QIPCRTR); }))) {
            mixin(enumMixinStr_AF_QIPCRTR);
        }
    }




    static if(!is(typeof(S_IFIFO))) {
        private enum enumMixinStr_S_IFIFO = `enum S_IFIFO = std.conv.octal!10000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFIFO); }))) {
            mixin(enumMixinStr_S_IFIFO);
        }
    }




    static if(!is(typeof(AF_KCM))) {
        private enum enumMixinStr_AF_KCM = `enum AF_KCM = PF_KCM;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_KCM); }))) {
            mixin(enumMixinStr_AF_KCM);
        }
    }




    static if(!is(typeof(S_IFLNK))) {
        private enum enumMixinStr_S_IFLNK = `enum S_IFLNK = std.conv.octal!120000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFLNK); }))) {
            mixin(enumMixinStr_S_IFLNK);
        }
    }




    static if(!is(typeof(AF_VSOCK))) {
        private enum enumMixinStr_AF_VSOCK = `enum AF_VSOCK = PF_VSOCK;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_VSOCK); }))) {
            mixin(enumMixinStr_AF_VSOCK);
        }
    }




    static if(!is(typeof(AF_NFC))) {
        private enum enumMixinStr_AF_NFC = `enum AF_NFC = PF_NFC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_NFC); }))) {
            mixin(enumMixinStr_AF_NFC);
        }
    }




    static if(!is(typeof(S_IFSOCK))) {
        private enum enumMixinStr_S_IFSOCK = `enum S_IFSOCK = std.conv.octal!140000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IFSOCK); }))) {
            mixin(enumMixinStr_S_IFSOCK);
        }
    }




    static if(!is(typeof(S_ISUID))) {
        private enum enumMixinStr_S_ISUID = `enum S_ISUID = std.conv.octal!4000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_ISUID); }))) {
            mixin(enumMixinStr_S_ISUID);
        }
    }




    static if(!is(typeof(S_ISGID))) {
        private enum enumMixinStr_S_ISGID = `enum S_ISGID = std.conv.octal!2000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_ISGID); }))) {
            mixin(enumMixinStr_S_ISGID);
        }
    }




    static if(!is(typeof(AF_ALG))) {
        private enum enumMixinStr_AF_ALG = `enum AF_ALG = PF_ALG;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ALG); }))) {
            mixin(enumMixinStr_AF_ALG);
        }
    }




    static if(!is(typeof(S_ISVTX))) {
        private enum enumMixinStr_S_ISVTX = `enum S_ISVTX = std.conv.octal!1000;`;
        static if(is(typeof({ mixin(enumMixinStr_S_ISVTX); }))) {
            mixin(enumMixinStr_S_ISVTX);
        }
    }




    static if(!is(typeof(S_IRUSR))) {
        private enum enumMixinStr_S_IRUSR = `enum S_IRUSR = std.conv.octal!400;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IRUSR); }))) {
            mixin(enumMixinStr_S_IRUSR);
        }
    }




    static if(!is(typeof(S_IWUSR))) {
        private enum enumMixinStr_S_IWUSR = `enum S_IWUSR = std.conv.octal!200;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IWUSR); }))) {
            mixin(enumMixinStr_S_IWUSR);
        }
    }




    static if(!is(typeof(S_IXUSR))) {
        private enum enumMixinStr_S_IXUSR = `enum S_IXUSR = std.conv.octal!100;`;
        static if(is(typeof({ mixin(enumMixinStr_S_IXUSR); }))) {
            mixin(enumMixinStr_S_IXUSR);
        }
    }




    static if(!is(typeof(S_IRWXU))) {
        private enum enumMixinStr_S_IRWXU = `enum S_IRWXU = ( std.conv.octal!400 | std.conv.octal!200 | std.conv.octal!100 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IRWXU); }))) {
            mixin(enumMixinStr_S_IRWXU);
        }
    }




    static if(!is(typeof(S_IRGRP))) {
        private enum enumMixinStr_S_IRGRP = `enum S_IRGRP = ( std.conv.octal!400 >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IRGRP); }))) {
            mixin(enumMixinStr_S_IRGRP);
        }
    }




    static if(!is(typeof(S_IWGRP))) {
        private enum enumMixinStr_S_IWGRP = `enum S_IWGRP = ( std.conv.octal!200 >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IWGRP); }))) {
            mixin(enumMixinStr_S_IWGRP);
        }
    }




    static if(!is(typeof(S_IXGRP))) {
        private enum enumMixinStr_S_IXGRP = `enum S_IXGRP = ( std.conv.octal!100 >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IXGRP); }))) {
            mixin(enumMixinStr_S_IXGRP);
        }
    }




    static if(!is(typeof(S_IRWXG))) {
        private enum enumMixinStr_S_IRWXG = `enum S_IRWXG = ( ( std.conv.octal!400 | std.conv.octal!200 | std.conv.octal!100 ) >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IRWXG); }))) {
            mixin(enumMixinStr_S_IRWXG);
        }
    }




    static if(!is(typeof(S_IROTH))) {
        private enum enumMixinStr_S_IROTH = `enum S_IROTH = ( ( std.conv.octal!400 >> 3 ) >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IROTH); }))) {
            mixin(enumMixinStr_S_IROTH);
        }
    }




    static if(!is(typeof(S_IWOTH))) {
        private enum enumMixinStr_S_IWOTH = `enum S_IWOTH = ( ( std.conv.octal!200 >> 3 ) >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IWOTH); }))) {
            mixin(enumMixinStr_S_IWOTH);
        }
    }




    static if(!is(typeof(S_IXOTH))) {
        private enum enumMixinStr_S_IXOTH = `enum S_IXOTH = ( ( std.conv.octal!100 >> 3 ) >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IXOTH); }))) {
            mixin(enumMixinStr_S_IXOTH);
        }
    }




    static if(!is(typeof(S_IRWXO))) {
        private enum enumMixinStr_S_IRWXO = `enum S_IRWXO = ( ( ( std.conv.octal!400 | std.conv.octal!200 | std.conv.octal!100 ) >> 3 ) >> 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_S_IRWXO); }))) {
            mixin(enumMixinStr_S_IRWXO);
        }
    }




    static if(!is(typeof(AF_CAIF))) {
        private enum enumMixinStr_AF_CAIF = `enum AF_CAIF = PF_CAIF;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_CAIF); }))) {
            mixin(enumMixinStr_AF_CAIF);
        }
    }




    static if(!is(typeof(R_OK))) {
        private enum enumMixinStr_R_OK = `enum R_OK = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_R_OK); }))) {
            mixin(enumMixinStr_R_OK);
        }
    }




    static if(!is(typeof(W_OK))) {
        private enum enumMixinStr_W_OK = `enum W_OK = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_W_OK); }))) {
            mixin(enumMixinStr_W_OK);
        }
    }




    static if(!is(typeof(X_OK))) {
        private enum enumMixinStr_X_OK = `enum X_OK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_X_OK); }))) {
            mixin(enumMixinStr_X_OK);
        }
    }




    static if(!is(typeof(F_OK))) {
        private enum enumMixinStr_F_OK = `enum F_OK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_F_OK); }))) {
            mixin(enumMixinStr_F_OK);
        }
    }




    static if(!is(typeof(AF_IEEE802154))) {
        private enum enumMixinStr_AF_IEEE802154 = `enum AF_IEEE802154 = PF_IEEE802154;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_IEEE802154); }))) {
            mixin(enumMixinStr_AF_IEEE802154);
        }
    }




    static if(!is(typeof(SEEK_SET))) {
        private enum enumMixinStr_SEEK_SET = `enum SEEK_SET = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_SEEK_SET); }))) {
            mixin(enumMixinStr_SEEK_SET);
        }
    }




    static if(!is(typeof(SEEK_CUR))) {
        private enum enumMixinStr_SEEK_CUR = `enum SEEK_CUR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_SEEK_CUR); }))) {
            mixin(enumMixinStr_SEEK_CUR);
        }
    }




    static if(!is(typeof(SEEK_END))) {
        private enum enumMixinStr_SEEK_END = `enum SEEK_END = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_SEEK_END); }))) {
            mixin(enumMixinStr_SEEK_END);
        }
    }




    static if(!is(typeof(AF_PHONET))) {
        private enum enumMixinStr_AF_PHONET = `enum AF_PHONET = PF_PHONET;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_PHONET); }))) {
            mixin(enumMixinStr_AF_PHONET);
        }
    }




    static if(!is(typeof(AT_FDCWD))) {
        private enum enumMixinStr_AT_FDCWD = `enum AT_FDCWD = - 100;`;
        static if(is(typeof({ mixin(enumMixinStr_AT_FDCWD); }))) {
            mixin(enumMixinStr_AT_FDCWD);
        }
    }




    static if(!is(typeof(AT_SYMLINK_NOFOLLOW))) {
        private enum enumMixinStr_AT_SYMLINK_NOFOLLOW = `enum AT_SYMLINK_NOFOLLOW = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_AT_SYMLINK_NOFOLLOW); }))) {
            mixin(enumMixinStr_AT_SYMLINK_NOFOLLOW);
        }
    }




    static if(!is(typeof(AT_REMOVEDIR))) {
        private enum enumMixinStr_AT_REMOVEDIR = `enum AT_REMOVEDIR = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_AT_REMOVEDIR); }))) {
            mixin(enumMixinStr_AT_REMOVEDIR);
        }
    }




    static if(!is(typeof(AT_SYMLINK_FOLLOW))) {
        private enum enumMixinStr_AT_SYMLINK_FOLLOW = `enum AT_SYMLINK_FOLLOW = 0x400;`;
        static if(is(typeof({ mixin(enumMixinStr_AT_SYMLINK_FOLLOW); }))) {
            mixin(enumMixinStr_AT_SYMLINK_FOLLOW);
        }
    }




    static if(!is(typeof(AT_EACCESS))) {
        private enum enumMixinStr_AT_EACCESS = `enum AT_EACCESS = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_AT_EACCESS); }))) {
            mixin(enumMixinStr_AT_EACCESS);
        }
    }




    static if(!is(typeof(AF_ISDN))) {
        private enum enumMixinStr_AF_ISDN = `enum AF_ISDN = PF_ISDN;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ISDN); }))) {
            mixin(enumMixinStr_AF_ISDN);
        }
    }




    static if(!is(typeof(AF_RXRPC))) {
        private enum enumMixinStr_AF_RXRPC = `enum AF_RXRPC = PF_RXRPC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_RXRPC); }))) {
            mixin(enumMixinStr_AF_RXRPC);
        }
    }




    static if(!is(typeof(AF_IUCV))) {
        private enum enumMixinStr_AF_IUCV = `enum AF_IUCV = PF_IUCV;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_IUCV); }))) {
            mixin(enumMixinStr_AF_IUCV);
        }
    }




    static if(!is(typeof(AF_BLUETOOTH))) {
        private enum enumMixinStr_AF_BLUETOOTH = `enum AF_BLUETOOTH = PF_BLUETOOTH;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_BLUETOOTH); }))) {
            mixin(enumMixinStr_AF_BLUETOOTH);
        }
    }




    static if(!is(typeof(AF_TIPC))) {
        private enum enumMixinStr_AF_TIPC = `enum AF_TIPC = PF_TIPC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_TIPC); }))) {
            mixin(enumMixinStr_AF_TIPC);
        }
    }




    static if(!is(typeof(AF_CAN))) {
        private enum enumMixinStr_AF_CAN = `enum AF_CAN = PF_CAN;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_CAN); }))) {
            mixin(enumMixinStr_AF_CAN);
        }
    }




    static if(!is(typeof(AF_MPLS))) {
        private enum enumMixinStr_AF_MPLS = `enum AF_MPLS = PF_MPLS;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_MPLS); }))) {
            mixin(enumMixinStr_AF_MPLS);
        }
    }




    static if(!is(typeof(AF_IB))) {
        private enum enumMixinStr_AF_IB = `enum AF_IB = PF_IB;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_IB); }))) {
            mixin(enumMixinStr_AF_IB);
        }
    }




    static if(!is(typeof(AF_LLC))) {
        private enum enumMixinStr_AF_LLC = `enum AF_LLC = PF_LLC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_LLC); }))) {
            mixin(enumMixinStr_AF_LLC);
        }
    }




    static if(!is(typeof(AF_WANPIPE))) {
        private enum enumMixinStr_AF_WANPIPE = `enum AF_WANPIPE = PF_WANPIPE;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_WANPIPE); }))) {
            mixin(enumMixinStr_AF_WANPIPE);
        }
    }




    static if(!is(typeof(F_ULOCK))) {
        private enum enumMixinStr_F_ULOCK = `enum F_ULOCK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_F_ULOCK); }))) {
            mixin(enumMixinStr_F_ULOCK);
        }
    }




    static if(!is(typeof(F_LOCK))) {
        private enum enumMixinStr_F_LOCK = `enum F_LOCK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_F_LOCK); }))) {
            mixin(enumMixinStr_F_LOCK);
        }
    }




    static if(!is(typeof(F_TLOCK))) {
        private enum enumMixinStr_F_TLOCK = `enum F_TLOCK = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_F_TLOCK); }))) {
            mixin(enumMixinStr_F_TLOCK);
        }
    }




    static if(!is(typeof(F_TEST))) {
        private enum enumMixinStr_F_TEST = `enum F_TEST = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_F_TEST); }))) {
            mixin(enumMixinStr_F_TEST);
        }
    }




    static if(!is(typeof(AF_PPPOX))) {
        private enum enumMixinStr_AF_PPPOX = `enum AF_PPPOX = PF_PPPOX;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_PPPOX); }))) {
            mixin(enumMixinStr_AF_PPPOX);
        }
    }




    static if(!is(typeof(AF_IRDA))) {
        private enum enumMixinStr_AF_IRDA = `enum AF_IRDA = PF_IRDA;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_IRDA); }))) {
            mixin(enumMixinStr_AF_IRDA);
        }
    }




    static if(!is(typeof(AF_SNA))) {
        private enum enumMixinStr_AF_SNA = `enum AF_SNA = PF_SNA;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_SNA); }))) {
            mixin(enumMixinStr_AF_SNA);
        }
    }




    static if(!is(typeof(AF_RDS))) {
        private enum enumMixinStr_AF_RDS = `enum AF_RDS = PF_RDS;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_RDS); }))) {
            mixin(enumMixinStr_AF_RDS);
        }
    }




    static if(!is(typeof(AF_ATMSVC))) {
        private enum enumMixinStr_AF_ATMSVC = `enum AF_ATMSVC = PF_ATMSVC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ATMSVC); }))) {
            mixin(enumMixinStr_AF_ATMSVC);
        }
    }




    static if(!is(typeof(AF_ECONET))) {
        private enum enumMixinStr_AF_ECONET = `enum AF_ECONET = PF_ECONET;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ECONET); }))) {
            mixin(enumMixinStr_AF_ECONET);
        }
    }




    static if(!is(typeof(AF_ASH))) {
        private enum enumMixinStr_AF_ASH = `enum AF_ASH = PF_ASH;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ASH); }))) {
            mixin(enumMixinStr_AF_ASH);
        }
    }




    static if(!is(typeof(AF_PACKET))) {
        private enum enumMixinStr_AF_PACKET = `enum AF_PACKET = PF_PACKET;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_PACKET); }))) {
            mixin(enumMixinStr_AF_PACKET);
        }
    }




    static if(!is(typeof(_FEATURES_H))) {
        private enum enumMixinStr__FEATURES_H = `enum _FEATURES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FEATURES_H); }))) {
            mixin(enumMixinStr__FEATURES_H);
        }
    }






    static if(!is(typeof(AF_ROUTE))) {
        private enum enumMixinStr_AF_ROUTE = `enum AF_ROUTE = PF_ROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ROUTE); }))) {
            mixin(enumMixinStr_AF_ROUTE);
        }
    }




    static if(!is(typeof(AF_NETLINK))) {
        private enum enumMixinStr_AF_NETLINK = `enum AF_NETLINK = PF_NETLINK;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_NETLINK); }))) {
            mixin(enumMixinStr_AF_NETLINK);
        }
    }






    static if(!is(typeof(AF_KEY))) {
        private enum enumMixinStr_AF_KEY = `enum AF_KEY = PF_KEY;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_KEY); }))) {
            mixin(enumMixinStr_AF_KEY);
        }
    }




    static if(!is(typeof(AF_SECURITY))) {
        private enum enumMixinStr_AF_SECURITY = `enum AF_SECURITY = PF_SECURITY;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_SECURITY); }))) {
            mixin(enumMixinStr_AF_SECURITY);
        }
    }
    static if(!is(typeof(_DEFAULT_SOURCE))) {
        private enum enumMixinStr__DEFAULT_SOURCE = `enum _DEFAULT_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__DEFAULT_SOURCE); }))) {
            mixin(enumMixinStr__DEFAULT_SOURCE);
        }
    }




    static if(!is(typeof(AF_NETBEUI))) {
        private enum enumMixinStr_AF_NETBEUI = `enum AF_NETBEUI = PF_NETBEUI;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_NETBEUI); }))) {
            mixin(enumMixinStr_AF_NETBEUI);
        }
    }




    static if(!is(typeof(AF_DECnet))) {
        private enum enumMixinStr_AF_DECnet = `enum AF_DECnet = PF_DECnet;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_DECnet); }))) {
            mixin(enumMixinStr_AF_DECnet);
        }
    }




    static if(!is(typeof(__USE_ISOC11))) {
        private enum enumMixinStr___USE_ISOC11 = `enum __USE_ISOC11 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC11); }))) {
            mixin(enumMixinStr___USE_ISOC11);
        }
    }




    static if(!is(typeof(AF_ROSE))) {
        private enum enumMixinStr_AF_ROSE = `enum AF_ROSE = PF_ROSE;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ROSE); }))) {
            mixin(enumMixinStr_AF_ROSE);
        }
    }




    static if(!is(typeof(AF_INET6))) {
        private enum enumMixinStr_AF_INET6 = `enum AF_INET6 = PF_INET6;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_INET6); }))) {
            mixin(enumMixinStr_AF_INET6);
        }
    }




    static if(!is(typeof(__USE_ISOC99))) {
        private enum enumMixinStr___USE_ISOC99 = `enum __USE_ISOC99 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC99); }))) {
            mixin(enumMixinStr___USE_ISOC99);
        }
    }




    static if(!is(typeof(AF_X25))) {
        private enum enumMixinStr_AF_X25 = `enum AF_X25 = PF_X25;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_X25); }))) {
            mixin(enumMixinStr_AF_X25);
        }
    }




    static if(!is(typeof(AF_ATMPVC))) {
        private enum enumMixinStr_AF_ATMPVC = `enum AF_ATMPVC = PF_ATMPVC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_ATMPVC); }))) {
            mixin(enumMixinStr_AF_ATMPVC);
        }
    }




    static if(!is(typeof(__USE_ISOC95))) {
        private enum enumMixinStr___USE_ISOC95 = `enum __USE_ISOC95 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC95); }))) {
            mixin(enumMixinStr___USE_ISOC95);
        }
    }




    static if(!is(typeof(AF_BRIDGE))) {
        private enum enumMixinStr_AF_BRIDGE = `enum AF_BRIDGE = PF_BRIDGE;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_BRIDGE); }))) {
            mixin(enumMixinStr_AF_BRIDGE);
        }
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        private enum enumMixinStr___USE_POSIX_IMPLICITLY = `enum __USE_POSIX_IMPLICITLY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX_IMPLICITLY); }))) {
            mixin(enumMixinStr___USE_POSIX_IMPLICITLY);
        }
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        private enum enumMixinStr__POSIX_SOURCE = `enum _POSIX_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_SOURCE);
        }
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        private enum enumMixinStr__POSIX_C_SOURCE = `enum _POSIX_C_SOURCE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_C_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_C_SOURCE);
        }
    }




    static if(!is(typeof(AF_NETROM))) {
        private enum enumMixinStr_AF_NETROM = `enum AF_NETROM = PF_NETROM;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_NETROM); }))) {
            mixin(enumMixinStr_AF_NETROM);
        }
    }




    static if(!is(typeof(AF_APPLETALK))) {
        private enum enumMixinStr_AF_APPLETALK = `enum AF_APPLETALK = PF_APPLETALK;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_APPLETALK); }))) {
            mixin(enumMixinStr_AF_APPLETALK);
        }
    }




    static if(!is(typeof(AF_IPX))) {
        private enum enumMixinStr_AF_IPX = `enum AF_IPX = PF_IPX;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_IPX); }))) {
            mixin(enumMixinStr_AF_IPX);
        }
    }




    static if(!is(typeof(AF_AX25))) {
        private enum enumMixinStr_AF_AX25 = `enum AF_AX25 = PF_AX25;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_AX25); }))) {
            mixin(enumMixinStr_AF_AX25);
        }
    }




    static if(!is(typeof(AF_INET))) {
        private enum enumMixinStr_AF_INET = `enum AF_INET = PF_INET;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_INET); }))) {
            mixin(enumMixinStr_AF_INET);
        }
    }




    static if(!is(typeof(AF_FILE))) {
        private enum enumMixinStr_AF_FILE = `enum AF_FILE = PF_FILE;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_FILE); }))) {
            mixin(enumMixinStr_AF_FILE);
        }
    }




    static if(!is(typeof(AF_UNIX))) {
        private enum enumMixinStr_AF_UNIX = `enum AF_UNIX = PF_UNIX;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_UNIX); }))) {
            mixin(enumMixinStr_AF_UNIX);
        }
    }




    static if(!is(typeof(__USE_POSIX))) {
        private enum enumMixinStr___USE_POSIX = `enum __USE_POSIX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX); }))) {
            mixin(enumMixinStr___USE_POSIX);
        }
    }




    static if(!is(typeof(AF_LOCAL))) {
        private enum enumMixinStr_AF_LOCAL = `enum AF_LOCAL = PF_LOCAL;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_LOCAL); }))) {
            mixin(enumMixinStr_AF_LOCAL);
        }
    }




    static if(!is(typeof(AF_UNSPEC))) {
        private enum enumMixinStr_AF_UNSPEC = `enum AF_UNSPEC = PF_UNSPEC;`;
        static if(is(typeof({ mixin(enumMixinStr_AF_UNSPEC); }))) {
            mixin(enumMixinStr_AF_UNSPEC);
        }
    }




    static if(!is(typeof(__USE_POSIX2))) {
        private enum enumMixinStr___USE_POSIX2 = `enum __USE_POSIX2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX2); }))) {
            mixin(enumMixinStr___USE_POSIX2);
        }
    }




    static if(!is(typeof(PF_MAX))) {
        private enum enumMixinStr_PF_MAX = `enum PF_MAX = 45;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_MAX); }))) {
            mixin(enumMixinStr_PF_MAX);
        }
    }




    static if(!is(typeof(PF_XDP))) {
        private enum enumMixinStr_PF_XDP = `enum PF_XDP = 44;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_XDP); }))) {
            mixin(enumMixinStr_PF_XDP);
        }
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        private enum enumMixinStr___USE_POSIX199309 = `enum __USE_POSIX199309 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199309); }))) {
            mixin(enumMixinStr___USE_POSIX199309);
        }
    }




    static if(!is(typeof(PF_SMC))) {
        private enum enumMixinStr_PF_SMC = `enum PF_SMC = 43;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_SMC); }))) {
            mixin(enumMixinStr_PF_SMC);
        }
    }




    static if(!is(typeof(PF_QIPCRTR))) {
        private enum enumMixinStr_PF_QIPCRTR = `enum PF_QIPCRTR = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_QIPCRTR); }))) {
            mixin(enumMixinStr_PF_QIPCRTR);
        }
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        private enum enumMixinStr___USE_POSIX199506 = `enum __USE_POSIX199506 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199506); }))) {
            mixin(enumMixinStr___USE_POSIX199506);
        }
    }




    static if(!is(typeof(PF_KCM))) {
        private enum enumMixinStr_PF_KCM = `enum PF_KCM = 41;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_KCM); }))) {
            mixin(enumMixinStr_PF_KCM);
        }
    }




    static if(!is(typeof(PF_VSOCK))) {
        private enum enumMixinStr_PF_VSOCK = `enum PF_VSOCK = 40;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_VSOCK); }))) {
            mixin(enumMixinStr_PF_VSOCK);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K))) {
        private enum enumMixinStr___USE_XOPEN2K = `enum __USE_XOPEN2K = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K); }))) {
            mixin(enumMixinStr___USE_XOPEN2K);
        }
    }




    static if(!is(typeof(PF_NFC))) {
        private enum enumMixinStr_PF_NFC = `enum PF_NFC = 39;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_NFC); }))) {
            mixin(enumMixinStr_PF_NFC);
        }
    }




    static if(!is(typeof(PF_ALG))) {
        private enum enumMixinStr_PF_ALG = `enum PF_ALG = 38;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ALG); }))) {
            mixin(enumMixinStr_PF_ALG);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        private enum enumMixinStr___USE_XOPEN2K8 = `enum __USE_XOPEN2K8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K8); }))) {
            mixin(enumMixinStr___USE_XOPEN2K8);
        }
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        private enum enumMixinStr__ATFILE_SOURCE = `enum _ATFILE_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ATFILE_SOURCE); }))) {
            mixin(enumMixinStr__ATFILE_SOURCE);
        }
    }




    static if(!is(typeof(PF_CAIF))) {
        private enum enumMixinStr_PF_CAIF = `enum PF_CAIF = 37;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_CAIF); }))) {
            mixin(enumMixinStr_PF_CAIF);
        }
    }




    static if(!is(typeof(__USE_MISC))) {
        private enum enumMixinStr___USE_MISC = `enum __USE_MISC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_MISC); }))) {
            mixin(enumMixinStr___USE_MISC);
        }
    }




    static if(!is(typeof(PF_IEEE802154))) {
        private enum enumMixinStr_PF_IEEE802154 = `enum PF_IEEE802154 = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_IEEE802154); }))) {
            mixin(enumMixinStr_PF_IEEE802154);
        }
    }




    static if(!is(typeof(__USE_ATFILE))) {
        private enum enumMixinStr___USE_ATFILE = `enum __USE_ATFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ATFILE); }))) {
            mixin(enumMixinStr___USE_ATFILE);
        }
    }




    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        private enum enumMixinStr___USE_FORTIFY_LEVEL = `enum __USE_FORTIFY_LEVEL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_FORTIFY_LEVEL); }))) {
            mixin(enumMixinStr___USE_FORTIFY_LEVEL);
        }
    }




    static if(!is(typeof(PF_PHONET))) {
        private enum enumMixinStr_PF_PHONET = `enum PF_PHONET = 35;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_PHONET); }))) {
            mixin(enumMixinStr_PF_PHONET);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_GETS))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_GETS = `enum __GLIBC_USE_DEPRECATED_GETS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS);
        }
    }




    static if(!is(typeof(PF_ISDN))) {
        private enum enumMixinStr_PF_ISDN = `enum PF_ISDN = 34;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ISDN); }))) {
            mixin(enumMixinStr_PF_ISDN);
        }
    }




    static if(!is(typeof(PF_RXRPC))) {
        private enum enumMixinStr_PF_RXRPC = `enum PF_RXRPC = 33;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_RXRPC); }))) {
            mixin(enumMixinStr_PF_RXRPC);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_SCANF))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_SCANF = `enum __GLIBC_USE_DEPRECATED_SCANF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF);
        }
    }




    static if(!is(typeof(PF_IUCV))) {
        private enum enumMixinStr_PF_IUCV = `enum PF_IUCV = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_IUCV); }))) {
            mixin(enumMixinStr_PF_IUCV);
        }
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        private enum enumMixinStr___GNU_LIBRARY__ = `enum __GNU_LIBRARY__ = 6;`;
        static if(is(typeof({ mixin(enumMixinStr___GNU_LIBRARY__); }))) {
            mixin(enumMixinStr___GNU_LIBRARY__);
        }
    }




    static if(!is(typeof(__GLIBC__))) {
        private enum enumMixinStr___GLIBC__ = `enum __GLIBC__ = 2;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC__); }))) {
            mixin(enumMixinStr___GLIBC__);
        }
    }




    static if(!is(typeof(__GLIBC_MINOR__))) {
        private enum enumMixinStr___GLIBC_MINOR__ = `enum __GLIBC_MINOR__ = 30;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_MINOR__); }))) {
            mixin(enumMixinStr___GLIBC_MINOR__);
        }
    }






    static if(!is(typeof(PF_BLUETOOTH))) {
        private enum enumMixinStr_PF_BLUETOOTH = `enum PF_BLUETOOTH = 31;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_BLUETOOTH); }))) {
            mixin(enumMixinStr_PF_BLUETOOTH);
        }
    }




    static if(!is(typeof(PF_TIPC))) {
        private enum enumMixinStr_PF_TIPC = `enum PF_TIPC = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_TIPC); }))) {
            mixin(enumMixinStr_PF_TIPC);
        }
    }




    static if(!is(typeof(PF_CAN))) {
        private enum enumMixinStr_PF_CAN = `enum PF_CAN = 29;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_CAN); }))) {
            mixin(enumMixinStr_PF_CAN);
        }
    }




    static if(!is(typeof(PF_MPLS))) {
        private enum enumMixinStr_PF_MPLS = `enum PF_MPLS = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_MPLS); }))) {
            mixin(enumMixinStr_PF_MPLS);
        }
    }




    static if(!is(typeof(PF_IB))) {
        private enum enumMixinStr_PF_IB = `enum PF_IB = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_IB); }))) {
            mixin(enumMixinStr_PF_IB);
        }
    }




    static if(!is(typeof(PF_LLC))) {
        private enum enumMixinStr_PF_LLC = `enum PF_LLC = 26;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_LLC); }))) {
            mixin(enumMixinStr_PF_LLC);
        }
    }
    static if(!is(typeof(PF_WANPIPE))) {
        private enum enumMixinStr_PF_WANPIPE = `enum PF_WANPIPE = 25;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_WANPIPE); }))) {
            mixin(enumMixinStr_PF_WANPIPE);
        }
    }




    static if(!is(typeof(PF_PPPOX))) {
        private enum enumMixinStr_PF_PPPOX = `enum PF_PPPOX = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_PPPOX); }))) {
            mixin(enumMixinStr_PF_PPPOX);
        }
    }




    static if(!is(typeof(PF_IRDA))) {
        private enum enumMixinStr_PF_IRDA = `enum PF_IRDA = 23;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_IRDA); }))) {
            mixin(enumMixinStr_PF_IRDA);
        }
    }




    static if(!is(typeof(PF_SNA))) {
        private enum enumMixinStr_PF_SNA = `enum PF_SNA = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_SNA); }))) {
            mixin(enumMixinStr_PF_SNA);
        }
    }




    static if(!is(typeof(PF_RDS))) {
        private enum enumMixinStr_PF_RDS = `enum PF_RDS = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_RDS); }))) {
            mixin(enumMixinStr_PF_RDS);
        }
    }






    static if(!is(typeof(PF_ATMSVC))) {
        private enum enumMixinStr_PF_ATMSVC = `enum PF_ATMSVC = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ATMSVC); }))) {
            mixin(enumMixinStr_PF_ATMSVC);
        }
    }




    static if(!is(typeof(PF_ECONET))) {
        private enum enumMixinStr_PF_ECONET = `enum PF_ECONET = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ECONET); }))) {
            mixin(enumMixinStr_PF_ECONET);
        }
    }




    static if(!is(typeof(PF_ASH))) {
        private enum enumMixinStr_PF_ASH = `enum PF_ASH = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ASH); }))) {
            mixin(enumMixinStr_PF_ASH);
        }
    }




    static if(!is(typeof(PF_PACKET))) {
        private enum enumMixinStr_PF_PACKET = `enum PF_PACKET = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_PACKET); }))) {
            mixin(enumMixinStr_PF_PACKET);
        }
    }




    static if(!is(typeof(PF_ROUTE))) {
        private enum enumMixinStr_PF_ROUTE = `enum PF_ROUTE = PF_NETLINK;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ROUTE); }))) {
            mixin(enumMixinStr_PF_ROUTE);
        }
    }




    static if(!is(typeof(PF_NETLINK))) {
        private enum enumMixinStr_PF_NETLINK = `enum PF_NETLINK = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_NETLINK); }))) {
            mixin(enumMixinStr_PF_NETLINK);
        }
    }




    static if(!is(typeof(PF_KEY))) {
        private enum enumMixinStr_PF_KEY = `enum PF_KEY = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_KEY); }))) {
            mixin(enumMixinStr_PF_KEY);
        }
    }




    static if(!is(typeof(PF_SECURITY))) {
        private enum enumMixinStr_PF_SECURITY = `enum PF_SECURITY = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_SECURITY); }))) {
            mixin(enumMixinStr_PF_SECURITY);
        }
    }




    static if(!is(typeof(PF_NETBEUI))) {
        private enum enumMixinStr_PF_NETBEUI = `enum PF_NETBEUI = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_NETBEUI); }))) {
            mixin(enumMixinStr_PF_NETBEUI);
        }
    }




    static if(!is(typeof(PF_DECnet))) {
        private enum enumMixinStr_PF_DECnet = `enum PF_DECnet = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_DECnet); }))) {
            mixin(enumMixinStr_PF_DECnet);
        }
    }




    static if(!is(typeof(PF_ROSE))) {
        private enum enumMixinStr_PF_ROSE = `enum PF_ROSE = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ROSE); }))) {
            mixin(enumMixinStr_PF_ROSE);
        }
    }




    static if(!is(typeof(PF_INET6))) {
        private enum enumMixinStr_PF_INET6 = `enum PF_INET6 = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_INET6); }))) {
            mixin(enumMixinStr_PF_INET6);
        }
    }




    static if(!is(typeof(PF_X25))) {
        private enum enumMixinStr_PF_X25 = `enum PF_X25 = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_X25); }))) {
            mixin(enumMixinStr_PF_X25);
        }
    }




    static if(!is(typeof(NL_CB_KIND_MAX))) {
        private enum enumMixinStr_NL_CB_KIND_MAX = `enum NL_CB_KIND_MAX = ( __NL_CB_KIND_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NL_CB_KIND_MAX); }))) {
            mixin(enumMixinStr_NL_CB_KIND_MAX);
        }
    }




    static if(!is(typeof(PF_ATMPVC))) {
        private enum enumMixinStr_PF_ATMPVC = `enum PF_ATMPVC = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_ATMPVC); }))) {
            mixin(enumMixinStr_PF_ATMPVC);
        }
    }




    static if(!is(typeof(NL_CB_TYPE_MAX))) {
        private enum enumMixinStr_NL_CB_TYPE_MAX = `enum NL_CB_TYPE_MAX = ( __NL_CB_TYPE_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NL_CB_TYPE_MAX); }))) {
            mixin(enumMixinStr_NL_CB_TYPE_MAX);
        }
    }




    static if(!is(typeof(PF_BRIDGE))) {
        private enum enumMixinStr_PF_BRIDGE = `enum PF_BRIDGE = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_BRIDGE); }))) {
            mixin(enumMixinStr_PF_BRIDGE);
        }
    }




    static if(!is(typeof(PF_NETROM))) {
        private enum enumMixinStr_PF_NETROM = `enum PF_NETROM = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_NETROM); }))) {
            mixin(enumMixinStr_PF_NETROM);
        }
    }




    static if(!is(typeof(PF_APPLETALK))) {
        private enum enumMixinStr_PF_APPLETALK = `enum PF_APPLETALK = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_APPLETALK); }))) {
            mixin(enumMixinStr_PF_APPLETALK);
        }
    }




    static if(!is(typeof(PF_IPX))) {
        private enum enumMixinStr_PF_IPX = `enum PF_IPX = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_IPX); }))) {
            mixin(enumMixinStr_PF_IPX);
        }
    }




    static if(!is(typeof(PF_AX25))) {
        private enum enumMixinStr_PF_AX25 = `enum PF_AX25 = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_AX25); }))) {
            mixin(enumMixinStr_PF_AX25);
        }
    }




    static if(!is(typeof(PF_INET))) {
        private enum enumMixinStr_PF_INET = `enum PF_INET = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_INET); }))) {
            mixin(enumMixinStr_PF_INET);
        }
    }




    static if(!is(typeof(PF_FILE))) {
        private enum enumMixinStr_PF_FILE = `enum PF_FILE = PF_LOCAL;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_FILE); }))) {
            mixin(enumMixinStr_PF_FILE);
        }
    }




    static if(!is(typeof(PF_UNIX))) {
        private enum enumMixinStr_PF_UNIX = `enum PF_UNIX = PF_LOCAL;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_UNIX); }))) {
            mixin(enumMixinStr_PF_UNIX);
        }
    }




    static if(!is(typeof(PF_LOCAL))) {
        private enum enumMixinStr_PF_LOCAL = `enum PF_LOCAL = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_LOCAL); }))) {
            mixin(enumMixinStr_PF_LOCAL);
        }
    }




    static if(!is(typeof(PF_UNSPEC))) {
        private enum enumMixinStr_PF_UNSPEC = `enum PF_UNSPEC = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_PF_UNSPEC); }))) {
            mixin(enumMixinStr_PF_UNSPEC);
        }
    }
    static if(!is(typeof(_SS_SIZE))) {
        private enum enumMixinStr__SS_SIZE = `enum _SS_SIZE = 128;`;
        static if(is(typeof({ mixin(enumMixinStr__SS_SIZE); }))) {
            mixin(enumMixinStr__SS_SIZE);
        }
    }




    static if(!is(typeof(ARPHRD_INFINIBAND))) {
        private enum enumMixinStr_ARPHRD_INFINIBAND = `enum ARPHRD_INFINIBAND = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_ARPHRD_INFINIBAND); }))) {
            mixin(enumMixinStr_ARPHRD_INFINIBAND);
        }
    }




    static if(!is(typeof(ETH_P_MPLS_UC))) {
        private enum enumMixinStr_ETH_P_MPLS_UC = `enum ETH_P_MPLS_UC = 0x8847;`;
        static if(is(typeof({ mixin(enumMixinStr_ETH_P_MPLS_UC); }))) {
            mixin(enumMixinStr_ETH_P_MPLS_UC);
        }
    }




    static if(!is(typeof(ETH_P_MPLS_MC))) {
        private enum enumMixinStr_ETH_P_MPLS_MC = `enum ETH_P_MPLS_MC = 0x8848;`;
        static if(is(typeof({ mixin(enumMixinStr_ETH_P_MPLS_MC); }))) {
            mixin(enumMixinStr_ETH_P_MPLS_MC);
        }
    }




    static if(!is(typeof(ETH_P_EDP2))) {
        private enum enumMixinStr_ETH_P_EDP2 = `enum ETH_P_EDP2 = 0x88A2;`;
        static if(is(typeof({ mixin(enumMixinStr_ETH_P_EDP2); }))) {
            mixin(enumMixinStr_ETH_P_EDP2);
        }
    }




    static if(!is(typeof(ETH_P_HDLC))) {
        private enum enumMixinStr_ETH_P_HDLC = `enum ETH_P_HDLC = 0x0019;`;
        static if(is(typeof({ mixin(enumMixinStr_ETH_P_HDLC); }))) {
            mixin(enumMixinStr_ETH_P_HDLC);
        }
    }




    static if(!is(typeof(__SOCKADDR_COMMON_SIZE))) {
        private enum enumMixinStr___SOCKADDR_COMMON_SIZE = `enum __SOCKADDR_COMMON_SIZE = ( ( unsigned short int ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr___SOCKADDR_COMMON_SIZE); }))) {
            mixin(enumMixinStr___SOCKADDR_COMMON_SIZE);
        }
    }
    static if(!is(typeof(_BITS_SOCKADDR_H))) {
        private enum enumMixinStr__BITS_SOCKADDR_H = `enum _BITS_SOCKADDR_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_SOCKADDR_H); }))) {
            mixin(enumMixinStr__BITS_SOCKADDR_H);
        }
    }
    static if(!is(typeof(__FD_ZERO_STOS))) {
        private enum enumMixinStr___FD_ZERO_STOS = `enum __FD_ZERO_STOS = "stosq";`;
        static if(is(typeof({ mixin(enumMixinStr___FD_ZERO_STOS); }))) {
            mixin(enumMixinStr___FD_ZERO_STOS);
        }
    }




    static if(!is(typeof(__have_pthread_attr_t))) {
        private enum enumMixinStr___have_pthread_attr_t = `enum __have_pthread_attr_t = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___have_pthread_attr_t); }))) {
            mixin(enumMixinStr___have_pthread_attr_t);
        }
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_COMMON_H))) {
        private enum enumMixinStr__BITS_PTHREADTYPES_COMMON_H = `enum _BITS_PTHREADTYPES_COMMON_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_PTHREADTYPES_COMMON_H); }))) {
            mixin(enumMixinStr__BITS_PTHREADTYPES_COMMON_H);
        }
    }




    static if(!is(typeof(__PTHREAD_RWLOCK_INT_FLAGS_SHARED))) {
        private enum enumMixinStr___PTHREAD_RWLOCK_INT_FLAGS_SHARED = `enum __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_RWLOCK_INT_FLAGS_SHARED); }))) {
            mixin(enumMixinStr___PTHREAD_RWLOCK_INT_FLAGS_SHARED);
        }
    }




    static if(!is(typeof(__PTHREAD_RWLOCK_ELISION_EXTRA))) {
        private enum enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA = `enum __PTHREAD_RWLOCK_ELISION_EXTRA = 0 , { 0 , 0 , 0 , 0 , 0 , 0 , 0 };`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA); }))) {
            mixin(enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA);
        }
    }
    static if(!is(typeof(__PTHREAD_MUTEX_USE_UNION))) {
        private enum enumMixinStr___PTHREAD_MUTEX_USE_UNION = `enum __PTHREAD_MUTEX_USE_UNION = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_MUTEX_USE_UNION); }))) {
            mixin(enumMixinStr___PTHREAD_MUTEX_USE_UNION);
        }
    }




    static if(!is(typeof(__PTHREAD_MUTEX_NUSERS_AFTER_KIND))) {
        private enum enumMixinStr___PTHREAD_MUTEX_NUSERS_AFTER_KIND = `enum __PTHREAD_MUTEX_NUSERS_AFTER_KIND = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_MUTEX_NUSERS_AFTER_KIND); }))) {
            mixin(enumMixinStr___PTHREAD_MUTEX_NUSERS_AFTER_KIND);
        }
    }




    static if(!is(typeof(__PTHREAD_MUTEX_LOCK_ELISION))) {
        private enum enumMixinStr___PTHREAD_MUTEX_LOCK_ELISION = `enum __PTHREAD_MUTEX_LOCK_ELISION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_MUTEX_LOCK_ELISION); }))) {
            mixin(enumMixinStr___PTHREAD_MUTEX_LOCK_ELISION);
        }
    }
    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T = `enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T = `enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T = `enum __SIZEOF_PTHREAD_CONDATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_COND_T = `enum __SIZEOF_PTHREAD_COND_T = 48;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_COND_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_COND_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T = `enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_BARRIER_T = `enum __SIZEOF_PTHREAD_BARRIER_T = 32;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIER_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIER_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T = `enum __SIZEOF_PTHREAD_RWLOCK_T = 56;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_MUTEX_T = `enum __SIZEOF_PTHREAD_MUTEX_T = 40;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEX_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEX_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_ATTR_T = `enum __SIZEOF_PTHREAD_ATTR_T = 56;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_ATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_ATTR_T);
        }
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_ARCH_H))) {
        private enum enumMixinStr__BITS_PTHREADTYPES_ARCH_H = `enum _BITS_PTHREADTYPES_ARCH_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_PTHREADTYPES_ARCH_H); }))) {
            mixin(enumMixinStr__BITS_PTHREADTYPES_ARCH_H);
        }
    }




    static if(!is(typeof(_POSIX_TYPED_MEMORY_OBJECTS))) {
        private enum enumMixinStr__POSIX_TYPED_MEMORY_OBJECTS = `enum _POSIX_TYPED_MEMORY_OBJECTS = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TYPED_MEMORY_OBJECTS); }))) {
            mixin(enumMixinStr__POSIX_TYPED_MEMORY_OBJECTS);
        }
    }




    static if(!is(typeof(_POSIX_TRACE_LOG))) {
        private enum enumMixinStr__POSIX_TRACE_LOG = `enum _POSIX_TRACE_LOG = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TRACE_LOG); }))) {
            mixin(enumMixinStr__POSIX_TRACE_LOG);
        }
    }




    static if(!is(typeof(_POSIX_TRACE_INHERIT))) {
        private enum enumMixinStr__POSIX_TRACE_INHERIT = `enum _POSIX_TRACE_INHERIT = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TRACE_INHERIT); }))) {
            mixin(enumMixinStr__POSIX_TRACE_INHERIT);
        }
    }




    static if(!is(typeof(_POSIX_TRACE_EVENT_FILTER))) {
        private enum enumMixinStr__POSIX_TRACE_EVENT_FILTER = `enum _POSIX_TRACE_EVENT_FILTER = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TRACE_EVENT_FILTER); }))) {
            mixin(enumMixinStr__POSIX_TRACE_EVENT_FILTER);
        }
    }




    static if(!is(typeof(_POSIX_TRACE))) {
        private enum enumMixinStr__POSIX_TRACE = `enum _POSIX_TRACE = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TRACE); }))) {
            mixin(enumMixinStr__POSIX_TRACE);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_SPORADIC_SERVER))) {
        private enum enumMixinStr__POSIX_THREAD_SPORADIC_SERVER = `enum _POSIX_THREAD_SPORADIC_SERVER = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_SPORADIC_SERVER); }))) {
            mixin(enumMixinStr__POSIX_THREAD_SPORADIC_SERVER);
        }
    }






    static if(!is(typeof(_POSIX_SPORADIC_SERVER))) {
        private enum enumMixinStr__POSIX_SPORADIC_SERVER = `enum _POSIX_SPORADIC_SERVER = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SPORADIC_SERVER); }))) {
            mixin(enumMixinStr__POSIX_SPORADIC_SERVER);
        }
    }




    static if(!is(typeof(_POSIX2_CHAR_TERM))) {
        private enum enumMixinStr__POSIX2_CHAR_TERM = `enum _POSIX2_CHAR_TERM = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_CHAR_TERM); }))) {
            mixin(enumMixinStr__POSIX2_CHAR_TERM);
        }
    }




    static if(!is(typeof(NL_DUMP_MAX))) {
        private enum enumMixinStr_NL_DUMP_MAX = `enum NL_DUMP_MAX = ( __NL_DUMP_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NL_DUMP_MAX); }))) {
            mixin(enumMixinStr_NL_DUMP_MAX);
        }
    }




    static if(!is(typeof(_POSIX_RAW_SOCKETS))) {
        private enum enumMixinStr__POSIX_RAW_SOCKETS = `enum _POSIX_RAW_SOCKETS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_RAW_SOCKETS); }))) {
            mixin(enumMixinStr__POSIX_RAW_SOCKETS);
        }
    }




    static if(!is(typeof(_POSIX_IPV6))) {
        private enum enumMixinStr__POSIX_IPV6 = `enum _POSIX_IPV6 = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_IPV6); }))) {
            mixin(enumMixinStr__POSIX_IPV6);
        }
    }






    static if(!is(typeof(_POSIX_ADVISORY_INFO))) {
        private enum enumMixinStr__POSIX_ADVISORY_INFO = `enum _POSIX_ADVISORY_INFO = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_ADVISORY_INFO); }))) {
            mixin(enumMixinStr__POSIX_ADVISORY_INFO);
        }
    }




    static if(!is(typeof(_POSIX_CLOCK_SELECTION))) {
        private enum enumMixinStr__POSIX_CLOCK_SELECTION = `enum _POSIX_CLOCK_SELECTION = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_CLOCK_SELECTION); }))) {
            mixin(enumMixinStr__POSIX_CLOCK_SELECTION);
        }
    }




    static if(!is(typeof(_POSIX_MONOTONIC_CLOCK))) {
        private enum enumMixinStr__POSIX_MONOTONIC_CLOCK = `enum _POSIX_MONOTONIC_CLOCK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_MONOTONIC_CLOCK); }))) {
            mixin(enumMixinStr__POSIX_MONOTONIC_CLOCK);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_PROCESS_SHARED))) {
        private enum enumMixinStr__POSIX_THREAD_PROCESS_SHARED = `enum _POSIX_THREAD_PROCESS_SHARED = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_PROCESS_SHARED); }))) {
            mixin(enumMixinStr__POSIX_THREAD_PROCESS_SHARED);
        }
    }




    static if(!is(typeof(IFA_MAX))) {
        private enum enumMixinStr_IFA_MAX = `enum IFA_MAX = ( __IFA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_MAX); }))) {
            mixin(enumMixinStr_IFA_MAX);
        }
    }




    static if(!is(typeof(IFA_F_SECONDARY))) {
        private enum enumMixinStr_IFA_F_SECONDARY = `enum IFA_F_SECONDARY = 0x01;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_SECONDARY); }))) {
            mixin(enumMixinStr_IFA_F_SECONDARY);
        }
    }




    static if(!is(typeof(IFA_F_TEMPORARY))) {
        private enum enumMixinStr_IFA_F_TEMPORARY = `enum IFA_F_TEMPORARY = 0x01;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_TEMPORARY); }))) {
            mixin(enumMixinStr_IFA_F_TEMPORARY);
        }
    }




    static if(!is(typeof(IFA_F_NODAD))) {
        private enum enumMixinStr_IFA_F_NODAD = `enum IFA_F_NODAD = 0x02;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_NODAD); }))) {
            mixin(enumMixinStr_IFA_F_NODAD);
        }
    }




    static if(!is(typeof(IFA_F_OPTIMISTIC))) {
        private enum enumMixinStr_IFA_F_OPTIMISTIC = `enum IFA_F_OPTIMISTIC = 0x04;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_OPTIMISTIC); }))) {
            mixin(enumMixinStr_IFA_F_OPTIMISTIC);
        }
    }




    static if(!is(typeof(IFA_F_DADFAILED))) {
        private enum enumMixinStr_IFA_F_DADFAILED = `enum IFA_F_DADFAILED = 0x08;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_DADFAILED); }))) {
            mixin(enumMixinStr_IFA_F_DADFAILED);
        }
    }




    static if(!is(typeof(IFA_F_HOMEADDRESS))) {
        private enum enumMixinStr_IFA_F_HOMEADDRESS = `enum IFA_F_HOMEADDRESS = 0x10;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_HOMEADDRESS); }))) {
            mixin(enumMixinStr_IFA_F_HOMEADDRESS);
        }
    }




    static if(!is(typeof(IFA_F_DEPRECATED))) {
        private enum enumMixinStr_IFA_F_DEPRECATED = `enum IFA_F_DEPRECATED = 0x20;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_DEPRECATED); }))) {
            mixin(enumMixinStr_IFA_F_DEPRECATED);
        }
    }




    static if(!is(typeof(IFA_F_TENTATIVE))) {
        private enum enumMixinStr_IFA_F_TENTATIVE = `enum IFA_F_TENTATIVE = 0x40;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_TENTATIVE); }))) {
            mixin(enumMixinStr_IFA_F_TENTATIVE);
        }
    }




    static if(!is(typeof(IFA_F_PERMANENT))) {
        private enum enumMixinStr_IFA_F_PERMANENT = `enum IFA_F_PERMANENT = 0x80;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_PERMANENT); }))) {
            mixin(enumMixinStr_IFA_F_PERMANENT);
        }
    }




    static if(!is(typeof(IFA_F_MANAGETEMPADDR))) {
        private enum enumMixinStr_IFA_F_MANAGETEMPADDR = `enum IFA_F_MANAGETEMPADDR = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_MANAGETEMPADDR); }))) {
            mixin(enumMixinStr_IFA_F_MANAGETEMPADDR);
        }
    }




    static if(!is(typeof(IFA_F_NOPREFIXROUTE))) {
        private enum enumMixinStr_IFA_F_NOPREFIXROUTE = `enum IFA_F_NOPREFIXROUTE = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_NOPREFIXROUTE); }))) {
            mixin(enumMixinStr_IFA_F_NOPREFIXROUTE);
        }
    }




    static if(!is(typeof(IFA_F_MCAUTOJOIN))) {
        private enum enumMixinStr_IFA_F_MCAUTOJOIN = `enum IFA_F_MCAUTOJOIN = 0x400;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_MCAUTOJOIN); }))) {
            mixin(enumMixinStr_IFA_F_MCAUTOJOIN);
        }
    }




    static if(!is(typeof(IFA_F_STABLE_PRIVACY))) {
        private enum enumMixinStr_IFA_F_STABLE_PRIVACY = `enum IFA_F_STABLE_PRIVACY = 0x800;`;
        static if(is(typeof({ mixin(enumMixinStr_IFA_F_STABLE_PRIVACY); }))) {
            mixin(enumMixinStr_IFA_F_STABLE_PRIVACY);
        }
    }




    static if(!is(typeof(_POSIX_MESSAGE_PASSING))) {
        private enum enumMixinStr__POSIX_MESSAGE_PASSING = `enum _POSIX_MESSAGE_PASSING = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_MESSAGE_PASSING); }))) {
            mixin(enumMixinStr__POSIX_MESSAGE_PASSING);
        }
    }
    static if(!is(typeof(_POSIX_BARRIERS))) {
        private enum enumMixinStr__POSIX_BARRIERS = `enum _POSIX_BARRIERS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_BARRIERS); }))) {
            mixin(enumMixinStr__POSIX_BARRIERS);
        }
    }




    static if(!is(typeof(_POSIX_TIMERS))) {
        private enum enumMixinStr__POSIX_TIMERS = `enum _POSIX_TIMERS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TIMERS); }))) {
            mixin(enumMixinStr__POSIX_TIMERS);
        }
    }




    static if(!is(typeof(_POSIX_SPAWN))) {
        private enum enumMixinStr__POSIX_SPAWN = `enum _POSIX_SPAWN = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SPAWN); }))) {
            mixin(enumMixinStr__POSIX_SPAWN);
        }
    }




    static if(!is(typeof(_POSIX_SPIN_LOCKS))) {
        private enum enumMixinStr__POSIX_SPIN_LOCKS = `enum _POSIX_SPIN_LOCKS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SPIN_LOCKS); }))) {
            mixin(enumMixinStr__POSIX_SPIN_LOCKS);
        }
    }




    static if(!is(typeof(_POSIX_TIMEOUTS))) {
        private enum enumMixinStr__POSIX_TIMEOUTS = `enum _POSIX_TIMEOUTS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_TIMEOUTS); }))) {
            mixin(enumMixinStr__POSIX_TIMEOUTS);
        }
    }




    static if(!is(typeof(_POSIX_SHELL))) {
        private enum enumMixinStr__POSIX_SHELL = `enum _POSIX_SHELL = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SHELL); }))) {
            mixin(enumMixinStr__POSIX_SHELL);
        }
    }




    static if(!is(typeof(IFLA_COST))) {
        private enum enumMixinStr_IFLA_COST = `enum IFLA_COST = IFLA_COST;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_COST); }))) {
            mixin(enumMixinStr_IFLA_COST);
        }
    }




    static if(!is(typeof(IFLA_PRIORITY))) {
        private enum enumMixinStr_IFLA_PRIORITY = `enum IFLA_PRIORITY = IFLA_PRIORITY;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_PRIORITY); }))) {
            mixin(enumMixinStr_IFLA_PRIORITY);
        }
    }




    static if(!is(typeof(IFLA_MASTER))) {
        private enum enumMixinStr_IFLA_MASTER = `enum IFLA_MASTER = IFLA_MASTER;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_MASTER); }))) {
            mixin(enumMixinStr_IFLA_MASTER);
        }
    }




    static if(!is(typeof(IFLA_WIRELESS))) {
        private enum enumMixinStr_IFLA_WIRELESS = `enum IFLA_WIRELESS = IFLA_WIRELESS;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_WIRELESS); }))) {
            mixin(enumMixinStr_IFLA_WIRELESS);
        }
    }




    static if(!is(typeof(IFLA_PROTINFO))) {
        private enum enumMixinStr_IFLA_PROTINFO = `enum IFLA_PROTINFO = IFLA_PROTINFO;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_PROTINFO); }))) {
            mixin(enumMixinStr_IFLA_PROTINFO);
        }
    }




    static if(!is(typeof(IFLA_TXQLEN))) {
        private enum enumMixinStr_IFLA_TXQLEN = `enum IFLA_TXQLEN = IFLA_TXQLEN;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_TXQLEN); }))) {
            mixin(enumMixinStr_IFLA_TXQLEN);
        }
    }




    static if(!is(typeof(IFLA_MAP))) {
        private enum enumMixinStr_IFLA_MAP = `enum IFLA_MAP = IFLA_MAP;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_MAP); }))) {
            mixin(enumMixinStr_IFLA_MAP);
        }
    }




    static if(!is(typeof(IFLA_WEIGHT))) {
        private enum enumMixinStr_IFLA_WEIGHT = `enum IFLA_WEIGHT = IFLA_WEIGHT;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_WEIGHT); }))) {
            mixin(enumMixinStr_IFLA_WEIGHT);
        }
    }




    static if(!is(typeof(IFLA_LINKINFO))) {
        private enum enumMixinStr_IFLA_LINKINFO = `enum IFLA_LINKINFO = IFLA_LINKINFO;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_LINKINFO); }))) {
            mixin(enumMixinStr_IFLA_LINKINFO);
        }
    }




    static if(!is(typeof(IFLA_PROMISCUITY))) {
        private enum enumMixinStr_IFLA_PROMISCUITY = `enum IFLA_PROMISCUITY = IFLA_PROMISCUITY;`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_PROMISCUITY); }))) {
            mixin(enumMixinStr_IFLA_PROMISCUITY);
        }
    }




    static if(!is(typeof(IFLA_MAX))) {
        private enum enumMixinStr_IFLA_MAX = `enum IFLA_MAX = ( __IFLA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_MAX); }))) {
            mixin(enumMixinStr_IFLA_MAX);
        }
    }
    static if(!is(typeof(_POSIX_READER_WRITER_LOCKS))) {
        private enum enumMixinStr__POSIX_READER_WRITER_LOCKS = `enum _POSIX_READER_WRITER_LOCKS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_READER_WRITER_LOCKS); }))) {
            mixin(enumMixinStr__POSIX_READER_WRITER_LOCKS);
        }
    }




    static if(!is(typeof(IFLA_INET_MAX))) {
        private enum enumMixinStr_IFLA_INET_MAX = `enum IFLA_INET_MAX = ( __IFLA_INET_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_INET_MAX); }))) {
            mixin(enumMixinStr_IFLA_INET_MAX);
        }
    }




    static if(!is(typeof(_POSIX_REGEXP))) {
        private enum enumMixinStr__POSIX_REGEXP = `enum _POSIX_REGEXP = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_REGEXP); }))) {
            mixin(enumMixinStr__POSIX_REGEXP);
        }
    }




    static if(!is(typeof(IFLA_INET6_MAX))) {
        private enum enumMixinStr_IFLA_INET6_MAX = `enum IFLA_INET6_MAX = ( __IFLA_INET6_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_INET6_MAX); }))) {
            mixin(enumMixinStr_IFLA_INET6_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_CPUTIME))) {
        private enum enumMixinStr__POSIX_THREAD_CPUTIME = `enum _POSIX_THREAD_CPUTIME = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_CPUTIME); }))) {
            mixin(enumMixinStr__POSIX_THREAD_CPUTIME);
        }
    }




    static if(!is(typeof(_POSIX_CPUTIME))) {
        private enum enumMixinStr__POSIX_CPUTIME = `enum _POSIX_CPUTIME = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_CPUTIME); }))) {
            mixin(enumMixinStr__POSIX_CPUTIME);
        }
    }




    static if(!is(typeof(IFLA_BR_MAX))) {
        private enum enumMixinStr_IFLA_BR_MAX = `enum IFLA_BR_MAX = ( __IFLA_BR_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_BR_MAX); }))) {
            mixin(enumMixinStr_IFLA_BR_MAX);
        }
    }




    static if(!is(typeof(_POSIX_SHARED_MEMORY_OBJECTS))) {
        private enum enumMixinStr__POSIX_SHARED_MEMORY_OBJECTS = `enum _POSIX_SHARED_MEMORY_OBJECTS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SHARED_MEMORY_OBJECTS); }))) {
            mixin(enumMixinStr__POSIX_SHARED_MEMORY_OBJECTS);
        }
    }




    static if(!is(typeof(_LFS64_STDIO))) {
        private enum enumMixinStr__LFS64_STDIO = `enum _LFS64_STDIO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__LFS64_STDIO); }))) {
            mixin(enumMixinStr__LFS64_STDIO);
        }
    }




    static if(!is(typeof(_LFS64_LARGEFILE))) {
        private enum enumMixinStr__LFS64_LARGEFILE = `enum _LFS64_LARGEFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__LFS64_LARGEFILE); }))) {
            mixin(enumMixinStr__LFS64_LARGEFILE);
        }
    }




    static if(!is(typeof(IFLA_BRPORT_MAX))) {
        private enum enumMixinStr_IFLA_BRPORT_MAX = `enum IFLA_BRPORT_MAX = ( __IFLA_BRPORT_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_BRPORT_MAX); }))) {
            mixin(enumMixinStr_IFLA_BRPORT_MAX);
        }
    }




    static if(!is(typeof(_LFS_LARGEFILE))) {
        private enum enumMixinStr__LFS_LARGEFILE = `enum _LFS_LARGEFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__LFS_LARGEFILE); }))) {
            mixin(enumMixinStr__LFS_LARGEFILE);
        }
    }




    static if(!is(typeof(_LFS64_ASYNCHRONOUS_IO))) {
        private enum enumMixinStr__LFS64_ASYNCHRONOUS_IO = `enum _LFS64_ASYNCHRONOUS_IO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__LFS64_ASYNCHRONOUS_IO); }))) {
            mixin(enumMixinStr__LFS64_ASYNCHRONOUS_IO);
        }
    }




    static if(!is(typeof(IFLA_INFO_MAX))) {
        private enum enumMixinStr_IFLA_INFO_MAX = `enum IFLA_INFO_MAX = ( __IFLA_INFO_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_INFO_MAX); }))) {
            mixin(enumMixinStr_IFLA_INFO_MAX);
        }
    }




    static if(!is(typeof(_POSIX_PRIORITIZED_IO))) {
        private enum enumMixinStr__POSIX_PRIORITIZED_IO = `enum _POSIX_PRIORITIZED_IO = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_PRIORITIZED_IO); }))) {
            mixin(enumMixinStr__POSIX_PRIORITIZED_IO);
        }
    }




    static if(!is(typeof(IFLA_VLAN_MAX))) {
        private enum enumMixinStr_IFLA_VLAN_MAX = `enum IFLA_VLAN_MAX = ( __IFLA_VLAN_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VLAN_MAX); }))) {
            mixin(enumMixinStr_IFLA_VLAN_MAX);
        }
    }




    static if(!is(typeof(_LFS_ASYNCHRONOUS_IO))) {
        private enum enumMixinStr__LFS_ASYNCHRONOUS_IO = `enum _LFS_ASYNCHRONOUS_IO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__LFS_ASYNCHRONOUS_IO); }))) {
            mixin(enumMixinStr__LFS_ASYNCHRONOUS_IO);
        }
    }




    static if(!is(typeof(_POSIX_ASYNC_IO))) {
        private enum enumMixinStr__POSIX_ASYNC_IO = `enum _POSIX_ASYNC_IO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_ASYNC_IO); }))) {
            mixin(enumMixinStr__POSIX_ASYNC_IO);
        }
    }




    static if(!is(typeof(IFLA_VLAN_QOS_MAX))) {
        private enum enumMixinStr_IFLA_VLAN_QOS_MAX = `enum IFLA_VLAN_QOS_MAX = ( __IFLA_VLAN_QOS_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VLAN_QOS_MAX); }))) {
            mixin(enumMixinStr_IFLA_VLAN_QOS_MAX);
        }
    }




    static if(!is(typeof(_POSIX_ASYNCHRONOUS_IO))) {
        private enum enumMixinStr__POSIX_ASYNCHRONOUS_IO = `enum _POSIX_ASYNCHRONOUS_IO = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_ASYNCHRONOUS_IO); }))) {
            mixin(enumMixinStr__POSIX_ASYNCHRONOUS_IO);
        }
    }




    static if(!is(typeof(_POSIX_REALTIME_SIGNALS))) {
        private enum enumMixinStr__POSIX_REALTIME_SIGNALS = `enum _POSIX_REALTIME_SIGNALS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_REALTIME_SIGNALS); }))) {
            mixin(enumMixinStr__POSIX_REALTIME_SIGNALS);
        }
    }




    static if(!is(typeof(IFLA_MACVLAN_MAX))) {
        private enum enumMixinStr_IFLA_MACVLAN_MAX = `enum IFLA_MACVLAN_MAX = ( __IFLA_MACVLAN_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_MACVLAN_MAX); }))) {
            mixin(enumMixinStr_IFLA_MACVLAN_MAX);
        }
    }




    static if(!is(typeof(_POSIX_SEMAPHORES))) {
        private enum enumMixinStr__POSIX_SEMAPHORES = `enum _POSIX_SEMAPHORES = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SEMAPHORES); }))) {
            mixin(enumMixinStr__POSIX_SEMAPHORES);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_ROBUST_PRIO_PROTECT))) {
        private enum enumMixinStr__POSIX_THREAD_ROBUST_PRIO_PROTECT = `enum _POSIX_THREAD_ROBUST_PRIO_PROTECT = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_ROBUST_PRIO_PROTECT); }))) {
            mixin(enumMixinStr__POSIX_THREAD_ROBUST_PRIO_PROTECT);
        }
    }




    static if(!is(typeof(MACVLAN_FLAG_NOPROMISC))) {
        private enum enumMixinStr_MACVLAN_FLAG_NOPROMISC = `enum MACVLAN_FLAG_NOPROMISC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MACVLAN_FLAG_NOPROMISC); }))) {
            mixin(enumMixinStr_MACVLAN_FLAG_NOPROMISC);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_ROBUST_PRIO_INHERIT))) {
        private enum enumMixinStr__POSIX_THREAD_ROBUST_PRIO_INHERIT = `enum _POSIX_THREAD_ROBUST_PRIO_INHERIT = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_ROBUST_PRIO_INHERIT); }))) {
            mixin(enumMixinStr__POSIX_THREAD_ROBUST_PRIO_INHERIT);
        }
    }




    static if(!is(typeof(IFLA_VRF_MAX))) {
        private enum enumMixinStr_IFLA_VRF_MAX = `enum IFLA_VRF_MAX = ( __IFLA_VRF_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VRF_MAX); }))) {
            mixin(enumMixinStr_IFLA_VRF_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_PRIO_PROTECT))) {
        private enum enumMixinStr__POSIX_THREAD_PRIO_PROTECT = `enum _POSIX_THREAD_PRIO_PROTECT = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_PRIO_PROTECT); }))) {
            mixin(enumMixinStr__POSIX_THREAD_PRIO_PROTECT);
        }
    }




    static if(!is(typeof(IFLA_VRF_PORT_MAX))) {
        private enum enumMixinStr_IFLA_VRF_PORT_MAX = `enum IFLA_VRF_PORT_MAX = ( __IFLA_VRF_PORT_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VRF_PORT_MAX); }))) {
            mixin(enumMixinStr_IFLA_VRF_PORT_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_PRIO_INHERIT))) {
        private enum enumMixinStr__POSIX_THREAD_PRIO_INHERIT = `enum _POSIX_THREAD_PRIO_INHERIT = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_PRIO_INHERIT); }))) {
            mixin(enumMixinStr__POSIX_THREAD_PRIO_INHERIT);
        }
    }




    static if(!is(typeof(IFLA_MACSEC_MAX))) {
        private enum enumMixinStr_IFLA_MACSEC_MAX = `enum IFLA_MACSEC_MAX = ( __IFLA_MACSEC_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_MACSEC_MAX); }))) {
            mixin(enumMixinStr_IFLA_MACSEC_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_ATTR_STACKADDR))) {
        private enum enumMixinStr__POSIX_THREAD_ATTR_STACKADDR = `enum _POSIX_THREAD_ATTR_STACKADDR = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_ATTR_STACKADDR); }))) {
            mixin(enumMixinStr__POSIX_THREAD_ATTR_STACKADDR);
        }
    }




    static if(!is(typeof(IFLA_XFRM_MAX))) {
        private enum enumMixinStr_IFLA_XFRM_MAX = `enum IFLA_XFRM_MAX = ( __IFLA_XFRM_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_XFRM_MAX); }))) {
            mixin(enumMixinStr_IFLA_XFRM_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_ATTR_STACKSIZE))) {
        private enum enumMixinStr__POSIX_THREAD_ATTR_STACKSIZE = `enum _POSIX_THREAD_ATTR_STACKSIZE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_ATTR_STACKSIZE); }))) {
            mixin(enumMixinStr__POSIX_THREAD_ATTR_STACKSIZE);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_PRIORITY_SCHEDULING))) {
        private enum enumMixinStr__POSIX_THREAD_PRIORITY_SCHEDULING = `enum _POSIX_THREAD_PRIORITY_SCHEDULING = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_PRIORITY_SCHEDULING); }))) {
            mixin(enumMixinStr__POSIX_THREAD_PRIORITY_SCHEDULING);
        }
    }




    static if(!is(typeof(IFLA_IPVLAN_MAX))) {
        private enum enumMixinStr_IFLA_IPVLAN_MAX = `enum IFLA_IPVLAN_MAX = ( __IFLA_IPVLAN_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_IPVLAN_MAX); }))) {
            mixin(enumMixinStr_IFLA_IPVLAN_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREAD_SAFE_FUNCTIONS))) {
        private enum enumMixinStr__POSIX_THREAD_SAFE_FUNCTIONS = `enum _POSIX_THREAD_SAFE_FUNCTIONS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREAD_SAFE_FUNCTIONS); }))) {
            mixin(enumMixinStr__POSIX_THREAD_SAFE_FUNCTIONS);
        }
    }




    static if(!is(typeof(IPVLAN_F_PRIVATE))) {
        private enum enumMixinStr_IPVLAN_F_PRIVATE = `enum IPVLAN_F_PRIVATE = 0x01;`;
        static if(is(typeof({ mixin(enumMixinStr_IPVLAN_F_PRIVATE); }))) {
            mixin(enumMixinStr_IPVLAN_F_PRIVATE);
        }
    }




    static if(!is(typeof(IPVLAN_F_VEPA))) {
        private enum enumMixinStr_IPVLAN_F_VEPA = `enum IPVLAN_F_VEPA = 0x02;`;
        static if(is(typeof({ mixin(enumMixinStr_IPVLAN_F_VEPA); }))) {
            mixin(enumMixinStr_IPVLAN_F_VEPA);
        }
    }




    static if(!is(typeof(_POSIX_REENTRANT_FUNCTIONS))) {
        private enum enumMixinStr__POSIX_REENTRANT_FUNCTIONS = `enum _POSIX_REENTRANT_FUNCTIONS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_REENTRANT_FUNCTIONS); }))) {
            mixin(enumMixinStr__POSIX_REENTRANT_FUNCTIONS);
        }
    }




    static if(!is(typeof(IFLA_VXLAN_MAX))) {
        private enum enumMixinStr_IFLA_VXLAN_MAX = `enum IFLA_VXLAN_MAX = ( __IFLA_VXLAN_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VXLAN_MAX); }))) {
            mixin(enumMixinStr_IFLA_VXLAN_MAX);
        }
    }




    static if(!is(typeof(_POSIX_THREADS))) {
        private enum enumMixinStr__POSIX_THREADS = `enum _POSIX_THREADS = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_THREADS); }))) {
            mixin(enumMixinStr__POSIX_THREADS);
        }
    }




    static if(!is(typeof(_XOPEN_SHM))) {
        private enum enumMixinStr__XOPEN_SHM = `enum _XOPEN_SHM = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_SHM); }))) {
            mixin(enumMixinStr__XOPEN_SHM);
        }
    }




    static if(!is(typeof(_XOPEN_REALTIME_THREADS))) {
        private enum enumMixinStr__XOPEN_REALTIME_THREADS = `enum _XOPEN_REALTIME_THREADS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_REALTIME_THREADS); }))) {
            mixin(enumMixinStr__XOPEN_REALTIME_THREADS);
        }
    }




    static if(!is(typeof(IFLA_GENEVE_MAX))) {
        private enum enumMixinStr_IFLA_GENEVE_MAX = `enum IFLA_GENEVE_MAX = ( __IFLA_GENEVE_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_GENEVE_MAX); }))) {
            mixin(enumMixinStr_IFLA_GENEVE_MAX);
        }
    }




    static if(!is(typeof(_XOPEN_REALTIME))) {
        private enum enumMixinStr__XOPEN_REALTIME = `enum _XOPEN_REALTIME = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_REALTIME); }))) {
            mixin(enumMixinStr__XOPEN_REALTIME);
        }
    }




    static if(!is(typeof(_POSIX_NO_TRUNC))) {
        private enum enumMixinStr__POSIX_NO_TRUNC = `enum _POSIX_NO_TRUNC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_NO_TRUNC); }))) {
            mixin(enumMixinStr__POSIX_NO_TRUNC);
        }
    }




    static if(!is(typeof(IFLA_PPP_MAX))) {
        private enum enumMixinStr_IFLA_PPP_MAX = `enum IFLA_PPP_MAX = ( __IFLA_PPP_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_PPP_MAX); }))) {
            mixin(enumMixinStr_IFLA_PPP_MAX);
        }
    }




    static if(!is(typeof(_POSIX_VDISABLE))) {
        private enum enumMixinStr__POSIX_VDISABLE = `enum _POSIX_VDISABLE = '\0';`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_VDISABLE); }))) {
            mixin(enumMixinStr__POSIX_VDISABLE);
        }
    }




    static if(!is(typeof(_POSIX_CHOWN_RESTRICTED))) {
        private enum enumMixinStr__POSIX_CHOWN_RESTRICTED = `enum _POSIX_CHOWN_RESTRICTED = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_CHOWN_RESTRICTED); }))) {
            mixin(enumMixinStr__POSIX_CHOWN_RESTRICTED);
        }
    }




    static if(!is(typeof(IFLA_GTP_MAX))) {
        private enum enumMixinStr_IFLA_GTP_MAX = `enum IFLA_GTP_MAX = ( __IFLA_GTP_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_GTP_MAX); }))) {
            mixin(enumMixinStr_IFLA_GTP_MAX);
        }
    }




    static if(!is(typeof(_POSIX_MEMORY_PROTECTION))) {
        private enum enumMixinStr__POSIX_MEMORY_PROTECTION = `enum _POSIX_MEMORY_PROTECTION = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_MEMORY_PROTECTION); }))) {
            mixin(enumMixinStr__POSIX_MEMORY_PROTECTION);
        }
    }




    static if(!is(typeof(IFLA_BOND_MAX))) {
        private enum enumMixinStr_IFLA_BOND_MAX = `enum IFLA_BOND_MAX = ( __IFLA_BOND_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_BOND_MAX); }))) {
            mixin(enumMixinStr_IFLA_BOND_MAX);
        }
    }




    static if(!is(typeof(_POSIX_MEMLOCK_RANGE))) {
        private enum enumMixinStr__POSIX_MEMLOCK_RANGE = `enum _POSIX_MEMLOCK_RANGE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_MEMLOCK_RANGE); }))) {
            mixin(enumMixinStr__POSIX_MEMLOCK_RANGE);
        }
    }




    static if(!is(typeof(IFLA_BOND_AD_INFO_MAX))) {
        private enum enumMixinStr_IFLA_BOND_AD_INFO_MAX = `enum IFLA_BOND_AD_INFO_MAX = ( __IFLA_BOND_AD_INFO_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_BOND_AD_INFO_MAX); }))) {
            mixin(enumMixinStr_IFLA_BOND_AD_INFO_MAX);
        }
    }




    static if(!is(typeof(_POSIX_MEMLOCK))) {
        private enum enumMixinStr__POSIX_MEMLOCK = `enum _POSIX_MEMLOCK = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_MEMLOCK); }))) {
            mixin(enumMixinStr__POSIX_MEMLOCK);
        }
    }




    static if(!is(typeof(IFLA_BOND_SLAVE_MAX))) {
        private enum enumMixinStr_IFLA_BOND_SLAVE_MAX = `enum IFLA_BOND_SLAVE_MAX = ( __IFLA_BOND_SLAVE_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_BOND_SLAVE_MAX); }))) {
            mixin(enumMixinStr_IFLA_BOND_SLAVE_MAX);
        }
    }




    static if(!is(typeof(_POSIX_MAPPED_FILES))) {
        private enum enumMixinStr__POSIX_MAPPED_FILES = `enum _POSIX_MAPPED_FILES = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_MAPPED_FILES); }))) {
            mixin(enumMixinStr__POSIX_MAPPED_FILES);
        }
    }




    static if(!is(typeof(IFLA_VF_INFO_MAX))) {
        private enum enumMixinStr_IFLA_VF_INFO_MAX = `enum IFLA_VF_INFO_MAX = ( __IFLA_VF_INFO_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VF_INFO_MAX); }))) {
            mixin(enumMixinStr_IFLA_VF_INFO_MAX);
        }
    }




    static if(!is(typeof(_POSIX_FSYNC))) {
        private enum enumMixinStr__POSIX_FSYNC = `enum _POSIX_FSYNC = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_FSYNC); }))) {
            mixin(enumMixinStr__POSIX_FSYNC);
        }
    }




    static if(!is(typeof(IFLA_VF_MAX))) {
        private enum enumMixinStr_IFLA_VF_MAX = `enum IFLA_VF_MAX = ( __IFLA_VF_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VF_MAX); }))) {
            mixin(enumMixinStr_IFLA_VF_MAX);
        }
    }




    static if(!is(typeof(_POSIX_SYNCHRONIZED_IO))) {
        private enum enumMixinStr__POSIX_SYNCHRONIZED_IO = `enum _POSIX_SYNCHRONIZED_IO = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SYNCHRONIZED_IO); }))) {
            mixin(enumMixinStr__POSIX_SYNCHRONIZED_IO);
        }
    }




    static if(!is(typeof(_POSIX_PRIORITY_SCHEDULING))) {
        private enum enumMixinStr__POSIX_PRIORITY_SCHEDULING = `enum _POSIX_PRIORITY_SCHEDULING = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_PRIORITY_SCHEDULING); }))) {
            mixin(enumMixinStr__POSIX_PRIORITY_SCHEDULING);
        }
    }




    static if(!is(typeof(_POSIX_SAVED_IDS))) {
        private enum enumMixinStr__POSIX_SAVED_IDS = `enum _POSIX_SAVED_IDS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SAVED_IDS); }))) {
            mixin(enumMixinStr__POSIX_SAVED_IDS);
        }
    }




    static if(!is(typeof(_POSIX_JOB_CONTROL))) {
        private enum enumMixinStr__POSIX_JOB_CONTROL = `enum _POSIX_JOB_CONTROL = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_JOB_CONTROL); }))) {
            mixin(enumMixinStr__POSIX_JOB_CONTROL);
        }
    }




    static if(!is(typeof(IFLA_VF_VLAN_INFO_MAX))) {
        private enum enumMixinStr_IFLA_VF_VLAN_INFO_MAX = `enum IFLA_VF_VLAN_INFO_MAX = ( __IFLA_VF_VLAN_INFO_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VF_VLAN_INFO_MAX); }))) {
            mixin(enumMixinStr_IFLA_VF_VLAN_INFO_MAX);
        }
    }




    static if(!is(typeof(MAX_VLAN_LIST_LEN))) {
        private enum enumMixinStr_MAX_VLAN_LIST_LEN = `enum MAX_VLAN_LIST_LEN = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MAX_VLAN_LIST_LEN); }))) {
            mixin(enumMixinStr_MAX_VLAN_LIST_LEN);
        }
    }




    static if(!is(typeof(_BITS_POSIX_OPT_H))) {
        private enum enumMixinStr__BITS_POSIX_OPT_H = `enum _BITS_POSIX_OPT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_POSIX_OPT_H); }))) {
            mixin(enumMixinStr__BITS_POSIX_OPT_H);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT = `enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT = `enum __GLIBC_USE_IEC_60559_BFP_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_LIB_EXT2))) {
        private enum enumMixinStr___GLIBC_USE_LIB_EXT2 = `enum __GLIBC_USE_LIB_EXT2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_LIB_EXT2); }))) {
            mixin(enumMixinStr___GLIBC_USE_LIB_EXT2);
        }
    }




    static if(!is(typeof(IFLA_VF_STATS_MAX))) {
        private enum enumMixinStr_IFLA_VF_STATS_MAX = `enum IFLA_VF_STATS_MAX = ( __IFLA_VF_STATS_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VF_STATS_MAX); }))) {
            mixin(enumMixinStr_IFLA_VF_STATS_MAX);
        }
    }




    static if(!is(typeof(_GETOPT_POSIX_H))) {
        private enum enumMixinStr__GETOPT_POSIX_H = `enum _GETOPT_POSIX_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__GETOPT_POSIX_H); }))) {
            mixin(enumMixinStr__GETOPT_POSIX_H);
        }
    }




    static if(!is(typeof(_GETOPT_CORE_H))) {
        private enum enumMixinStr__GETOPT_CORE_H = `enum _GETOPT_CORE_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__GETOPT_CORE_H); }))) {
            mixin(enumMixinStr__GETOPT_CORE_H);
        }
    }




    static if(!is(typeof(IFLA_VF_PORT_MAX))) {
        private enum enumMixinStr_IFLA_VF_PORT_MAX = `enum IFLA_VF_PORT_MAX = ( __IFLA_VF_PORT_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_VF_PORT_MAX); }))) {
            mixin(enumMixinStr_IFLA_VF_PORT_MAX);
        }
    }




    static if(!is(typeof(F_SETLKW64))) {
        private enum enumMixinStr_F_SETLKW64 = `enum F_SETLKW64 = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETLKW64); }))) {
            mixin(enumMixinStr_F_SETLKW64);
        }
    }




    static if(!is(typeof(IFLA_PORT_MAX))) {
        private enum enumMixinStr_IFLA_PORT_MAX = `enum IFLA_PORT_MAX = ( __IFLA_PORT_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_PORT_MAX); }))) {
            mixin(enumMixinStr_IFLA_PORT_MAX);
        }
    }




    static if(!is(typeof(PORT_PROFILE_MAX))) {
        private enum enumMixinStr_PORT_PROFILE_MAX = `enum PORT_PROFILE_MAX = 40;`;
        static if(is(typeof({ mixin(enumMixinStr_PORT_PROFILE_MAX); }))) {
            mixin(enumMixinStr_PORT_PROFILE_MAX);
        }
    }




    static if(!is(typeof(PORT_UUID_MAX))) {
        private enum enumMixinStr_PORT_UUID_MAX = `enum PORT_UUID_MAX = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_PORT_UUID_MAX); }))) {
            mixin(enumMixinStr_PORT_UUID_MAX);
        }
    }




    static if(!is(typeof(PORT_SELF_VF))) {
        private enum enumMixinStr_PORT_SELF_VF = `enum PORT_SELF_VF = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr_PORT_SELF_VF); }))) {
            mixin(enumMixinStr_PORT_SELF_VF);
        }
    }




    static if(!is(typeof(F_SETLK64))) {
        private enum enumMixinStr_F_SETLK64 = `enum F_SETLK64 = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETLK64); }))) {
            mixin(enumMixinStr_F_SETLK64);
        }
    }




    static if(!is(typeof(F_GETLK64))) {
        private enum enumMixinStr_F_GETLK64 = `enum F_GETLK64 = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_F_GETLK64); }))) {
            mixin(enumMixinStr_F_GETLK64);
        }
    }




    static if(!is(typeof(__O_LARGEFILE))) {
        private enum enumMixinStr___O_LARGEFILE = `enum __O_LARGEFILE = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___O_LARGEFILE); }))) {
            mixin(enumMixinStr___O_LARGEFILE);
        }
    }




    static if(!is(typeof(POSIX_FADV_NOREUSE))) {
        private enum enumMixinStr_POSIX_FADV_NOREUSE = `enum POSIX_FADV_NOREUSE = __POSIX_FADV_NOREUSE;`;
        static if(is(typeof({ mixin(enumMixinStr_POSIX_FADV_NOREUSE); }))) {
            mixin(enumMixinStr_POSIX_FADV_NOREUSE);
        }
    }




    static if(!is(typeof(POSIX_FADV_DONTNEED))) {
        private enum enumMixinStr_POSIX_FADV_DONTNEED = `enum POSIX_FADV_DONTNEED = __POSIX_FADV_DONTNEED;`;
        static if(is(typeof({ mixin(enumMixinStr_POSIX_FADV_DONTNEED); }))) {
            mixin(enumMixinStr_POSIX_FADV_DONTNEED);
        }
    }




    static if(!is(typeof(IFLA_IPOIB_MAX))) {
        private enum enumMixinStr_IFLA_IPOIB_MAX = `enum IFLA_IPOIB_MAX = ( __IFLA_IPOIB_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_IPOIB_MAX); }))) {
            mixin(enumMixinStr_IFLA_IPOIB_MAX);
        }
    }




    static if(!is(typeof(POSIX_FADV_WILLNEED))) {
        private enum enumMixinStr_POSIX_FADV_WILLNEED = `enum POSIX_FADV_WILLNEED = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_POSIX_FADV_WILLNEED); }))) {
            mixin(enumMixinStr_POSIX_FADV_WILLNEED);
        }
    }




    static if(!is(typeof(IFLA_HSR_MAX))) {
        private enum enumMixinStr_IFLA_HSR_MAX = `enum IFLA_HSR_MAX = ( __IFLA_HSR_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_HSR_MAX); }))) {
            mixin(enumMixinStr_IFLA_HSR_MAX);
        }
    }




    static if(!is(typeof(POSIX_FADV_SEQUENTIAL))) {
        private enum enumMixinStr_POSIX_FADV_SEQUENTIAL = `enum POSIX_FADV_SEQUENTIAL = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_POSIX_FADV_SEQUENTIAL); }))) {
            mixin(enumMixinStr_POSIX_FADV_SEQUENTIAL);
        }
    }




    static if(!is(typeof(POSIX_FADV_RANDOM))) {
        private enum enumMixinStr_POSIX_FADV_RANDOM = `enum POSIX_FADV_RANDOM = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_POSIX_FADV_RANDOM); }))) {
            mixin(enumMixinStr_POSIX_FADV_RANDOM);
        }
    }




    static if(!is(typeof(IFLA_STATS_MAX))) {
        private enum enumMixinStr_IFLA_STATS_MAX = `enum IFLA_STATS_MAX = ( __IFLA_STATS_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_STATS_MAX); }))) {
            mixin(enumMixinStr_IFLA_STATS_MAX);
        }
    }






    static if(!is(typeof(POSIX_FADV_NORMAL))) {
        private enum enumMixinStr_POSIX_FADV_NORMAL = `enum POSIX_FADV_NORMAL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_POSIX_FADV_NORMAL); }))) {
            mixin(enumMixinStr_POSIX_FADV_NORMAL);
        }
    }




    static if(!is(typeof(LINK_XSTATS_TYPE_MAX))) {
        private enum enumMixinStr_LINK_XSTATS_TYPE_MAX = `enum LINK_XSTATS_TYPE_MAX = ( __LINK_XSTATS_TYPE_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_LINK_XSTATS_TYPE_MAX); }))) {
            mixin(enumMixinStr_LINK_XSTATS_TYPE_MAX);
        }
    }




    static if(!is(typeof(__POSIX_FADV_NOREUSE))) {
        private enum enumMixinStr___POSIX_FADV_NOREUSE = `enum __POSIX_FADV_NOREUSE = 5;`;
        static if(is(typeof({ mixin(enumMixinStr___POSIX_FADV_NOREUSE); }))) {
            mixin(enumMixinStr___POSIX_FADV_NOREUSE);
        }
    }




    static if(!is(typeof(IFLA_OFFLOAD_XSTATS_MAX))) {
        private enum enumMixinStr_IFLA_OFFLOAD_XSTATS_MAX = `enum IFLA_OFFLOAD_XSTATS_MAX = ( __IFLA_OFFLOAD_XSTATS_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_OFFLOAD_XSTATS_MAX); }))) {
            mixin(enumMixinStr_IFLA_OFFLOAD_XSTATS_MAX);
        }
    }




    static if(!is(typeof(XDP_FLAGS_UPDATE_IF_NOEXIST))) {
        private enum enumMixinStr_XDP_FLAGS_UPDATE_IF_NOEXIST = `enum XDP_FLAGS_UPDATE_IF_NOEXIST = ( 1U << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_XDP_FLAGS_UPDATE_IF_NOEXIST); }))) {
            mixin(enumMixinStr_XDP_FLAGS_UPDATE_IF_NOEXIST);
        }
    }




    static if(!is(typeof(XDP_FLAGS_SKB_MODE))) {
        private enum enumMixinStr_XDP_FLAGS_SKB_MODE = `enum XDP_FLAGS_SKB_MODE = ( 1U << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_XDP_FLAGS_SKB_MODE); }))) {
            mixin(enumMixinStr_XDP_FLAGS_SKB_MODE);
        }
    }




    static if(!is(typeof(XDP_FLAGS_DRV_MODE))) {
        private enum enumMixinStr_XDP_FLAGS_DRV_MODE = `enum XDP_FLAGS_DRV_MODE = ( 1U << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_XDP_FLAGS_DRV_MODE); }))) {
            mixin(enumMixinStr_XDP_FLAGS_DRV_MODE);
        }
    }




    static if(!is(typeof(XDP_FLAGS_HW_MODE))) {
        private enum enumMixinStr_XDP_FLAGS_HW_MODE = `enum XDP_FLAGS_HW_MODE = ( 1U << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_XDP_FLAGS_HW_MODE); }))) {
            mixin(enumMixinStr_XDP_FLAGS_HW_MODE);
        }
    }




    static if(!is(typeof(XDP_FLAGS_MODES))) {
        private enum enumMixinStr_XDP_FLAGS_MODES = `enum XDP_FLAGS_MODES = ( ( 1U << 1 ) | ( 1U << 2 ) | ( 1U << 3 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_XDP_FLAGS_MODES); }))) {
            mixin(enumMixinStr_XDP_FLAGS_MODES);
        }
    }




    static if(!is(typeof(XDP_FLAGS_MASK))) {
        private enum enumMixinStr_XDP_FLAGS_MASK = `enum XDP_FLAGS_MASK = ( ( 1U << 0 ) | ( ( 1U << 1 ) | ( 1U << 2 ) | ( 1U << 3 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr_XDP_FLAGS_MASK); }))) {
            mixin(enumMixinStr_XDP_FLAGS_MASK);
        }
    }




    static if(!is(typeof(__POSIX_FADV_DONTNEED))) {
        private enum enumMixinStr___POSIX_FADV_DONTNEED = `enum __POSIX_FADV_DONTNEED = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___POSIX_FADV_DONTNEED); }))) {
            mixin(enumMixinStr___POSIX_FADV_DONTNEED);
        }
    }




    static if(!is(typeof(FNDELAY))) {
        private enum enumMixinStr_FNDELAY = `enum FNDELAY = O_NDELAY;`;
        static if(is(typeof({ mixin(enumMixinStr_FNDELAY); }))) {
            mixin(enumMixinStr_FNDELAY);
        }
    }




    static if(!is(typeof(IFLA_XDP_MAX))) {
        private enum enumMixinStr_IFLA_XDP_MAX = `enum IFLA_XDP_MAX = ( __IFLA_XDP_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_XDP_MAX); }))) {
            mixin(enumMixinStr_IFLA_XDP_MAX);
        }
    }




    static if(!is(typeof(FNONBLOCK))) {
        private enum enumMixinStr_FNONBLOCK = `enum FNONBLOCK = O_NONBLOCK;`;
        static if(is(typeof({ mixin(enumMixinStr_FNONBLOCK); }))) {
            mixin(enumMixinStr_FNONBLOCK);
        }
    }




    static if(!is(typeof(FASYNC))) {
        private enum enumMixinStr_FASYNC = `enum FASYNC = O_ASYNC;`;
        static if(is(typeof({ mixin(enumMixinStr_FASYNC); }))) {
            mixin(enumMixinStr_FASYNC);
        }
    }




    static if(!is(typeof(IFLA_TUN_MAX))) {
        private enum enumMixinStr_IFLA_TUN_MAX = `enum IFLA_TUN_MAX = ( __IFLA_TUN_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_TUN_MAX); }))) {
            mixin(enumMixinStr_IFLA_TUN_MAX);
        }
    }




    static if(!is(typeof(RMNET_FLAGS_INGRESS_DEAGGREGATION))) {
        private enum enumMixinStr_RMNET_FLAGS_INGRESS_DEAGGREGATION = `enum RMNET_FLAGS_INGRESS_DEAGGREGATION = ( 1U << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RMNET_FLAGS_INGRESS_DEAGGREGATION); }))) {
            mixin(enumMixinStr_RMNET_FLAGS_INGRESS_DEAGGREGATION);
        }
    }




    static if(!is(typeof(RMNET_FLAGS_INGRESS_MAP_COMMANDS))) {
        private enum enumMixinStr_RMNET_FLAGS_INGRESS_MAP_COMMANDS = `enum RMNET_FLAGS_INGRESS_MAP_COMMANDS = ( 1U << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RMNET_FLAGS_INGRESS_MAP_COMMANDS); }))) {
            mixin(enumMixinStr_RMNET_FLAGS_INGRESS_MAP_COMMANDS);
        }
    }




    static if(!is(typeof(RMNET_FLAGS_INGRESS_MAP_CKSUMV4))) {
        private enum enumMixinStr_RMNET_FLAGS_INGRESS_MAP_CKSUMV4 = `enum RMNET_FLAGS_INGRESS_MAP_CKSUMV4 = ( 1U << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RMNET_FLAGS_INGRESS_MAP_CKSUMV4); }))) {
            mixin(enumMixinStr_RMNET_FLAGS_INGRESS_MAP_CKSUMV4);
        }
    }




    static if(!is(typeof(RMNET_FLAGS_EGRESS_MAP_CKSUMV4))) {
        private enum enumMixinStr_RMNET_FLAGS_EGRESS_MAP_CKSUMV4 = `enum RMNET_FLAGS_EGRESS_MAP_CKSUMV4 = ( 1U << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RMNET_FLAGS_EGRESS_MAP_CKSUMV4); }))) {
            mixin(enumMixinStr_RMNET_FLAGS_EGRESS_MAP_CKSUMV4);
        }
    }




    static if(!is(typeof(FFSYNC))) {
        private enum enumMixinStr_FFSYNC = `enum FFSYNC = O_FSYNC;`;
        static if(is(typeof({ mixin(enumMixinStr_FFSYNC); }))) {
            mixin(enumMixinStr_FFSYNC);
        }
    }




    static if(!is(typeof(IFLA_RMNET_MAX))) {
        private enum enumMixinStr_IFLA_RMNET_MAX = `enum IFLA_RMNET_MAX = ( __IFLA_RMNET_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_IFLA_RMNET_MAX); }))) {
            mixin(enumMixinStr_IFLA_RMNET_MAX);
        }
    }




    static if(!is(typeof(FAPPEND))) {
        private enum enumMixinStr_FAPPEND = `enum FAPPEND = O_APPEND;`;
        static if(is(typeof({ mixin(enumMixinStr_FAPPEND); }))) {
            mixin(enumMixinStr_FAPPEND);
        }
    }






    static if(!is(typeof(LOCK_UN))) {
        private enum enumMixinStr_LOCK_UN = `enum LOCK_UN = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_LOCK_UN); }))) {
            mixin(enumMixinStr_LOCK_UN);
        }
    }
    static if(!is(typeof(LOCK_NB))) {
        private enum enumMixinStr_LOCK_NB = `enum LOCK_NB = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_LOCK_NB); }))) {
            mixin(enumMixinStr_LOCK_NB);
        }
    }




    static if(!is(typeof(LOCK_EX))) {
        private enum enumMixinStr_LOCK_EX = `enum LOCK_EX = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_LOCK_EX); }))) {
            mixin(enumMixinStr_LOCK_EX);
        }
    }




    static if(!is(typeof(LOCK_SH))) {
        private enum enumMixinStr_LOCK_SH = `enum LOCK_SH = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LOCK_SH); }))) {
            mixin(enumMixinStr_LOCK_SH);
        }
    }




    static if(!is(typeof(F_SHLCK))) {
        private enum enumMixinStr_F_SHLCK = `enum F_SHLCK = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SHLCK); }))) {
            mixin(enumMixinStr_F_SHLCK);
        }
    }




    static if(!is(typeof(NDA_MAX))) {
        private enum enumMixinStr_NDA_MAX = `enum NDA_MAX = ( __NDA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NDA_MAX); }))) {
            mixin(enumMixinStr_NDA_MAX);
        }
    }




    static if(!is(typeof(NTF_USE))) {
        private enum enumMixinStr_NTF_USE = `enum NTF_USE = 0x01;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_USE); }))) {
            mixin(enumMixinStr_NTF_USE);
        }
    }




    static if(!is(typeof(NTF_SELF))) {
        private enum enumMixinStr_NTF_SELF = `enum NTF_SELF = 0x02;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_SELF); }))) {
            mixin(enumMixinStr_NTF_SELF);
        }
    }




    static if(!is(typeof(NTF_MASTER))) {
        private enum enumMixinStr_NTF_MASTER = `enum NTF_MASTER = 0x04;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_MASTER); }))) {
            mixin(enumMixinStr_NTF_MASTER);
        }
    }




    static if(!is(typeof(NTF_PROXY))) {
        private enum enumMixinStr_NTF_PROXY = `enum NTF_PROXY = 0x08;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_PROXY); }))) {
            mixin(enumMixinStr_NTF_PROXY);
        }
    }




    static if(!is(typeof(NTF_EXT_LEARNED))) {
        private enum enumMixinStr_NTF_EXT_LEARNED = `enum NTF_EXT_LEARNED = 0x10;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_EXT_LEARNED); }))) {
            mixin(enumMixinStr_NTF_EXT_LEARNED);
        }
    }




    static if(!is(typeof(NTF_OFFLOADED))) {
        private enum enumMixinStr_NTF_OFFLOADED = `enum NTF_OFFLOADED = 0x20;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_OFFLOADED); }))) {
            mixin(enumMixinStr_NTF_OFFLOADED);
        }
    }




    static if(!is(typeof(NTF_STICKY))) {
        private enum enumMixinStr_NTF_STICKY = `enum NTF_STICKY = 0x40;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_STICKY); }))) {
            mixin(enumMixinStr_NTF_STICKY);
        }
    }




    static if(!is(typeof(NTF_ROUTER))) {
        private enum enumMixinStr_NTF_ROUTER = `enum NTF_ROUTER = 0x80;`;
        static if(is(typeof({ mixin(enumMixinStr_NTF_ROUTER); }))) {
            mixin(enumMixinStr_NTF_ROUTER);
        }
    }




    static if(!is(typeof(NUD_INCOMPLETE))) {
        private enum enumMixinStr_NUD_INCOMPLETE = `enum NUD_INCOMPLETE = 0x01;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_INCOMPLETE); }))) {
            mixin(enumMixinStr_NUD_INCOMPLETE);
        }
    }




    static if(!is(typeof(NUD_REACHABLE))) {
        private enum enumMixinStr_NUD_REACHABLE = `enum NUD_REACHABLE = 0x02;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_REACHABLE); }))) {
            mixin(enumMixinStr_NUD_REACHABLE);
        }
    }




    static if(!is(typeof(NUD_STALE))) {
        private enum enumMixinStr_NUD_STALE = `enum NUD_STALE = 0x04;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_STALE); }))) {
            mixin(enumMixinStr_NUD_STALE);
        }
    }




    static if(!is(typeof(NUD_DELAY))) {
        private enum enumMixinStr_NUD_DELAY = `enum NUD_DELAY = 0x08;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_DELAY); }))) {
            mixin(enumMixinStr_NUD_DELAY);
        }
    }




    static if(!is(typeof(NUD_PROBE))) {
        private enum enumMixinStr_NUD_PROBE = `enum NUD_PROBE = 0x10;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_PROBE); }))) {
            mixin(enumMixinStr_NUD_PROBE);
        }
    }




    static if(!is(typeof(NUD_FAILED))) {
        private enum enumMixinStr_NUD_FAILED = `enum NUD_FAILED = 0x20;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_FAILED); }))) {
            mixin(enumMixinStr_NUD_FAILED);
        }
    }




    static if(!is(typeof(NUD_NOARP))) {
        private enum enumMixinStr_NUD_NOARP = `enum NUD_NOARP = 0x40;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_NOARP); }))) {
            mixin(enumMixinStr_NUD_NOARP);
        }
    }




    static if(!is(typeof(NUD_PERMANENT))) {
        private enum enumMixinStr_NUD_PERMANENT = `enum NUD_PERMANENT = 0x80;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_PERMANENT); }))) {
            mixin(enumMixinStr_NUD_PERMANENT);
        }
    }




    static if(!is(typeof(NUD_NONE))) {
        private enum enumMixinStr_NUD_NONE = `enum NUD_NONE = 0x00;`;
        static if(is(typeof({ mixin(enumMixinStr_NUD_NONE); }))) {
            mixin(enumMixinStr_NUD_NONE);
        }
    }




    static if(!is(typeof(F_EXLCK))) {
        private enum enumMixinStr_F_EXLCK = `enum F_EXLCK = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_F_EXLCK); }))) {
            mixin(enumMixinStr_F_EXLCK);
        }
    }




    static if(!is(typeof(F_UNLCK))) {
        private enum enumMixinStr_F_UNLCK = `enum F_UNLCK = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_F_UNLCK); }))) {
            mixin(enumMixinStr_F_UNLCK);
        }
    }




    static if(!is(typeof(F_WRLCK))) {
        private enum enumMixinStr_F_WRLCK = `enum F_WRLCK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_F_WRLCK); }))) {
            mixin(enumMixinStr_F_WRLCK);
        }
    }




    static if(!is(typeof(NDTPA_MAX))) {
        private enum enumMixinStr_NDTPA_MAX = `enum NDTPA_MAX = ( __NDTPA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NDTPA_MAX); }))) {
            mixin(enumMixinStr_NDTPA_MAX);
        }
    }




    static if(!is(typeof(F_RDLCK))) {
        private enum enumMixinStr_F_RDLCK = `enum F_RDLCK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_F_RDLCK); }))) {
            mixin(enumMixinStr_F_RDLCK);
        }
    }




    static if(!is(typeof(FD_CLOEXEC))) {
        private enum enumMixinStr_FD_CLOEXEC = `enum FD_CLOEXEC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_FD_CLOEXEC); }))) {
            mixin(enumMixinStr_FD_CLOEXEC);
        }
    }




    static if(!is(typeof(F_DUPFD_CLOEXEC))) {
        private enum enumMixinStr_F_DUPFD_CLOEXEC = `enum F_DUPFD_CLOEXEC = 1030;`;
        static if(is(typeof({ mixin(enumMixinStr_F_DUPFD_CLOEXEC); }))) {
            mixin(enumMixinStr_F_DUPFD_CLOEXEC);
        }
    }




    static if(!is(typeof(NDTA_MAX))) {
        private enum enumMixinStr_NDTA_MAX = `enum NDTA_MAX = ( __NDTA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NDTA_MAX); }))) {
            mixin(enumMixinStr_NDTA_MAX);
        }
    }






    static if(!is(typeof(__F_GETOWN_EX))) {
        private enum enumMixinStr___F_GETOWN_EX = `enum __F_GETOWN_EX = 16;`;
        static if(is(typeof({ mixin(enumMixinStr___F_GETOWN_EX); }))) {
            mixin(enumMixinStr___F_GETOWN_EX);
        }
    }




    static if(!is(typeof(__F_SETOWN_EX))) {
        private enum enumMixinStr___F_SETOWN_EX = `enum __F_SETOWN_EX = 15;`;
        static if(is(typeof({ mixin(enumMixinStr___F_SETOWN_EX); }))) {
            mixin(enumMixinStr___F_SETOWN_EX);
        }
    }




    static if(!is(typeof(__F_GETSIG))) {
        private enum enumMixinStr___F_GETSIG = `enum __F_GETSIG = 11;`;
        static if(is(typeof({ mixin(enumMixinStr___F_GETSIG); }))) {
            mixin(enumMixinStr___F_GETSIG);
        }
    }




    static if(!is(typeof(NETLINK_ROUTE))) {
        private enum enumMixinStr_NETLINK_ROUTE = `enum NETLINK_ROUTE = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_ROUTE); }))) {
            mixin(enumMixinStr_NETLINK_ROUTE);
        }
    }




    static if(!is(typeof(NETLINK_UNUSED))) {
        private enum enumMixinStr_NETLINK_UNUSED = `enum NETLINK_UNUSED = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_UNUSED); }))) {
            mixin(enumMixinStr_NETLINK_UNUSED);
        }
    }




    static if(!is(typeof(NETLINK_USERSOCK))) {
        private enum enumMixinStr_NETLINK_USERSOCK = `enum NETLINK_USERSOCK = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_USERSOCK); }))) {
            mixin(enumMixinStr_NETLINK_USERSOCK);
        }
    }




    static if(!is(typeof(NETLINK_FIREWALL))) {
        private enum enumMixinStr_NETLINK_FIREWALL = `enum NETLINK_FIREWALL = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_FIREWALL); }))) {
            mixin(enumMixinStr_NETLINK_FIREWALL);
        }
    }




    static if(!is(typeof(NETLINK_SOCK_DIAG))) {
        private enum enumMixinStr_NETLINK_SOCK_DIAG = `enum NETLINK_SOCK_DIAG = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_SOCK_DIAG); }))) {
            mixin(enumMixinStr_NETLINK_SOCK_DIAG);
        }
    }




    static if(!is(typeof(NETLINK_NFLOG))) {
        private enum enumMixinStr_NETLINK_NFLOG = `enum NETLINK_NFLOG = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_NFLOG); }))) {
            mixin(enumMixinStr_NETLINK_NFLOG);
        }
    }




    static if(!is(typeof(NETLINK_XFRM))) {
        private enum enumMixinStr_NETLINK_XFRM = `enum NETLINK_XFRM = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_XFRM); }))) {
            mixin(enumMixinStr_NETLINK_XFRM);
        }
    }




    static if(!is(typeof(NETLINK_SELINUX))) {
        private enum enumMixinStr_NETLINK_SELINUX = `enum NETLINK_SELINUX = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_SELINUX); }))) {
            mixin(enumMixinStr_NETLINK_SELINUX);
        }
    }




    static if(!is(typeof(NETLINK_ISCSI))) {
        private enum enumMixinStr_NETLINK_ISCSI = `enum NETLINK_ISCSI = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_ISCSI); }))) {
            mixin(enumMixinStr_NETLINK_ISCSI);
        }
    }




    static if(!is(typeof(NETLINK_AUDIT))) {
        private enum enumMixinStr_NETLINK_AUDIT = `enum NETLINK_AUDIT = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_AUDIT); }))) {
            mixin(enumMixinStr_NETLINK_AUDIT);
        }
    }




    static if(!is(typeof(NETLINK_FIB_LOOKUP))) {
        private enum enumMixinStr_NETLINK_FIB_LOOKUP = `enum NETLINK_FIB_LOOKUP = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_FIB_LOOKUP); }))) {
            mixin(enumMixinStr_NETLINK_FIB_LOOKUP);
        }
    }




    static if(!is(typeof(NETLINK_CONNECTOR))) {
        private enum enumMixinStr_NETLINK_CONNECTOR = `enum NETLINK_CONNECTOR = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_CONNECTOR); }))) {
            mixin(enumMixinStr_NETLINK_CONNECTOR);
        }
    }




    static if(!is(typeof(NETLINK_NETFILTER))) {
        private enum enumMixinStr_NETLINK_NETFILTER = `enum NETLINK_NETFILTER = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_NETFILTER); }))) {
            mixin(enumMixinStr_NETLINK_NETFILTER);
        }
    }




    static if(!is(typeof(NETLINK_IP6_FW))) {
        private enum enumMixinStr_NETLINK_IP6_FW = `enum NETLINK_IP6_FW = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_IP6_FW); }))) {
            mixin(enumMixinStr_NETLINK_IP6_FW);
        }
    }




    static if(!is(typeof(NETLINK_DNRTMSG))) {
        private enum enumMixinStr_NETLINK_DNRTMSG = `enum NETLINK_DNRTMSG = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_DNRTMSG); }))) {
            mixin(enumMixinStr_NETLINK_DNRTMSG);
        }
    }




    static if(!is(typeof(NETLINK_KOBJECT_UEVENT))) {
        private enum enumMixinStr_NETLINK_KOBJECT_UEVENT = `enum NETLINK_KOBJECT_UEVENT = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_KOBJECT_UEVENT); }))) {
            mixin(enumMixinStr_NETLINK_KOBJECT_UEVENT);
        }
    }




    static if(!is(typeof(NETLINK_GENERIC))) {
        private enum enumMixinStr_NETLINK_GENERIC = `enum NETLINK_GENERIC = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_GENERIC); }))) {
            mixin(enumMixinStr_NETLINK_GENERIC);
        }
    }




    static if(!is(typeof(NETLINK_SCSITRANSPORT))) {
        private enum enumMixinStr_NETLINK_SCSITRANSPORT = `enum NETLINK_SCSITRANSPORT = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_SCSITRANSPORT); }))) {
            mixin(enumMixinStr_NETLINK_SCSITRANSPORT);
        }
    }




    static if(!is(typeof(NETLINK_ECRYPTFS))) {
        private enum enumMixinStr_NETLINK_ECRYPTFS = `enum NETLINK_ECRYPTFS = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_ECRYPTFS); }))) {
            mixin(enumMixinStr_NETLINK_ECRYPTFS);
        }
    }




    static if(!is(typeof(NETLINK_RDMA))) {
        private enum enumMixinStr_NETLINK_RDMA = `enum NETLINK_RDMA = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_RDMA); }))) {
            mixin(enumMixinStr_NETLINK_RDMA);
        }
    }




    static if(!is(typeof(NETLINK_CRYPTO))) {
        private enum enumMixinStr_NETLINK_CRYPTO = `enum NETLINK_CRYPTO = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_CRYPTO); }))) {
            mixin(enumMixinStr_NETLINK_CRYPTO);
        }
    }




    static if(!is(typeof(NETLINK_SMC))) {
        private enum enumMixinStr_NETLINK_SMC = `enum NETLINK_SMC = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_SMC); }))) {
            mixin(enumMixinStr_NETLINK_SMC);
        }
    }




    static if(!is(typeof(NETLINK_INET_DIAG))) {
        private enum enumMixinStr_NETLINK_INET_DIAG = `enum NETLINK_INET_DIAG = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_INET_DIAG); }))) {
            mixin(enumMixinStr_NETLINK_INET_DIAG);
        }
    }




    static if(!is(typeof(MAX_LINKS))) {
        private enum enumMixinStr_MAX_LINKS = `enum MAX_LINKS = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_MAX_LINKS); }))) {
            mixin(enumMixinStr_MAX_LINKS);
        }
    }




    static if(!is(typeof(__F_SETSIG))) {
        private enum enumMixinStr___F_SETSIG = `enum __F_SETSIG = 10;`;
        static if(is(typeof({ mixin(enumMixinStr___F_SETSIG); }))) {
            mixin(enumMixinStr___F_SETSIG);
        }
    }




    static if(!is(typeof(F_GETOWN))) {
        private enum enumMixinStr_F_GETOWN = `enum F_GETOWN = __F_GETOWN;`;
        static if(is(typeof({ mixin(enumMixinStr_F_GETOWN); }))) {
            mixin(enumMixinStr_F_GETOWN);
        }
    }




    static if(!is(typeof(NLM_F_REQUEST))) {
        private enum enumMixinStr_NLM_F_REQUEST = `enum NLM_F_REQUEST = 0x01;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_REQUEST); }))) {
            mixin(enumMixinStr_NLM_F_REQUEST);
        }
    }




    static if(!is(typeof(NLM_F_MULTI))) {
        private enum enumMixinStr_NLM_F_MULTI = `enum NLM_F_MULTI = 0x02;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_MULTI); }))) {
            mixin(enumMixinStr_NLM_F_MULTI);
        }
    }




    static if(!is(typeof(NLM_F_ACK))) {
        private enum enumMixinStr_NLM_F_ACK = `enum NLM_F_ACK = 0x04;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_ACK); }))) {
            mixin(enumMixinStr_NLM_F_ACK);
        }
    }




    static if(!is(typeof(NLM_F_ECHO))) {
        private enum enumMixinStr_NLM_F_ECHO = `enum NLM_F_ECHO = 0x08;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_ECHO); }))) {
            mixin(enumMixinStr_NLM_F_ECHO);
        }
    }




    static if(!is(typeof(NLM_F_DUMP_INTR))) {
        private enum enumMixinStr_NLM_F_DUMP_INTR = `enum NLM_F_DUMP_INTR = 0x10;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_DUMP_INTR); }))) {
            mixin(enumMixinStr_NLM_F_DUMP_INTR);
        }
    }




    static if(!is(typeof(NLM_F_DUMP_FILTERED))) {
        private enum enumMixinStr_NLM_F_DUMP_FILTERED = `enum NLM_F_DUMP_FILTERED = 0x20;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_DUMP_FILTERED); }))) {
            mixin(enumMixinStr_NLM_F_DUMP_FILTERED);
        }
    }




    static if(!is(typeof(NLM_F_ROOT))) {
        private enum enumMixinStr_NLM_F_ROOT = `enum NLM_F_ROOT = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_ROOT); }))) {
            mixin(enumMixinStr_NLM_F_ROOT);
        }
    }




    static if(!is(typeof(NLM_F_MATCH))) {
        private enum enumMixinStr_NLM_F_MATCH = `enum NLM_F_MATCH = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_MATCH); }))) {
            mixin(enumMixinStr_NLM_F_MATCH);
        }
    }




    static if(!is(typeof(NLM_F_ATOMIC))) {
        private enum enumMixinStr_NLM_F_ATOMIC = `enum NLM_F_ATOMIC = 0x400;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_ATOMIC); }))) {
            mixin(enumMixinStr_NLM_F_ATOMIC);
        }
    }




    static if(!is(typeof(NLM_F_DUMP))) {
        private enum enumMixinStr_NLM_F_DUMP = `enum NLM_F_DUMP = ( 0x100 | 0x200 );`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_DUMP); }))) {
            mixin(enumMixinStr_NLM_F_DUMP);
        }
    }




    static if(!is(typeof(NLM_F_REPLACE))) {
        private enum enumMixinStr_NLM_F_REPLACE = `enum NLM_F_REPLACE = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_REPLACE); }))) {
            mixin(enumMixinStr_NLM_F_REPLACE);
        }
    }




    static if(!is(typeof(NLM_F_EXCL))) {
        private enum enumMixinStr_NLM_F_EXCL = `enum NLM_F_EXCL = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_EXCL); }))) {
            mixin(enumMixinStr_NLM_F_EXCL);
        }
    }




    static if(!is(typeof(NLM_F_CREATE))) {
        private enum enumMixinStr_NLM_F_CREATE = `enum NLM_F_CREATE = 0x400;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_CREATE); }))) {
            mixin(enumMixinStr_NLM_F_CREATE);
        }
    }




    static if(!is(typeof(NLM_F_APPEND))) {
        private enum enumMixinStr_NLM_F_APPEND = `enum NLM_F_APPEND = 0x800;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_APPEND); }))) {
            mixin(enumMixinStr_NLM_F_APPEND);
        }
    }




    static if(!is(typeof(NLM_F_NONREC))) {
        private enum enumMixinStr_NLM_F_NONREC = `enum NLM_F_NONREC = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_NONREC); }))) {
            mixin(enumMixinStr_NLM_F_NONREC);
        }
    }




    static if(!is(typeof(NLM_F_CAPPED))) {
        private enum enumMixinStr_NLM_F_CAPPED = `enum NLM_F_CAPPED = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_CAPPED); }))) {
            mixin(enumMixinStr_NLM_F_CAPPED);
        }
    }




    static if(!is(typeof(NLM_F_ACK_TLVS))) {
        private enum enumMixinStr_NLM_F_ACK_TLVS = `enum NLM_F_ACK_TLVS = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_NLM_F_ACK_TLVS); }))) {
            mixin(enumMixinStr_NLM_F_ACK_TLVS);
        }
    }




    static if(!is(typeof(NLMSG_ALIGNTO))) {
        private enum enumMixinStr_NLMSG_ALIGNTO = `enum NLMSG_ALIGNTO = 4U;`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_ALIGNTO); }))) {
            mixin(enumMixinStr_NLMSG_ALIGNTO);
        }
    }






    static if(!is(typeof(NLMSG_HDRLEN))) {
        private enum enumMixinStr_NLMSG_HDRLEN = `enum NLMSG_HDRLEN = ( cast( int ) ( ( ( ( nlmsghdr ) .sizeof ) + 4U - 1 ) & ~ ( 4U - 1 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_HDRLEN); }))) {
            mixin(enumMixinStr_NLMSG_HDRLEN);
        }
    }
    static if(!is(typeof(NLMSG_NOOP))) {
        private enum enumMixinStr_NLMSG_NOOP = `enum NLMSG_NOOP = 0x1;`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_NOOP); }))) {
            mixin(enumMixinStr_NLMSG_NOOP);
        }
    }




    static if(!is(typeof(NLMSG_ERROR))) {
        private enum enumMixinStr_NLMSG_ERROR = `enum NLMSG_ERROR = 0x2;`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_ERROR); }))) {
            mixin(enumMixinStr_NLMSG_ERROR);
        }
    }




    static if(!is(typeof(NLMSG_DONE))) {
        private enum enumMixinStr_NLMSG_DONE = `enum NLMSG_DONE = 0x3;`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_DONE); }))) {
            mixin(enumMixinStr_NLMSG_DONE);
        }
    }




    static if(!is(typeof(NLMSG_OVERRUN))) {
        private enum enumMixinStr_NLMSG_OVERRUN = `enum NLMSG_OVERRUN = 0x4;`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_OVERRUN); }))) {
            mixin(enumMixinStr_NLMSG_OVERRUN);
        }
    }




    static if(!is(typeof(NLMSG_MIN_TYPE))) {
        private enum enumMixinStr_NLMSG_MIN_TYPE = `enum NLMSG_MIN_TYPE = 0x10;`;
        static if(is(typeof({ mixin(enumMixinStr_NLMSG_MIN_TYPE); }))) {
            mixin(enumMixinStr_NLMSG_MIN_TYPE);
        }
    }




    static if(!is(typeof(F_SETOWN))) {
        private enum enumMixinStr_F_SETOWN = `enum F_SETOWN = __F_SETOWN;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETOWN); }))) {
            mixin(enumMixinStr_F_SETOWN);
        }
    }




    static if(!is(typeof(__F_GETOWN))) {
        private enum enumMixinStr___F_GETOWN = `enum __F_GETOWN = 9;`;
        static if(is(typeof({ mixin(enumMixinStr___F_GETOWN); }))) {
            mixin(enumMixinStr___F_GETOWN);
        }
    }




    static if(!is(typeof(NETLINK_ADD_MEMBERSHIP))) {
        private enum enumMixinStr_NETLINK_ADD_MEMBERSHIP = `enum NETLINK_ADD_MEMBERSHIP = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_ADD_MEMBERSHIP); }))) {
            mixin(enumMixinStr_NETLINK_ADD_MEMBERSHIP);
        }
    }




    static if(!is(typeof(NETLINK_DROP_MEMBERSHIP))) {
        private enum enumMixinStr_NETLINK_DROP_MEMBERSHIP = `enum NETLINK_DROP_MEMBERSHIP = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_DROP_MEMBERSHIP); }))) {
            mixin(enumMixinStr_NETLINK_DROP_MEMBERSHIP);
        }
    }




    static if(!is(typeof(NETLINK_PKTINFO))) {
        private enum enumMixinStr_NETLINK_PKTINFO = `enum NETLINK_PKTINFO = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_PKTINFO); }))) {
            mixin(enumMixinStr_NETLINK_PKTINFO);
        }
    }




    static if(!is(typeof(NETLINK_BROADCAST_ERROR))) {
        private enum enumMixinStr_NETLINK_BROADCAST_ERROR = `enum NETLINK_BROADCAST_ERROR = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_BROADCAST_ERROR); }))) {
            mixin(enumMixinStr_NETLINK_BROADCAST_ERROR);
        }
    }




    static if(!is(typeof(NETLINK_NO_ENOBUFS))) {
        private enum enumMixinStr_NETLINK_NO_ENOBUFS = `enum NETLINK_NO_ENOBUFS = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_NO_ENOBUFS); }))) {
            mixin(enumMixinStr_NETLINK_NO_ENOBUFS);
        }
    }




    static if(!is(typeof(NETLINK_RX_RING))) {
        private enum enumMixinStr_NETLINK_RX_RING = `enum NETLINK_RX_RING = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_RX_RING); }))) {
            mixin(enumMixinStr_NETLINK_RX_RING);
        }
    }




    static if(!is(typeof(NETLINK_TX_RING))) {
        private enum enumMixinStr_NETLINK_TX_RING = `enum NETLINK_TX_RING = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_TX_RING); }))) {
            mixin(enumMixinStr_NETLINK_TX_RING);
        }
    }




    static if(!is(typeof(NETLINK_LISTEN_ALL_NSID))) {
        private enum enumMixinStr_NETLINK_LISTEN_ALL_NSID = `enum NETLINK_LISTEN_ALL_NSID = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_LISTEN_ALL_NSID); }))) {
            mixin(enumMixinStr_NETLINK_LISTEN_ALL_NSID);
        }
    }




    static if(!is(typeof(NETLINK_LIST_MEMBERSHIPS))) {
        private enum enumMixinStr_NETLINK_LIST_MEMBERSHIPS = `enum NETLINK_LIST_MEMBERSHIPS = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_LIST_MEMBERSHIPS); }))) {
            mixin(enumMixinStr_NETLINK_LIST_MEMBERSHIPS);
        }
    }




    static if(!is(typeof(NETLINK_CAP_ACK))) {
        private enum enumMixinStr_NETLINK_CAP_ACK = `enum NETLINK_CAP_ACK = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_CAP_ACK); }))) {
            mixin(enumMixinStr_NETLINK_CAP_ACK);
        }
    }




    static if(!is(typeof(NETLINK_EXT_ACK))) {
        private enum enumMixinStr_NETLINK_EXT_ACK = `enum NETLINK_EXT_ACK = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_EXT_ACK); }))) {
            mixin(enumMixinStr_NETLINK_EXT_ACK);
        }
    }




    static if(!is(typeof(NETLINK_GET_STRICT_CHK))) {
        private enum enumMixinStr_NETLINK_GET_STRICT_CHK = `enum NETLINK_GET_STRICT_CHK = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_NETLINK_GET_STRICT_CHK); }))) {
            mixin(enumMixinStr_NETLINK_GET_STRICT_CHK);
        }
    }




    static if(!is(typeof(__F_SETOWN))) {
        private enum enumMixinStr___F_SETOWN = `enum __F_SETOWN = 8;`;
        static if(is(typeof({ mixin(enumMixinStr___F_SETOWN); }))) {
            mixin(enumMixinStr___F_SETOWN);
        }
    }




    static if(!is(typeof(F_SETFL))) {
        private enum enumMixinStr_F_SETFL = `enum F_SETFL = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETFL); }))) {
            mixin(enumMixinStr_F_SETFL);
        }
    }




    static if(!is(typeof(F_GETFL))) {
        private enum enumMixinStr_F_GETFL = `enum F_GETFL = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_F_GETFL); }))) {
            mixin(enumMixinStr_F_GETFL);
        }
    }




    static if(!is(typeof(F_SETFD))) {
        private enum enumMixinStr_F_SETFD = `enum F_SETFD = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETFD); }))) {
            mixin(enumMixinStr_F_SETFD);
        }
    }




    static if(!is(typeof(NL_MMAP_MSG_ALIGNMENT))) {
        private enum enumMixinStr_NL_MMAP_MSG_ALIGNMENT = `enum NL_MMAP_MSG_ALIGNMENT = 4U;`;
        static if(is(typeof({ mixin(enumMixinStr_NL_MMAP_MSG_ALIGNMENT); }))) {
            mixin(enumMixinStr_NL_MMAP_MSG_ALIGNMENT);
        }
    }






    static if(!is(typeof(NL_MMAP_HDRLEN))) {
        private enum enumMixinStr_NL_MMAP_HDRLEN = `enum NL_MMAP_HDRLEN = ( ( ( ( nl_mmap_hdr ) .sizeof ) + ( ( typeof ( ( nl_mmap_hdr ) .sizeof ) ) ( 4U ) - 1 ) ) & ~ ( ( typeof ( ( nl_mmap_hdr ) .sizeof ) ) ( 4U ) - 1 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_NL_MMAP_HDRLEN); }))) {
            mixin(enumMixinStr_NL_MMAP_HDRLEN);
        }
    }




    static if(!is(typeof(NET_MAJOR))) {
        private enum enumMixinStr_NET_MAJOR = `enum NET_MAJOR = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_NET_MAJOR); }))) {
            mixin(enumMixinStr_NET_MAJOR);
        }
    }




    static if(!is(typeof(F_GETFD))) {
        private enum enumMixinStr_F_GETFD = `enum F_GETFD = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_F_GETFD); }))) {
            mixin(enumMixinStr_F_GETFD);
        }
    }




    static if(!is(typeof(F_DUPFD))) {
        private enum enumMixinStr_F_DUPFD = `enum F_DUPFD = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_F_DUPFD); }))) {
            mixin(enumMixinStr_F_DUPFD);
        }
    }




    static if(!is(typeof(NLA_F_NESTED))) {
        private enum enumMixinStr_NLA_F_NESTED = `enum NLA_F_NESTED = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_NLA_F_NESTED); }))) {
            mixin(enumMixinStr_NLA_F_NESTED);
        }
    }




    static if(!is(typeof(NLA_F_NET_BYTEORDER))) {
        private enum enumMixinStr_NLA_F_NET_BYTEORDER = `enum NLA_F_NET_BYTEORDER = ( 1 << 14 );`;
        static if(is(typeof({ mixin(enumMixinStr_NLA_F_NET_BYTEORDER); }))) {
            mixin(enumMixinStr_NLA_F_NET_BYTEORDER);
        }
    }




    static if(!is(typeof(NLA_TYPE_MASK))) {
        private enum enumMixinStr_NLA_TYPE_MASK = `enum NLA_TYPE_MASK = ~ ( ( 1 << 15 ) | ( 1 << 14 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_NLA_TYPE_MASK); }))) {
            mixin(enumMixinStr_NLA_TYPE_MASK);
        }
    }




    static if(!is(typeof(NLA_ALIGNTO))) {
        private enum enumMixinStr_NLA_ALIGNTO = `enum NLA_ALIGNTO = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_NLA_ALIGNTO); }))) {
            mixin(enumMixinStr_NLA_ALIGNTO);
        }
    }






    static if(!is(typeof(NLA_HDRLEN))) {
        private enum enumMixinStr_NLA_HDRLEN = `enum NLA_HDRLEN = ( cast( int ) ( ( ( ( nlattr ) .sizeof ) + 4 - 1 ) & ~ ( 4 - 1 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr_NLA_HDRLEN); }))) {
            mixin(enumMixinStr_NLA_HDRLEN);
        }
    }




    static if(!is(typeof(O_RSYNC))) {
        private enum enumMixinStr_O_RSYNC = `enum O_RSYNC = O_SYNC;`;
        static if(is(typeof({ mixin(enumMixinStr_O_RSYNC); }))) {
            mixin(enumMixinStr_O_RSYNC);
        }
    }






    static if(!is(typeof(O_DSYNC))) {
        private enum enumMixinStr_O_DSYNC = `enum O_DSYNC = __O_DSYNC;`;
        static if(is(typeof({ mixin(enumMixinStr_O_DSYNC); }))) {
            mixin(enumMixinStr_O_DSYNC);
        }
    }




    static if(!is(typeof(O_CLOEXEC))) {
        private enum enumMixinStr_O_CLOEXEC = `enum O_CLOEXEC = __O_CLOEXEC;`;
        static if(is(typeof({ mixin(enumMixinStr_O_CLOEXEC); }))) {
            mixin(enumMixinStr_O_CLOEXEC);
        }
    }




    static if(!is(typeof(O_NOFOLLOW))) {
        private enum enumMixinStr_O_NOFOLLOW = `enum O_NOFOLLOW = __O_NOFOLLOW;`;
        static if(is(typeof({ mixin(enumMixinStr_O_NOFOLLOW); }))) {
            mixin(enumMixinStr_O_NOFOLLOW);
        }
    }




    static if(!is(typeof(O_DIRECTORY))) {
        private enum enumMixinStr_O_DIRECTORY = `enum O_DIRECTORY = __O_DIRECTORY;`;
        static if(is(typeof({ mixin(enumMixinStr_O_DIRECTORY); }))) {
            mixin(enumMixinStr_O_DIRECTORY);
        }
    }




    static if(!is(typeof(F_SETLKW))) {
        private enum enumMixinStr_F_SETLKW = `enum F_SETLKW = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETLKW); }))) {
            mixin(enumMixinStr_F_SETLKW);
        }
    }




    static if(!is(typeof(F_SETLK))) {
        private enum enumMixinStr_F_SETLK = `enum F_SETLK = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_F_SETLK); }))) {
            mixin(enumMixinStr_F_SETLK);
        }
    }




    static if(!is(typeof(F_GETLK))) {
        private enum enumMixinStr_F_GETLK = `enum F_GETLK = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_F_GETLK); }))) {
            mixin(enumMixinStr_F_GETLK);
        }
    }




    static if(!is(typeof(__O_TMPFILE))) {
        private enum enumMixinStr___O_TMPFILE = `enum __O_TMPFILE = ( 020000000 | __O_DIRECTORY );`;
        static if(is(typeof({ mixin(enumMixinStr___O_TMPFILE); }))) {
            mixin(enumMixinStr___O_TMPFILE);
        }
    }






    static if(!is(typeof(__O_DSYNC))) {
        private enum enumMixinStr___O_DSYNC = `enum __O_DSYNC = std.conv.octal!10000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_DSYNC); }))) {
            mixin(enumMixinStr___O_DSYNC);
        }
    }




    static if(!is(typeof(__O_PATH))) {
        private enum enumMixinStr___O_PATH = `enum __O_PATH = std.conv.octal!10000000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_PATH); }))) {
            mixin(enumMixinStr___O_PATH);
        }
    }




    static if(!is(typeof(__O_NOATIME))) {
        private enum enumMixinStr___O_NOATIME = `enum __O_NOATIME = std.conv.octal!1000000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_NOATIME); }))) {
            mixin(enumMixinStr___O_NOATIME);
        }
    }




    static if(!is(typeof(__O_DIRECT))) {
        private enum enumMixinStr___O_DIRECT = `enum __O_DIRECT = std.conv.octal!40000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_DIRECT); }))) {
            mixin(enumMixinStr___O_DIRECT);
        }
    }




    static if(!is(typeof(__O_CLOEXEC))) {
        private enum enumMixinStr___O_CLOEXEC = `enum __O_CLOEXEC = std.conv.octal!2000000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_CLOEXEC); }))) {
            mixin(enumMixinStr___O_CLOEXEC);
        }
    }




    static if(!is(typeof(RTNL_FAMILY_IPMR))) {
        private enum enumMixinStr_RTNL_FAMILY_IPMR = `enum RTNL_FAMILY_IPMR = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNL_FAMILY_IPMR); }))) {
            mixin(enumMixinStr_RTNL_FAMILY_IPMR);
        }
    }




    static if(!is(typeof(RTNL_FAMILY_IP6MR))) {
        private enum enumMixinStr_RTNL_FAMILY_IP6MR = `enum RTNL_FAMILY_IP6MR = 129;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNL_FAMILY_IP6MR); }))) {
            mixin(enumMixinStr_RTNL_FAMILY_IP6MR);
        }
    }




    static if(!is(typeof(RTNL_FAMILY_MAX))) {
        private enum enumMixinStr_RTNL_FAMILY_MAX = `enum RTNL_FAMILY_MAX = 129;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNL_FAMILY_MAX); }))) {
            mixin(enumMixinStr_RTNL_FAMILY_MAX);
        }
    }




    static if(!is(typeof(__O_NOFOLLOW))) {
        private enum enumMixinStr___O_NOFOLLOW = `enum __O_NOFOLLOW = std.conv.octal!400000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_NOFOLLOW); }))) {
            mixin(enumMixinStr___O_NOFOLLOW);
        }
    }




    static if(!is(typeof(RTM_BASE))) {
        private enum enumMixinStr_RTM_BASE = `enum RTM_BASE = RTM_BASE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_BASE); }))) {
            mixin(enumMixinStr_RTM_BASE);
        }
    }




    static if(!is(typeof(RTM_NEWLINK))) {
        private enum enumMixinStr_RTM_NEWLINK = `enum RTM_NEWLINK = RTM_NEWLINK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWLINK); }))) {
            mixin(enumMixinStr_RTM_NEWLINK);
        }
    }




    static if(!is(typeof(RTM_DELLINK))) {
        private enum enumMixinStr_RTM_DELLINK = `enum RTM_DELLINK = RTM_DELLINK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELLINK); }))) {
            mixin(enumMixinStr_RTM_DELLINK);
        }
    }




    static if(!is(typeof(RTM_GETLINK))) {
        private enum enumMixinStr_RTM_GETLINK = `enum RTM_GETLINK = RTM_GETLINK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETLINK); }))) {
            mixin(enumMixinStr_RTM_GETLINK);
        }
    }




    static if(!is(typeof(RTM_SETLINK))) {
        private enum enumMixinStr_RTM_SETLINK = `enum RTM_SETLINK = RTM_SETLINK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_SETLINK); }))) {
            mixin(enumMixinStr_RTM_SETLINK);
        }
    }




    static if(!is(typeof(RTM_NEWADDR))) {
        private enum enumMixinStr_RTM_NEWADDR = `enum RTM_NEWADDR = RTM_NEWADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWADDR); }))) {
            mixin(enumMixinStr_RTM_NEWADDR);
        }
    }




    static if(!is(typeof(RTM_DELADDR))) {
        private enum enumMixinStr_RTM_DELADDR = `enum RTM_DELADDR = RTM_DELADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELADDR); }))) {
            mixin(enumMixinStr_RTM_DELADDR);
        }
    }




    static if(!is(typeof(RTM_GETADDR))) {
        private enum enumMixinStr_RTM_GETADDR = `enum RTM_GETADDR = RTM_GETADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETADDR); }))) {
            mixin(enumMixinStr_RTM_GETADDR);
        }
    }




    static if(!is(typeof(RTM_NEWROUTE))) {
        private enum enumMixinStr_RTM_NEWROUTE = `enum RTM_NEWROUTE = RTM_NEWROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWROUTE); }))) {
            mixin(enumMixinStr_RTM_NEWROUTE);
        }
    }




    static if(!is(typeof(RTM_DELROUTE))) {
        private enum enumMixinStr_RTM_DELROUTE = `enum RTM_DELROUTE = RTM_DELROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELROUTE); }))) {
            mixin(enumMixinStr_RTM_DELROUTE);
        }
    }




    static if(!is(typeof(RTM_GETROUTE))) {
        private enum enumMixinStr_RTM_GETROUTE = `enum RTM_GETROUTE = RTM_GETROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETROUTE); }))) {
            mixin(enumMixinStr_RTM_GETROUTE);
        }
    }




    static if(!is(typeof(RTM_NEWNEIGH))) {
        private enum enumMixinStr_RTM_NEWNEIGH = `enum RTM_NEWNEIGH = RTM_NEWNEIGH;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWNEIGH); }))) {
            mixin(enumMixinStr_RTM_NEWNEIGH);
        }
    }




    static if(!is(typeof(RTM_DELNEIGH))) {
        private enum enumMixinStr_RTM_DELNEIGH = `enum RTM_DELNEIGH = RTM_DELNEIGH;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELNEIGH); }))) {
            mixin(enumMixinStr_RTM_DELNEIGH);
        }
    }




    static if(!is(typeof(RTM_GETNEIGH))) {
        private enum enumMixinStr_RTM_GETNEIGH = `enum RTM_GETNEIGH = RTM_GETNEIGH;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETNEIGH); }))) {
            mixin(enumMixinStr_RTM_GETNEIGH);
        }
    }




    static if(!is(typeof(RTM_NEWRULE))) {
        private enum enumMixinStr_RTM_NEWRULE = `enum RTM_NEWRULE = RTM_NEWRULE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWRULE); }))) {
            mixin(enumMixinStr_RTM_NEWRULE);
        }
    }




    static if(!is(typeof(RTM_DELRULE))) {
        private enum enumMixinStr_RTM_DELRULE = `enum RTM_DELRULE = RTM_DELRULE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELRULE); }))) {
            mixin(enumMixinStr_RTM_DELRULE);
        }
    }




    static if(!is(typeof(RTM_GETRULE))) {
        private enum enumMixinStr_RTM_GETRULE = `enum RTM_GETRULE = RTM_GETRULE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETRULE); }))) {
            mixin(enumMixinStr_RTM_GETRULE);
        }
    }




    static if(!is(typeof(RTM_NEWQDISC))) {
        private enum enumMixinStr_RTM_NEWQDISC = `enum RTM_NEWQDISC = RTM_NEWQDISC;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWQDISC); }))) {
            mixin(enumMixinStr_RTM_NEWQDISC);
        }
    }




    static if(!is(typeof(RTM_DELQDISC))) {
        private enum enumMixinStr_RTM_DELQDISC = `enum RTM_DELQDISC = RTM_DELQDISC;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELQDISC); }))) {
            mixin(enumMixinStr_RTM_DELQDISC);
        }
    }




    static if(!is(typeof(RTM_GETQDISC))) {
        private enum enumMixinStr_RTM_GETQDISC = `enum RTM_GETQDISC = RTM_GETQDISC;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETQDISC); }))) {
            mixin(enumMixinStr_RTM_GETQDISC);
        }
    }




    static if(!is(typeof(RTM_NEWTCLASS))) {
        private enum enumMixinStr_RTM_NEWTCLASS = `enum RTM_NEWTCLASS = RTM_NEWTCLASS;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWTCLASS); }))) {
            mixin(enumMixinStr_RTM_NEWTCLASS);
        }
    }




    static if(!is(typeof(RTM_DELTCLASS))) {
        private enum enumMixinStr_RTM_DELTCLASS = `enum RTM_DELTCLASS = RTM_DELTCLASS;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELTCLASS); }))) {
            mixin(enumMixinStr_RTM_DELTCLASS);
        }
    }




    static if(!is(typeof(RTM_GETTCLASS))) {
        private enum enumMixinStr_RTM_GETTCLASS = `enum RTM_GETTCLASS = RTM_GETTCLASS;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETTCLASS); }))) {
            mixin(enumMixinStr_RTM_GETTCLASS);
        }
    }




    static if(!is(typeof(RTM_NEWTFILTER))) {
        private enum enumMixinStr_RTM_NEWTFILTER = `enum RTM_NEWTFILTER = RTM_NEWTFILTER;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWTFILTER); }))) {
            mixin(enumMixinStr_RTM_NEWTFILTER);
        }
    }




    static if(!is(typeof(RTM_DELTFILTER))) {
        private enum enumMixinStr_RTM_DELTFILTER = `enum RTM_DELTFILTER = RTM_DELTFILTER;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELTFILTER); }))) {
            mixin(enumMixinStr_RTM_DELTFILTER);
        }
    }




    static if(!is(typeof(RTM_GETTFILTER))) {
        private enum enumMixinStr_RTM_GETTFILTER = `enum RTM_GETTFILTER = RTM_GETTFILTER;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETTFILTER); }))) {
            mixin(enumMixinStr_RTM_GETTFILTER);
        }
    }




    static if(!is(typeof(RTM_NEWACTION))) {
        private enum enumMixinStr_RTM_NEWACTION = `enum RTM_NEWACTION = RTM_NEWACTION;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWACTION); }))) {
            mixin(enumMixinStr_RTM_NEWACTION);
        }
    }




    static if(!is(typeof(RTM_DELACTION))) {
        private enum enumMixinStr_RTM_DELACTION = `enum RTM_DELACTION = RTM_DELACTION;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELACTION); }))) {
            mixin(enumMixinStr_RTM_DELACTION);
        }
    }




    static if(!is(typeof(RTM_GETACTION))) {
        private enum enumMixinStr_RTM_GETACTION = `enum RTM_GETACTION = RTM_GETACTION;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETACTION); }))) {
            mixin(enumMixinStr_RTM_GETACTION);
        }
    }




    static if(!is(typeof(RTM_NEWPREFIX))) {
        private enum enumMixinStr_RTM_NEWPREFIX = `enum RTM_NEWPREFIX = RTM_NEWPREFIX;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWPREFIX); }))) {
            mixin(enumMixinStr_RTM_NEWPREFIX);
        }
    }




    static if(!is(typeof(RTM_GETMULTICAST))) {
        private enum enumMixinStr_RTM_GETMULTICAST = `enum RTM_GETMULTICAST = RTM_GETMULTICAST;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETMULTICAST); }))) {
            mixin(enumMixinStr_RTM_GETMULTICAST);
        }
    }




    static if(!is(typeof(RTM_GETANYCAST))) {
        private enum enumMixinStr_RTM_GETANYCAST = `enum RTM_GETANYCAST = RTM_GETANYCAST;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETANYCAST); }))) {
            mixin(enumMixinStr_RTM_GETANYCAST);
        }
    }




    static if(!is(typeof(RTM_NEWNEIGHTBL))) {
        private enum enumMixinStr_RTM_NEWNEIGHTBL = `enum RTM_NEWNEIGHTBL = RTM_NEWNEIGHTBL;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWNEIGHTBL); }))) {
            mixin(enumMixinStr_RTM_NEWNEIGHTBL);
        }
    }




    static if(!is(typeof(RTM_GETNEIGHTBL))) {
        private enum enumMixinStr_RTM_GETNEIGHTBL = `enum RTM_GETNEIGHTBL = RTM_GETNEIGHTBL;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETNEIGHTBL); }))) {
            mixin(enumMixinStr_RTM_GETNEIGHTBL);
        }
    }




    static if(!is(typeof(RTM_SETNEIGHTBL))) {
        private enum enumMixinStr_RTM_SETNEIGHTBL = `enum RTM_SETNEIGHTBL = RTM_SETNEIGHTBL;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_SETNEIGHTBL); }))) {
            mixin(enumMixinStr_RTM_SETNEIGHTBL);
        }
    }




    static if(!is(typeof(RTM_NEWNDUSEROPT))) {
        private enum enumMixinStr_RTM_NEWNDUSEROPT = `enum RTM_NEWNDUSEROPT = RTM_NEWNDUSEROPT;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWNDUSEROPT); }))) {
            mixin(enumMixinStr_RTM_NEWNDUSEROPT);
        }
    }




    static if(!is(typeof(RTM_NEWADDRLABEL))) {
        private enum enumMixinStr_RTM_NEWADDRLABEL = `enum RTM_NEWADDRLABEL = RTM_NEWADDRLABEL;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWADDRLABEL); }))) {
            mixin(enumMixinStr_RTM_NEWADDRLABEL);
        }
    }




    static if(!is(typeof(RTM_DELADDRLABEL))) {
        private enum enumMixinStr_RTM_DELADDRLABEL = `enum RTM_DELADDRLABEL = RTM_DELADDRLABEL;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELADDRLABEL); }))) {
            mixin(enumMixinStr_RTM_DELADDRLABEL);
        }
    }




    static if(!is(typeof(RTM_GETADDRLABEL))) {
        private enum enumMixinStr_RTM_GETADDRLABEL = `enum RTM_GETADDRLABEL = RTM_GETADDRLABEL;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETADDRLABEL); }))) {
            mixin(enumMixinStr_RTM_GETADDRLABEL);
        }
    }




    static if(!is(typeof(RTM_GETDCB))) {
        private enum enumMixinStr_RTM_GETDCB = `enum RTM_GETDCB = RTM_GETDCB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETDCB); }))) {
            mixin(enumMixinStr_RTM_GETDCB);
        }
    }




    static if(!is(typeof(RTM_SETDCB))) {
        private enum enumMixinStr_RTM_SETDCB = `enum RTM_SETDCB = RTM_SETDCB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_SETDCB); }))) {
            mixin(enumMixinStr_RTM_SETDCB);
        }
    }




    static if(!is(typeof(RTM_NEWNETCONF))) {
        private enum enumMixinStr_RTM_NEWNETCONF = `enum RTM_NEWNETCONF = RTM_NEWNETCONF;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWNETCONF); }))) {
            mixin(enumMixinStr_RTM_NEWNETCONF);
        }
    }




    static if(!is(typeof(RTM_DELNETCONF))) {
        private enum enumMixinStr_RTM_DELNETCONF = `enum RTM_DELNETCONF = RTM_DELNETCONF;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELNETCONF); }))) {
            mixin(enumMixinStr_RTM_DELNETCONF);
        }
    }




    static if(!is(typeof(RTM_GETNETCONF))) {
        private enum enumMixinStr_RTM_GETNETCONF = `enum RTM_GETNETCONF = RTM_GETNETCONF;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETNETCONF); }))) {
            mixin(enumMixinStr_RTM_GETNETCONF);
        }
    }




    static if(!is(typeof(RTM_NEWMDB))) {
        private enum enumMixinStr_RTM_NEWMDB = `enum RTM_NEWMDB = RTM_NEWMDB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWMDB); }))) {
            mixin(enumMixinStr_RTM_NEWMDB);
        }
    }




    static if(!is(typeof(RTM_DELMDB))) {
        private enum enumMixinStr_RTM_DELMDB = `enum RTM_DELMDB = RTM_DELMDB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELMDB); }))) {
            mixin(enumMixinStr_RTM_DELMDB);
        }
    }




    static if(!is(typeof(RTM_GETMDB))) {
        private enum enumMixinStr_RTM_GETMDB = `enum RTM_GETMDB = RTM_GETMDB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETMDB); }))) {
            mixin(enumMixinStr_RTM_GETMDB);
        }
    }




    static if(!is(typeof(RTM_NEWNSID))) {
        private enum enumMixinStr_RTM_NEWNSID = `enum RTM_NEWNSID = RTM_NEWNSID;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWNSID); }))) {
            mixin(enumMixinStr_RTM_NEWNSID);
        }
    }




    static if(!is(typeof(RTM_DELNSID))) {
        private enum enumMixinStr_RTM_DELNSID = `enum RTM_DELNSID = RTM_DELNSID;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELNSID); }))) {
            mixin(enumMixinStr_RTM_DELNSID);
        }
    }




    static if(!is(typeof(RTM_GETNSID))) {
        private enum enumMixinStr_RTM_GETNSID = `enum RTM_GETNSID = RTM_GETNSID;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETNSID); }))) {
            mixin(enumMixinStr_RTM_GETNSID);
        }
    }




    static if(!is(typeof(RTM_NEWSTATS))) {
        private enum enumMixinStr_RTM_NEWSTATS = `enum RTM_NEWSTATS = RTM_NEWSTATS;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWSTATS); }))) {
            mixin(enumMixinStr_RTM_NEWSTATS);
        }
    }




    static if(!is(typeof(RTM_GETSTATS))) {
        private enum enumMixinStr_RTM_GETSTATS = `enum RTM_GETSTATS = RTM_GETSTATS;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETSTATS); }))) {
            mixin(enumMixinStr_RTM_GETSTATS);
        }
    }




    static if(!is(typeof(RTM_NEWCACHEREPORT))) {
        private enum enumMixinStr_RTM_NEWCACHEREPORT = `enum RTM_NEWCACHEREPORT = RTM_NEWCACHEREPORT;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWCACHEREPORT); }))) {
            mixin(enumMixinStr_RTM_NEWCACHEREPORT);
        }
    }




    static if(!is(typeof(RTM_NEWCHAIN))) {
        private enum enumMixinStr_RTM_NEWCHAIN = `enum RTM_NEWCHAIN = RTM_NEWCHAIN;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWCHAIN); }))) {
            mixin(enumMixinStr_RTM_NEWCHAIN);
        }
    }




    static if(!is(typeof(RTM_DELCHAIN))) {
        private enum enumMixinStr_RTM_DELCHAIN = `enum RTM_DELCHAIN = RTM_DELCHAIN;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELCHAIN); }))) {
            mixin(enumMixinStr_RTM_DELCHAIN);
        }
    }




    static if(!is(typeof(RTM_GETCHAIN))) {
        private enum enumMixinStr_RTM_GETCHAIN = `enum RTM_GETCHAIN = RTM_GETCHAIN;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETCHAIN); }))) {
            mixin(enumMixinStr_RTM_GETCHAIN);
        }
    }




    static if(!is(typeof(RTM_NEWNEXTHOP))) {
        private enum enumMixinStr_RTM_NEWNEXTHOP = `enum RTM_NEWNEXTHOP = RTM_NEWNEXTHOP;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NEWNEXTHOP); }))) {
            mixin(enumMixinStr_RTM_NEWNEXTHOP);
        }
    }




    static if(!is(typeof(RTM_DELNEXTHOP))) {
        private enum enumMixinStr_RTM_DELNEXTHOP = `enum RTM_DELNEXTHOP = RTM_DELNEXTHOP;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_DELNEXTHOP); }))) {
            mixin(enumMixinStr_RTM_DELNEXTHOP);
        }
    }




    static if(!is(typeof(RTM_GETNEXTHOP))) {
        private enum enumMixinStr_RTM_GETNEXTHOP = `enum RTM_GETNEXTHOP = RTM_GETNEXTHOP;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_GETNEXTHOP); }))) {
            mixin(enumMixinStr_RTM_GETNEXTHOP);
        }
    }




    static if(!is(typeof(RTM_MAX))) {
        private enum enumMixinStr_RTM_MAX = `enum RTM_MAX = ( ( ( __RTM_MAX + 3 ) & ~ 3 ) - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_MAX); }))) {
            mixin(enumMixinStr_RTM_MAX);
        }
    }




    static if(!is(typeof(RTM_NR_MSGTYPES))) {
        private enum enumMixinStr_RTM_NR_MSGTYPES = `enum RTM_NR_MSGTYPES = ( ( ( ( __RTM_MAX + 3 ) & ~ 3 ) - 1 ) + 1 - RTM_BASE );`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NR_MSGTYPES); }))) {
            mixin(enumMixinStr_RTM_NR_MSGTYPES);
        }
    }




    static if(!is(typeof(RTM_NR_FAMILIES))) {
        private enum enumMixinStr_RTM_NR_FAMILIES = `enum RTM_NR_FAMILIES = ( ( ( ( ( __RTM_MAX + 3 ) & ~ 3 ) - 1 ) + 1 - RTM_BASE ) >> 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_NR_FAMILIES); }))) {
            mixin(enumMixinStr_RTM_NR_FAMILIES);
        }
    }






    static if(!is(typeof(__O_DIRECTORY))) {
        private enum enumMixinStr___O_DIRECTORY = `enum __O_DIRECTORY = std.conv.octal!200000;`;
        static if(is(typeof({ mixin(enumMixinStr___O_DIRECTORY); }))) {
            mixin(enumMixinStr___O_DIRECTORY);
        }
    }




    static if(!is(typeof(RTA_ALIGNTO))) {
        private enum enumMixinStr_RTA_ALIGNTO = `enum RTA_ALIGNTO = 4U;`;
        static if(is(typeof({ mixin(enumMixinStr_RTA_ALIGNTO); }))) {
            mixin(enumMixinStr_RTA_ALIGNTO);
        }
    }
    static if(!is(typeof(O_ASYNC))) {
        private enum enumMixinStr_O_ASYNC = `enum O_ASYNC = std.conv.octal!20000;`;
        static if(is(typeof({ mixin(enumMixinStr_O_ASYNC); }))) {
            mixin(enumMixinStr_O_ASYNC);
        }
    }




    static if(!is(typeof(O_FSYNC))) {
        private enum enumMixinStr_O_FSYNC = `enum O_FSYNC = O_SYNC;`;
        static if(is(typeof({ mixin(enumMixinStr_O_FSYNC); }))) {
            mixin(enumMixinStr_O_FSYNC);
        }
    }




    static if(!is(typeof(RTN_MAX))) {
        private enum enumMixinStr_RTN_MAX = `enum RTN_MAX = ( __RTN_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTN_MAX); }))) {
            mixin(enumMixinStr_RTN_MAX);
        }
    }




    static if(!is(typeof(RTPROT_UNSPEC))) {
        private enum enumMixinStr_RTPROT_UNSPEC = `enum RTPROT_UNSPEC = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_UNSPEC); }))) {
            mixin(enumMixinStr_RTPROT_UNSPEC);
        }
    }




    static if(!is(typeof(RTPROT_REDIRECT))) {
        private enum enumMixinStr_RTPROT_REDIRECT = `enum RTPROT_REDIRECT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_REDIRECT); }))) {
            mixin(enumMixinStr_RTPROT_REDIRECT);
        }
    }




    static if(!is(typeof(RTPROT_KERNEL))) {
        private enum enumMixinStr_RTPROT_KERNEL = `enum RTPROT_KERNEL = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_KERNEL); }))) {
            mixin(enumMixinStr_RTPROT_KERNEL);
        }
    }




    static if(!is(typeof(RTPROT_BOOT))) {
        private enum enumMixinStr_RTPROT_BOOT = `enum RTPROT_BOOT = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_BOOT); }))) {
            mixin(enumMixinStr_RTPROT_BOOT);
        }
    }




    static if(!is(typeof(RTPROT_STATIC))) {
        private enum enumMixinStr_RTPROT_STATIC = `enum RTPROT_STATIC = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_STATIC); }))) {
            mixin(enumMixinStr_RTPROT_STATIC);
        }
    }




    static if(!is(typeof(RTPROT_GATED))) {
        private enum enumMixinStr_RTPROT_GATED = `enum RTPROT_GATED = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_GATED); }))) {
            mixin(enumMixinStr_RTPROT_GATED);
        }
    }




    static if(!is(typeof(RTPROT_RA))) {
        private enum enumMixinStr_RTPROT_RA = `enum RTPROT_RA = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_RA); }))) {
            mixin(enumMixinStr_RTPROT_RA);
        }
    }




    static if(!is(typeof(RTPROT_MRT))) {
        private enum enumMixinStr_RTPROT_MRT = `enum RTPROT_MRT = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_MRT); }))) {
            mixin(enumMixinStr_RTPROT_MRT);
        }
    }




    static if(!is(typeof(RTPROT_ZEBRA))) {
        private enum enumMixinStr_RTPROT_ZEBRA = `enum RTPROT_ZEBRA = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_ZEBRA); }))) {
            mixin(enumMixinStr_RTPROT_ZEBRA);
        }
    }




    static if(!is(typeof(RTPROT_BIRD))) {
        private enum enumMixinStr_RTPROT_BIRD = `enum RTPROT_BIRD = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_BIRD); }))) {
            mixin(enumMixinStr_RTPROT_BIRD);
        }
    }




    static if(!is(typeof(RTPROT_DNROUTED))) {
        private enum enumMixinStr_RTPROT_DNROUTED = `enum RTPROT_DNROUTED = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_DNROUTED); }))) {
            mixin(enumMixinStr_RTPROT_DNROUTED);
        }
    }




    static if(!is(typeof(RTPROT_XORP))) {
        private enum enumMixinStr_RTPROT_XORP = `enum RTPROT_XORP = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_XORP); }))) {
            mixin(enumMixinStr_RTPROT_XORP);
        }
    }




    static if(!is(typeof(RTPROT_NTK))) {
        private enum enumMixinStr_RTPROT_NTK = `enum RTPROT_NTK = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_NTK); }))) {
            mixin(enumMixinStr_RTPROT_NTK);
        }
    }




    static if(!is(typeof(RTPROT_DHCP))) {
        private enum enumMixinStr_RTPROT_DHCP = `enum RTPROT_DHCP = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_DHCP); }))) {
            mixin(enumMixinStr_RTPROT_DHCP);
        }
    }




    static if(!is(typeof(RTPROT_MROUTED))) {
        private enum enumMixinStr_RTPROT_MROUTED = `enum RTPROT_MROUTED = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_MROUTED); }))) {
            mixin(enumMixinStr_RTPROT_MROUTED);
        }
    }




    static if(!is(typeof(RTPROT_BABEL))) {
        private enum enumMixinStr_RTPROT_BABEL = `enum RTPROT_BABEL = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_BABEL); }))) {
            mixin(enumMixinStr_RTPROT_BABEL);
        }
    }




    static if(!is(typeof(RTPROT_BGP))) {
        private enum enumMixinStr_RTPROT_BGP = `enum RTPROT_BGP = 186;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_BGP); }))) {
            mixin(enumMixinStr_RTPROT_BGP);
        }
    }




    static if(!is(typeof(RTPROT_ISIS))) {
        private enum enumMixinStr_RTPROT_ISIS = `enum RTPROT_ISIS = 187;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_ISIS); }))) {
            mixin(enumMixinStr_RTPROT_ISIS);
        }
    }




    static if(!is(typeof(RTPROT_OSPF))) {
        private enum enumMixinStr_RTPROT_OSPF = `enum RTPROT_OSPF = 188;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_OSPF); }))) {
            mixin(enumMixinStr_RTPROT_OSPF);
        }
    }




    static if(!is(typeof(RTPROT_RIP))) {
        private enum enumMixinStr_RTPROT_RIP = `enum RTPROT_RIP = 189;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_RIP); }))) {
            mixin(enumMixinStr_RTPROT_RIP);
        }
    }




    static if(!is(typeof(RTPROT_EIGRP))) {
        private enum enumMixinStr_RTPROT_EIGRP = `enum RTPROT_EIGRP = 192;`;
        static if(is(typeof({ mixin(enumMixinStr_RTPROT_EIGRP); }))) {
            mixin(enumMixinStr_RTPROT_EIGRP);
        }
    }




    static if(!is(typeof(O_SYNC))) {
        private enum enumMixinStr_O_SYNC = `enum O_SYNC = std.conv.octal!4010000;`;
        static if(is(typeof({ mixin(enumMixinStr_O_SYNC); }))) {
            mixin(enumMixinStr_O_SYNC);
        }
    }




    static if(!is(typeof(RTM_F_NOTIFY))) {
        private enum enumMixinStr_RTM_F_NOTIFY = `enum RTM_F_NOTIFY = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_F_NOTIFY); }))) {
            mixin(enumMixinStr_RTM_F_NOTIFY);
        }
    }




    static if(!is(typeof(RTM_F_CLONED))) {
        private enum enumMixinStr_RTM_F_CLONED = `enum RTM_F_CLONED = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_F_CLONED); }))) {
            mixin(enumMixinStr_RTM_F_CLONED);
        }
    }




    static if(!is(typeof(RTM_F_EQUALIZE))) {
        private enum enumMixinStr_RTM_F_EQUALIZE = `enum RTM_F_EQUALIZE = 0x400;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_F_EQUALIZE); }))) {
            mixin(enumMixinStr_RTM_F_EQUALIZE);
        }
    }




    static if(!is(typeof(RTM_F_PREFIX))) {
        private enum enumMixinStr_RTM_F_PREFIX = `enum RTM_F_PREFIX = 0x800;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_F_PREFIX); }))) {
            mixin(enumMixinStr_RTM_F_PREFIX);
        }
    }




    static if(!is(typeof(RTM_F_LOOKUP_TABLE))) {
        private enum enumMixinStr_RTM_F_LOOKUP_TABLE = `enum RTM_F_LOOKUP_TABLE = 0x1000;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_F_LOOKUP_TABLE); }))) {
            mixin(enumMixinStr_RTM_F_LOOKUP_TABLE);
        }
    }




    static if(!is(typeof(RTM_F_FIB_MATCH))) {
        private enum enumMixinStr_RTM_F_FIB_MATCH = `enum RTM_F_FIB_MATCH = 0x2000;`;
        static if(is(typeof({ mixin(enumMixinStr_RTM_F_FIB_MATCH); }))) {
            mixin(enumMixinStr_RTM_F_FIB_MATCH);
        }
    }




    static if(!is(typeof(O_NDELAY))) {
        private enum enumMixinStr_O_NDELAY = `enum O_NDELAY = O_NONBLOCK;`;
        static if(is(typeof({ mixin(enumMixinStr_O_NDELAY); }))) {
            mixin(enumMixinStr_O_NDELAY);
        }
    }




    static if(!is(typeof(O_NONBLOCK))) {
        private enum enumMixinStr_O_NONBLOCK = `enum O_NONBLOCK = std.conv.octal!4000;`;
        static if(is(typeof({ mixin(enumMixinStr_O_NONBLOCK); }))) {
            mixin(enumMixinStr_O_NONBLOCK);
        }
    }




    static if(!is(typeof(RTA_MAX))) {
        private enum enumMixinStr_RTA_MAX = `enum RTA_MAX = ( __RTA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTA_MAX); }))) {
            mixin(enumMixinStr_RTA_MAX);
        }
    }
    static if(!is(typeof(O_APPEND))) {
        private enum enumMixinStr_O_APPEND = `enum O_APPEND = std.conv.octal!2000;`;
        static if(is(typeof({ mixin(enumMixinStr_O_APPEND); }))) {
            mixin(enumMixinStr_O_APPEND);
        }
    }




    static if(!is(typeof(RTNH_F_DEAD))) {
        private enum enumMixinStr_RTNH_F_DEAD = `enum RTNH_F_DEAD = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_F_DEAD); }))) {
            mixin(enumMixinStr_RTNH_F_DEAD);
        }
    }




    static if(!is(typeof(RTNH_F_PERVASIVE))) {
        private enum enumMixinStr_RTNH_F_PERVASIVE = `enum RTNH_F_PERVASIVE = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_F_PERVASIVE); }))) {
            mixin(enumMixinStr_RTNH_F_PERVASIVE);
        }
    }




    static if(!is(typeof(RTNH_F_ONLINK))) {
        private enum enumMixinStr_RTNH_F_ONLINK = `enum RTNH_F_ONLINK = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_F_ONLINK); }))) {
            mixin(enumMixinStr_RTNH_F_ONLINK);
        }
    }




    static if(!is(typeof(RTNH_F_OFFLOAD))) {
        private enum enumMixinStr_RTNH_F_OFFLOAD = `enum RTNH_F_OFFLOAD = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_F_OFFLOAD); }))) {
            mixin(enumMixinStr_RTNH_F_OFFLOAD);
        }
    }




    static if(!is(typeof(RTNH_F_LINKDOWN))) {
        private enum enumMixinStr_RTNH_F_LINKDOWN = `enum RTNH_F_LINKDOWN = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_F_LINKDOWN); }))) {
            mixin(enumMixinStr_RTNH_F_LINKDOWN);
        }
    }




    static if(!is(typeof(RTNH_F_UNRESOLVED))) {
        private enum enumMixinStr_RTNH_F_UNRESOLVED = `enum RTNH_F_UNRESOLVED = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_F_UNRESOLVED); }))) {
            mixin(enumMixinStr_RTNH_F_UNRESOLVED);
        }
    }




    static if(!is(typeof(RTNH_COMPARE_MASK))) {
        private enum enumMixinStr_RTNH_COMPARE_MASK = `enum RTNH_COMPARE_MASK = ( 1 | 16 | 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_COMPARE_MASK); }))) {
            mixin(enumMixinStr_RTNH_COMPARE_MASK);
        }
    }




    static if(!is(typeof(RTNH_ALIGNTO))) {
        private enum enumMixinStr_RTNH_ALIGNTO = `enum RTNH_ALIGNTO = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNH_ALIGNTO); }))) {
            mixin(enumMixinStr_RTNH_ALIGNTO);
        }
    }
    static if(!is(typeof(O_TRUNC))) {
        private enum enumMixinStr_O_TRUNC = `enum O_TRUNC = std.conv.octal!1000;`;
        static if(is(typeof({ mixin(enumMixinStr_O_TRUNC); }))) {
            mixin(enumMixinStr_O_TRUNC);
        }
    }




    static if(!is(typeof(O_NOCTTY))) {
        private enum enumMixinStr_O_NOCTTY = `enum O_NOCTTY = std.conv.octal!400;`;
        static if(is(typeof({ mixin(enumMixinStr_O_NOCTTY); }))) {
            mixin(enumMixinStr_O_NOCTTY);
        }
    }




    static if(!is(typeof(RTNETLINK_HAVE_PEERINFO))) {
        private enum enumMixinStr_RTNETLINK_HAVE_PEERINFO = `enum RTNETLINK_HAVE_PEERINFO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNETLINK_HAVE_PEERINFO); }))) {
            mixin(enumMixinStr_RTNETLINK_HAVE_PEERINFO);
        }
    }




    static if(!is(typeof(O_EXCL))) {
        private enum enumMixinStr_O_EXCL = `enum O_EXCL = std.conv.octal!200;`;
        static if(is(typeof({ mixin(enumMixinStr_O_EXCL); }))) {
            mixin(enumMixinStr_O_EXCL);
        }
    }




    static if(!is(typeof(RTAX_UNSPEC))) {
        private enum enumMixinStr_RTAX_UNSPEC = `enum RTAX_UNSPEC = RTAX_UNSPEC;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_UNSPEC); }))) {
            mixin(enumMixinStr_RTAX_UNSPEC);
        }
    }




    static if(!is(typeof(RTAX_LOCK))) {
        private enum enumMixinStr_RTAX_LOCK = `enum RTAX_LOCK = RTAX_LOCK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_LOCK); }))) {
            mixin(enumMixinStr_RTAX_LOCK);
        }
    }




    static if(!is(typeof(RTAX_MTU))) {
        private enum enumMixinStr_RTAX_MTU = `enum RTAX_MTU = RTAX_MTU;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_MTU); }))) {
            mixin(enumMixinStr_RTAX_MTU);
        }
    }




    static if(!is(typeof(RTAX_WINDOW))) {
        private enum enumMixinStr_RTAX_WINDOW = `enum RTAX_WINDOW = RTAX_WINDOW;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_WINDOW); }))) {
            mixin(enumMixinStr_RTAX_WINDOW);
        }
    }




    static if(!is(typeof(RTAX_RTT))) {
        private enum enumMixinStr_RTAX_RTT = `enum RTAX_RTT = RTAX_RTT;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_RTT); }))) {
            mixin(enumMixinStr_RTAX_RTT);
        }
    }




    static if(!is(typeof(RTAX_RTTVAR))) {
        private enum enumMixinStr_RTAX_RTTVAR = `enum RTAX_RTTVAR = RTAX_RTTVAR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_RTTVAR); }))) {
            mixin(enumMixinStr_RTAX_RTTVAR);
        }
    }




    static if(!is(typeof(RTAX_SSTHRESH))) {
        private enum enumMixinStr_RTAX_SSTHRESH = `enum RTAX_SSTHRESH = RTAX_SSTHRESH;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_SSTHRESH); }))) {
            mixin(enumMixinStr_RTAX_SSTHRESH);
        }
    }




    static if(!is(typeof(RTAX_CWND))) {
        private enum enumMixinStr_RTAX_CWND = `enum RTAX_CWND = RTAX_CWND;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_CWND); }))) {
            mixin(enumMixinStr_RTAX_CWND);
        }
    }




    static if(!is(typeof(RTAX_ADVMSS))) {
        private enum enumMixinStr_RTAX_ADVMSS = `enum RTAX_ADVMSS = RTAX_ADVMSS;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_ADVMSS); }))) {
            mixin(enumMixinStr_RTAX_ADVMSS);
        }
    }




    static if(!is(typeof(RTAX_REORDERING))) {
        private enum enumMixinStr_RTAX_REORDERING = `enum RTAX_REORDERING = RTAX_REORDERING;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_REORDERING); }))) {
            mixin(enumMixinStr_RTAX_REORDERING);
        }
    }




    static if(!is(typeof(RTAX_HOPLIMIT))) {
        private enum enumMixinStr_RTAX_HOPLIMIT = `enum RTAX_HOPLIMIT = RTAX_HOPLIMIT;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_HOPLIMIT); }))) {
            mixin(enumMixinStr_RTAX_HOPLIMIT);
        }
    }




    static if(!is(typeof(RTAX_INITCWND))) {
        private enum enumMixinStr_RTAX_INITCWND = `enum RTAX_INITCWND = RTAX_INITCWND;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_INITCWND); }))) {
            mixin(enumMixinStr_RTAX_INITCWND);
        }
    }




    static if(!is(typeof(RTAX_FEATURES))) {
        private enum enumMixinStr_RTAX_FEATURES = `enum RTAX_FEATURES = RTAX_FEATURES;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FEATURES); }))) {
            mixin(enumMixinStr_RTAX_FEATURES);
        }
    }




    static if(!is(typeof(RTAX_RTO_MIN))) {
        private enum enumMixinStr_RTAX_RTO_MIN = `enum RTAX_RTO_MIN = RTAX_RTO_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_RTO_MIN); }))) {
            mixin(enumMixinStr_RTAX_RTO_MIN);
        }
    }




    static if(!is(typeof(RTAX_INITRWND))) {
        private enum enumMixinStr_RTAX_INITRWND = `enum RTAX_INITRWND = RTAX_INITRWND;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_INITRWND); }))) {
            mixin(enumMixinStr_RTAX_INITRWND);
        }
    }




    static if(!is(typeof(RTAX_QUICKACK))) {
        private enum enumMixinStr_RTAX_QUICKACK = `enum RTAX_QUICKACK = RTAX_QUICKACK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_QUICKACK); }))) {
            mixin(enumMixinStr_RTAX_QUICKACK);
        }
    }




    static if(!is(typeof(RTAX_CC_ALGO))) {
        private enum enumMixinStr_RTAX_CC_ALGO = `enum RTAX_CC_ALGO = RTAX_CC_ALGO;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_CC_ALGO); }))) {
            mixin(enumMixinStr_RTAX_CC_ALGO);
        }
    }




    static if(!is(typeof(RTAX_FASTOPEN_NO_COOKIE))) {
        private enum enumMixinStr_RTAX_FASTOPEN_NO_COOKIE = `enum RTAX_FASTOPEN_NO_COOKIE = RTAX_FASTOPEN_NO_COOKIE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FASTOPEN_NO_COOKIE); }))) {
            mixin(enumMixinStr_RTAX_FASTOPEN_NO_COOKIE);
        }
    }




    static if(!is(typeof(RTAX_MAX))) {
        private enum enumMixinStr_RTAX_MAX = `enum RTAX_MAX = ( __RTAX_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_MAX); }))) {
            mixin(enumMixinStr_RTAX_MAX);
        }
    }




    static if(!is(typeof(RTAX_FEATURE_ECN))) {
        private enum enumMixinStr_RTAX_FEATURE_ECN = `enum RTAX_FEATURE_ECN = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FEATURE_ECN); }))) {
            mixin(enumMixinStr_RTAX_FEATURE_ECN);
        }
    }




    static if(!is(typeof(RTAX_FEATURE_SACK))) {
        private enum enumMixinStr_RTAX_FEATURE_SACK = `enum RTAX_FEATURE_SACK = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FEATURE_SACK); }))) {
            mixin(enumMixinStr_RTAX_FEATURE_SACK);
        }
    }




    static if(!is(typeof(RTAX_FEATURE_TIMESTAMP))) {
        private enum enumMixinStr_RTAX_FEATURE_TIMESTAMP = `enum RTAX_FEATURE_TIMESTAMP = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FEATURE_TIMESTAMP); }))) {
            mixin(enumMixinStr_RTAX_FEATURE_TIMESTAMP);
        }
    }




    static if(!is(typeof(RTAX_FEATURE_ALLFRAG))) {
        private enum enumMixinStr_RTAX_FEATURE_ALLFRAG = `enum RTAX_FEATURE_ALLFRAG = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FEATURE_ALLFRAG); }))) {
            mixin(enumMixinStr_RTAX_FEATURE_ALLFRAG);
        }
    }




    static if(!is(typeof(RTAX_FEATURE_MASK))) {
        private enum enumMixinStr_RTAX_FEATURE_MASK = `enum RTAX_FEATURE_MASK = ( ( 1 << 0 ) | ( 1 << 1 ) | ( 1 << 2 ) | ( 1 << 3 ) );`;
        static if(is(typeof({ mixin(enumMixinStr_RTAX_FEATURE_MASK); }))) {
            mixin(enumMixinStr_RTAX_FEATURE_MASK);
        }
    }




    static if(!is(typeof(O_CREAT))) {
        private enum enumMixinStr_O_CREAT = `enum O_CREAT = std.conv.octal!100;`;
        static if(is(typeof({ mixin(enumMixinStr_O_CREAT); }))) {
            mixin(enumMixinStr_O_CREAT);
        }
    }




    static if(!is(typeof(O_RDWR))) {
        private enum enumMixinStr_O_RDWR = `enum O_RDWR = std.conv.octal!2;`;
        static if(is(typeof({ mixin(enumMixinStr_O_RDWR); }))) {
            mixin(enumMixinStr_O_RDWR);
        }
    }




    static if(!is(typeof(O_WRONLY))) {
        private enum enumMixinStr_O_WRONLY = `enum O_WRONLY = std.conv.octal!1;`;
        static if(is(typeof({ mixin(enumMixinStr_O_WRONLY); }))) {
            mixin(enumMixinStr_O_WRONLY);
        }
    }




    static if(!is(typeof(O_RDONLY))) {
        private enum enumMixinStr_O_RDONLY = `enum O_RDONLY = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_O_RDONLY); }))) {
            mixin(enumMixinStr_O_RDONLY);
        }
    }




    static if(!is(typeof(O_ACCMODE))) {
        private enum enumMixinStr_O_ACCMODE = `enum O_ACCMODE = std.conv.octal!3;`;
        static if(is(typeof({ mixin(enumMixinStr_O_ACCMODE); }))) {
            mixin(enumMixinStr_O_ACCMODE);
        }
    }




    static if(!is(typeof(ENOTSUP))) {
        private enum enumMixinStr_ENOTSUP = `enum ENOTSUP = EOPNOTSUPP;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTSUP); }))) {
            mixin(enumMixinStr_ENOTSUP);
        }
    }




    static if(!is(typeof(PREFIX_MAX))) {
        private enum enumMixinStr_PREFIX_MAX = `enum PREFIX_MAX = ( __PREFIX_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PREFIX_MAX); }))) {
            mixin(enumMixinStr_PREFIX_MAX);
        }
    }




    static if(!is(typeof(_BITS_ERRNO_H))) {
        private enum enumMixinStr__BITS_ERRNO_H = `enum _BITS_ERRNO_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_ERRNO_H); }))) {
            mixin(enumMixinStr__BITS_ERRNO_H);
        }
    }




    static if(!is(typeof(__LP64_OFF64_LDFLAGS))) {
        private enum enumMixinStr___LP64_OFF64_LDFLAGS = `enum __LP64_OFF64_LDFLAGS = "-m64";`;
        static if(is(typeof({ mixin(enumMixinStr___LP64_OFF64_LDFLAGS); }))) {
            mixin(enumMixinStr___LP64_OFF64_LDFLAGS);
        }
    }




    static if(!is(typeof(tcm_block_index))) {
        private enum enumMixinStr_tcm_block_index = `enum tcm_block_index = tcm_parent;`;
        static if(is(typeof({ mixin(enumMixinStr_tcm_block_index); }))) {
            mixin(enumMixinStr_tcm_block_index);
        }
    }




    static if(!is(typeof(TCM_IFINDEX_MAGIC_BLOCK))) {
        private enum enumMixinStr_TCM_IFINDEX_MAGIC_BLOCK = `enum TCM_IFINDEX_MAGIC_BLOCK = ( 0xFFFFFFFFU );`;
        static if(is(typeof({ mixin(enumMixinStr_TCM_IFINDEX_MAGIC_BLOCK); }))) {
            mixin(enumMixinStr_TCM_IFINDEX_MAGIC_BLOCK);
        }
    }




    static if(!is(typeof(__LP64_OFF64_CFLAGS))) {
        private enum enumMixinStr___LP64_OFF64_CFLAGS = `enum __LP64_OFF64_CFLAGS = "-m64";`;
        static if(is(typeof({ mixin(enumMixinStr___LP64_OFF64_CFLAGS); }))) {
            mixin(enumMixinStr___LP64_OFF64_CFLAGS);
        }
    }




    static if(!is(typeof(TCA_MAX))) {
        private enum enumMixinStr_TCA_MAX = `enum TCA_MAX = ( __TCA_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_TCA_MAX); }))) {
            mixin(enumMixinStr_TCA_MAX);
        }
    }
    static if(!is(typeof(__ILP32_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr___ILP32_OFFBIG_LDFLAGS = `enum __ILP32_OFFBIG_LDFLAGS = "-m32";`;
        static if(is(typeof({ mixin(enumMixinStr___ILP32_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr___ILP32_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(__ILP32_OFFBIG_CFLAGS))) {
        private enum enumMixinStr___ILP32_OFFBIG_CFLAGS = `enum __ILP32_OFFBIG_CFLAGS = "-m32 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64";`;
        static if(is(typeof({ mixin(enumMixinStr___ILP32_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr___ILP32_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(NDUSEROPT_MAX))) {
        private enum enumMixinStr_NDUSEROPT_MAX = `enum NDUSEROPT_MAX = ( __NDUSEROPT_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_NDUSEROPT_MAX); }))) {
            mixin(enumMixinStr_NDUSEROPT_MAX);
        }
    }




    static if(!is(typeof(RTMGRP_LINK))) {
        private enum enumMixinStr_RTMGRP_LINK = `enum RTMGRP_LINK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_LINK); }))) {
            mixin(enumMixinStr_RTMGRP_LINK);
        }
    }




    static if(!is(typeof(RTMGRP_NOTIFY))) {
        private enum enumMixinStr_RTMGRP_NOTIFY = `enum RTMGRP_NOTIFY = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_NOTIFY); }))) {
            mixin(enumMixinStr_RTMGRP_NOTIFY);
        }
    }




    static if(!is(typeof(RTMGRP_NEIGH))) {
        private enum enumMixinStr_RTMGRP_NEIGH = `enum RTMGRP_NEIGH = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_NEIGH); }))) {
            mixin(enumMixinStr_RTMGRP_NEIGH);
        }
    }




    static if(!is(typeof(RTMGRP_TC))) {
        private enum enumMixinStr_RTMGRP_TC = `enum RTMGRP_TC = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_TC); }))) {
            mixin(enumMixinStr_RTMGRP_TC);
        }
    }




    static if(!is(typeof(RTMGRP_IPV4_IFADDR))) {
        private enum enumMixinStr_RTMGRP_IPV4_IFADDR = `enum RTMGRP_IPV4_IFADDR = 0x10;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV4_IFADDR); }))) {
            mixin(enumMixinStr_RTMGRP_IPV4_IFADDR);
        }
    }




    static if(!is(typeof(RTMGRP_IPV4_MROUTE))) {
        private enum enumMixinStr_RTMGRP_IPV4_MROUTE = `enum RTMGRP_IPV4_MROUTE = 0x20;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV4_MROUTE); }))) {
            mixin(enumMixinStr_RTMGRP_IPV4_MROUTE);
        }
    }




    static if(!is(typeof(RTMGRP_IPV4_ROUTE))) {
        private enum enumMixinStr_RTMGRP_IPV4_ROUTE = `enum RTMGRP_IPV4_ROUTE = 0x40;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV4_ROUTE); }))) {
            mixin(enumMixinStr_RTMGRP_IPV4_ROUTE);
        }
    }




    static if(!is(typeof(RTMGRP_IPV4_RULE))) {
        private enum enumMixinStr_RTMGRP_IPV4_RULE = `enum RTMGRP_IPV4_RULE = 0x80;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV4_RULE); }))) {
            mixin(enumMixinStr_RTMGRP_IPV4_RULE);
        }
    }




    static if(!is(typeof(RTMGRP_IPV6_IFADDR))) {
        private enum enumMixinStr_RTMGRP_IPV6_IFADDR = `enum RTMGRP_IPV6_IFADDR = 0x100;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV6_IFADDR); }))) {
            mixin(enumMixinStr_RTMGRP_IPV6_IFADDR);
        }
    }




    static if(!is(typeof(RTMGRP_IPV6_MROUTE))) {
        private enum enumMixinStr_RTMGRP_IPV6_MROUTE = `enum RTMGRP_IPV6_MROUTE = 0x200;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV6_MROUTE); }))) {
            mixin(enumMixinStr_RTMGRP_IPV6_MROUTE);
        }
    }




    static if(!is(typeof(RTMGRP_IPV6_ROUTE))) {
        private enum enumMixinStr_RTMGRP_IPV6_ROUTE = `enum RTMGRP_IPV6_ROUTE = 0x400;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV6_ROUTE); }))) {
            mixin(enumMixinStr_RTMGRP_IPV6_ROUTE);
        }
    }




    static if(!is(typeof(RTMGRP_IPV6_IFINFO))) {
        private enum enumMixinStr_RTMGRP_IPV6_IFINFO = `enum RTMGRP_IPV6_IFINFO = 0x800;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV6_IFINFO); }))) {
            mixin(enumMixinStr_RTMGRP_IPV6_IFINFO);
        }
    }




    static if(!is(typeof(RTMGRP_DECnet_IFADDR))) {
        private enum enumMixinStr_RTMGRP_DECnet_IFADDR = `enum RTMGRP_DECnet_IFADDR = 0x1000;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_DECnet_IFADDR); }))) {
            mixin(enumMixinStr_RTMGRP_DECnet_IFADDR);
        }
    }




    static if(!is(typeof(RTMGRP_DECnet_ROUTE))) {
        private enum enumMixinStr_RTMGRP_DECnet_ROUTE = `enum RTMGRP_DECnet_ROUTE = 0x4000;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_DECnet_ROUTE); }))) {
            mixin(enumMixinStr_RTMGRP_DECnet_ROUTE);
        }
    }




    static if(!is(typeof(RTMGRP_IPV6_PREFIX))) {
        private enum enumMixinStr_RTMGRP_IPV6_PREFIX = `enum RTMGRP_IPV6_PREFIX = 0x20000;`;
        static if(is(typeof({ mixin(enumMixinStr_RTMGRP_IPV6_PREFIX); }))) {
            mixin(enumMixinStr_RTMGRP_IPV6_PREFIX);
        }
    }




    static if(!is(typeof(__ILP32_OFF32_LDFLAGS))) {
        private enum enumMixinStr___ILP32_OFF32_LDFLAGS = `enum __ILP32_OFF32_LDFLAGS = "-m32";`;
        static if(is(typeof({ mixin(enumMixinStr___ILP32_OFF32_LDFLAGS); }))) {
            mixin(enumMixinStr___ILP32_OFF32_LDFLAGS);
        }
    }




    static if(!is(typeof(RTNLGRP_NONE))) {
        private enum enumMixinStr_RTNLGRP_NONE = `enum RTNLGRP_NONE = RTNLGRP_NONE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_NONE); }))) {
            mixin(enumMixinStr_RTNLGRP_NONE);
        }
    }




    static if(!is(typeof(RTNLGRP_LINK))) {
        private enum enumMixinStr_RTNLGRP_LINK = `enum RTNLGRP_LINK = RTNLGRP_LINK;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_LINK); }))) {
            mixin(enumMixinStr_RTNLGRP_LINK);
        }
    }




    static if(!is(typeof(RTNLGRP_NOTIFY))) {
        private enum enumMixinStr_RTNLGRP_NOTIFY = `enum RTNLGRP_NOTIFY = RTNLGRP_NOTIFY;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_NOTIFY); }))) {
            mixin(enumMixinStr_RTNLGRP_NOTIFY);
        }
    }




    static if(!is(typeof(RTNLGRP_NEIGH))) {
        private enum enumMixinStr_RTNLGRP_NEIGH = `enum RTNLGRP_NEIGH = RTNLGRP_NEIGH;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_NEIGH); }))) {
            mixin(enumMixinStr_RTNLGRP_NEIGH);
        }
    }




    static if(!is(typeof(RTNLGRP_TC))) {
        private enum enumMixinStr_RTNLGRP_TC = `enum RTNLGRP_TC = RTNLGRP_TC;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_TC); }))) {
            mixin(enumMixinStr_RTNLGRP_TC);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV4_IFADDR))) {
        private enum enumMixinStr_RTNLGRP_IPV4_IFADDR = `enum RTNLGRP_IPV4_IFADDR = RTNLGRP_IPV4_IFADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV4_IFADDR); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV4_IFADDR);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV4_MROUTE))) {
        private enum enumMixinStr_RTNLGRP_IPV4_MROUTE = `enum RTNLGRP_IPV4_MROUTE = RTNLGRP_IPV4_MROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV4_MROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV4_MROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV4_ROUTE))) {
        private enum enumMixinStr_RTNLGRP_IPV4_ROUTE = `enum RTNLGRP_IPV4_ROUTE = RTNLGRP_IPV4_ROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV4_ROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV4_ROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV4_RULE))) {
        private enum enumMixinStr_RTNLGRP_IPV4_RULE = `enum RTNLGRP_IPV4_RULE = RTNLGRP_IPV4_RULE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV4_RULE); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV4_RULE);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_IFADDR))) {
        private enum enumMixinStr_RTNLGRP_IPV6_IFADDR = `enum RTNLGRP_IPV6_IFADDR = RTNLGRP_IPV6_IFADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_IFADDR); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_IFADDR);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_MROUTE))) {
        private enum enumMixinStr_RTNLGRP_IPV6_MROUTE = `enum RTNLGRP_IPV6_MROUTE = RTNLGRP_IPV6_MROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_MROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_MROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_ROUTE))) {
        private enum enumMixinStr_RTNLGRP_IPV6_ROUTE = `enum RTNLGRP_IPV6_ROUTE = RTNLGRP_IPV6_ROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_ROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_ROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_IFINFO))) {
        private enum enumMixinStr_RTNLGRP_IPV6_IFINFO = `enum RTNLGRP_IPV6_IFINFO = RTNLGRP_IPV6_IFINFO;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_IFINFO); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_IFINFO);
        }
    }




    static if(!is(typeof(RTNLGRP_DECnet_IFADDR))) {
        private enum enumMixinStr_RTNLGRP_DECnet_IFADDR = `enum RTNLGRP_DECnet_IFADDR = RTNLGRP_DECnet_IFADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_DECnet_IFADDR); }))) {
            mixin(enumMixinStr_RTNLGRP_DECnet_IFADDR);
        }
    }




    static if(!is(typeof(RTNLGRP_DECnet_ROUTE))) {
        private enum enumMixinStr_RTNLGRP_DECnet_ROUTE = `enum RTNLGRP_DECnet_ROUTE = RTNLGRP_DECnet_ROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_DECnet_ROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_DECnet_ROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_DECnet_RULE))) {
        private enum enumMixinStr_RTNLGRP_DECnet_RULE = `enum RTNLGRP_DECnet_RULE = RTNLGRP_DECnet_RULE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_DECnet_RULE); }))) {
            mixin(enumMixinStr_RTNLGRP_DECnet_RULE);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_PREFIX))) {
        private enum enumMixinStr_RTNLGRP_IPV6_PREFIX = `enum RTNLGRP_IPV6_PREFIX = RTNLGRP_IPV6_PREFIX;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_PREFIX); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_PREFIX);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_RULE))) {
        private enum enumMixinStr_RTNLGRP_IPV6_RULE = `enum RTNLGRP_IPV6_RULE = RTNLGRP_IPV6_RULE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_RULE); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_RULE);
        }
    }




    static if(!is(typeof(RTNLGRP_ND_USEROPT))) {
        private enum enumMixinStr_RTNLGRP_ND_USEROPT = `enum RTNLGRP_ND_USEROPT = RTNLGRP_ND_USEROPT;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_ND_USEROPT); }))) {
            mixin(enumMixinStr_RTNLGRP_ND_USEROPT);
        }
    }




    static if(!is(typeof(RTNLGRP_PHONET_IFADDR))) {
        private enum enumMixinStr_RTNLGRP_PHONET_IFADDR = `enum RTNLGRP_PHONET_IFADDR = RTNLGRP_PHONET_IFADDR;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_PHONET_IFADDR); }))) {
            mixin(enumMixinStr_RTNLGRP_PHONET_IFADDR);
        }
    }




    static if(!is(typeof(RTNLGRP_PHONET_ROUTE))) {
        private enum enumMixinStr_RTNLGRP_PHONET_ROUTE = `enum RTNLGRP_PHONET_ROUTE = RTNLGRP_PHONET_ROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_PHONET_ROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_PHONET_ROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_DCB))) {
        private enum enumMixinStr_RTNLGRP_DCB = `enum RTNLGRP_DCB = RTNLGRP_DCB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_DCB); }))) {
            mixin(enumMixinStr_RTNLGRP_DCB);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV4_NETCONF))) {
        private enum enumMixinStr_RTNLGRP_IPV4_NETCONF = `enum RTNLGRP_IPV4_NETCONF = RTNLGRP_IPV4_NETCONF;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV4_NETCONF); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV4_NETCONF);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_NETCONF))) {
        private enum enumMixinStr_RTNLGRP_IPV6_NETCONF = `enum RTNLGRP_IPV6_NETCONF = RTNLGRP_IPV6_NETCONF;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_NETCONF); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_NETCONF);
        }
    }




    static if(!is(typeof(RTNLGRP_MDB))) {
        private enum enumMixinStr_RTNLGRP_MDB = `enum RTNLGRP_MDB = RTNLGRP_MDB;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_MDB); }))) {
            mixin(enumMixinStr_RTNLGRP_MDB);
        }
    }




    static if(!is(typeof(RTNLGRP_MPLS_ROUTE))) {
        private enum enumMixinStr_RTNLGRP_MPLS_ROUTE = `enum RTNLGRP_MPLS_ROUTE = RTNLGRP_MPLS_ROUTE;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_MPLS_ROUTE); }))) {
            mixin(enumMixinStr_RTNLGRP_MPLS_ROUTE);
        }
    }




    static if(!is(typeof(RTNLGRP_NSID))) {
        private enum enumMixinStr_RTNLGRP_NSID = `enum RTNLGRP_NSID = RTNLGRP_NSID;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_NSID); }))) {
            mixin(enumMixinStr_RTNLGRP_NSID);
        }
    }




    static if(!is(typeof(RTNLGRP_MPLS_NETCONF))) {
        private enum enumMixinStr_RTNLGRP_MPLS_NETCONF = `enum RTNLGRP_MPLS_NETCONF = RTNLGRP_MPLS_NETCONF;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_MPLS_NETCONF); }))) {
            mixin(enumMixinStr_RTNLGRP_MPLS_NETCONF);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV4_MROUTE_R))) {
        private enum enumMixinStr_RTNLGRP_IPV4_MROUTE_R = `enum RTNLGRP_IPV4_MROUTE_R = RTNLGRP_IPV4_MROUTE_R;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV4_MROUTE_R); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV4_MROUTE_R);
        }
    }




    static if(!is(typeof(RTNLGRP_IPV6_MROUTE_R))) {
        private enum enumMixinStr_RTNLGRP_IPV6_MROUTE_R = `enum RTNLGRP_IPV6_MROUTE_R = RTNLGRP_IPV6_MROUTE_R;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_IPV6_MROUTE_R); }))) {
            mixin(enumMixinStr_RTNLGRP_IPV6_MROUTE_R);
        }
    }




    static if(!is(typeof(RTNLGRP_NEXTHOP))) {
        private enum enumMixinStr_RTNLGRP_NEXTHOP = `enum RTNLGRP_NEXTHOP = RTNLGRP_NEXTHOP;`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_NEXTHOP); }))) {
            mixin(enumMixinStr_RTNLGRP_NEXTHOP);
        }
    }




    static if(!is(typeof(RTNLGRP_MAX))) {
        private enum enumMixinStr_RTNLGRP_MAX = `enum RTNLGRP_MAX = ( __RTNLGRP_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTNLGRP_MAX); }))) {
            mixin(enumMixinStr_RTNLGRP_MAX);
        }
    }




    static if(!is(typeof(__ILP32_OFF32_CFLAGS))) {
        private enum enumMixinStr___ILP32_OFF32_CFLAGS = `enum __ILP32_OFF32_CFLAGS = "-m32";`;
        static if(is(typeof({ mixin(enumMixinStr___ILP32_OFF32_CFLAGS); }))) {
            mixin(enumMixinStr___ILP32_OFF32_CFLAGS);
        }
    }




    static if(!is(typeof(_XBS5_LP64_OFF64))) {
        private enum enumMixinStr__XBS5_LP64_OFF64 = `enum _XBS5_LP64_OFF64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XBS5_LP64_OFF64); }))) {
            mixin(enumMixinStr__XBS5_LP64_OFF64);
        }
    }




    static if(!is(typeof(TCA_ACT_TAB))) {
        private enum enumMixinStr_TCA_ACT_TAB = `enum TCA_ACT_TAB = TCA_ROOT_TAB;`;
        static if(is(typeof({ mixin(enumMixinStr_TCA_ACT_TAB); }))) {
            mixin(enumMixinStr_TCA_ACT_TAB);
        }
    }




    static if(!is(typeof(TCAA_MAX))) {
        private enum enumMixinStr_TCAA_MAX = `enum TCAA_MAX = TCA_ROOT_TAB;`;
        static if(is(typeof({ mixin(enumMixinStr_TCAA_MAX); }))) {
            mixin(enumMixinStr_TCAA_MAX);
        }
    }




    static if(!is(typeof(TCA_ROOT_MAX))) {
        private enum enumMixinStr_TCA_ROOT_MAX = `enum TCA_ROOT_MAX = ( __TCA_ROOT_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_TCA_ROOT_MAX); }))) {
            mixin(enumMixinStr_TCA_ROOT_MAX);
        }
    }
    static if(!is(typeof(TCA_FLAG_LARGE_DUMP_ON))) {
        private enum enumMixinStr_TCA_FLAG_LARGE_DUMP_ON = `enum TCA_FLAG_LARGE_DUMP_ON = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_TCA_FLAG_LARGE_DUMP_ON); }))) {
            mixin(enumMixinStr_TCA_FLAG_LARGE_DUMP_ON);
        }
    }




    static if(!is(typeof(RTEXT_FILTER_VF))) {
        private enum enumMixinStr_RTEXT_FILTER_VF = `enum RTEXT_FILTER_VF = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTEXT_FILTER_VF); }))) {
            mixin(enumMixinStr_RTEXT_FILTER_VF);
        }
    }




    static if(!is(typeof(RTEXT_FILTER_BRVLAN))) {
        private enum enumMixinStr_RTEXT_FILTER_BRVLAN = `enum RTEXT_FILTER_BRVLAN = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTEXT_FILTER_BRVLAN); }))) {
            mixin(enumMixinStr_RTEXT_FILTER_BRVLAN);
        }
    }




    static if(!is(typeof(RTEXT_FILTER_BRVLAN_COMPRESSED))) {
        private enum enumMixinStr_RTEXT_FILTER_BRVLAN_COMPRESSED = `enum RTEXT_FILTER_BRVLAN_COMPRESSED = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTEXT_FILTER_BRVLAN_COMPRESSED); }))) {
            mixin(enumMixinStr_RTEXT_FILTER_BRVLAN_COMPRESSED);
        }
    }




    static if(!is(typeof(RTEXT_FILTER_SKIP_STATS))) {
        private enum enumMixinStr_RTEXT_FILTER_SKIP_STATS = `enum RTEXT_FILTER_SKIP_STATS = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_RTEXT_FILTER_SKIP_STATS); }))) {
            mixin(enumMixinStr_RTEXT_FILTER_SKIP_STATS);
        }
    }






    static if(!is(typeof(_K_SS_MAXSIZE))) {
        private enum enumMixinStr__K_SS_MAXSIZE = `enum _K_SS_MAXSIZE = 128;`;
        static if(is(typeof({ mixin(enumMixinStr__K_SS_MAXSIZE); }))) {
            mixin(enumMixinStr__K_SS_MAXSIZE);
        }
    }




    static if(!is(typeof(_POSIX_V6_LP64_OFF64))) {
        private enum enumMixinStr__POSIX_V6_LP64_OFF64 = `enum _POSIX_V6_LP64_OFF64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_V6_LP64_OFF64); }))) {
            mixin(enumMixinStr__POSIX_V6_LP64_OFF64);
        }
    }




    static if(!is(typeof(_POSIX_V7_LP64_OFF64))) {
        private enum enumMixinStr__POSIX_V7_LP64_OFF64 = `enum _POSIX_V7_LP64_OFF64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_V7_LP64_OFF64); }))) {
            mixin(enumMixinStr__POSIX_V7_LP64_OFF64);
        }
    }




    static if(!is(typeof(_XBS5_LPBIG_OFFBIG))) {
        private enum enumMixinStr__XBS5_LPBIG_OFFBIG = `enum _XBS5_LPBIG_OFFBIG = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XBS5_LPBIG_OFFBIG); }))) {
            mixin(enumMixinStr__XBS5_LPBIG_OFFBIG);
        }
    }




    static if(!is(typeof(__always_inline))) {
        private enum enumMixinStr___always_inline = `enum __always_inline = __inline__;`;
        static if(is(typeof({ mixin(enumMixinStr___always_inline); }))) {
            mixin(enumMixinStr___always_inline);
        }
    }






    static if(!is(typeof(_POSIX_V6_LPBIG_OFFBIG))) {
        private enum enumMixinStr__POSIX_V6_LPBIG_OFFBIG = `enum _POSIX_V6_LPBIG_OFFBIG = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_V6_LPBIG_OFFBIG); }))) {
            mixin(enumMixinStr__POSIX_V6_LPBIG_OFFBIG);
        }
    }




    static if(!is(typeof(SI_LOAD_SHIFT))) {
        private enum enumMixinStr_SI_LOAD_SHIFT = `enum SI_LOAD_SHIFT = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_SI_LOAD_SHIFT); }))) {
            mixin(enumMixinStr_SI_LOAD_SHIFT);
        }
    }




    static if(!is(typeof(_POSIX_V7_LPBIG_OFFBIG))) {
        private enum enumMixinStr__POSIX_V7_LPBIG_OFFBIG = `enum _POSIX_V7_LPBIG_OFFBIG = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_V7_LPBIG_OFFBIG); }))) {
            mixin(enumMixinStr__POSIX_V7_LPBIG_OFFBIG);
        }
    }






    static if(!is(typeof(__BYTE_ORDER))) {
        private enum enumMixinStr___BYTE_ORDER = `enum __BYTE_ORDER = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr___BYTE_ORDER); }))) {
            mixin(enumMixinStr___BYTE_ORDER);
        }
    }




    static if(!is(typeof(_CS_V7_ENV))) {
        private enum enumMixinStr__CS_V7_ENV = `enum _CS_V7_ENV = _CS_V7_ENV;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_V7_ENV); }))) {
            mixin(enumMixinStr__CS_V7_ENV);
        }
    }






    static if(!is(typeof(__bitwise))) {
        private enum enumMixinStr___bitwise = `enum __bitwise = ;`;
        static if(is(typeof({ mixin(enumMixinStr___bitwise); }))) {
            mixin(enumMixinStr___bitwise);
        }
    }




    static if(!is(typeof(_CS_V6_ENV))) {
        private enum enumMixinStr__CS_V6_ENV = `enum _CS_V6_ENV = _CS_V6_ENV;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_V6_ENV); }))) {
            mixin(enumMixinStr__CS_V6_ENV);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = `enum _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS = _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LPBIG_OFFBIG_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LIBS = `enum _CS_POSIX_V7_LPBIG_OFFBIG_LIBS = _CS_POSIX_V7_LPBIG_OFFBIG_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LIBS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = `enum _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS = _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = `enum _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS = _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LP64_OFF64_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_LP64_OFF64_LINTFLAGS = `enum _CS_POSIX_V7_LP64_OFF64_LINTFLAGS = _CS_POSIX_V7_LP64_OFF64_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LP64_OFF64_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V7_LP64_OFF64_LIBS = `enum _CS_POSIX_V7_LP64_OFF64_LIBS = _CS_POSIX_V7_LP64_OFF64_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_LIBS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LP64_OFF64_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_LP64_OFF64_LDFLAGS = `enum _CS_POSIX_V7_LP64_OFF64_LDFLAGS = _CS_POSIX_V7_LP64_OFF64_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_LP64_OFF64_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_LP64_OFF64_CFLAGS = `enum _CS_POSIX_V7_LP64_OFF64_CFLAGS = _CS_POSIX_V7_LP64_OFF64_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_LP64_OFF64_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = `enum _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS = _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFFBIG_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LIBS = `enum _CS_POSIX_V7_ILP32_OFFBIG_LIBS = _CS_POSIX_V7_ILP32_OFFBIG_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LIBS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = `enum _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS = _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFFBIG_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = `enum _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS = _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFF32_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = `enum _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS = _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFF32_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LIBS = `enum _CS_POSIX_V7_ILP32_OFF32_LIBS = _CS_POSIX_V7_ILP32_OFF32_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LIBS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFF32_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LDFLAGS = `enum _CS_POSIX_V7_ILP32_OFF32_LDFLAGS = _CS_POSIX_V7_ILP32_OFF32_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_LDFLAGS);
        }
    }




    static if(!is(typeof(__aligned_u64))) {
        private enum enumMixinStr___aligned_u64 = `enum __aligned_u64 = __u64 __attribute__ ( ( aligned ( 8 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr___aligned_u64); }))) {
            mixin(enumMixinStr___aligned_u64);
        }
    }




    static if(!is(typeof(__aligned_be64))) {
        private enum enumMixinStr___aligned_be64 = `enum __aligned_be64 = __be64 __attribute__ ( ( aligned ( 8 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr___aligned_be64); }))) {
            mixin(enumMixinStr___aligned_be64);
        }
    }




    static if(!is(typeof(__aligned_le64))) {
        private enum enumMixinStr___aligned_le64 = `enum __aligned_le64 = __le64 __attribute__ ( ( aligned ( 8 ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr___aligned_le64); }))) {
            mixin(enumMixinStr___aligned_le64);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_ILP32_OFF32_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V7_ILP32_OFF32_CFLAGS = `enum _CS_POSIX_V7_ILP32_OFF32_CFLAGS = _CS_POSIX_V7_ILP32_OFF32_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_ILP32_OFF32_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = `enum _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS = _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS);
        }
    }






    static if(!is(typeof(_CS_POSIX_V6_LPBIG_OFFBIG_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LIBS = `enum _CS_POSIX_V6_LPBIG_OFFBIG_LIBS = _CS_POSIX_V6_LPBIG_OFFBIG_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LIBS);
        }
    }




    static if(!is(typeof(VETH_INFO_MAX))) {
        private enum enumMixinStr_VETH_INFO_MAX = `enum VETH_INFO_MAX = ( __VETH_INFO_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_VETH_INFO_MAX); }))) {
            mixin(enumMixinStr_VETH_INFO_MAX);
        }
    }




    static if(!is(typeof(_NET_IF_H))) {
        private enum enumMixinStr__NET_IF_H = `enum _NET_IF_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__NET_IF_H); }))) {
            mixin(enumMixinStr__NET_IF_H);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = `enum _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS = _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = `enum _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS = _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LP64_OFF64_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_LP64_OFF64_LINTFLAGS = `enum _CS_POSIX_V6_LP64_OFF64_LINTFLAGS = _CS_POSIX_V6_LP64_OFF64_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LP64_OFF64_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V6_LP64_OFF64_LIBS = `enum _CS_POSIX_V6_LP64_OFF64_LIBS = _CS_POSIX_V6_LP64_OFF64_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_LIBS);
        }
    }




    static if(!is(typeof(IF_NAMESIZE))) {
        private enum enumMixinStr_IF_NAMESIZE = `enum IF_NAMESIZE = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_IF_NAMESIZE); }))) {
            mixin(enumMixinStr_IF_NAMESIZE);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LP64_OFF64_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_LP64_OFF64_LDFLAGS = `enum _CS_POSIX_V6_LP64_OFF64_LDFLAGS = _CS_POSIX_V6_LP64_OFF64_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_LP64_OFF64_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_LP64_OFF64_CFLAGS = `enum _CS_POSIX_V6_LP64_OFF64_CFLAGS = _CS_POSIX_V6_LP64_OFF64_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_LP64_OFF64_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = `enum _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS = _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS);
        }
    }




    static if(!is(typeof(IFF_UP))) {
        private enum enumMixinStr_IFF_UP = `enum IFF_UP = IFF_UP;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_UP); }))) {
            mixin(enumMixinStr_IFF_UP);
        }
    }




    static if(!is(typeof(IFF_BROADCAST))) {
        private enum enumMixinStr_IFF_BROADCAST = `enum IFF_BROADCAST = IFF_BROADCAST;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_BROADCAST); }))) {
            mixin(enumMixinStr_IFF_BROADCAST);
        }
    }




    static if(!is(typeof(IFF_DEBUG))) {
        private enum enumMixinStr_IFF_DEBUG = `enum IFF_DEBUG = IFF_DEBUG;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_DEBUG); }))) {
            mixin(enumMixinStr_IFF_DEBUG);
        }
    }




    static if(!is(typeof(IFF_LOOPBACK))) {
        private enum enumMixinStr_IFF_LOOPBACK = `enum IFF_LOOPBACK = IFF_LOOPBACK;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_LOOPBACK); }))) {
            mixin(enumMixinStr_IFF_LOOPBACK);
        }
    }




    static if(!is(typeof(IFF_POINTOPOINT))) {
        private enum enumMixinStr_IFF_POINTOPOINT = `enum IFF_POINTOPOINT = IFF_POINTOPOINT;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_POINTOPOINT); }))) {
            mixin(enumMixinStr_IFF_POINTOPOINT);
        }
    }




    static if(!is(typeof(IFF_NOTRAILERS))) {
        private enum enumMixinStr_IFF_NOTRAILERS = `enum IFF_NOTRAILERS = IFF_NOTRAILERS;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_NOTRAILERS); }))) {
            mixin(enumMixinStr_IFF_NOTRAILERS);
        }
    }




    static if(!is(typeof(IFF_RUNNING))) {
        private enum enumMixinStr_IFF_RUNNING = `enum IFF_RUNNING = IFF_RUNNING;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_RUNNING); }))) {
            mixin(enumMixinStr_IFF_RUNNING);
        }
    }




    static if(!is(typeof(IFF_NOARP))) {
        private enum enumMixinStr_IFF_NOARP = `enum IFF_NOARP = IFF_NOARP;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_NOARP); }))) {
            mixin(enumMixinStr_IFF_NOARP);
        }
    }




    static if(!is(typeof(IFF_PROMISC))) {
        private enum enumMixinStr_IFF_PROMISC = `enum IFF_PROMISC = IFF_PROMISC;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_PROMISC); }))) {
            mixin(enumMixinStr_IFF_PROMISC);
        }
    }




    static if(!is(typeof(IFF_ALLMULTI))) {
        private enum enumMixinStr_IFF_ALLMULTI = `enum IFF_ALLMULTI = IFF_ALLMULTI;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_ALLMULTI); }))) {
            mixin(enumMixinStr_IFF_ALLMULTI);
        }
    }




    static if(!is(typeof(IFF_MASTER))) {
        private enum enumMixinStr_IFF_MASTER = `enum IFF_MASTER = IFF_MASTER;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_MASTER); }))) {
            mixin(enumMixinStr_IFF_MASTER);
        }
    }




    static if(!is(typeof(IFF_SLAVE))) {
        private enum enumMixinStr_IFF_SLAVE = `enum IFF_SLAVE = IFF_SLAVE;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_SLAVE); }))) {
            mixin(enumMixinStr_IFF_SLAVE);
        }
    }




    static if(!is(typeof(IFF_MULTICAST))) {
        private enum enumMixinStr_IFF_MULTICAST = `enum IFF_MULTICAST = IFF_MULTICAST;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_MULTICAST); }))) {
            mixin(enumMixinStr_IFF_MULTICAST);
        }
    }




    static if(!is(typeof(IFF_PORTSEL))) {
        private enum enumMixinStr_IFF_PORTSEL = `enum IFF_PORTSEL = IFF_PORTSEL;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_PORTSEL); }))) {
            mixin(enumMixinStr_IFF_PORTSEL);
        }
    }




    static if(!is(typeof(IFF_AUTOMEDIA))) {
        private enum enumMixinStr_IFF_AUTOMEDIA = `enum IFF_AUTOMEDIA = IFF_AUTOMEDIA;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_AUTOMEDIA); }))) {
            mixin(enumMixinStr_IFF_AUTOMEDIA);
        }
    }




    static if(!is(typeof(IFF_DYNAMIC))) {
        private enum enumMixinStr_IFF_DYNAMIC = `enum IFF_DYNAMIC = IFF_DYNAMIC;`;
        static if(is(typeof({ mixin(enumMixinStr_IFF_DYNAMIC); }))) {
            mixin(enumMixinStr_IFF_DYNAMIC);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFFBIG_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LIBS = `enum _CS_POSIX_V6_ILP32_OFFBIG_LIBS = _CS_POSIX_V6_ILP32_OFFBIG_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LIBS);
        }
    }




    static if(!is(typeof(ifa_broadaddr))) {
        private enum enumMixinStr_ifa_broadaddr = `enum ifa_broadaddr = ifa_ifu . ifu_broadaddr;`;
        static if(is(typeof({ mixin(enumMixinStr_ifa_broadaddr); }))) {
            mixin(enumMixinStr_ifa_broadaddr);
        }
    }




    static if(!is(typeof(ifa_dstaddr))) {
        private enum enumMixinStr_ifa_dstaddr = `enum ifa_dstaddr = ifa_ifu . ifu_dstaddr;`;
        static if(is(typeof({ mixin(enumMixinStr_ifa_dstaddr); }))) {
            mixin(enumMixinStr_ifa_dstaddr);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = `enum _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS = _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFFBIG_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = `enum _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS = _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(IFHWADDRLEN))) {
        private enum enumMixinStr_IFHWADDRLEN = `enum IFHWADDRLEN = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_IFHWADDRLEN); }))) {
            mixin(enumMixinStr_IFHWADDRLEN);
        }
    }




    static if(!is(typeof(IFNAMSIZ))) {
        private enum enumMixinStr_IFNAMSIZ = `enum IFNAMSIZ = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_IFNAMSIZ); }))) {
            mixin(enumMixinStr_IFNAMSIZ);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFF32_LINTFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = `enum _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS = _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFF32_LIBS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LIBS = `enum _CS_POSIX_V6_ILP32_OFF32_LIBS = _CS_POSIX_V6_ILP32_OFF32_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LIBS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LIBS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFF32_LDFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LDFLAGS = `enum _CS_POSIX_V6_ILP32_OFF32_LDFLAGS = _CS_POSIX_V6_ILP32_OFF32_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_LDFLAGS);
        }
    }




    static if(!is(typeof(ifr_name))) {
        private enum enumMixinStr_ifr_name = `enum ifr_name = ifr_ifrn . ifrn_name;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_name); }))) {
            mixin(enumMixinStr_ifr_name);
        }
    }




    static if(!is(typeof(ifr_hwaddr))) {
        private enum enumMixinStr_ifr_hwaddr = `enum ifr_hwaddr = ifr_ifru . ifru_hwaddr;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_hwaddr); }))) {
            mixin(enumMixinStr_ifr_hwaddr);
        }
    }




    static if(!is(typeof(ifr_addr))) {
        private enum enumMixinStr_ifr_addr = `enum ifr_addr = ifr_ifru . ifru_addr;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_addr); }))) {
            mixin(enumMixinStr_ifr_addr);
        }
    }




    static if(!is(typeof(ifr_dstaddr))) {
        private enum enumMixinStr_ifr_dstaddr = `enum ifr_dstaddr = ifr_ifru . ifru_dstaddr;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_dstaddr); }))) {
            mixin(enumMixinStr_ifr_dstaddr);
        }
    }




    static if(!is(typeof(ifr_broadaddr))) {
        private enum enumMixinStr_ifr_broadaddr = `enum ifr_broadaddr = ifr_ifru . ifru_broadaddr;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_broadaddr); }))) {
            mixin(enumMixinStr_ifr_broadaddr);
        }
    }




    static if(!is(typeof(ifr_netmask))) {
        private enum enumMixinStr_ifr_netmask = `enum ifr_netmask = ifr_ifru . ifru_netmask;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_netmask); }))) {
            mixin(enumMixinStr_ifr_netmask);
        }
    }




    static if(!is(typeof(ifr_flags))) {
        private enum enumMixinStr_ifr_flags = `enum ifr_flags = ifr_ifru . ifru_flags;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_flags); }))) {
            mixin(enumMixinStr_ifr_flags);
        }
    }




    static if(!is(typeof(ifr_metric))) {
        private enum enumMixinStr_ifr_metric = `enum ifr_metric = ifr_ifru . ifru_ivalue;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_metric); }))) {
            mixin(enumMixinStr_ifr_metric);
        }
    }




    static if(!is(typeof(ifr_mtu))) {
        private enum enumMixinStr_ifr_mtu = `enum ifr_mtu = ifr_ifru . ifru_mtu;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_mtu); }))) {
            mixin(enumMixinStr_ifr_mtu);
        }
    }




    static if(!is(typeof(ifr_map))) {
        private enum enumMixinStr_ifr_map = `enum ifr_map = ifr_ifru . ifru_map;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_map); }))) {
            mixin(enumMixinStr_ifr_map);
        }
    }




    static if(!is(typeof(ifr_slave))) {
        private enum enumMixinStr_ifr_slave = `enum ifr_slave = ifr_ifru . ifru_slave;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_slave); }))) {
            mixin(enumMixinStr_ifr_slave);
        }
    }




    static if(!is(typeof(ifr_data))) {
        private enum enumMixinStr_ifr_data = `enum ifr_data = ifr_ifru . ifru_data;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_data); }))) {
            mixin(enumMixinStr_ifr_data);
        }
    }




    static if(!is(typeof(ifr_ifindex))) {
        private enum enumMixinStr_ifr_ifindex = `enum ifr_ifindex = ifr_ifru . ifru_ivalue;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_ifindex); }))) {
            mixin(enumMixinStr_ifr_ifindex);
        }
    }




    static if(!is(typeof(ifr_bandwidth))) {
        private enum enumMixinStr_ifr_bandwidth = `enum ifr_bandwidth = ifr_ifru . ifru_ivalue;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_bandwidth); }))) {
            mixin(enumMixinStr_ifr_bandwidth);
        }
    }




    static if(!is(typeof(ifr_qlen))) {
        private enum enumMixinStr_ifr_qlen = `enum ifr_qlen = ifr_ifru . ifru_ivalue;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_qlen); }))) {
            mixin(enumMixinStr_ifr_qlen);
        }
    }




    static if(!is(typeof(ifr_newname))) {
        private enum enumMixinStr_ifr_newname = `enum ifr_newname = ifr_ifru . ifru_newname;`;
        static if(is(typeof({ mixin(enumMixinStr_ifr_newname); }))) {
            mixin(enumMixinStr_ifr_newname);
        }
    }




    static if(!is(typeof(_IOT_ifreq))) {
        private enum enumMixinStr__IOT_ifreq = `enum _IOT_ifreq = _IOT ( _IOTS cast( char ) , 16 , _IOTS cast( char ) , 16 , 0 , 0 );`;
        static if(is(typeof({ mixin(enumMixinStr__IOT_ifreq); }))) {
            mixin(enumMixinStr__IOT_ifreq);
        }
    }




    static if(!is(typeof(_IOT_ifreq_short))) {
        private enum enumMixinStr__IOT_ifreq_short = `enum _IOT_ifreq_short = _IOT ( _IOTS cast( char ) , 16 , _IOTS cast( short ) , 1 , 0 , 0 );`;
        static if(is(typeof({ mixin(enumMixinStr__IOT_ifreq_short); }))) {
            mixin(enumMixinStr__IOT_ifreq_short);
        }
    }




    static if(!is(typeof(_IOT_ifreq_int))) {
        private enum enumMixinStr__IOT_ifreq_int = `enum _IOT_ifreq_int = _IOT ( _IOTS cast( char ) , 16 , _IOTS cast( int ) , 1 , 0 , 0 );`;
        static if(is(typeof({ mixin(enumMixinStr__IOT_ifreq_int); }))) {
            mixin(enumMixinStr__IOT_ifreq_int);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_ILP32_OFF32_CFLAGS))) {
        private enum enumMixinStr__CS_POSIX_V6_ILP32_OFF32_CFLAGS = `enum _CS_POSIX_V6_ILP32_OFF32_CFLAGS = _CS_POSIX_V6_ILP32_OFF32_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_CFLAGS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_ILP32_OFF32_CFLAGS);
        }
    }




    static if(!is(typeof(ifc_buf))) {
        private enum enumMixinStr_ifc_buf = `enum ifc_buf = ifc_ifcu . ifcu_buf;`;
        static if(is(typeof({ mixin(enumMixinStr_ifc_buf); }))) {
            mixin(enumMixinStr_ifc_buf);
        }
    }




    static if(!is(typeof(ifc_req))) {
        private enum enumMixinStr_ifc_req = `enum ifc_req = ifc_ifcu . ifcu_req;`;
        static if(is(typeof({ mixin(enumMixinStr_ifc_req); }))) {
            mixin(enumMixinStr_ifc_req);
        }
    }




    static if(!is(typeof(_IOT_ifconf))) {
        private enum enumMixinStr__IOT_ifconf = `enum _IOT_ifconf = _IOT ( _IOTS ( ifconf ) , 1 , 0 , 0 , 0 , 0 );`;
        static if(is(typeof({ mixin(enumMixinStr__IOT_ifconf); }))) {
            mixin(enumMixinStr__IOT_ifconf);
        }
    }




    static if(!is(typeof(_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS))) {
        private enum enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = `enum _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS = _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LPBIG_OFFBIG_LIBS))) {
        private enum enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LIBS = `enum _CS_XBS5_LPBIG_OFFBIG_LIBS = _CS_XBS5_LPBIG_OFFBIG_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LIBS); }))) {
            mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LIBS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LPBIG_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LDFLAGS = `enum _CS_XBS5_LPBIG_OFFBIG_LDFLAGS = _CS_XBS5_LPBIG_OFFBIG_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LPBIG_OFFBIG_CFLAGS))) {
        private enum enumMixinStr__CS_XBS5_LPBIG_OFFBIG_CFLAGS = `enum _CS_XBS5_LPBIG_OFFBIG_CFLAGS = _CS_XBS5_LPBIG_OFFBIG_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_LPBIG_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LP64_OFF64_LINTFLAGS))) {
        private enum enumMixinStr__CS_XBS5_LP64_OFF64_LINTFLAGS = `enum _CS_XBS5_LP64_OFF64_LINTFLAGS = _CS_XBS5_LP64_OFF64_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LP64_OFF64_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_LP64_OFF64_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LP64_OFF64_LIBS))) {
        private enum enumMixinStr__CS_XBS5_LP64_OFF64_LIBS = `enum _CS_XBS5_LP64_OFF64_LIBS = _CS_XBS5_LP64_OFF64_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LP64_OFF64_LIBS); }))) {
            mixin(enumMixinStr__CS_XBS5_LP64_OFF64_LIBS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LP64_OFF64_LDFLAGS))) {
        private enum enumMixinStr__CS_XBS5_LP64_OFF64_LDFLAGS = `enum _CS_XBS5_LP64_OFF64_LDFLAGS = _CS_XBS5_LP64_OFF64_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LP64_OFF64_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_LP64_OFF64_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_LP64_OFF64_CFLAGS))) {
        private enum enumMixinStr__CS_XBS5_LP64_OFF64_CFLAGS = `enum _CS_XBS5_LP64_OFF64_CFLAGS = _CS_XBS5_LP64_OFF64_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_LP64_OFF64_CFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_LP64_OFF64_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFFBIG_LINTFLAGS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFFBIG_LINTFLAGS = `enum _CS_XBS5_ILP32_OFFBIG_LINTFLAGS = _CS_XBS5_ILP32_OFFBIG_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFFBIG_LIBS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFFBIG_LIBS = `enum _CS_XBS5_ILP32_OFFBIG_LIBS = _CS_XBS5_ILP32_OFFBIG_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_LIBS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_LIBS);
        }
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        private enum enumMixinStr__STDC_PREDEF_H = `enum _STDC_PREDEF_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDC_PREDEF_H); }))) {
            mixin(enumMixinStr__STDC_PREDEF_H);
        }
    }




    static if(!is(typeof(_STDINT_H))) {
        private enum enumMixinStr__STDINT_H = `enum _STDINT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDINT_H); }))) {
            mixin(enumMixinStr__STDINT_H);
        }
    }






    static if(!is(typeof(_CS_XBS5_ILP32_OFFBIG_LDFLAGS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFFBIG_LDFLAGS = `enum _CS_XBS5_ILP32_OFFBIG_LDFLAGS = _CS_XBS5_ILP32_OFFBIG_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFFBIG_CFLAGS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFFBIG_CFLAGS = `enum _CS_XBS5_ILP32_OFFBIG_CFLAGS = _CS_XBS5_ILP32_OFFBIG_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_CFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFFBIG_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFF32_LINTFLAGS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFF32_LINTFLAGS = `enum _CS_XBS5_ILP32_OFF32_LINTFLAGS = _CS_XBS5_ILP32_OFF32_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFF32_LIBS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFF32_LIBS = `enum _CS_XBS5_ILP32_OFF32_LIBS = _CS_XBS5_ILP32_OFF32_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_LIBS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_LIBS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFF32_LDFLAGS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFF32_LDFLAGS = `enum _CS_XBS5_ILP32_OFF32_LDFLAGS = _CS_XBS5_ILP32_OFF32_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_XBS5_ILP32_OFF32_CFLAGS))) {
        private enum enumMixinStr__CS_XBS5_ILP32_OFF32_CFLAGS = `enum _CS_XBS5_ILP32_OFF32_CFLAGS = _CS_XBS5_ILP32_OFF32_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_CFLAGS); }))) {
            mixin(enumMixinStr__CS_XBS5_ILP32_OFF32_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_LFS64_LINTFLAGS))) {
        private enum enumMixinStr__CS_LFS64_LINTFLAGS = `enum _CS_LFS64_LINTFLAGS = _CS_LFS64_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS64_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_LFS64_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_LFS64_LIBS))) {
        private enum enumMixinStr__CS_LFS64_LIBS = `enum _CS_LFS64_LIBS = _CS_LFS64_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS64_LIBS); }))) {
            mixin(enumMixinStr__CS_LFS64_LIBS);
        }
    }




    static if(!is(typeof(_CS_LFS64_LDFLAGS))) {
        private enum enumMixinStr__CS_LFS64_LDFLAGS = `enum _CS_LFS64_LDFLAGS = _CS_LFS64_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS64_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_LFS64_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_LFS64_CFLAGS))) {
        private enum enumMixinStr__CS_LFS64_CFLAGS = `enum _CS_LFS64_CFLAGS = _CS_LFS64_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS64_CFLAGS); }))) {
            mixin(enumMixinStr__CS_LFS64_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_LFS_LINTFLAGS))) {
        private enum enumMixinStr__CS_LFS_LINTFLAGS = `enum _CS_LFS_LINTFLAGS = _CS_LFS_LINTFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS_LINTFLAGS); }))) {
            mixin(enumMixinStr__CS_LFS_LINTFLAGS);
        }
    }




    static if(!is(typeof(_CS_LFS_LIBS))) {
        private enum enumMixinStr__CS_LFS_LIBS = `enum _CS_LFS_LIBS = _CS_LFS_LIBS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS_LIBS); }))) {
            mixin(enumMixinStr__CS_LFS_LIBS);
        }
    }




    static if(!is(typeof(_CS_LFS_LDFLAGS))) {
        private enum enumMixinStr__CS_LFS_LDFLAGS = `enum _CS_LFS_LDFLAGS = _CS_LFS_LDFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS_LDFLAGS); }))) {
            mixin(enumMixinStr__CS_LFS_LDFLAGS);
        }
    }




    static if(!is(typeof(_CS_LFS_CFLAGS))) {
        private enum enumMixinStr__CS_LFS_CFLAGS = `enum _CS_LFS_CFLAGS = _CS_LFS_CFLAGS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_LFS_CFLAGS); }))) {
            mixin(enumMixinStr__CS_LFS_CFLAGS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V7_WIDTH_RESTRICTED_ENVS))) {
        private enum enumMixinStr__CS_POSIX_V7_WIDTH_RESTRICTED_ENVS = `enum _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS = _CS_V7_WIDTH_RESTRICTED_ENVS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V7_WIDTH_RESTRICTED_ENVS); }))) {
            mixin(enumMixinStr__CS_POSIX_V7_WIDTH_RESTRICTED_ENVS);
        }
    }




    static if(!is(typeof(_CS_V7_WIDTH_RESTRICTED_ENVS))) {
        private enum enumMixinStr__CS_V7_WIDTH_RESTRICTED_ENVS = `enum _CS_V7_WIDTH_RESTRICTED_ENVS = _CS_V7_WIDTH_RESTRICTED_ENVS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_V7_WIDTH_RESTRICTED_ENVS); }))) {
            mixin(enumMixinStr__CS_V7_WIDTH_RESTRICTED_ENVS);
        }
    }




    static if(!is(typeof(_CS_POSIX_V5_WIDTH_RESTRICTED_ENVS))) {
        private enum enumMixinStr__CS_POSIX_V5_WIDTH_RESTRICTED_ENVS = `enum _CS_POSIX_V5_WIDTH_RESTRICTED_ENVS = _CS_V5_WIDTH_RESTRICTED_ENVS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V5_WIDTH_RESTRICTED_ENVS); }))) {
            mixin(enumMixinStr__CS_POSIX_V5_WIDTH_RESTRICTED_ENVS);
        }
    }




    static if(!is(typeof(_CS_V5_WIDTH_RESTRICTED_ENVS))) {
        private enum enumMixinStr__CS_V5_WIDTH_RESTRICTED_ENVS = `enum _CS_V5_WIDTH_RESTRICTED_ENVS = _CS_V5_WIDTH_RESTRICTED_ENVS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_V5_WIDTH_RESTRICTED_ENVS); }))) {
            mixin(enumMixinStr__CS_V5_WIDTH_RESTRICTED_ENVS);
        }
    }




    static if(!is(typeof(_CS_GNU_LIBPTHREAD_VERSION))) {
        private enum enumMixinStr__CS_GNU_LIBPTHREAD_VERSION = `enum _CS_GNU_LIBPTHREAD_VERSION = _CS_GNU_LIBPTHREAD_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_GNU_LIBPTHREAD_VERSION); }))) {
            mixin(enumMixinStr__CS_GNU_LIBPTHREAD_VERSION);
        }
    }




    static if(!is(typeof(_CS_GNU_LIBC_VERSION))) {
        private enum enumMixinStr__CS_GNU_LIBC_VERSION = `enum _CS_GNU_LIBC_VERSION = _CS_GNU_LIBC_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_GNU_LIBC_VERSION); }))) {
            mixin(enumMixinStr__CS_GNU_LIBC_VERSION);
        }
    }




    static if(!is(typeof(_CS_POSIX_V6_WIDTH_RESTRICTED_ENVS))) {
        private enum enumMixinStr__CS_POSIX_V6_WIDTH_RESTRICTED_ENVS = `enum _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS = _CS_V6_WIDTH_RESTRICTED_ENVS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_POSIX_V6_WIDTH_RESTRICTED_ENVS); }))) {
            mixin(enumMixinStr__CS_POSIX_V6_WIDTH_RESTRICTED_ENVS);
        }
    }




    static if(!is(typeof(_CS_V6_WIDTH_RESTRICTED_ENVS))) {
        private enum enumMixinStr__CS_V6_WIDTH_RESTRICTED_ENVS = `enum _CS_V6_WIDTH_RESTRICTED_ENVS = _CS_V6_WIDTH_RESTRICTED_ENVS;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_V6_WIDTH_RESTRICTED_ENVS); }))) {
            mixin(enumMixinStr__CS_V6_WIDTH_RESTRICTED_ENVS);
        }
    }




    static if(!is(typeof(_CS_PATH))) {
        private enum enumMixinStr__CS_PATH = `enum _CS_PATH = _CS_PATH;`;
        static if(is(typeof({ mixin(enumMixinStr__CS_PATH); }))) {
            mixin(enumMixinStr__CS_PATH);
        }
    }




    static if(!is(typeof(_SC_THREAD_ROBUST_PRIO_PROTECT))) {
        private enum enumMixinStr__SC_THREAD_ROBUST_PRIO_PROTECT = `enum _SC_THREAD_ROBUST_PRIO_PROTECT = _SC_THREAD_ROBUST_PRIO_PROTECT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_ROBUST_PRIO_PROTECT); }))) {
            mixin(enumMixinStr__SC_THREAD_ROBUST_PRIO_PROTECT);
        }
    }




    static if(!is(typeof(_SC_THREAD_ROBUST_PRIO_INHERIT))) {
        private enum enumMixinStr__SC_THREAD_ROBUST_PRIO_INHERIT = `enum _SC_THREAD_ROBUST_PRIO_INHERIT = _SC_THREAD_ROBUST_PRIO_INHERIT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_ROBUST_PRIO_INHERIT); }))) {
            mixin(enumMixinStr__SC_THREAD_ROBUST_PRIO_INHERIT);
        }
    }




    static if(!is(typeof(_SC_XOPEN_STREAMS))) {
        private enum enumMixinStr__SC_XOPEN_STREAMS = `enum _SC_XOPEN_STREAMS = _SC_XOPEN_STREAMS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_STREAMS); }))) {
            mixin(enumMixinStr__SC_XOPEN_STREAMS);
        }
    }






    static if(!is(typeof(_SC_TRACE_USER_EVENT_MAX))) {
        private enum enumMixinStr__SC_TRACE_USER_EVENT_MAX = `enum _SC_TRACE_USER_EVENT_MAX = _SC_TRACE_USER_EVENT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_USER_EVENT_MAX); }))) {
            mixin(enumMixinStr__SC_TRACE_USER_EVENT_MAX);
        }
    }




    static if(!is(typeof(_SC_TRACE_SYS_MAX))) {
        private enum enumMixinStr__SC_TRACE_SYS_MAX = `enum _SC_TRACE_SYS_MAX = _SC_TRACE_SYS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_SYS_MAX); }))) {
            mixin(enumMixinStr__SC_TRACE_SYS_MAX);
        }
    }




    static if(!is(typeof(_SC_TRACE_NAME_MAX))) {
        private enum enumMixinStr__SC_TRACE_NAME_MAX = `enum _SC_TRACE_NAME_MAX = _SC_TRACE_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_NAME_MAX); }))) {
            mixin(enumMixinStr__SC_TRACE_NAME_MAX);
        }
    }




    static if(!is(typeof(_SC_TRACE_EVENT_NAME_MAX))) {
        private enum enumMixinStr__SC_TRACE_EVENT_NAME_MAX = `enum _SC_TRACE_EVENT_NAME_MAX = _SC_TRACE_EVENT_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_EVENT_NAME_MAX); }))) {
            mixin(enumMixinStr__SC_TRACE_EVENT_NAME_MAX);
        }
    }
    static if(!is(typeof(INT8_MIN))) {
        private enum enumMixinStr_INT8_MIN = `enum INT8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MIN); }))) {
            mixin(enumMixinStr_INT8_MIN);
        }
    }




    static if(!is(typeof(INT16_MIN))) {
        private enum enumMixinStr_INT16_MIN = `enum INT16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MIN); }))) {
            mixin(enumMixinStr_INT16_MIN);
        }
    }




    static if(!is(typeof(INT32_MIN))) {
        private enum enumMixinStr_INT32_MIN = `enum INT32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MIN); }))) {
            mixin(enumMixinStr_INT32_MIN);
        }
    }




    static if(!is(typeof(INT64_MIN))) {
        private enum enumMixinStr_INT64_MIN = `enum INT64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MIN); }))) {
            mixin(enumMixinStr_INT64_MIN);
        }
    }




    static if(!is(typeof(INT8_MAX))) {
        private enum enumMixinStr_INT8_MAX = `enum INT8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MAX); }))) {
            mixin(enumMixinStr_INT8_MAX);
        }
    }




    static if(!is(typeof(INT16_MAX))) {
        private enum enumMixinStr_INT16_MAX = `enum INT16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MAX); }))) {
            mixin(enumMixinStr_INT16_MAX);
        }
    }




    static if(!is(typeof(INT32_MAX))) {
        private enum enumMixinStr_INT32_MAX = `enum INT32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MAX); }))) {
            mixin(enumMixinStr_INT32_MAX);
        }
    }




    static if(!is(typeof(INT64_MAX))) {
        private enum enumMixinStr_INT64_MAX = `enum INT64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MAX); }))) {
            mixin(enumMixinStr_INT64_MAX);
        }
    }




    static if(!is(typeof(UINT8_MAX))) {
        private enum enumMixinStr_UINT8_MAX = `enum UINT8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT8_MAX); }))) {
            mixin(enumMixinStr_UINT8_MAX);
        }
    }




    static if(!is(typeof(UINT16_MAX))) {
        private enum enumMixinStr_UINT16_MAX = `enum UINT16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT16_MAX); }))) {
            mixin(enumMixinStr_UINT16_MAX);
        }
    }




    static if(!is(typeof(UINT32_MAX))) {
        private enum enumMixinStr_UINT32_MAX = `enum UINT32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT32_MAX); }))) {
            mixin(enumMixinStr_UINT32_MAX);
        }
    }




    static if(!is(typeof(UINT64_MAX))) {
        private enum enumMixinStr_UINT64_MAX = `enum UINT64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT64_MAX); }))) {
            mixin(enumMixinStr_UINT64_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST8_MIN))) {
        private enum enumMixinStr_INT_LEAST8_MIN = `enum INT_LEAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST8_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST16_MIN))) {
        private enum enumMixinStr_INT_LEAST16_MIN = `enum INT_LEAST16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST16_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST32_MIN))) {
        private enum enumMixinStr_INT_LEAST32_MIN = `enum INT_LEAST32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST32_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST64_MIN))) {
        private enum enumMixinStr_INT_LEAST64_MIN = `enum INT_LEAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST64_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST8_MAX))) {
        private enum enumMixinStr_INT_LEAST8_MAX = `enum INT_LEAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST16_MAX))) {
        private enum enumMixinStr_INT_LEAST16_MAX = `enum INT_LEAST16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST32_MAX))) {
        private enum enumMixinStr_INT_LEAST32_MAX = `enum INT_LEAST32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MAX))) {
        private enum enumMixinStr_INT_LEAST64_MAX = `enum INT_LEAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST8_MAX))) {
        private enum enumMixinStr_UINT_LEAST8_MAX = `enum UINT_LEAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST16_MAX))) {
        private enum enumMixinStr_UINT_LEAST16_MAX = `enum UINT_LEAST16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST32_MAX))) {
        private enum enumMixinStr_UINT_LEAST32_MAX = `enum UINT_LEAST32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST64_MAX))) {
        private enum enumMixinStr_UINT_LEAST64_MAX = `enum UINT_LEAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(INT_FAST8_MIN))) {
        private enum enumMixinStr_INT_FAST8_MIN = `enum INT_FAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MIN); }))) {
            mixin(enumMixinStr_INT_FAST8_MIN);
        }
    }




    static if(!is(typeof(_SC_SS_REPL_MAX))) {
        private enum enumMixinStr__SC_SS_REPL_MAX = `enum _SC_SS_REPL_MAX = _SC_SS_REPL_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SS_REPL_MAX); }))) {
            mixin(enumMixinStr__SC_SS_REPL_MAX);
        }
    }




    static if(!is(typeof(INT_FAST16_MIN))) {
        private enum enumMixinStr_INT_FAST16_MIN = `enum INT_FAST16_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MIN); }))) {
            mixin(enumMixinStr_INT_FAST16_MIN);
        }
    }




    static if(!is(typeof(INT_FAST32_MIN))) {
        private enum enumMixinStr_INT_FAST32_MIN = `enum INT_FAST32_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MIN); }))) {
            mixin(enumMixinStr_INT_FAST32_MIN);
        }
    }




    static if(!is(typeof(INT_FAST64_MIN))) {
        private enum enumMixinStr_INT_FAST64_MIN = `enum INT_FAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MIN); }))) {
            mixin(enumMixinStr_INT_FAST64_MIN);
        }
    }




    static if(!is(typeof(INT_FAST8_MAX))) {
        private enum enumMixinStr_INT_FAST8_MAX = `enum INT_FAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MAX); }))) {
            mixin(enumMixinStr_INT_FAST8_MAX);
        }
    }




    static if(!is(typeof(_SC_V7_LPBIG_OFFBIG))) {
        private enum enumMixinStr__SC_V7_LPBIG_OFFBIG = `enum _SC_V7_LPBIG_OFFBIG = _SC_V7_LPBIG_OFFBIG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V7_LPBIG_OFFBIG); }))) {
            mixin(enumMixinStr__SC_V7_LPBIG_OFFBIG);
        }
    }




    static if(!is(typeof(INT_FAST16_MAX))) {
        private enum enumMixinStr_INT_FAST16_MAX = `enum INT_FAST16_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MAX); }))) {
            mixin(enumMixinStr_INT_FAST16_MAX);
        }
    }




    static if(!is(typeof(INT_FAST32_MAX))) {
        private enum enumMixinStr_INT_FAST32_MAX = `enum INT_FAST32_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MAX); }))) {
            mixin(enumMixinStr_INT_FAST32_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MAX))) {
        private enum enumMixinStr_INT_FAST64_MAX = `enum INT_FAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MAX); }))) {
            mixin(enumMixinStr_INT_FAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST8_MAX))) {
        private enum enumMixinStr_UINT_FAST8_MAX = `enum UINT_FAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST8_MAX);
        }
    }




    static if(!is(typeof(_SC_V7_LP64_OFF64))) {
        private enum enumMixinStr__SC_V7_LP64_OFF64 = `enum _SC_V7_LP64_OFF64 = _SC_V7_LP64_OFF64;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V7_LP64_OFF64); }))) {
            mixin(enumMixinStr__SC_V7_LP64_OFF64);
        }
    }




    static if(!is(typeof(UINT_FAST16_MAX))) {
        private enum enumMixinStr_UINT_FAST16_MAX = `enum UINT_FAST16_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST32_MAX))) {
        private enum enumMixinStr_UINT_FAST32_MAX = `enum UINT_FAST32_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST64_MAX))) {
        private enum enumMixinStr_UINT_FAST64_MAX = `enum UINT_FAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST64_MAX);
        }
    }




    static if(!is(typeof(_SC_V7_ILP32_OFFBIG))) {
        private enum enumMixinStr__SC_V7_ILP32_OFFBIG = `enum _SC_V7_ILP32_OFFBIG = _SC_V7_ILP32_OFFBIG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V7_ILP32_OFFBIG); }))) {
            mixin(enumMixinStr__SC_V7_ILP32_OFFBIG);
        }
    }




    static if(!is(typeof(INTPTR_MIN))) {
        private enum enumMixinStr_INTPTR_MIN = `enum INTPTR_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MIN); }))) {
            mixin(enumMixinStr_INTPTR_MIN);
        }
    }




    static if(!is(typeof(INTPTR_MAX))) {
        private enum enumMixinStr_INTPTR_MAX = `enum INTPTR_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MAX); }))) {
            mixin(enumMixinStr_INTPTR_MAX);
        }
    }




    static if(!is(typeof(UINTPTR_MAX))) {
        private enum enumMixinStr_UINTPTR_MAX = `enum UINTPTR_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTPTR_MAX); }))) {
            mixin(enumMixinStr_UINTPTR_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MIN))) {
        private enum enumMixinStr_INTMAX_MIN = `enum INTMAX_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MIN); }))) {
            mixin(enumMixinStr_INTMAX_MIN);
        }
    }




    static if(!is(typeof(INTMAX_MAX))) {
        private enum enumMixinStr_INTMAX_MAX = `enum INTMAX_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MAX); }))) {
            mixin(enumMixinStr_INTMAX_MAX);
        }
    }




    static if(!is(typeof(UINTMAX_MAX))) {
        private enum enumMixinStr_UINTMAX_MAX = `enum UINTMAX_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTMAX_MAX); }))) {
            mixin(enumMixinStr_UINTMAX_MAX);
        }
    }




    static if(!is(typeof(_SC_V7_ILP32_OFF32))) {
        private enum enumMixinStr__SC_V7_ILP32_OFF32 = `enum _SC_V7_ILP32_OFF32 = _SC_V7_ILP32_OFF32;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V7_ILP32_OFF32); }))) {
            mixin(enumMixinStr__SC_V7_ILP32_OFF32);
        }
    }




    static if(!is(typeof(PTRDIFF_MIN))) {
        private enum enumMixinStr_PTRDIFF_MIN = `enum PTRDIFF_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MIN); }))) {
            mixin(enumMixinStr_PTRDIFF_MIN);
        }
    }




    static if(!is(typeof(PTRDIFF_MAX))) {
        private enum enumMixinStr_PTRDIFF_MAX = `enum PTRDIFF_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MAX); }))) {
            mixin(enumMixinStr_PTRDIFF_MAX);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MIN))) {
        private enum enumMixinStr_SIG_ATOMIC_MIN = `enum SIG_ATOMIC_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MIN); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MIN);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MAX))) {
        private enum enumMixinStr_SIG_ATOMIC_MAX = `enum SIG_ATOMIC_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MAX); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MAX);
        }
    }




    static if(!is(typeof(_SC_RAW_SOCKETS))) {
        private enum enumMixinStr__SC_RAW_SOCKETS = `enum _SC_RAW_SOCKETS = _SC_RAW_SOCKETS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_RAW_SOCKETS); }))) {
            mixin(enumMixinStr__SC_RAW_SOCKETS);
        }
    }




    static if(!is(typeof(SIZE_MAX))) {
        private enum enumMixinStr_SIZE_MAX = `enum SIZE_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_SIZE_MAX); }))) {
            mixin(enumMixinStr_SIZE_MAX);
        }
    }




    static if(!is(typeof(WCHAR_MIN))) {
        private enum enumMixinStr_WCHAR_MIN = `enum WCHAR_MIN = ( - 0x7fffffff - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MIN); }))) {
            mixin(enumMixinStr_WCHAR_MIN);
        }
    }




    static if(!is(typeof(WCHAR_MAX))) {
        private enum enumMixinStr_WCHAR_MAX = `enum WCHAR_MAX = 0x7fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MAX); }))) {
            mixin(enumMixinStr_WCHAR_MAX);
        }
    }




    static if(!is(typeof(WINT_MIN))) {
        private enum enumMixinStr_WINT_MIN = `enum WINT_MIN = ( 0u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MIN); }))) {
            mixin(enumMixinStr_WINT_MIN);
        }
    }




    static if(!is(typeof(WINT_MAX))) {
        private enum enumMixinStr_WINT_MAX = `enum WINT_MAX = ( 4294967295u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MAX); }))) {
            mixin(enumMixinStr_WINT_MAX);
        }
    }
    static if(!is(typeof(_SC_IPV6))) {
        private enum enumMixinStr__SC_IPV6 = `enum _SC_IPV6 = _SC_IPV6;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_IPV6); }))) {
            mixin(enumMixinStr__SC_IPV6);
        }
    }
    static if(!is(typeof(_SC_LEVEL4_CACHE_LINESIZE))) {
        private enum enumMixinStr__SC_LEVEL4_CACHE_LINESIZE = `enum _SC_LEVEL4_CACHE_LINESIZE = _SC_LEVEL4_CACHE_LINESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL4_CACHE_LINESIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL4_CACHE_LINESIZE);
        }
    }






    static if(!is(typeof(_SC_LEVEL4_CACHE_ASSOC))) {
        private enum enumMixinStr__SC_LEVEL4_CACHE_ASSOC = `enum _SC_LEVEL4_CACHE_ASSOC = _SC_LEVEL4_CACHE_ASSOC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL4_CACHE_ASSOC); }))) {
            mixin(enumMixinStr__SC_LEVEL4_CACHE_ASSOC);
        }
    }
    static if(!is(typeof(_SC_LEVEL4_CACHE_SIZE))) {
        private enum enumMixinStr__SC_LEVEL4_CACHE_SIZE = `enum _SC_LEVEL4_CACHE_SIZE = _SC_LEVEL4_CACHE_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL4_CACHE_SIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL4_CACHE_SIZE);
        }
    }




    static if(!is(typeof(_STDIO_H))) {
        private enum enumMixinStr__STDIO_H = `enum _STDIO_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDIO_H); }))) {
            mixin(enumMixinStr__STDIO_H);
        }
    }




    static if(!is(typeof(_SC_LEVEL3_CACHE_LINESIZE))) {
        private enum enumMixinStr__SC_LEVEL3_CACHE_LINESIZE = `enum _SC_LEVEL3_CACHE_LINESIZE = _SC_LEVEL3_CACHE_LINESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL3_CACHE_LINESIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL3_CACHE_LINESIZE);
        }
    }




    static if(!is(typeof(_SC_LEVEL3_CACHE_ASSOC))) {
        private enum enumMixinStr__SC_LEVEL3_CACHE_ASSOC = `enum _SC_LEVEL3_CACHE_ASSOC = _SC_LEVEL3_CACHE_ASSOC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL3_CACHE_ASSOC); }))) {
            mixin(enumMixinStr__SC_LEVEL3_CACHE_ASSOC);
        }
    }






    static if(!is(typeof(_SC_LEVEL3_CACHE_SIZE))) {
        private enum enumMixinStr__SC_LEVEL3_CACHE_SIZE = `enum _SC_LEVEL3_CACHE_SIZE = _SC_LEVEL3_CACHE_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL3_CACHE_SIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL3_CACHE_SIZE);
        }
    }






    static if(!is(typeof(_SC_LEVEL2_CACHE_LINESIZE))) {
        private enum enumMixinStr__SC_LEVEL2_CACHE_LINESIZE = `enum _SC_LEVEL2_CACHE_LINESIZE = _SC_LEVEL2_CACHE_LINESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL2_CACHE_LINESIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL2_CACHE_LINESIZE);
        }
    }




    static if(!is(typeof(_SC_LEVEL2_CACHE_ASSOC))) {
        private enum enumMixinStr__SC_LEVEL2_CACHE_ASSOC = `enum _SC_LEVEL2_CACHE_ASSOC = _SC_LEVEL2_CACHE_ASSOC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL2_CACHE_ASSOC); }))) {
            mixin(enumMixinStr__SC_LEVEL2_CACHE_ASSOC);
        }
    }




    static if(!is(typeof(_SC_LEVEL2_CACHE_SIZE))) {
        private enum enumMixinStr__SC_LEVEL2_CACHE_SIZE = `enum _SC_LEVEL2_CACHE_SIZE = _SC_LEVEL2_CACHE_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL2_CACHE_SIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL2_CACHE_SIZE);
        }
    }




    static if(!is(typeof(_SC_LEVEL1_DCACHE_LINESIZE))) {
        private enum enumMixinStr__SC_LEVEL1_DCACHE_LINESIZE = `enum _SC_LEVEL1_DCACHE_LINESIZE = _SC_LEVEL1_DCACHE_LINESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL1_DCACHE_LINESIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL1_DCACHE_LINESIZE);
        }
    }




    static if(!is(typeof(_SC_LEVEL1_DCACHE_ASSOC))) {
        private enum enumMixinStr__SC_LEVEL1_DCACHE_ASSOC = `enum _SC_LEVEL1_DCACHE_ASSOC = _SC_LEVEL1_DCACHE_ASSOC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL1_DCACHE_ASSOC); }))) {
            mixin(enumMixinStr__SC_LEVEL1_DCACHE_ASSOC);
        }
    }




    static if(!is(typeof(_SC_LEVEL1_DCACHE_SIZE))) {
        private enum enumMixinStr__SC_LEVEL1_DCACHE_SIZE = `enum _SC_LEVEL1_DCACHE_SIZE = _SC_LEVEL1_DCACHE_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL1_DCACHE_SIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL1_DCACHE_SIZE);
        }
    }




    static if(!is(typeof(_SC_LEVEL1_ICACHE_LINESIZE))) {
        private enum enumMixinStr__SC_LEVEL1_ICACHE_LINESIZE = `enum _SC_LEVEL1_ICACHE_LINESIZE = _SC_LEVEL1_ICACHE_LINESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL1_ICACHE_LINESIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL1_ICACHE_LINESIZE);
        }
    }




    static if(!is(typeof(_SC_LEVEL1_ICACHE_ASSOC))) {
        private enum enumMixinStr__SC_LEVEL1_ICACHE_ASSOC = `enum _SC_LEVEL1_ICACHE_ASSOC = _SC_LEVEL1_ICACHE_ASSOC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL1_ICACHE_ASSOC); }))) {
            mixin(enumMixinStr__SC_LEVEL1_ICACHE_ASSOC);
        }
    }




    static if(!is(typeof(_SC_LEVEL1_ICACHE_SIZE))) {
        private enum enumMixinStr__SC_LEVEL1_ICACHE_SIZE = `enum _SC_LEVEL1_ICACHE_SIZE = _SC_LEVEL1_ICACHE_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LEVEL1_ICACHE_SIZE); }))) {
            mixin(enumMixinStr__SC_LEVEL1_ICACHE_SIZE);
        }
    }






    static if(!is(typeof(_SC_TRACE_LOG))) {
        private enum enumMixinStr__SC_TRACE_LOG = `enum _SC_TRACE_LOG = _SC_TRACE_LOG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_LOG); }))) {
            mixin(enumMixinStr__SC_TRACE_LOG);
        }
    }




    static if(!is(typeof(_SC_TRACE_INHERIT))) {
        private enum enumMixinStr__SC_TRACE_INHERIT = `enum _SC_TRACE_INHERIT = _SC_TRACE_INHERIT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_INHERIT); }))) {
            mixin(enumMixinStr__SC_TRACE_INHERIT);
        }
    }




    static if(!is(typeof(_SC_TRACE_EVENT_FILTER))) {
        private enum enumMixinStr__SC_TRACE_EVENT_FILTER = `enum _SC_TRACE_EVENT_FILTER = _SC_TRACE_EVENT_FILTER;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE_EVENT_FILTER); }))) {
            mixin(enumMixinStr__SC_TRACE_EVENT_FILTER);
        }
    }




    static if(!is(typeof(_SC_TRACE))) {
        private enum enumMixinStr__SC_TRACE = `enum _SC_TRACE = _SC_TRACE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TRACE); }))) {
            mixin(enumMixinStr__SC_TRACE);
        }
    }




    static if(!is(typeof(_SC_HOST_NAME_MAX))) {
        private enum enumMixinStr__SC_HOST_NAME_MAX = `enum _SC_HOST_NAME_MAX = _SC_HOST_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_HOST_NAME_MAX); }))) {
            mixin(enumMixinStr__SC_HOST_NAME_MAX);
        }
    }




    static if(!is(typeof(_IOFBF))) {
        private enum enumMixinStr__IOFBF = `enum _IOFBF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr__IOFBF); }))) {
            mixin(enumMixinStr__IOFBF);
        }
    }




    static if(!is(typeof(_IOLBF))) {
        private enum enumMixinStr__IOLBF = `enum _IOLBF = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__IOLBF); }))) {
            mixin(enumMixinStr__IOLBF);
        }
    }




    static if(!is(typeof(_IONBF))) {
        private enum enumMixinStr__IONBF = `enum _IONBF = 2;`;
        static if(is(typeof({ mixin(enumMixinStr__IONBF); }))) {
            mixin(enumMixinStr__IONBF);
        }
    }




    static if(!is(typeof(BUFSIZ))) {
        private enum enumMixinStr_BUFSIZ = `enum BUFSIZ = 8192;`;
        static if(is(typeof({ mixin(enumMixinStr_BUFSIZ); }))) {
            mixin(enumMixinStr_BUFSIZ);
        }
    }




    static if(!is(typeof(EOF))) {
        private enum enumMixinStr_EOF = `enum EOF = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_EOF); }))) {
            mixin(enumMixinStr_EOF);
        }
    }




    static if(!is(typeof(_SC_V6_LPBIG_OFFBIG))) {
        private enum enumMixinStr__SC_V6_LPBIG_OFFBIG = `enum _SC_V6_LPBIG_OFFBIG = _SC_V6_LPBIG_OFFBIG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V6_LPBIG_OFFBIG); }))) {
            mixin(enumMixinStr__SC_V6_LPBIG_OFFBIG);
        }
    }




    static if(!is(typeof(P_tmpdir))) {
        private enum enumMixinStr_P_tmpdir = `enum P_tmpdir = "/tmp";`;
        static if(is(typeof({ mixin(enumMixinStr_P_tmpdir); }))) {
            mixin(enumMixinStr_P_tmpdir);
        }
    }




    static if(!is(typeof(_SC_V6_LP64_OFF64))) {
        private enum enumMixinStr__SC_V6_LP64_OFF64 = `enum _SC_V6_LP64_OFF64 = _SC_V6_LP64_OFF64;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V6_LP64_OFF64); }))) {
            mixin(enumMixinStr__SC_V6_LP64_OFF64);
        }
    }




    static if(!is(typeof(_SC_V6_ILP32_OFFBIG))) {
        private enum enumMixinStr__SC_V6_ILP32_OFFBIG = `enum _SC_V6_ILP32_OFFBIG = _SC_V6_ILP32_OFFBIG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V6_ILP32_OFFBIG); }))) {
            mixin(enumMixinStr__SC_V6_ILP32_OFFBIG);
        }
    }




    static if(!is(typeof(_SC_V6_ILP32_OFF32))) {
        private enum enumMixinStr__SC_V6_ILP32_OFF32 = `enum _SC_V6_ILP32_OFF32 = _SC_V6_ILP32_OFF32;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_V6_ILP32_OFF32); }))) {
            mixin(enumMixinStr__SC_V6_ILP32_OFF32);
        }
    }




    static if(!is(typeof(_SC_2_PBS_CHECKPOINT))) {
        private enum enumMixinStr__SC_2_PBS_CHECKPOINT = `enum _SC_2_PBS_CHECKPOINT = _SC_2_PBS_CHECKPOINT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_PBS_CHECKPOINT); }))) {
            mixin(enumMixinStr__SC_2_PBS_CHECKPOINT);
        }
    }




    static if(!is(typeof(stdin))) {
        private enum enumMixinStr_stdin = `enum stdin = stdin;`;
        static if(is(typeof({ mixin(enumMixinStr_stdin); }))) {
            mixin(enumMixinStr_stdin);
        }
    }




    static if(!is(typeof(stdout))) {
        private enum enumMixinStr_stdout = `enum stdout = stdout;`;
        static if(is(typeof({ mixin(enumMixinStr_stdout); }))) {
            mixin(enumMixinStr_stdout);
        }
    }




    static if(!is(typeof(stderr))) {
        private enum enumMixinStr_stderr = `enum stderr = stderr;`;
        static if(is(typeof({ mixin(enumMixinStr_stderr); }))) {
            mixin(enumMixinStr_stderr);
        }
    }




    static if(!is(typeof(_SC_STREAMS))) {
        private enum enumMixinStr__SC_STREAMS = `enum _SC_STREAMS = _SC_STREAMS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_STREAMS); }))) {
            mixin(enumMixinStr__SC_STREAMS);
        }
    }




    static if(!is(typeof(_SC_SYMLOOP_MAX))) {
        private enum enumMixinStr__SC_SYMLOOP_MAX = `enum _SC_SYMLOOP_MAX = _SC_SYMLOOP_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SYMLOOP_MAX); }))) {
            mixin(enumMixinStr__SC_SYMLOOP_MAX);
        }
    }




    static if(!is(typeof(_SC_2_PBS_TRACK))) {
        private enum enumMixinStr__SC_2_PBS_TRACK = `enum _SC_2_PBS_TRACK = _SC_2_PBS_TRACK;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_PBS_TRACK); }))) {
            mixin(enumMixinStr__SC_2_PBS_TRACK);
        }
    }




    static if(!is(typeof(_SC_2_PBS_MESSAGE))) {
        private enum enumMixinStr__SC_2_PBS_MESSAGE = `enum _SC_2_PBS_MESSAGE = _SC_2_PBS_MESSAGE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_PBS_MESSAGE); }))) {
            mixin(enumMixinStr__SC_2_PBS_MESSAGE);
        }
    }




    static if(!is(typeof(_SC_2_PBS_LOCATE))) {
        private enum enumMixinStr__SC_2_PBS_LOCATE = `enum _SC_2_PBS_LOCATE = _SC_2_PBS_LOCATE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_PBS_LOCATE); }))) {
            mixin(enumMixinStr__SC_2_PBS_LOCATE);
        }
    }




    static if(!is(typeof(_SC_2_PBS_ACCOUNTING))) {
        private enum enumMixinStr__SC_2_PBS_ACCOUNTING = `enum _SC_2_PBS_ACCOUNTING = _SC_2_PBS_ACCOUNTING;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_PBS_ACCOUNTING); }))) {
            mixin(enumMixinStr__SC_2_PBS_ACCOUNTING);
        }
    }




    static if(!is(typeof(_SC_2_PBS))) {
        private enum enumMixinStr__SC_2_PBS = `enum _SC_2_PBS = _SC_2_PBS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_PBS); }))) {
            mixin(enumMixinStr__SC_2_PBS);
        }
    }




    static if(!is(typeof(_SC_USER_GROUPS_R))) {
        private enum enumMixinStr__SC_USER_GROUPS_R = `enum _SC_USER_GROUPS_R = _SC_USER_GROUPS_R;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_USER_GROUPS_R); }))) {
            mixin(enumMixinStr__SC_USER_GROUPS_R);
        }
    }




    static if(!is(typeof(_SC_USER_GROUPS))) {
        private enum enumMixinStr__SC_USER_GROUPS = `enum _SC_USER_GROUPS = _SC_USER_GROUPS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_USER_GROUPS); }))) {
            mixin(enumMixinStr__SC_USER_GROUPS);
        }
    }




    static if(!is(typeof(_SC_TYPED_MEMORY_OBJECTS))) {
        private enum enumMixinStr__SC_TYPED_MEMORY_OBJECTS = `enum _SC_TYPED_MEMORY_OBJECTS = _SC_TYPED_MEMORY_OBJECTS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TYPED_MEMORY_OBJECTS); }))) {
            mixin(enumMixinStr__SC_TYPED_MEMORY_OBJECTS);
        }
    }




    static if(!is(typeof(_SC_TIMEOUTS))) {
        private enum enumMixinStr__SC_TIMEOUTS = `enum _SC_TIMEOUTS = _SC_TIMEOUTS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TIMEOUTS); }))) {
            mixin(enumMixinStr__SC_TIMEOUTS);
        }
    }




    static if(!is(typeof(_SC_SYSTEM_DATABASE_R))) {
        private enum enumMixinStr__SC_SYSTEM_DATABASE_R = `enum _SC_SYSTEM_DATABASE_R = _SC_SYSTEM_DATABASE_R;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SYSTEM_DATABASE_R); }))) {
            mixin(enumMixinStr__SC_SYSTEM_DATABASE_R);
        }
    }




    static if(!is(typeof(_SC_SYSTEM_DATABASE))) {
        private enum enumMixinStr__SC_SYSTEM_DATABASE = `enum _SC_SYSTEM_DATABASE = _SC_SYSTEM_DATABASE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SYSTEM_DATABASE); }))) {
            mixin(enumMixinStr__SC_SYSTEM_DATABASE);
        }
    }




    static if(!is(typeof(_SC_THREAD_SPORADIC_SERVER))) {
        private enum enumMixinStr__SC_THREAD_SPORADIC_SERVER = `enum _SC_THREAD_SPORADIC_SERVER = _SC_THREAD_SPORADIC_SERVER;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_SPORADIC_SERVER); }))) {
            mixin(enumMixinStr__SC_THREAD_SPORADIC_SERVER);
        }
    }




    static if(!is(typeof(_SC_SPORADIC_SERVER))) {
        private enum enumMixinStr__SC_SPORADIC_SERVER = `enum _SC_SPORADIC_SERVER = _SC_SPORADIC_SERVER;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SPORADIC_SERVER); }))) {
            mixin(enumMixinStr__SC_SPORADIC_SERVER);
        }
    }




    static if(!is(typeof(_SC_SPAWN))) {
        private enum enumMixinStr__SC_SPAWN = `enum _SC_SPAWN = _SC_SPAWN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SPAWN); }))) {
            mixin(enumMixinStr__SC_SPAWN);
        }
    }




    static if(!is(typeof(_SC_SIGNALS))) {
        private enum enumMixinStr__SC_SIGNALS = `enum _SC_SIGNALS = _SC_SIGNALS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SIGNALS); }))) {
            mixin(enumMixinStr__SC_SIGNALS);
        }
    }




    static if(!is(typeof(_SC_SHELL))) {
        private enum enumMixinStr__SC_SHELL = `enum _SC_SHELL = _SC_SHELL;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SHELL); }))) {
            mixin(enumMixinStr__SC_SHELL);
        }
    }




    static if(!is(typeof(_SC_REGEX_VERSION))) {
        private enum enumMixinStr__SC_REGEX_VERSION = `enum _SC_REGEX_VERSION = _SC_REGEX_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_REGEX_VERSION); }))) {
            mixin(enumMixinStr__SC_REGEX_VERSION);
        }
    }




    static if(!is(typeof(_SC_REGEXP))) {
        private enum enumMixinStr__SC_REGEXP = `enum _SC_REGEXP = _SC_REGEXP;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_REGEXP); }))) {
            mixin(enumMixinStr__SC_REGEXP);
        }
    }




    static if(!is(typeof(_SC_SPIN_LOCKS))) {
        private enum enumMixinStr__SC_SPIN_LOCKS = `enum _SC_SPIN_LOCKS = _SC_SPIN_LOCKS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SPIN_LOCKS); }))) {
            mixin(enumMixinStr__SC_SPIN_LOCKS);
        }
    }




    static if(!is(typeof(_SC_READER_WRITER_LOCKS))) {
        private enum enumMixinStr__SC_READER_WRITER_LOCKS = `enum _SC_READER_WRITER_LOCKS = _SC_READER_WRITER_LOCKS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_READER_WRITER_LOCKS); }))) {
            mixin(enumMixinStr__SC_READER_WRITER_LOCKS);
        }
    }




    static if(!is(typeof(_SC_NETWORKING))) {
        private enum enumMixinStr__SC_NETWORKING = `enum _SC_NETWORKING = _SC_NETWORKING;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NETWORKING); }))) {
            mixin(enumMixinStr__SC_NETWORKING);
        }
    }




    static if(!is(typeof(_SC_SINGLE_PROCESS))) {
        private enum enumMixinStr__SC_SINGLE_PROCESS = `enum _SC_SINGLE_PROCESS = _SC_SINGLE_PROCESS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SINGLE_PROCESS); }))) {
            mixin(enumMixinStr__SC_SINGLE_PROCESS);
        }
    }




    static if(!is(typeof(_SC_MULTI_PROCESS))) {
        private enum enumMixinStr__SC_MULTI_PROCESS = `enum _SC_MULTI_PROCESS = _SC_MULTI_PROCESS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MULTI_PROCESS); }))) {
            mixin(enumMixinStr__SC_MULTI_PROCESS);
        }
    }




    static if(!is(typeof(_SC_MONOTONIC_CLOCK))) {
        private enum enumMixinStr__SC_MONOTONIC_CLOCK = `enum _SC_MONOTONIC_CLOCK = _SC_MONOTONIC_CLOCK;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MONOTONIC_CLOCK); }))) {
            mixin(enumMixinStr__SC_MONOTONIC_CLOCK);
        }
    }




    static if(!is(typeof(_SC_FILE_SYSTEM))) {
        private enum enumMixinStr__SC_FILE_SYSTEM = `enum _SC_FILE_SYSTEM = _SC_FILE_SYSTEM;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_FILE_SYSTEM); }))) {
            mixin(enumMixinStr__SC_FILE_SYSTEM);
        }
    }




    static if(!is(typeof(_SC_FILE_LOCKING))) {
        private enum enumMixinStr__SC_FILE_LOCKING = `enum _SC_FILE_LOCKING = _SC_FILE_LOCKING;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_FILE_LOCKING); }))) {
            mixin(enumMixinStr__SC_FILE_LOCKING);
        }
    }




    static if(!is(typeof(_SC_FILE_ATTRIBUTES))) {
        private enum enumMixinStr__SC_FILE_ATTRIBUTES = `enum _SC_FILE_ATTRIBUTES = _SC_FILE_ATTRIBUTES;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_FILE_ATTRIBUTES); }))) {
            mixin(enumMixinStr__SC_FILE_ATTRIBUTES);
        }
    }




    static if(!is(typeof(_SC_PIPE))) {
        private enum enumMixinStr__SC_PIPE = `enum _SC_PIPE = _SC_PIPE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PIPE); }))) {
            mixin(enumMixinStr__SC_PIPE);
        }
    }




    static if(!is(typeof(_SC_FIFO))) {
        private enum enumMixinStr__SC_FIFO = `enum _SC_FIFO = _SC_FIFO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_FIFO); }))) {
            mixin(enumMixinStr__SC_FIFO);
        }
    }




    static if(!is(typeof(_SC_FD_MGMT))) {
        private enum enumMixinStr__SC_FD_MGMT = `enum _SC_FD_MGMT = _SC_FD_MGMT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_FD_MGMT); }))) {
            mixin(enumMixinStr__SC_FD_MGMT);
        }
    }




    static if(!is(typeof(_SC_DEVICE_SPECIFIC_R))) {
        private enum enumMixinStr__SC_DEVICE_SPECIFIC_R = `enum _SC_DEVICE_SPECIFIC_R = _SC_DEVICE_SPECIFIC_R;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_DEVICE_SPECIFIC_R); }))) {
            mixin(enumMixinStr__SC_DEVICE_SPECIFIC_R);
        }
    }




    static if(!is(typeof(_SC_DEVICE_SPECIFIC))) {
        private enum enumMixinStr__SC_DEVICE_SPECIFIC = `enum _SC_DEVICE_SPECIFIC = _SC_DEVICE_SPECIFIC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_DEVICE_SPECIFIC); }))) {
            mixin(enumMixinStr__SC_DEVICE_SPECIFIC);
        }
    }




    static if(!is(typeof(_SC_DEVICE_IO))) {
        private enum enumMixinStr__SC_DEVICE_IO = `enum _SC_DEVICE_IO = _SC_DEVICE_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_DEVICE_IO); }))) {
            mixin(enumMixinStr__SC_DEVICE_IO);
        }
    }




    static if(!is(typeof(_SC_THREAD_CPUTIME))) {
        private enum enumMixinStr__SC_THREAD_CPUTIME = `enum _SC_THREAD_CPUTIME = _SC_THREAD_CPUTIME;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_CPUTIME); }))) {
            mixin(enumMixinStr__SC_THREAD_CPUTIME);
        }
    }




    static if(!is(typeof(_SC_CPUTIME))) {
        private enum enumMixinStr__SC_CPUTIME = `enum _SC_CPUTIME = _SC_CPUTIME;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CPUTIME); }))) {
            mixin(enumMixinStr__SC_CPUTIME);
        }
    }




    static if(!is(typeof(_SC_CLOCK_SELECTION))) {
        private enum enumMixinStr__SC_CLOCK_SELECTION = `enum _SC_CLOCK_SELECTION = _SC_CLOCK_SELECTION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CLOCK_SELECTION); }))) {
            mixin(enumMixinStr__SC_CLOCK_SELECTION);
        }
    }




    static if(!is(typeof(_SC_C_LANG_SUPPORT_R))) {
        private enum enumMixinStr__SC_C_LANG_SUPPORT_R = `enum _SC_C_LANG_SUPPORT_R = _SC_C_LANG_SUPPORT_R;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_C_LANG_SUPPORT_R); }))) {
            mixin(enumMixinStr__SC_C_LANG_SUPPORT_R);
        }
    }




    static if(!is(typeof(_SC_C_LANG_SUPPORT))) {
        private enum enumMixinStr__SC_C_LANG_SUPPORT = `enum _SC_C_LANG_SUPPORT = _SC_C_LANG_SUPPORT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_C_LANG_SUPPORT); }))) {
            mixin(enumMixinStr__SC_C_LANG_SUPPORT);
        }
    }




    static if(!is(typeof(_SC_BASE))) {
        private enum enumMixinStr__SC_BASE = `enum _SC_BASE = _SC_BASE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_BASE); }))) {
            mixin(enumMixinStr__SC_BASE);
        }
    }




    static if(!is(typeof(_SC_BARRIERS))) {
        private enum enumMixinStr__SC_BARRIERS = `enum _SC_BARRIERS = _SC_BARRIERS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_BARRIERS); }))) {
            mixin(enumMixinStr__SC_BARRIERS);
        }
    }




    static if(!is(typeof(_SC_ADVISORY_INFO))) {
        private enum enumMixinStr__SC_ADVISORY_INFO = `enum _SC_ADVISORY_INFO = _SC_ADVISORY_INFO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_ADVISORY_INFO); }))) {
            mixin(enumMixinStr__SC_ADVISORY_INFO);
        }
    }




    static if(!is(typeof(_SC_XOPEN_REALTIME_THREADS))) {
        private enum enumMixinStr__SC_XOPEN_REALTIME_THREADS = `enum _SC_XOPEN_REALTIME_THREADS = _SC_XOPEN_REALTIME_THREADS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_REALTIME_THREADS); }))) {
            mixin(enumMixinStr__SC_XOPEN_REALTIME_THREADS);
        }
    }




    static if(!is(typeof(_SC_XOPEN_REALTIME))) {
        private enum enumMixinStr__SC_XOPEN_REALTIME = `enum _SC_XOPEN_REALTIME = _SC_XOPEN_REALTIME;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_REALTIME); }))) {
            mixin(enumMixinStr__SC_XOPEN_REALTIME);
        }
    }




    static if(!is(typeof(_SC_XOPEN_LEGACY))) {
        private enum enumMixinStr__SC_XOPEN_LEGACY = `enum _SC_XOPEN_LEGACY = _SC_XOPEN_LEGACY;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_LEGACY); }))) {
            mixin(enumMixinStr__SC_XOPEN_LEGACY);
        }
    }




    static if(!is(typeof(_SC_XBS5_LPBIG_OFFBIG))) {
        private enum enumMixinStr__SC_XBS5_LPBIG_OFFBIG = `enum _SC_XBS5_LPBIG_OFFBIG = _SC_XBS5_LPBIG_OFFBIG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XBS5_LPBIG_OFFBIG); }))) {
            mixin(enumMixinStr__SC_XBS5_LPBIG_OFFBIG);
        }
    }




    static if(!is(typeof(_SC_XBS5_LP64_OFF64))) {
        private enum enumMixinStr__SC_XBS5_LP64_OFF64 = `enum _SC_XBS5_LP64_OFF64 = _SC_XBS5_LP64_OFF64;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XBS5_LP64_OFF64); }))) {
            mixin(enumMixinStr__SC_XBS5_LP64_OFF64);
        }
    }




    static if(!is(typeof(_SC_XBS5_ILP32_OFFBIG))) {
        private enum enumMixinStr__SC_XBS5_ILP32_OFFBIG = `enum _SC_XBS5_ILP32_OFFBIG = _SC_XBS5_ILP32_OFFBIG;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XBS5_ILP32_OFFBIG); }))) {
            mixin(enumMixinStr__SC_XBS5_ILP32_OFFBIG);
        }
    }




    static if(!is(typeof(_SC_XBS5_ILP32_OFF32))) {
        private enum enumMixinStr__SC_XBS5_ILP32_OFF32 = `enum _SC_XBS5_ILP32_OFF32 = _SC_XBS5_ILP32_OFF32;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XBS5_ILP32_OFF32); }))) {
            mixin(enumMixinStr__SC_XBS5_ILP32_OFF32);
        }
    }




    static if(!is(typeof(_SC_NL_TEXTMAX))) {
        private enum enumMixinStr__SC_NL_TEXTMAX = `enum _SC_NL_TEXTMAX = _SC_NL_TEXTMAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NL_TEXTMAX); }))) {
            mixin(enumMixinStr__SC_NL_TEXTMAX);
        }
    }




    static if(!is(typeof(_SC_NL_SETMAX))) {
        private enum enumMixinStr__SC_NL_SETMAX = `enum _SC_NL_SETMAX = _SC_NL_SETMAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NL_SETMAX); }))) {
            mixin(enumMixinStr__SC_NL_SETMAX);
        }
    }




    static if(!is(typeof(_SC_NL_NMAX))) {
        private enum enumMixinStr__SC_NL_NMAX = `enum _SC_NL_NMAX = _SC_NL_NMAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NL_NMAX); }))) {
            mixin(enumMixinStr__SC_NL_NMAX);
        }
    }




    static if(!is(typeof(_SC_NL_MSGMAX))) {
        private enum enumMixinStr__SC_NL_MSGMAX = `enum _SC_NL_MSGMAX = _SC_NL_MSGMAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NL_MSGMAX); }))) {
            mixin(enumMixinStr__SC_NL_MSGMAX);
        }
    }




    static if(!is(typeof(_SC_NL_LANGMAX))) {
        private enum enumMixinStr__SC_NL_LANGMAX = `enum _SC_NL_LANGMAX = _SC_NL_LANGMAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NL_LANGMAX); }))) {
            mixin(enumMixinStr__SC_NL_LANGMAX);
        }
    }




    static if(!is(typeof(_SC_NL_ARGMAX))) {
        private enum enumMixinStr__SC_NL_ARGMAX = `enum _SC_NL_ARGMAX = _SC_NL_ARGMAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NL_ARGMAX); }))) {
            mixin(enumMixinStr__SC_NL_ARGMAX);
        }
    }




    static if(!is(typeof(_SC_USHRT_MAX))) {
        private enum enumMixinStr__SC_USHRT_MAX = `enum _SC_USHRT_MAX = _SC_USHRT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_USHRT_MAX); }))) {
            mixin(enumMixinStr__SC_USHRT_MAX);
        }
    }




    static if(!is(typeof(_SC_ULONG_MAX))) {
        private enum enumMixinStr__SC_ULONG_MAX = `enum _SC_ULONG_MAX = _SC_ULONG_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_ULONG_MAX); }))) {
            mixin(enumMixinStr__SC_ULONG_MAX);
        }
    }




    static if(!is(typeof(_SC_UINT_MAX))) {
        private enum enumMixinStr__SC_UINT_MAX = `enum _SC_UINT_MAX = _SC_UINT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_UINT_MAX); }))) {
            mixin(enumMixinStr__SC_UINT_MAX);
        }
    }




    static if(!is(typeof(_SC_UCHAR_MAX))) {
        private enum enumMixinStr__SC_UCHAR_MAX = `enum _SC_UCHAR_MAX = _SC_UCHAR_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_UCHAR_MAX); }))) {
            mixin(enumMixinStr__SC_UCHAR_MAX);
        }
    }




    static if(!is(typeof(_SC_SHRT_MIN))) {
        private enum enumMixinStr__SC_SHRT_MIN = `enum _SC_SHRT_MIN = _SC_SHRT_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SHRT_MIN); }))) {
            mixin(enumMixinStr__SC_SHRT_MIN);
        }
    }




    static if(!is(typeof(_SC_SHRT_MAX))) {
        private enum enumMixinStr__SC_SHRT_MAX = `enum _SC_SHRT_MAX = _SC_SHRT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SHRT_MAX); }))) {
            mixin(enumMixinStr__SC_SHRT_MAX);
        }
    }




    static if(!is(typeof(_SC_SCHAR_MIN))) {
        private enum enumMixinStr__SC_SCHAR_MIN = `enum _SC_SCHAR_MIN = _SC_SCHAR_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SCHAR_MIN); }))) {
            mixin(enumMixinStr__SC_SCHAR_MIN);
        }
    }




    static if(!is(typeof(_SC_SCHAR_MAX))) {
        private enum enumMixinStr__SC_SCHAR_MAX = `enum _SC_SCHAR_MAX = _SC_SCHAR_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SCHAR_MAX); }))) {
            mixin(enumMixinStr__SC_SCHAR_MAX);
        }
    }




    static if(!is(typeof(_SC_SSIZE_MAX))) {
        private enum enumMixinStr__SC_SSIZE_MAX = `enum _SC_SSIZE_MAX = _SC_SSIZE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SSIZE_MAX); }))) {
            mixin(enumMixinStr__SC_SSIZE_MAX);
        }
    }




    static if(!is(typeof(_SC_NZERO))) {
        private enum enumMixinStr__SC_NZERO = `enum _SC_NZERO = _SC_NZERO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NZERO); }))) {
            mixin(enumMixinStr__SC_NZERO);
        }
    }




    static if(!is(typeof(_SC_MB_LEN_MAX))) {
        private enum enumMixinStr__SC_MB_LEN_MAX = `enum _SC_MB_LEN_MAX = _SC_MB_LEN_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MB_LEN_MAX); }))) {
            mixin(enumMixinStr__SC_MB_LEN_MAX);
        }
    }




    static if(!is(typeof(_SC_WORD_BIT))) {
        private enum enumMixinStr__SC_WORD_BIT = `enum _SC_WORD_BIT = _SC_WORD_BIT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_WORD_BIT); }))) {
            mixin(enumMixinStr__SC_WORD_BIT);
        }
    }




    static if(!is(typeof(_SC_LONG_BIT))) {
        private enum enumMixinStr__SC_LONG_BIT = `enum _SC_LONG_BIT = _SC_LONG_BIT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LONG_BIT); }))) {
            mixin(enumMixinStr__SC_LONG_BIT);
        }
    }




    static if(!is(typeof(_SC_INT_MIN))) {
        private enum enumMixinStr__SC_INT_MIN = `enum _SC_INT_MIN = _SC_INT_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_INT_MIN); }))) {
            mixin(enumMixinStr__SC_INT_MIN);
        }
    }




    static if(!is(typeof(_SC_INT_MAX))) {
        private enum enumMixinStr__SC_INT_MAX = `enum _SC_INT_MAX = _SC_INT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_INT_MAX); }))) {
            mixin(enumMixinStr__SC_INT_MAX);
        }
    }




    static if(!is(typeof(_SC_CHAR_MIN))) {
        private enum enumMixinStr__SC_CHAR_MIN = `enum _SC_CHAR_MIN = _SC_CHAR_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CHAR_MIN); }))) {
            mixin(enumMixinStr__SC_CHAR_MIN);
        }
    }




    static if(!is(typeof(_SC_CHAR_MAX))) {
        private enum enumMixinStr__SC_CHAR_MAX = `enum _SC_CHAR_MAX = _SC_CHAR_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CHAR_MAX); }))) {
            mixin(enumMixinStr__SC_CHAR_MAX);
        }
    }




    static if(!is(typeof(_SC_CHAR_BIT))) {
        private enum enumMixinStr__SC_CHAR_BIT = `enum _SC_CHAR_BIT = _SC_CHAR_BIT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CHAR_BIT); }))) {
            mixin(enumMixinStr__SC_CHAR_BIT);
        }
    }




    static if(!is(typeof(_SC_XOPEN_XPG4))) {
        private enum enumMixinStr__SC_XOPEN_XPG4 = `enum _SC_XOPEN_XPG4 = _SC_XOPEN_XPG4;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_XPG4); }))) {
            mixin(enumMixinStr__SC_XOPEN_XPG4);
        }
    }




    static if(!is(typeof(_SC_XOPEN_XPG3))) {
        private enum enumMixinStr__SC_XOPEN_XPG3 = `enum _SC_XOPEN_XPG3 = _SC_XOPEN_XPG3;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_XPG3); }))) {
            mixin(enumMixinStr__SC_XOPEN_XPG3);
        }
    }




    static if(!is(typeof(_SC_XOPEN_XPG2))) {
        private enum enumMixinStr__SC_XOPEN_XPG2 = `enum _SC_XOPEN_XPG2 = _SC_XOPEN_XPG2;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_XPG2); }))) {
            mixin(enumMixinStr__SC_XOPEN_XPG2);
        }
    }




    static if(!is(typeof(_SC_2_UPE))) {
        private enum enumMixinStr__SC_2_UPE = `enum _SC_2_UPE = _SC_2_UPE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_UPE); }))) {
            mixin(enumMixinStr__SC_2_UPE);
        }
    }




    static if(!is(typeof(_SC_2_C_VERSION))) {
        private enum enumMixinStr__SC_2_C_VERSION = `enum _SC_2_C_VERSION = _SC_2_C_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_C_VERSION); }))) {
            mixin(enumMixinStr__SC_2_C_VERSION);
        }
    }




    static if(!is(typeof(_SC_2_CHAR_TERM))) {
        private enum enumMixinStr__SC_2_CHAR_TERM = `enum _SC_2_CHAR_TERM = _SC_2_CHAR_TERM;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_CHAR_TERM); }))) {
            mixin(enumMixinStr__SC_2_CHAR_TERM);
        }
    }




    static if(!is(typeof(_SC_XOPEN_SHM))) {
        private enum enumMixinStr__SC_XOPEN_SHM = `enum _SC_XOPEN_SHM = _SC_XOPEN_SHM;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_SHM); }))) {
            mixin(enumMixinStr__SC_XOPEN_SHM);
        }
    }




    static if(!is(typeof(_SC_XOPEN_ENH_I18N))) {
        private enum enumMixinStr__SC_XOPEN_ENH_I18N = `enum _SC_XOPEN_ENH_I18N = _SC_XOPEN_ENH_I18N;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_ENH_I18N); }))) {
            mixin(enumMixinStr__SC_XOPEN_ENH_I18N);
        }
    }




    static if(!is(typeof(_SC_XOPEN_CRYPT))) {
        private enum enumMixinStr__SC_XOPEN_CRYPT = `enum _SC_XOPEN_CRYPT = _SC_XOPEN_CRYPT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_CRYPT); }))) {
            mixin(enumMixinStr__SC_XOPEN_CRYPT);
        }
    }




    static if(!is(typeof(_SC_XOPEN_UNIX))) {
        private enum enumMixinStr__SC_XOPEN_UNIX = `enum _SC_XOPEN_UNIX = _SC_XOPEN_UNIX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_UNIX); }))) {
            mixin(enumMixinStr__SC_XOPEN_UNIX);
        }
    }




    static if(!is(typeof(_SC_XOPEN_XCU_VERSION))) {
        private enum enumMixinStr__SC_XOPEN_XCU_VERSION = `enum _SC_XOPEN_XCU_VERSION = _SC_XOPEN_XCU_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_XCU_VERSION); }))) {
            mixin(enumMixinStr__SC_XOPEN_XCU_VERSION);
        }
    }




    static if(!is(typeof(_SC_XOPEN_VERSION))) {
        private enum enumMixinStr__SC_XOPEN_VERSION = `enum _SC_XOPEN_VERSION = _SC_XOPEN_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_XOPEN_VERSION); }))) {
            mixin(enumMixinStr__SC_XOPEN_VERSION);
        }
    }




    static if(!is(typeof(_SC_PASS_MAX))) {
        private enum enumMixinStr__SC_PASS_MAX = `enum _SC_PASS_MAX = _SC_PASS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PASS_MAX); }))) {
            mixin(enumMixinStr__SC_PASS_MAX);
        }
    }




    static if(!is(typeof(_SC_ATEXIT_MAX))) {
        private enum enumMixinStr__SC_ATEXIT_MAX = `enum _SC_ATEXIT_MAX = _SC_ATEXIT_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_ATEXIT_MAX); }))) {
            mixin(enumMixinStr__SC_ATEXIT_MAX);
        }
    }




    static if(!is(typeof(_SC_AVPHYS_PAGES))) {
        private enum enumMixinStr__SC_AVPHYS_PAGES = `enum _SC_AVPHYS_PAGES = _SC_AVPHYS_PAGES;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_AVPHYS_PAGES); }))) {
            mixin(enumMixinStr__SC_AVPHYS_PAGES);
        }
    }




    static if(!is(typeof(_SC_PHYS_PAGES))) {
        private enum enumMixinStr__SC_PHYS_PAGES = `enum _SC_PHYS_PAGES = _SC_PHYS_PAGES;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PHYS_PAGES); }))) {
            mixin(enumMixinStr__SC_PHYS_PAGES);
        }
    }




    static if(!is(typeof(_SC_NPROCESSORS_ONLN))) {
        private enum enumMixinStr__SC_NPROCESSORS_ONLN = `enum _SC_NPROCESSORS_ONLN = _SC_NPROCESSORS_ONLN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NPROCESSORS_ONLN); }))) {
            mixin(enumMixinStr__SC_NPROCESSORS_ONLN);
        }
    }




    static if(!is(typeof(_SC_NPROCESSORS_CONF))) {
        private enum enumMixinStr__SC_NPROCESSORS_CONF = `enum _SC_NPROCESSORS_CONF = _SC_NPROCESSORS_CONF;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NPROCESSORS_CONF); }))) {
            mixin(enumMixinStr__SC_NPROCESSORS_CONF);
        }
    }




    static if(!is(typeof(_SC_THREAD_PROCESS_SHARED))) {
        private enum enumMixinStr__SC_THREAD_PROCESS_SHARED = `enum _SC_THREAD_PROCESS_SHARED = _SC_THREAD_PROCESS_SHARED;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_PROCESS_SHARED); }))) {
            mixin(enumMixinStr__SC_THREAD_PROCESS_SHARED);
        }
    }




    static if(!is(typeof(_SC_THREAD_PRIO_PROTECT))) {
        private enum enumMixinStr__SC_THREAD_PRIO_PROTECT = `enum _SC_THREAD_PRIO_PROTECT = _SC_THREAD_PRIO_PROTECT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_PRIO_PROTECT); }))) {
            mixin(enumMixinStr__SC_THREAD_PRIO_PROTECT);
        }
    }




    static if(!is(typeof(_SC_THREAD_PRIO_INHERIT))) {
        private enum enumMixinStr__SC_THREAD_PRIO_INHERIT = `enum _SC_THREAD_PRIO_INHERIT = _SC_THREAD_PRIO_INHERIT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_PRIO_INHERIT); }))) {
            mixin(enumMixinStr__SC_THREAD_PRIO_INHERIT);
        }
    }




    static if(!is(typeof(_SC_THREAD_PRIORITY_SCHEDULING))) {
        private enum enumMixinStr__SC_THREAD_PRIORITY_SCHEDULING = `enum _SC_THREAD_PRIORITY_SCHEDULING = _SC_THREAD_PRIORITY_SCHEDULING;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_PRIORITY_SCHEDULING); }))) {
            mixin(enumMixinStr__SC_THREAD_PRIORITY_SCHEDULING);
        }
    }




    static if(!is(typeof(_SC_THREAD_ATTR_STACKSIZE))) {
        private enum enumMixinStr__SC_THREAD_ATTR_STACKSIZE = `enum _SC_THREAD_ATTR_STACKSIZE = _SC_THREAD_ATTR_STACKSIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_ATTR_STACKSIZE); }))) {
            mixin(enumMixinStr__SC_THREAD_ATTR_STACKSIZE);
        }
    }




    static if(!is(typeof(_SC_THREAD_ATTR_STACKADDR))) {
        private enum enumMixinStr__SC_THREAD_ATTR_STACKADDR = `enum _SC_THREAD_ATTR_STACKADDR = _SC_THREAD_ATTR_STACKADDR;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_ATTR_STACKADDR); }))) {
            mixin(enumMixinStr__SC_THREAD_ATTR_STACKADDR);
        }
    }




    static if(!is(typeof(_SC_THREAD_THREADS_MAX))) {
        private enum enumMixinStr__SC_THREAD_THREADS_MAX = `enum _SC_THREAD_THREADS_MAX = _SC_THREAD_THREADS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_THREADS_MAX); }))) {
            mixin(enumMixinStr__SC_THREAD_THREADS_MAX);
        }
    }




    static if(!is(typeof(_SC_THREAD_STACK_MIN))) {
        private enum enumMixinStr__SC_THREAD_STACK_MIN = `enum _SC_THREAD_STACK_MIN = _SC_THREAD_STACK_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_STACK_MIN); }))) {
            mixin(enumMixinStr__SC_THREAD_STACK_MIN);
        }
    }




    static if(!is(typeof(_SC_THREAD_KEYS_MAX))) {
        private enum enumMixinStr__SC_THREAD_KEYS_MAX = `enum _SC_THREAD_KEYS_MAX = _SC_THREAD_KEYS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_KEYS_MAX); }))) {
            mixin(enumMixinStr__SC_THREAD_KEYS_MAX);
        }
    }




    static if(!is(typeof(_SC_THREAD_DESTRUCTOR_ITERATIONS))) {
        private enum enumMixinStr__SC_THREAD_DESTRUCTOR_ITERATIONS = `enum _SC_THREAD_DESTRUCTOR_ITERATIONS = _SC_THREAD_DESTRUCTOR_ITERATIONS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_DESTRUCTOR_ITERATIONS); }))) {
            mixin(enumMixinStr__SC_THREAD_DESTRUCTOR_ITERATIONS);
        }
    }




    static if(!is(typeof(_SC_TTY_NAME_MAX))) {
        private enum enumMixinStr__SC_TTY_NAME_MAX = `enum _SC_TTY_NAME_MAX = _SC_TTY_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TTY_NAME_MAX); }))) {
            mixin(enumMixinStr__SC_TTY_NAME_MAX);
        }
    }




    static if(!is(typeof(_SC_LOGIN_NAME_MAX))) {
        private enum enumMixinStr__SC_LOGIN_NAME_MAX = `enum _SC_LOGIN_NAME_MAX = _SC_LOGIN_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LOGIN_NAME_MAX); }))) {
            mixin(enumMixinStr__SC_LOGIN_NAME_MAX);
        }
    }




    static if(!is(typeof(_SC_GETPW_R_SIZE_MAX))) {
        private enum enumMixinStr__SC_GETPW_R_SIZE_MAX = `enum _SC_GETPW_R_SIZE_MAX = _SC_GETPW_R_SIZE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_GETPW_R_SIZE_MAX); }))) {
            mixin(enumMixinStr__SC_GETPW_R_SIZE_MAX);
        }
    }




    static if(!is(typeof(_SC_GETGR_R_SIZE_MAX))) {
        private enum enumMixinStr__SC_GETGR_R_SIZE_MAX = `enum _SC_GETGR_R_SIZE_MAX = _SC_GETGR_R_SIZE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_GETGR_R_SIZE_MAX); }))) {
            mixin(enumMixinStr__SC_GETGR_R_SIZE_MAX);
        }
    }




    static if(!is(typeof(_SC_THREAD_SAFE_FUNCTIONS))) {
        private enum enumMixinStr__SC_THREAD_SAFE_FUNCTIONS = `enum _SC_THREAD_SAFE_FUNCTIONS = _SC_THREAD_SAFE_FUNCTIONS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREAD_SAFE_FUNCTIONS); }))) {
            mixin(enumMixinStr__SC_THREAD_SAFE_FUNCTIONS);
        }
    }




    static if(!is(typeof(_SC_THREADS))) {
        private enum enumMixinStr__SC_THREADS = `enum _SC_THREADS = _SC_THREADS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_THREADS); }))) {
            mixin(enumMixinStr__SC_THREADS);
        }
    }




    static if(!is(typeof(_SC_T_IOV_MAX))) {
        private enum enumMixinStr__SC_T_IOV_MAX = `enum _SC_T_IOV_MAX = _SC_T_IOV_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_T_IOV_MAX); }))) {
            mixin(enumMixinStr__SC_T_IOV_MAX);
        }
    }




    static if(!is(typeof(_SC_PII_OSI_M))) {
        private enum enumMixinStr__SC_PII_OSI_M = `enum _SC_PII_OSI_M = _SC_PII_OSI_M;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_OSI_M); }))) {
            mixin(enumMixinStr__SC_PII_OSI_M);
        }
    }




    static if(!is(typeof(_SC_PII_OSI_CLTS))) {
        private enum enumMixinStr__SC_PII_OSI_CLTS = `enum _SC_PII_OSI_CLTS = _SC_PII_OSI_CLTS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_OSI_CLTS); }))) {
            mixin(enumMixinStr__SC_PII_OSI_CLTS);
        }
    }




    static if(!is(typeof(_SC_PII_OSI_COTS))) {
        private enum enumMixinStr__SC_PII_OSI_COTS = `enum _SC_PII_OSI_COTS = _SC_PII_OSI_COTS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_OSI_COTS); }))) {
            mixin(enumMixinStr__SC_PII_OSI_COTS);
        }
    }




    static if(!is(typeof(_SC_PII_INTERNET_DGRAM))) {
        private enum enumMixinStr__SC_PII_INTERNET_DGRAM = `enum _SC_PII_INTERNET_DGRAM = _SC_PII_INTERNET_DGRAM;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_INTERNET_DGRAM); }))) {
            mixin(enumMixinStr__SC_PII_INTERNET_DGRAM);
        }
    }




    static if(!is(typeof(_SC_PII_INTERNET_STREAM))) {
        private enum enumMixinStr__SC_PII_INTERNET_STREAM = `enum _SC_PII_INTERNET_STREAM = _SC_PII_INTERNET_STREAM;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_INTERNET_STREAM); }))) {
            mixin(enumMixinStr__SC_PII_INTERNET_STREAM);
        }
    }




    static if(!is(typeof(_SC_IOV_MAX))) {
        private enum enumMixinStr__SC_IOV_MAX = `enum _SC_IOV_MAX = _SC_IOV_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_IOV_MAX); }))) {
            mixin(enumMixinStr__SC_IOV_MAX);
        }
    }




    static if(!is(typeof(_SC_UIO_MAXIOV))) {
        private enum enumMixinStr__SC_UIO_MAXIOV = `enum _SC_UIO_MAXIOV = _SC_UIO_MAXIOV;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_UIO_MAXIOV); }))) {
            mixin(enumMixinStr__SC_UIO_MAXIOV);
        }
    }




    static if(!is(typeof(_SC_SELECT))) {
        private enum enumMixinStr__SC_SELECT = `enum _SC_SELECT = _SC_SELECT;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SELECT); }))) {
            mixin(enumMixinStr__SC_SELECT);
        }
    }




    static if(!is(typeof(_SC_POLL))) {
        private enum enumMixinStr__SC_POLL = `enum _SC_POLL = _SC_POLL;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_POLL); }))) {
            mixin(enumMixinStr__SC_POLL);
        }
    }




    static if(!is(typeof(_SC_PII_OSI))) {
        private enum enumMixinStr__SC_PII_OSI = `enum _SC_PII_OSI = _SC_PII_OSI;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_OSI); }))) {
            mixin(enumMixinStr__SC_PII_OSI);
        }
    }




    static if(!is(typeof(_SC_PII_INTERNET))) {
        private enum enumMixinStr__SC_PII_INTERNET = `enum _SC_PII_INTERNET = _SC_PII_INTERNET;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_INTERNET); }))) {
            mixin(enumMixinStr__SC_PII_INTERNET);
        }
    }




    static if(!is(typeof(_SC_PII_SOCKET))) {
        private enum enumMixinStr__SC_PII_SOCKET = `enum _SC_PII_SOCKET = _SC_PII_SOCKET;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_SOCKET); }))) {
            mixin(enumMixinStr__SC_PII_SOCKET);
        }
    }




    static if(!is(typeof(_SC_PII_XTI))) {
        private enum enumMixinStr__SC_PII_XTI = `enum _SC_PII_XTI = _SC_PII_XTI;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII_XTI); }))) {
            mixin(enumMixinStr__SC_PII_XTI);
        }
    }




    static if(!is(typeof(_SC_PII))) {
        private enum enumMixinStr__SC_PII = `enum _SC_PII = _SC_PII;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PII); }))) {
            mixin(enumMixinStr__SC_PII);
        }
    }




    static if(!is(typeof(_SC_2_LOCALEDEF))) {
        private enum enumMixinStr__SC_2_LOCALEDEF = `enum _SC_2_LOCALEDEF = _SC_2_LOCALEDEF;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_LOCALEDEF); }))) {
            mixin(enumMixinStr__SC_2_LOCALEDEF);
        }
    }




    static if(!is(typeof(_SC_2_SW_DEV))) {
        private enum enumMixinStr__SC_2_SW_DEV = `enum _SC_2_SW_DEV = _SC_2_SW_DEV;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_SW_DEV); }))) {
            mixin(enumMixinStr__SC_2_SW_DEV);
        }
    }




    static if(!is(typeof(_SC_2_FORT_RUN))) {
        private enum enumMixinStr__SC_2_FORT_RUN = `enum _SC_2_FORT_RUN = _SC_2_FORT_RUN;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_FORT_RUN); }))) {
            mixin(enumMixinStr__SC_2_FORT_RUN);
        }
    }




    static if(!is(typeof(_SC_2_FORT_DEV))) {
        private enum enumMixinStr__SC_2_FORT_DEV = `enum _SC_2_FORT_DEV = _SC_2_FORT_DEV;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_FORT_DEV); }))) {
            mixin(enumMixinStr__SC_2_FORT_DEV);
        }
    }




    static if(!is(typeof(_SC_2_C_DEV))) {
        private enum enumMixinStr__SC_2_C_DEV = `enum _SC_2_C_DEV = _SC_2_C_DEV;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_C_DEV); }))) {
            mixin(enumMixinStr__SC_2_C_DEV);
        }
    }




    static if(!is(typeof(_SC_2_C_BIND))) {
        private enum enumMixinStr__SC_2_C_BIND = `enum _SC_2_C_BIND = _SC_2_C_BIND;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_C_BIND); }))) {
            mixin(enumMixinStr__SC_2_C_BIND);
        }
    }




    static if(!is(typeof(_SC_2_VERSION))) {
        private enum enumMixinStr__SC_2_VERSION = `enum _SC_2_VERSION = _SC_2_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_2_VERSION); }))) {
            mixin(enumMixinStr__SC_2_VERSION);
        }
    }




    static if(!is(typeof(_SC_CHARCLASS_NAME_MAX))) {
        private enum enumMixinStr__SC_CHARCLASS_NAME_MAX = `enum _SC_CHARCLASS_NAME_MAX = _SC_CHARCLASS_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CHARCLASS_NAME_MAX); }))) {
            mixin(enumMixinStr__SC_CHARCLASS_NAME_MAX);
        }
    }




    static if(!is(typeof(_SC_RE_DUP_MAX))) {
        private enum enumMixinStr__SC_RE_DUP_MAX = `enum _SC_RE_DUP_MAX = _SC_RE_DUP_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_RE_DUP_MAX); }))) {
            mixin(enumMixinStr__SC_RE_DUP_MAX);
        }
    }




    static if(!is(typeof(_SC_LINE_MAX))) {
        private enum enumMixinStr__SC_LINE_MAX = `enum _SC_LINE_MAX = _SC_LINE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_LINE_MAX); }))) {
            mixin(enumMixinStr__SC_LINE_MAX);
        }
    }




    static if(!is(typeof(_SC_EXPR_NEST_MAX))) {
        private enum enumMixinStr__SC_EXPR_NEST_MAX = `enum _SC_EXPR_NEST_MAX = _SC_EXPR_NEST_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_EXPR_NEST_MAX); }))) {
            mixin(enumMixinStr__SC_EXPR_NEST_MAX);
        }
    }




    static if(!is(typeof(_SC_EQUIV_CLASS_MAX))) {
        private enum enumMixinStr__SC_EQUIV_CLASS_MAX = `enum _SC_EQUIV_CLASS_MAX = _SC_EQUIV_CLASS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_EQUIV_CLASS_MAX); }))) {
            mixin(enumMixinStr__SC_EQUIV_CLASS_MAX);
        }
    }




    static if(!is(typeof(_SC_COLL_WEIGHTS_MAX))) {
        private enum enumMixinStr__SC_COLL_WEIGHTS_MAX = `enum _SC_COLL_WEIGHTS_MAX = _SC_COLL_WEIGHTS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_COLL_WEIGHTS_MAX); }))) {
            mixin(enumMixinStr__SC_COLL_WEIGHTS_MAX);
        }
    }




    static if(!is(typeof(_SC_BC_STRING_MAX))) {
        private enum enumMixinStr__SC_BC_STRING_MAX = `enum _SC_BC_STRING_MAX = _SC_BC_STRING_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_BC_STRING_MAX); }))) {
            mixin(enumMixinStr__SC_BC_STRING_MAX);
        }
    }




    static if(!is(typeof(_SC_BC_SCALE_MAX))) {
        private enum enumMixinStr__SC_BC_SCALE_MAX = `enum _SC_BC_SCALE_MAX = _SC_BC_SCALE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_BC_SCALE_MAX); }))) {
            mixin(enumMixinStr__SC_BC_SCALE_MAX);
        }
    }




    static if(!is(typeof(_SC_BC_DIM_MAX))) {
        private enum enumMixinStr__SC_BC_DIM_MAX = `enum _SC_BC_DIM_MAX = _SC_BC_DIM_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_BC_DIM_MAX); }))) {
            mixin(enumMixinStr__SC_BC_DIM_MAX);
        }
    }




    static if(!is(typeof(_SC_BC_BASE_MAX))) {
        private enum enumMixinStr__SC_BC_BASE_MAX = `enum _SC_BC_BASE_MAX = _SC_BC_BASE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_BC_BASE_MAX); }))) {
            mixin(enumMixinStr__SC_BC_BASE_MAX);
        }
    }




    static if(!is(typeof(_SC_TIMER_MAX))) {
        private enum enumMixinStr__SC_TIMER_MAX = `enum _SC_TIMER_MAX = _SC_TIMER_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TIMER_MAX); }))) {
            mixin(enumMixinStr__SC_TIMER_MAX);
        }
    }




    static if(!is(typeof(_SC_SIGQUEUE_MAX))) {
        private enum enumMixinStr__SC_SIGQUEUE_MAX = `enum _SC_SIGQUEUE_MAX = _SC_SIGQUEUE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SIGQUEUE_MAX); }))) {
            mixin(enumMixinStr__SC_SIGQUEUE_MAX);
        }
    }




    static if(!is(typeof(_SC_SEM_VALUE_MAX))) {
        private enum enumMixinStr__SC_SEM_VALUE_MAX = `enum _SC_SEM_VALUE_MAX = _SC_SEM_VALUE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SEM_VALUE_MAX); }))) {
            mixin(enumMixinStr__SC_SEM_VALUE_MAX);
        }
    }




    static if(!is(typeof(_SC_SEM_NSEMS_MAX))) {
        private enum enumMixinStr__SC_SEM_NSEMS_MAX = `enum _SC_SEM_NSEMS_MAX = _SC_SEM_NSEMS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SEM_NSEMS_MAX); }))) {
            mixin(enumMixinStr__SC_SEM_NSEMS_MAX);
        }
    }




    static if(!is(typeof(_SC_RTSIG_MAX))) {
        private enum enumMixinStr__SC_RTSIG_MAX = `enum _SC_RTSIG_MAX = _SC_RTSIG_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_RTSIG_MAX); }))) {
            mixin(enumMixinStr__SC_RTSIG_MAX);
        }
    }




    static if(!is(typeof(_SC_PAGE_SIZE))) {
        private enum enumMixinStr__SC_PAGE_SIZE = `enum _SC_PAGE_SIZE = _SC_PAGESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PAGE_SIZE); }))) {
            mixin(enumMixinStr__SC_PAGE_SIZE);
        }
    }




    static if(!is(typeof(_SC_PAGESIZE))) {
        private enum enumMixinStr__SC_PAGESIZE = `enum _SC_PAGESIZE = _SC_PAGESIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PAGESIZE); }))) {
            mixin(enumMixinStr__SC_PAGESIZE);
        }
    }




    static if(!is(typeof(_SC_VERSION))) {
        private enum enumMixinStr__SC_VERSION = `enum _SC_VERSION = _SC_VERSION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_VERSION); }))) {
            mixin(enumMixinStr__SC_VERSION);
        }
    }




    static if(!is(typeof(_SC_MQ_PRIO_MAX))) {
        private enum enumMixinStr__SC_MQ_PRIO_MAX = `enum _SC_MQ_PRIO_MAX = _SC_MQ_PRIO_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MQ_PRIO_MAX); }))) {
            mixin(enumMixinStr__SC_MQ_PRIO_MAX);
        }
    }




    static if(!is(typeof(_SC_MQ_OPEN_MAX))) {
        private enum enumMixinStr__SC_MQ_OPEN_MAX = `enum _SC_MQ_OPEN_MAX = _SC_MQ_OPEN_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MQ_OPEN_MAX); }))) {
            mixin(enumMixinStr__SC_MQ_OPEN_MAX);
        }
    }




    static if(!is(typeof(_SC_DELAYTIMER_MAX))) {
        private enum enumMixinStr__SC_DELAYTIMER_MAX = `enum _SC_DELAYTIMER_MAX = _SC_DELAYTIMER_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_DELAYTIMER_MAX); }))) {
            mixin(enumMixinStr__SC_DELAYTIMER_MAX);
        }
    }




    static if(!is(typeof(_SC_AIO_PRIO_DELTA_MAX))) {
        private enum enumMixinStr__SC_AIO_PRIO_DELTA_MAX = `enum _SC_AIO_PRIO_DELTA_MAX = _SC_AIO_PRIO_DELTA_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_AIO_PRIO_DELTA_MAX); }))) {
            mixin(enumMixinStr__SC_AIO_PRIO_DELTA_MAX);
        }
    }




    static if(!is(typeof(_SC_AIO_MAX))) {
        private enum enumMixinStr__SC_AIO_MAX = `enum _SC_AIO_MAX = _SC_AIO_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_AIO_MAX); }))) {
            mixin(enumMixinStr__SC_AIO_MAX);
        }
    }




    static if(!is(typeof(_SC_AIO_LISTIO_MAX))) {
        private enum enumMixinStr__SC_AIO_LISTIO_MAX = `enum _SC_AIO_LISTIO_MAX = _SC_AIO_LISTIO_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_AIO_LISTIO_MAX); }))) {
            mixin(enumMixinStr__SC_AIO_LISTIO_MAX);
        }
    }




    static if(!is(typeof(_SC_SHARED_MEMORY_OBJECTS))) {
        private enum enumMixinStr__SC_SHARED_MEMORY_OBJECTS = `enum _SC_SHARED_MEMORY_OBJECTS = _SC_SHARED_MEMORY_OBJECTS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SHARED_MEMORY_OBJECTS); }))) {
            mixin(enumMixinStr__SC_SHARED_MEMORY_OBJECTS);
        }
    }




    static if(!is(typeof(_SC_SEMAPHORES))) {
        private enum enumMixinStr__SC_SEMAPHORES = `enum _SC_SEMAPHORES = _SC_SEMAPHORES;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SEMAPHORES); }))) {
            mixin(enumMixinStr__SC_SEMAPHORES);
        }
    }




    static if(!is(typeof(_SC_MESSAGE_PASSING))) {
        private enum enumMixinStr__SC_MESSAGE_PASSING = `enum _SC_MESSAGE_PASSING = _SC_MESSAGE_PASSING;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MESSAGE_PASSING); }))) {
            mixin(enumMixinStr__SC_MESSAGE_PASSING);
        }
    }




    static if(!is(typeof(_SC_MEMORY_PROTECTION))) {
        private enum enumMixinStr__SC_MEMORY_PROTECTION = `enum _SC_MEMORY_PROTECTION = _SC_MEMORY_PROTECTION;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MEMORY_PROTECTION); }))) {
            mixin(enumMixinStr__SC_MEMORY_PROTECTION);
        }
    }




    static if(!is(typeof(_SC_MEMLOCK_RANGE))) {
        private enum enumMixinStr__SC_MEMLOCK_RANGE = `enum _SC_MEMLOCK_RANGE = _SC_MEMLOCK_RANGE;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MEMLOCK_RANGE); }))) {
            mixin(enumMixinStr__SC_MEMLOCK_RANGE);
        }
    }




    static if(!is(typeof(_SC_MEMLOCK))) {
        private enum enumMixinStr__SC_MEMLOCK = `enum _SC_MEMLOCK = _SC_MEMLOCK;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MEMLOCK); }))) {
            mixin(enumMixinStr__SC_MEMLOCK);
        }
    }




    static if(!is(typeof(_SC_MAPPED_FILES))) {
        private enum enumMixinStr__SC_MAPPED_FILES = `enum _SC_MAPPED_FILES = _SC_MAPPED_FILES;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_MAPPED_FILES); }))) {
            mixin(enumMixinStr__SC_MAPPED_FILES);
        }
    }




    static if(!is(typeof(_SC_FSYNC))) {
        private enum enumMixinStr__SC_FSYNC = `enum _SC_FSYNC = _SC_FSYNC;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_FSYNC); }))) {
            mixin(enumMixinStr__SC_FSYNC);
        }
    }




    static if(!is(typeof(_SC_SYNCHRONIZED_IO))) {
        private enum enumMixinStr__SC_SYNCHRONIZED_IO = `enum _SC_SYNCHRONIZED_IO = _SC_SYNCHRONIZED_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SYNCHRONIZED_IO); }))) {
            mixin(enumMixinStr__SC_SYNCHRONIZED_IO);
        }
    }




    static if(!is(typeof(_SC_PRIORITIZED_IO))) {
        private enum enumMixinStr__SC_PRIORITIZED_IO = `enum _SC_PRIORITIZED_IO = _SC_PRIORITIZED_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PRIORITIZED_IO); }))) {
            mixin(enumMixinStr__SC_PRIORITIZED_IO);
        }
    }




    static if(!is(typeof(_SC_ASYNCHRONOUS_IO))) {
        private enum enumMixinStr__SC_ASYNCHRONOUS_IO = `enum _SC_ASYNCHRONOUS_IO = _SC_ASYNCHRONOUS_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_ASYNCHRONOUS_IO); }))) {
            mixin(enumMixinStr__SC_ASYNCHRONOUS_IO);
        }
    }




    static if(!is(typeof(_SC_TIMERS))) {
        private enum enumMixinStr__SC_TIMERS = `enum _SC_TIMERS = _SC_TIMERS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TIMERS); }))) {
            mixin(enumMixinStr__SC_TIMERS);
        }
    }




    static if(!is(typeof(_SC_PRIORITY_SCHEDULING))) {
        private enum enumMixinStr__SC_PRIORITY_SCHEDULING = `enum _SC_PRIORITY_SCHEDULING = _SC_PRIORITY_SCHEDULING;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_PRIORITY_SCHEDULING); }))) {
            mixin(enumMixinStr__SC_PRIORITY_SCHEDULING);
        }
    }




    static if(!is(typeof(_SC_REALTIME_SIGNALS))) {
        private enum enumMixinStr__SC_REALTIME_SIGNALS = `enum _SC_REALTIME_SIGNALS = _SC_REALTIME_SIGNALS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_REALTIME_SIGNALS); }))) {
            mixin(enumMixinStr__SC_REALTIME_SIGNALS);
        }
    }




    static if(!is(typeof(_SC_SAVED_IDS))) {
        private enum enumMixinStr__SC_SAVED_IDS = `enum _SC_SAVED_IDS = _SC_SAVED_IDS;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_SAVED_IDS); }))) {
            mixin(enumMixinStr__SC_SAVED_IDS);
        }
    }




    static if(!is(typeof(_SC_JOB_CONTROL))) {
        private enum enumMixinStr__SC_JOB_CONTROL = `enum _SC_JOB_CONTROL = _SC_JOB_CONTROL;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_JOB_CONTROL); }))) {
            mixin(enumMixinStr__SC_JOB_CONTROL);
        }
    }




    static if(!is(typeof(_SC_TZNAME_MAX))) {
        private enum enumMixinStr__SC_TZNAME_MAX = `enum _SC_TZNAME_MAX = _SC_TZNAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_TZNAME_MAX); }))) {
            mixin(enumMixinStr__SC_TZNAME_MAX);
        }
    }




    static if(!is(typeof(_SC_STREAM_MAX))) {
        private enum enumMixinStr__SC_STREAM_MAX = `enum _SC_STREAM_MAX = _SC_STREAM_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_STREAM_MAX); }))) {
            mixin(enumMixinStr__SC_STREAM_MAX);
        }
    }




    static if(!is(typeof(_SC_OPEN_MAX))) {
        private enum enumMixinStr__SC_OPEN_MAX = `enum _SC_OPEN_MAX = _SC_OPEN_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_OPEN_MAX); }))) {
            mixin(enumMixinStr__SC_OPEN_MAX);
        }
    }




    static if(!is(typeof(_SC_NGROUPS_MAX))) {
        private enum enumMixinStr__SC_NGROUPS_MAX = `enum _SC_NGROUPS_MAX = _SC_NGROUPS_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_NGROUPS_MAX); }))) {
            mixin(enumMixinStr__SC_NGROUPS_MAX);
        }
    }




    static if(!is(typeof(_SC_CLK_TCK))) {
        private enum enumMixinStr__SC_CLK_TCK = `enum _SC_CLK_TCK = _SC_CLK_TCK;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CLK_TCK); }))) {
            mixin(enumMixinStr__SC_CLK_TCK);
        }
    }




    static if(!is(typeof(_SC_CHILD_MAX))) {
        private enum enumMixinStr__SC_CHILD_MAX = `enum _SC_CHILD_MAX = _SC_CHILD_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_CHILD_MAX); }))) {
            mixin(enumMixinStr__SC_CHILD_MAX);
        }
    }




    static if(!is(typeof(_SC_ARG_MAX))) {
        private enum enumMixinStr__SC_ARG_MAX = `enum _SC_ARG_MAX = _SC_ARG_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__SC_ARG_MAX); }))) {
            mixin(enumMixinStr__SC_ARG_MAX);
        }
    }




    static if(!is(typeof(_PC_2_SYMLINKS))) {
        private enum enumMixinStr__PC_2_SYMLINKS = `enum _PC_2_SYMLINKS = _PC_2_SYMLINKS;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_2_SYMLINKS); }))) {
            mixin(enumMixinStr__PC_2_SYMLINKS);
        }
    }




    static if(!is(typeof(_PC_SYMLINK_MAX))) {
        private enum enumMixinStr__PC_SYMLINK_MAX = `enum _PC_SYMLINK_MAX = _PC_SYMLINK_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_SYMLINK_MAX); }))) {
            mixin(enumMixinStr__PC_SYMLINK_MAX);
        }
    }




    static if(!is(typeof(_PC_ALLOC_SIZE_MIN))) {
        private enum enumMixinStr__PC_ALLOC_SIZE_MIN = `enum _PC_ALLOC_SIZE_MIN = _PC_ALLOC_SIZE_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_ALLOC_SIZE_MIN); }))) {
            mixin(enumMixinStr__PC_ALLOC_SIZE_MIN);
        }
    }




    static if(!is(typeof(_PC_REC_XFER_ALIGN))) {
        private enum enumMixinStr__PC_REC_XFER_ALIGN = `enum _PC_REC_XFER_ALIGN = _PC_REC_XFER_ALIGN;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_REC_XFER_ALIGN); }))) {
            mixin(enumMixinStr__PC_REC_XFER_ALIGN);
        }
    }




    static if(!is(typeof(_PC_REC_MIN_XFER_SIZE))) {
        private enum enumMixinStr__PC_REC_MIN_XFER_SIZE = `enum _PC_REC_MIN_XFER_SIZE = _PC_REC_MIN_XFER_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_REC_MIN_XFER_SIZE); }))) {
            mixin(enumMixinStr__PC_REC_MIN_XFER_SIZE);
        }
    }




    static if(!is(typeof(_PC_REC_MAX_XFER_SIZE))) {
        private enum enumMixinStr__PC_REC_MAX_XFER_SIZE = `enum _PC_REC_MAX_XFER_SIZE = _PC_REC_MAX_XFER_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_REC_MAX_XFER_SIZE); }))) {
            mixin(enumMixinStr__PC_REC_MAX_XFER_SIZE);
        }
    }




    static if(!is(typeof(_PC_REC_INCR_XFER_SIZE))) {
        private enum enumMixinStr__PC_REC_INCR_XFER_SIZE = `enum _PC_REC_INCR_XFER_SIZE = _PC_REC_INCR_XFER_SIZE;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_REC_INCR_XFER_SIZE); }))) {
            mixin(enumMixinStr__PC_REC_INCR_XFER_SIZE);
        }
    }




    static if(!is(typeof(_PC_FILESIZEBITS))) {
        private enum enumMixinStr__PC_FILESIZEBITS = `enum _PC_FILESIZEBITS = _PC_FILESIZEBITS;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_FILESIZEBITS); }))) {
            mixin(enumMixinStr__PC_FILESIZEBITS);
        }
    }




    static if(!is(typeof(_PC_SOCK_MAXBUF))) {
        private enum enumMixinStr__PC_SOCK_MAXBUF = `enum _PC_SOCK_MAXBUF = _PC_SOCK_MAXBUF;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_SOCK_MAXBUF); }))) {
            mixin(enumMixinStr__PC_SOCK_MAXBUF);
        }
    }




    static if(!is(typeof(_PC_PRIO_IO))) {
        private enum enumMixinStr__PC_PRIO_IO = `enum _PC_PRIO_IO = _PC_PRIO_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_PRIO_IO); }))) {
            mixin(enumMixinStr__PC_PRIO_IO);
        }
    }




    static if(!is(typeof(_PC_ASYNC_IO))) {
        private enum enumMixinStr__PC_ASYNC_IO = `enum _PC_ASYNC_IO = _PC_ASYNC_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_ASYNC_IO); }))) {
            mixin(enumMixinStr__PC_ASYNC_IO);
        }
    }




    static if(!is(typeof(_PC_SYNC_IO))) {
        private enum enumMixinStr__PC_SYNC_IO = `enum _PC_SYNC_IO = _PC_SYNC_IO;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_SYNC_IO); }))) {
            mixin(enumMixinStr__PC_SYNC_IO);
        }
    }




    static if(!is(typeof(_PC_VDISABLE))) {
        private enum enumMixinStr__PC_VDISABLE = `enum _PC_VDISABLE = _PC_VDISABLE;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_VDISABLE); }))) {
            mixin(enumMixinStr__PC_VDISABLE);
        }
    }




    static if(!is(typeof(_PC_NO_TRUNC))) {
        private enum enumMixinStr__PC_NO_TRUNC = `enum _PC_NO_TRUNC = _PC_NO_TRUNC;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_NO_TRUNC); }))) {
            mixin(enumMixinStr__PC_NO_TRUNC);
        }
    }




    static if(!is(typeof(_PC_CHOWN_RESTRICTED))) {
        private enum enumMixinStr__PC_CHOWN_RESTRICTED = `enum _PC_CHOWN_RESTRICTED = _PC_CHOWN_RESTRICTED;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_CHOWN_RESTRICTED); }))) {
            mixin(enumMixinStr__PC_CHOWN_RESTRICTED);
        }
    }




    static if(!is(typeof(_PC_PIPE_BUF))) {
        private enum enumMixinStr__PC_PIPE_BUF = `enum _PC_PIPE_BUF = _PC_PIPE_BUF;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_PIPE_BUF); }))) {
            mixin(enumMixinStr__PC_PIPE_BUF);
        }
    }




    static if(!is(typeof(_PC_PATH_MAX))) {
        private enum enumMixinStr__PC_PATH_MAX = `enum _PC_PATH_MAX = _PC_PATH_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_PATH_MAX); }))) {
            mixin(enumMixinStr__PC_PATH_MAX);
        }
    }




    static if(!is(typeof(_SYS_CDEFS_H))) {
        private enum enumMixinStr__SYS_CDEFS_H = `enum _SYS_CDEFS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_CDEFS_H); }))) {
            mixin(enumMixinStr__SYS_CDEFS_H);
        }
    }




    static if(!is(typeof(_PC_NAME_MAX))) {
        private enum enumMixinStr__PC_NAME_MAX = `enum _PC_NAME_MAX = _PC_NAME_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_NAME_MAX); }))) {
            mixin(enumMixinStr__PC_NAME_MAX);
        }
    }




    static if(!is(typeof(_PC_MAX_INPUT))) {
        private enum enumMixinStr__PC_MAX_INPUT = `enum _PC_MAX_INPUT = _PC_MAX_INPUT;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_MAX_INPUT); }))) {
            mixin(enumMixinStr__PC_MAX_INPUT);
        }
    }




    static if(!is(typeof(_PC_MAX_CANON))) {
        private enum enumMixinStr__PC_MAX_CANON = `enum _PC_MAX_CANON = _PC_MAX_CANON;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_MAX_CANON); }))) {
            mixin(enumMixinStr__PC_MAX_CANON);
        }
    }




    static if(!is(typeof(_PC_LINK_MAX))) {
        private enum enumMixinStr__PC_LINK_MAX = `enum _PC_LINK_MAX = _PC_LINK_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr__PC_LINK_MAX); }))) {
            mixin(enumMixinStr__PC_LINK_MAX);
        }
    }
    static if(!is(typeof(__THROW))) {
        private enum enumMixinStr___THROW = `enum __THROW = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROW); }))) {
            mixin(enumMixinStr___THROW);
        }
    }




    static if(!is(typeof(__THROWNL))) {
        private enum enumMixinStr___THROWNL = `enum __THROWNL = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROWNL); }))) {
            mixin(enumMixinStr___THROWNL);
        }
    }
    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        private enum enumMixinStr__BITS_BYTESWAP_H = `enum _BITS_BYTESWAP_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_BYTESWAP_H); }))) {
            mixin(enumMixinStr__BITS_BYTESWAP_H);
        }
    }
    static if(!is(typeof(__ptr_t))) {
        private enum enumMixinStr___ptr_t = `enum __ptr_t = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___ptr_t); }))) {
            mixin(enumMixinStr___ptr_t);
        }
    }
    static if(!is(typeof(__kernel_old_dev_t))) {
        private enum enumMixinStr___kernel_old_dev_t = `enum __kernel_old_dev_t = __kernel_old_dev_t;`;
        static if(is(typeof({ mixin(enumMixinStr___kernel_old_dev_t); }))) {
            mixin(enumMixinStr___kernel_old_dev_t);
        }
    }




    static if(!is(typeof(__kernel_old_uid_t))) {
        private enum enumMixinStr___kernel_old_uid_t = `enum __kernel_old_uid_t = __kernel_old_uid_t;`;
        static if(is(typeof({ mixin(enumMixinStr___kernel_old_uid_t); }))) {
            mixin(enumMixinStr___kernel_old_uid_t);
        }
    }




    static if(!is(typeof(__flexarr))) {
        private enum enumMixinStr___flexarr = `enum __flexarr = [ ];`;
        static if(is(typeof({ mixin(enumMixinStr___flexarr); }))) {
            mixin(enumMixinStr___flexarr);
        }
    }




    static if(!is(typeof(__glibc_c99_flexarr_available))) {
        private enum enumMixinStr___glibc_c99_flexarr_available = `enum __glibc_c99_flexarr_available = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_c99_flexarr_available); }))) {
            mixin(enumMixinStr___glibc_c99_flexarr_available);
        }
    }






    static if(!is(typeof(__BITS_PER_LONG))) {
        private enum enumMixinStr___BITS_PER_LONG = `enum __BITS_PER_LONG = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___BITS_PER_LONG); }))) {
            mixin(enumMixinStr___BITS_PER_LONG);
        }
    }
    static if(!is(typeof(SIOCGSTAMPNS_OLD))) {
        private enum enumMixinStr_SIOCGSTAMPNS_OLD = `enum SIOCGSTAMPNS_OLD = 0x8907;`;
        static if(is(typeof({ mixin(enumMixinStr_SIOCGSTAMPNS_OLD); }))) {
            mixin(enumMixinStr_SIOCGSTAMPNS_OLD);
        }
    }




    static if(!is(typeof(__attribute_malloc__))) {
        private enum enumMixinStr___attribute_malloc__ = `enum __attribute_malloc__ = __attribute__ ( ( __malloc__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_malloc__); }))) {
            mixin(enumMixinStr___attribute_malloc__);
        }
    }




    static if(!is(typeof(SIOCGSTAMP_OLD))) {
        private enum enumMixinStr_SIOCGSTAMP_OLD = `enum SIOCGSTAMP_OLD = 0x8906;`;
        static if(is(typeof({ mixin(enumMixinStr_SIOCGSTAMP_OLD); }))) {
            mixin(enumMixinStr_SIOCGSTAMP_OLD);
        }
    }






    static if(!is(typeof(SIOCATMARK))) {
        private enum enumMixinStr_SIOCATMARK = `enum SIOCATMARK = 0x8905;`;
        static if(is(typeof({ mixin(enumMixinStr_SIOCATMARK); }))) {
            mixin(enumMixinStr_SIOCATMARK);
        }
    }




    static if(!is(typeof(__attribute_pure__))) {
        private enum enumMixinStr___attribute_pure__ = `enum __attribute_pure__ = __attribute__ ( ( __pure__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_pure__); }))) {
            mixin(enumMixinStr___attribute_pure__);
        }
    }




    static if(!is(typeof(SIOCGPGRP))) {
        private enum enumMixinStr_SIOCGPGRP = `enum SIOCGPGRP = 0x8904;`;
        static if(is(typeof({ mixin(enumMixinStr_SIOCGPGRP); }))) {
            mixin(enumMixinStr_SIOCGPGRP);
        }
    }




    static if(!is(typeof(__attribute_const__))) {
        private enum enumMixinStr___attribute_const__ = `enum __attribute_const__ = __attribute__ ( cast( __const__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_const__); }))) {
            mixin(enumMixinStr___attribute_const__);
        }
    }




    static if(!is(typeof(FIOGETOWN))) {
        private enum enumMixinStr_FIOGETOWN = `enum FIOGETOWN = 0x8903;`;
        static if(is(typeof({ mixin(enumMixinStr_FIOGETOWN); }))) {
            mixin(enumMixinStr_FIOGETOWN);
        }
    }




    static if(!is(typeof(__attribute_used__))) {
        private enum enumMixinStr___attribute_used__ = `enum __attribute_used__ = __attribute__ ( ( __used__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_used__); }))) {
            mixin(enumMixinStr___attribute_used__);
        }
    }




    static if(!is(typeof(__attribute_noinline__))) {
        private enum enumMixinStr___attribute_noinline__ = `enum __attribute_noinline__ = __attribute__ ( ( __noinline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_noinline__); }))) {
            mixin(enumMixinStr___attribute_noinline__);
        }
    }




    static if(!is(typeof(SIOCSPGRP))) {
        private enum enumMixinStr_SIOCSPGRP = `enum SIOCSPGRP = 0x8902;`;
        static if(is(typeof({ mixin(enumMixinStr_SIOCSPGRP); }))) {
            mixin(enumMixinStr_SIOCSPGRP);
        }
    }




    static if(!is(typeof(__attribute_deprecated__))) {
        private enum enumMixinStr___attribute_deprecated__ = `enum __attribute_deprecated__ = __attribute__ ( ( __deprecated__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_deprecated__); }))) {
            mixin(enumMixinStr___attribute_deprecated__);
        }
    }




    static if(!is(typeof(FIOSETOWN))) {
        private enum enumMixinStr_FIOSETOWN = `enum FIOSETOWN = 0x8901;`;
        static if(is(typeof({ mixin(enumMixinStr_FIOSETOWN); }))) {
            mixin(enumMixinStr_FIOSETOWN);
        }
    }
    static if(!is(typeof(SCM_TIMESTAMPING))) {
        private enum enumMixinStr_SCM_TIMESTAMPING = `enum SCM_TIMESTAMPING = SO_TIMESTAMPING;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_TIMESTAMPING); }))) {
            mixin(enumMixinStr_SCM_TIMESTAMPING);
        }
    }






    static if(!is(typeof(SCM_TIMESTAMPNS))) {
        private enum enumMixinStr_SCM_TIMESTAMPNS = `enum SCM_TIMESTAMPNS = SO_TIMESTAMPNS;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_TIMESTAMPNS); }))) {
            mixin(enumMixinStr_SCM_TIMESTAMPNS);
        }
    }






    static if(!is(typeof(SCM_TIMESTAMP))) {
        private enum enumMixinStr_SCM_TIMESTAMP = `enum SCM_TIMESTAMP = SO_TIMESTAMP;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_TIMESTAMP); }))) {
            mixin(enumMixinStr_SCM_TIMESTAMP);
        }
    }






    static if(!is(typeof(SO_SNDTIMEO))) {
        private enum enumMixinStr_SO_SNDTIMEO = `enum SO_SNDTIMEO = SO_SNDTIMEO_OLD;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SNDTIMEO); }))) {
            mixin(enumMixinStr_SO_SNDTIMEO);
        }
    }




    static if(!is(typeof(__attribute_warn_unused_result__))) {
        private enum enumMixinStr___attribute_warn_unused_result__ = `enum __attribute_warn_unused_result__ = __attribute__ ( ( __warn_unused_result__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_warn_unused_result__); }))) {
            mixin(enumMixinStr___attribute_warn_unused_result__);
        }
    }




    static if(!is(typeof(SO_RCVTIMEO))) {
        private enum enumMixinStr_SO_RCVTIMEO = `enum SO_RCVTIMEO = SO_RCVTIMEO_OLD;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RCVTIMEO); }))) {
            mixin(enumMixinStr_SO_RCVTIMEO);
        }
    }






    static if(!is(typeof(SO_TIMESTAMPING))) {
        private enum enumMixinStr_SO_TIMESTAMPING = `enum SO_TIMESTAMPING = SO_TIMESTAMPING_OLD;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMPING); }))) {
            mixin(enumMixinStr_SO_TIMESTAMPING);
        }
    }




    static if(!is(typeof(SO_TIMESTAMPNS))) {
        private enum enumMixinStr_SO_TIMESTAMPNS = `enum SO_TIMESTAMPNS = SO_TIMESTAMPNS_OLD;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMPNS); }))) {
            mixin(enumMixinStr_SO_TIMESTAMPNS);
        }
    }






    static if(!is(typeof(SO_TIMESTAMP))) {
        private enum enumMixinStr_SO_TIMESTAMP = `enum SO_TIMESTAMP = SO_TIMESTAMP_OLD;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMP); }))) {
            mixin(enumMixinStr_SO_TIMESTAMP);
        }
    }




    static if(!is(typeof(SO_DETACH_REUSEPORT_BPF))) {
        private enum enumMixinStr_SO_DETACH_REUSEPORT_BPF = `enum SO_DETACH_REUSEPORT_BPF = 68;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_DETACH_REUSEPORT_BPF); }))) {
            mixin(enumMixinStr_SO_DETACH_REUSEPORT_BPF);
        }
    }




    static if(!is(typeof(SO_SNDTIMEO_NEW))) {
        private enum enumMixinStr_SO_SNDTIMEO_NEW = `enum SO_SNDTIMEO_NEW = 67;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SNDTIMEO_NEW); }))) {
            mixin(enumMixinStr_SO_SNDTIMEO_NEW);
        }
    }




    static if(!is(typeof(SO_RCVTIMEO_NEW))) {
        private enum enumMixinStr_SO_RCVTIMEO_NEW = `enum SO_RCVTIMEO_NEW = 66;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RCVTIMEO_NEW); }))) {
            mixin(enumMixinStr_SO_RCVTIMEO_NEW);
        }
    }




    static if(!is(typeof(__extern_inline))) {
        private enum enumMixinStr___extern_inline = `enum __extern_inline = extern __inline __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_inline); }))) {
            mixin(enumMixinStr___extern_inline);
        }
    }




    static if(!is(typeof(__extern_always_inline))) {
        private enum enumMixinStr___extern_always_inline = `enum __extern_always_inline = extern __inline__ __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_always_inline); }))) {
            mixin(enumMixinStr___extern_always_inline);
        }
    }




    static if(!is(typeof(SO_TIMESTAMPING_NEW))) {
        private enum enumMixinStr_SO_TIMESTAMPING_NEW = `enum SO_TIMESTAMPING_NEW = 65;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMPING_NEW); }))) {
            mixin(enumMixinStr_SO_TIMESTAMPING_NEW);
        }
    }




    static if(!is(typeof(__fortify_function))) {
        private enum enumMixinStr___fortify_function = `enum __fortify_function = extern __inline__ __attribute__ ( ( __gnu_inline__ ) ) ;`;
        static if(is(typeof({ mixin(enumMixinStr___fortify_function); }))) {
            mixin(enumMixinStr___fortify_function);
        }
    }




    static if(!is(typeof(SO_TIMESTAMPNS_NEW))) {
        private enum enumMixinStr_SO_TIMESTAMPNS_NEW = `enum SO_TIMESTAMPNS_NEW = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMPNS_NEW); }))) {
            mixin(enumMixinStr_SO_TIMESTAMPNS_NEW);
        }
    }




    static if(!is(typeof(SO_TIMESTAMP_NEW))) {
        private enum enumMixinStr_SO_TIMESTAMP_NEW = `enum SO_TIMESTAMP_NEW = 63;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMP_NEW); }))) {
            mixin(enumMixinStr_SO_TIMESTAMP_NEW);
        }
    }




    static if(!is(typeof(SO_TIMESTAMPING_OLD))) {
        private enum enumMixinStr_SO_TIMESTAMPING_OLD = `enum SO_TIMESTAMPING_OLD = 37;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMPING_OLD); }))) {
            mixin(enumMixinStr_SO_TIMESTAMPING_OLD);
        }
    }




    static if(!is(typeof(SO_TIMESTAMPNS_OLD))) {
        private enum enumMixinStr_SO_TIMESTAMPNS_OLD = `enum SO_TIMESTAMPNS_OLD = 35;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMPNS_OLD); }))) {
            mixin(enumMixinStr_SO_TIMESTAMPNS_OLD);
        }
    }




    static if(!is(typeof(__restrict_arr))) {
        private enum enumMixinStr___restrict_arr = `enum __restrict_arr = __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr___restrict_arr); }))) {
            mixin(enumMixinStr___restrict_arr);
        }
    }




    static if(!is(typeof(SO_TIMESTAMP_OLD))) {
        private enum enumMixinStr_SO_TIMESTAMP_OLD = `enum SO_TIMESTAMP_OLD = 29;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TIMESTAMP_OLD); }))) {
            mixin(enumMixinStr_SO_TIMESTAMP_OLD);
        }
    }
    static if(!is(typeof(SO_BINDTOIFINDEX))) {
        private enum enumMixinStr_SO_BINDTOIFINDEX = `enum SO_BINDTOIFINDEX = 62;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_BINDTOIFINDEX); }))) {
            mixin(enumMixinStr_SO_BINDTOIFINDEX);
        }
    }






    static if(!is(typeof(SCM_TXTIME))) {
        private enum enumMixinStr_SCM_TXTIME = `enum SCM_TXTIME = SO_TXTIME;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_TXTIME); }))) {
            mixin(enumMixinStr_SCM_TXTIME);
        }
    }




    static if(!is(typeof(__glibc_has_include))) {
        private enum enumMixinStr___glibc_has_include = `enum __glibc_has_include = __has_include;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_has_include); }))) {
            mixin(enumMixinStr___glibc_has_include);
        }
    }




    static if(!is(typeof(SO_TXTIME))) {
        private enum enumMixinStr_SO_TXTIME = `enum SO_TXTIME = 61;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TXTIME); }))) {
            mixin(enumMixinStr_SO_TXTIME);
        }
    }




    static if(!is(typeof(SO_ZEROCOPY))) {
        private enum enumMixinStr_SO_ZEROCOPY = `enum SO_ZEROCOPY = 60;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ZEROCOPY); }))) {
            mixin(enumMixinStr_SO_ZEROCOPY);
        }
    }




    static if(!is(typeof(SO_PEERGROUPS))) {
        private enum enumMixinStr_SO_PEERGROUPS = `enum SO_PEERGROUPS = 59;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PEERGROUPS); }))) {
            mixin(enumMixinStr_SO_PEERGROUPS);
        }
    }




    static if(!is(typeof(SCM_TIMESTAMPING_PKTINFO))) {
        private enum enumMixinStr_SCM_TIMESTAMPING_PKTINFO = `enum SCM_TIMESTAMPING_PKTINFO = 58;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_TIMESTAMPING_PKTINFO); }))) {
            mixin(enumMixinStr_SCM_TIMESTAMPING_PKTINFO);
        }
    }






    static if(!is(typeof(SO_COOKIE))) {
        private enum enumMixinStr_SO_COOKIE = `enum SO_COOKIE = 57;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_COOKIE); }))) {
            mixin(enumMixinStr_SO_COOKIE);
        }
    }






    static if(!is(typeof(SO_INCOMING_NAPI_ID))) {
        private enum enumMixinStr_SO_INCOMING_NAPI_ID = `enum SO_INCOMING_NAPI_ID = 56;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_INCOMING_NAPI_ID); }))) {
            mixin(enumMixinStr_SO_INCOMING_NAPI_ID);
        }
    }




    static if(!is(typeof(SO_MEMINFO))) {
        private enum enumMixinStr_SO_MEMINFO = `enum SO_MEMINFO = 55;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_MEMINFO); }))) {
            mixin(enumMixinStr_SO_MEMINFO);
        }
    }




    static if(!is(typeof(SCM_TIMESTAMPING_OPT_STATS))) {
        private enum enumMixinStr_SCM_TIMESTAMPING_OPT_STATS = `enum SCM_TIMESTAMPING_OPT_STATS = 54;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_TIMESTAMPING_OPT_STATS); }))) {
            mixin(enumMixinStr_SCM_TIMESTAMPING_OPT_STATS);
        }
    }




    static if(!is(typeof(SO_CNX_ADVICE))) {
        private enum enumMixinStr_SO_CNX_ADVICE = `enum SO_CNX_ADVICE = 53;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_CNX_ADVICE); }))) {
            mixin(enumMixinStr_SO_CNX_ADVICE);
        }
    }




    static if(!is(typeof(SO_ATTACH_REUSEPORT_EBPF))) {
        private enum enumMixinStr_SO_ATTACH_REUSEPORT_EBPF = `enum SO_ATTACH_REUSEPORT_EBPF = 52;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ATTACH_REUSEPORT_EBPF); }))) {
            mixin(enumMixinStr_SO_ATTACH_REUSEPORT_EBPF);
        }
    }




    static if(!is(typeof(SO_ATTACH_REUSEPORT_CBPF))) {
        private enum enumMixinStr_SO_ATTACH_REUSEPORT_CBPF = `enum SO_ATTACH_REUSEPORT_CBPF = 51;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ATTACH_REUSEPORT_CBPF); }))) {
            mixin(enumMixinStr_SO_ATTACH_REUSEPORT_CBPF);
        }
    }
    static if(!is(typeof(SO_DETACH_BPF))) {
        private enum enumMixinStr_SO_DETACH_BPF = `enum SO_DETACH_BPF = SO_DETACH_FILTER;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_DETACH_BPF); }))) {
            mixin(enumMixinStr_SO_DETACH_BPF);
        }
    }
    static if(!is(typeof(SO_ATTACH_BPF))) {
        private enum enumMixinStr_SO_ATTACH_BPF = `enum SO_ATTACH_BPF = 50;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ATTACH_BPF); }))) {
            mixin(enumMixinStr_SO_ATTACH_BPF);
        }
    }




    static if(!is(typeof(SO_INCOMING_CPU))) {
        private enum enumMixinStr_SO_INCOMING_CPU = `enum SO_INCOMING_CPU = 49;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_INCOMING_CPU); }))) {
            mixin(enumMixinStr_SO_INCOMING_CPU);
        }
    }
    static if(!is(typeof(SO_BPF_EXTENSIONS))) {
        private enum enumMixinStr_SO_BPF_EXTENSIONS = `enum SO_BPF_EXTENSIONS = 48;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_BPF_EXTENSIONS); }))) {
            mixin(enumMixinStr_SO_BPF_EXTENSIONS);
        }
    }




    static if(!is(typeof(SO_MAX_PACING_RATE))) {
        private enum enumMixinStr_SO_MAX_PACING_RATE = `enum SO_MAX_PACING_RATE = 47;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_MAX_PACING_RATE); }))) {
            mixin(enumMixinStr_SO_MAX_PACING_RATE);
        }
    }




    static if(!is(typeof(SO_BUSY_POLL))) {
        private enum enumMixinStr_SO_BUSY_POLL = `enum SO_BUSY_POLL = 46;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_BUSY_POLL); }))) {
            mixin(enumMixinStr_SO_BUSY_POLL);
        }
    }




    static if(!is(typeof(SO_SELECT_ERR_QUEUE))) {
        private enum enumMixinStr_SO_SELECT_ERR_QUEUE = `enum SO_SELECT_ERR_QUEUE = 45;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SELECT_ERR_QUEUE); }))) {
            mixin(enumMixinStr_SO_SELECT_ERR_QUEUE);
        }
    }




    static if(!is(typeof(SO_LOCK_FILTER))) {
        private enum enumMixinStr_SO_LOCK_FILTER = `enum SO_LOCK_FILTER = 44;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_LOCK_FILTER); }))) {
            mixin(enumMixinStr_SO_LOCK_FILTER);
        }
    }




    static if(!is(typeof(__HAVE_GENERIC_SELECTION))) {
        private enum enumMixinStr___HAVE_GENERIC_SELECTION = `enum __HAVE_GENERIC_SELECTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_GENERIC_SELECTION); }))) {
            mixin(enumMixinStr___HAVE_GENERIC_SELECTION);
        }
    }




    static if(!is(typeof(_SYS_SELECT_H))) {
        private enum enumMixinStr__SYS_SELECT_H = `enum _SYS_SELECT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_SELECT_H); }))) {
            mixin(enumMixinStr__SYS_SELECT_H);
        }
    }




    static if(!is(typeof(SO_NOFCS))) {
        private enum enumMixinStr_SO_NOFCS = `enum SO_NOFCS = 43;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_NOFCS); }))) {
            mixin(enumMixinStr_SO_NOFCS);
        }
    }




    static if(!is(typeof(SO_PEEK_OFF))) {
        private enum enumMixinStr_SO_PEEK_OFF = `enum SO_PEEK_OFF = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PEEK_OFF); }))) {
            mixin(enumMixinStr_SO_PEEK_OFF);
        }
    }




    static if(!is(typeof(SCM_WIFI_STATUS))) {
        private enum enumMixinStr_SCM_WIFI_STATUS = `enum SCM_WIFI_STATUS = SO_WIFI_STATUS;`;
        static if(is(typeof({ mixin(enumMixinStr_SCM_WIFI_STATUS); }))) {
            mixin(enumMixinStr_SCM_WIFI_STATUS);
        }
    }




    static if(!is(typeof(SO_WIFI_STATUS))) {
        private enum enumMixinStr_SO_WIFI_STATUS = `enum SO_WIFI_STATUS = 41;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_WIFI_STATUS); }))) {
            mixin(enumMixinStr_SO_WIFI_STATUS);
        }
    }




    static if(!is(typeof(SO_RXQ_OVFL))) {
        private enum enumMixinStr_SO_RXQ_OVFL = `enum SO_RXQ_OVFL = 40;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RXQ_OVFL); }))) {
            mixin(enumMixinStr_SO_RXQ_OVFL);
        }
    }




    static if(!is(typeof(SO_DOMAIN))) {
        private enum enumMixinStr_SO_DOMAIN = `enum SO_DOMAIN = 39;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_DOMAIN); }))) {
            mixin(enumMixinStr_SO_DOMAIN);
        }
    }




    static if(!is(typeof(SO_PROTOCOL))) {
        private enum enumMixinStr_SO_PROTOCOL = `enum SO_PROTOCOL = 38;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PROTOCOL); }))) {
            mixin(enumMixinStr_SO_PROTOCOL);
        }
    }




    static if(!is(typeof(SO_MARK))) {
        private enum enumMixinStr_SO_MARK = `enum SO_MARK = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_MARK); }))) {
            mixin(enumMixinStr_SO_MARK);
        }
    }




    static if(!is(typeof(SO_PASSSEC))) {
        private enum enumMixinStr_SO_PASSSEC = `enum SO_PASSSEC = 34;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PASSSEC); }))) {
            mixin(enumMixinStr_SO_PASSSEC);
        }
    }






    static if(!is(typeof(SO_PEERSEC))) {
        private enum enumMixinStr_SO_PEERSEC = `enum SO_PEERSEC = 31;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PEERSEC); }))) {
            mixin(enumMixinStr_SO_PEERSEC);
        }
    }




    static if(!is(typeof(__NFDBITS))) {
        private enum enumMixinStr___NFDBITS = `enum __NFDBITS = ( 8 * cast( int ) ( __fd_mask ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr___NFDBITS); }))) {
            mixin(enumMixinStr___NFDBITS);
        }
    }
    static if(!is(typeof(SO_ACCEPTCONN))) {
        private enum enumMixinStr_SO_ACCEPTCONN = `enum SO_ACCEPTCONN = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ACCEPTCONN); }))) {
            mixin(enumMixinStr_SO_ACCEPTCONN);
        }
    }




    static if(!is(typeof(SO_PEERNAME))) {
        private enum enumMixinStr_SO_PEERNAME = `enum SO_PEERNAME = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PEERNAME); }))) {
            mixin(enumMixinStr_SO_PEERNAME);
        }
    }




    static if(!is(typeof(SO_GET_FILTER))) {
        private enum enumMixinStr_SO_GET_FILTER = `enum SO_GET_FILTER = SO_ATTACH_FILTER;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_GET_FILTER); }))) {
            mixin(enumMixinStr_SO_GET_FILTER);
        }
    }




    static if(!is(typeof(SO_DETACH_FILTER))) {
        private enum enumMixinStr_SO_DETACH_FILTER = `enum SO_DETACH_FILTER = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_DETACH_FILTER); }))) {
            mixin(enumMixinStr_SO_DETACH_FILTER);
        }
    }






    static if(!is(typeof(FD_SETSIZE))) {
        private enum enumMixinStr_FD_SETSIZE = `enum FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr_FD_SETSIZE); }))) {
            mixin(enumMixinStr_FD_SETSIZE);
        }
    }




    static if(!is(typeof(SO_ATTACH_FILTER))) {
        private enum enumMixinStr_SO_ATTACH_FILTER = `enum SO_ATTACH_FILTER = 26;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ATTACH_FILTER); }))) {
            mixin(enumMixinStr_SO_ATTACH_FILTER);
        }
    }




    static if(!is(typeof(SO_BINDTODEVICE))) {
        private enum enumMixinStr_SO_BINDTODEVICE = `enum SO_BINDTODEVICE = 25;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_BINDTODEVICE); }))) {
            mixin(enumMixinStr_SO_BINDTODEVICE);
        }
    }




    static if(!is(typeof(NFDBITS))) {
        private enum enumMixinStr_NFDBITS = `enum NFDBITS = ( 8 * cast( int ) ( __fd_mask ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr_NFDBITS); }))) {
            mixin(enumMixinStr_NFDBITS);
        }
    }
    static if(!is(typeof(SO_SECURITY_ENCRYPTION_NETWORK))) {
        private enum enumMixinStr_SO_SECURITY_ENCRYPTION_NETWORK = `enum SO_SECURITY_ENCRYPTION_NETWORK = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SECURITY_ENCRYPTION_NETWORK); }))) {
            mixin(enumMixinStr_SO_SECURITY_ENCRYPTION_NETWORK);
        }
    }




    static if(!is(typeof(SO_SECURITY_ENCRYPTION_TRANSPORT))) {
        private enum enumMixinStr_SO_SECURITY_ENCRYPTION_TRANSPORT = `enum SO_SECURITY_ENCRYPTION_TRANSPORT = 23;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SECURITY_ENCRYPTION_TRANSPORT); }))) {
            mixin(enumMixinStr_SO_SECURITY_ENCRYPTION_TRANSPORT);
        }
    }




    static if(!is(typeof(SO_SECURITY_AUTHENTICATION))) {
        private enum enumMixinStr_SO_SECURITY_AUTHENTICATION = `enum SO_SECURITY_AUTHENTICATION = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SECURITY_AUTHENTICATION); }))) {
            mixin(enumMixinStr_SO_SECURITY_AUTHENTICATION);
        }
    }




    static if(!is(typeof(SO_SNDTIMEO_OLD))) {
        private enum enumMixinStr_SO_SNDTIMEO_OLD = `enum SO_SNDTIMEO_OLD = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SNDTIMEO_OLD); }))) {
            mixin(enumMixinStr_SO_SNDTIMEO_OLD);
        }
    }




    static if(!is(typeof(SO_RCVTIMEO_OLD))) {
        private enum enumMixinStr_SO_RCVTIMEO_OLD = `enum SO_RCVTIMEO_OLD = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RCVTIMEO_OLD); }))) {
            mixin(enumMixinStr_SO_RCVTIMEO_OLD);
        }
    }




    static if(!is(typeof(SO_SNDLOWAT))) {
        private enum enumMixinStr_SO_SNDLOWAT = `enum SO_SNDLOWAT = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SNDLOWAT); }))) {
            mixin(enumMixinStr_SO_SNDLOWAT);
        }
    }




    static if(!is(typeof(SO_RCVLOWAT))) {
        private enum enumMixinStr_SO_RCVLOWAT = `enum SO_RCVLOWAT = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RCVLOWAT); }))) {
            mixin(enumMixinStr_SO_RCVLOWAT);
        }
    }




    static if(!is(typeof(_SYS_SOCKET_H))) {
        private enum enumMixinStr__SYS_SOCKET_H = `enum _SYS_SOCKET_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_SOCKET_H); }))) {
            mixin(enumMixinStr__SYS_SOCKET_H);
        }
    }




    static if(!is(typeof(SO_PEERCRED))) {
        private enum enumMixinStr_SO_PEERCRED = `enum SO_PEERCRED = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PEERCRED); }))) {
            mixin(enumMixinStr_SO_PEERCRED);
        }
    }




    static if(!is(typeof(SO_PASSCRED))) {
        private enum enumMixinStr_SO_PASSCRED = `enum SO_PASSCRED = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PASSCRED); }))) {
            mixin(enumMixinStr_SO_PASSCRED);
        }
    }




    static if(!is(typeof(SO_REUSEPORT))) {
        private enum enumMixinStr_SO_REUSEPORT = `enum SO_REUSEPORT = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_REUSEPORT); }))) {
            mixin(enumMixinStr_SO_REUSEPORT);
        }
    }




    static if(!is(typeof(SO_BSDCOMPAT))) {
        private enum enumMixinStr_SO_BSDCOMPAT = `enum SO_BSDCOMPAT = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_BSDCOMPAT); }))) {
            mixin(enumMixinStr_SO_BSDCOMPAT);
        }
    }




    static if(!is(typeof(SO_LINGER))) {
        private enum enumMixinStr_SO_LINGER = `enum SO_LINGER = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_LINGER); }))) {
            mixin(enumMixinStr_SO_LINGER);
        }
    }




    static if(!is(typeof(SO_PRIORITY))) {
        private enum enumMixinStr_SO_PRIORITY = `enum SO_PRIORITY = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_PRIORITY); }))) {
            mixin(enumMixinStr_SO_PRIORITY);
        }
    }




    static if(!is(typeof(SO_NO_CHECK))) {
        private enum enumMixinStr_SO_NO_CHECK = `enum SO_NO_CHECK = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_NO_CHECK); }))) {
            mixin(enumMixinStr_SO_NO_CHECK);
        }
    }




    static if(!is(typeof(SO_OOBINLINE))) {
        private enum enumMixinStr_SO_OOBINLINE = `enum SO_OOBINLINE = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_OOBINLINE); }))) {
            mixin(enumMixinStr_SO_OOBINLINE);
        }
    }




    static if(!is(typeof(SHUT_RD))) {
        private enum enumMixinStr_SHUT_RD = `enum SHUT_RD = SHUT_RD;`;
        static if(is(typeof({ mixin(enumMixinStr_SHUT_RD); }))) {
            mixin(enumMixinStr_SHUT_RD);
        }
    }




    static if(!is(typeof(SHUT_WR))) {
        private enum enumMixinStr_SHUT_WR = `enum SHUT_WR = SHUT_WR;`;
        static if(is(typeof({ mixin(enumMixinStr_SHUT_WR); }))) {
            mixin(enumMixinStr_SHUT_WR);
        }
    }




    static if(!is(typeof(SHUT_RDWR))) {
        private enum enumMixinStr_SHUT_RDWR = `enum SHUT_RDWR = SHUT_RDWR;`;
        static if(is(typeof({ mixin(enumMixinStr_SHUT_RDWR); }))) {
            mixin(enumMixinStr_SHUT_RDWR);
        }
    }




    static if(!is(typeof(SO_KEEPALIVE))) {
        private enum enumMixinStr_SO_KEEPALIVE = `enum SO_KEEPALIVE = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_KEEPALIVE); }))) {
            mixin(enumMixinStr_SO_KEEPALIVE);
        }
    }




    static if(!is(typeof(__SOCKADDR_ARG))) {
        private enum enumMixinStr___SOCKADDR_ARG = `enum __SOCKADDR_ARG = sockaddr * __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr___SOCKADDR_ARG); }))) {
            mixin(enumMixinStr___SOCKADDR_ARG);
        }
    }




    static if(!is(typeof(__CONST_SOCKADDR_ARG))) {
        private enum enumMixinStr___CONST_SOCKADDR_ARG = `enum __CONST_SOCKADDR_ARG = const sockaddr *;`;
        static if(is(typeof({ mixin(enumMixinStr___CONST_SOCKADDR_ARG); }))) {
            mixin(enumMixinStr___CONST_SOCKADDR_ARG);
        }
    }




    static if(!is(typeof(SO_RCVBUFFORCE))) {
        private enum enumMixinStr_SO_RCVBUFFORCE = `enum SO_RCVBUFFORCE = 33;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RCVBUFFORCE); }))) {
            mixin(enumMixinStr_SO_RCVBUFFORCE);
        }
    }




    static if(!is(typeof(SO_SNDBUFFORCE))) {
        private enum enumMixinStr_SO_SNDBUFFORCE = `enum SO_SNDBUFFORCE = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SNDBUFFORCE); }))) {
            mixin(enumMixinStr_SO_SNDBUFFORCE);
        }
    }




    static if(!is(typeof(SO_RCVBUF))) {
        private enum enumMixinStr_SO_RCVBUF = `enum SO_RCVBUF = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_RCVBUF); }))) {
            mixin(enumMixinStr_SO_RCVBUF);
        }
    }




    static if(!is(typeof(SO_SNDBUF))) {
        private enum enumMixinStr_SO_SNDBUF = `enum SO_SNDBUF = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_SNDBUF); }))) {
            mixin(enumMixinStr_SO_SNDBUF);
        }
    }




    static if(!is(typeof(SO_BROADCAST))) {
        private enum enumMixinStr_SO_BROADCAST = `enum SO_BROADCAST = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_BROADCAST); }))) {
            mixin(enumMixinStr_SO_BROADCAST);
        }
    }




    static if(!is(typeof(SO_DONTROUTE))) {
        private enum enumMixinStr_SO_DONTROUTE = `enum SO_DONTROUTE = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_DONTROUTE); }))) {
            mixin(enumMixinStr_SO_DONTROUTE);
        }
    }




    static if(!is(typeof(SO_ERROR))) {
        private enum enumMixinStr_SO_ERROR = `enum SO_ERROR = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_ERROR); }))) {
            mixin(enumMixinStr_SO_ERROR);
        }
    }




    static if(!is(typeof(SO_TYPE))) {
        private enum enumMixinStr_SO_TYPE = `enum SO_TYPE = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_TYPE); }))) {
            mixin(enumMixinStr_SO_TYPE);
        }
    }




    static if(!is(typeof(SO_REUSEADDR))) {
        private enum enumMixinStr_SO_REUSEADDR = `enum SO_REUSEADDR = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_REUSEADDR); }))) {
            mixin(enumMixinStr_SO_REUSEADDR);
        }
    }




    static if(!is(typeof(SO_DEBUG))) {
        private enum enumMixinStr_SO_DEBUG = `enum SO_DEBUG = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_SO_DEBUG); }))) {
            mixin(enumMixinStr_SO_DEBUG);
        }
    }




    static if(!is(typeof(SOL_SOCKET))) {
        private enum enumMixinStr_SOL_SOCKET = `enum SOL_SOCKET = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_SOL_SOCKET); }))) {
            mixin(enumMixinStr_SOL_SOCKET);
        }
    }
    static if(!is(typeof(EHWPOISON))) {
        private enum enumMixinStr_EHWPOISON = `enum EHWPOISON = 133;`;
        static if(is(typeof({ mixin(enumMixinStr_EHWPOISON); }))) {
            mixin(enumMixinStr_EHWPOISON);
        }
    }




    static if(!is(typeof(ERFKILL))) {
        private enum enumMixinStr_ERFKILL = `enum ERFKILL = 132;`;
        static if(is(typeof({ mixin(enumMixinStr_ERFKILL); }))) {
            mixin(enumMixinStr_ERFKILL);
        }
    }




    static if(!is(typeof(ENOTRECOVERABLE))) {
        private enum enumMixinStr_ENOTRECOVERABLE = `enum ENOTRECOVERABLE = 131;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTRECOVERABLE); }))) {
            mixin(enumMixinStr_ENOTRECOVERABLE);
        }
    }




    static if(!is(typeof(EOWNERDEAD))) {
        private enum enumMixinStr_EOWNERDEAD = `enum EOWNERDEAD = 130;`;
        static if(is(typeof({ mixin(enumMixinStr_EOWNERDEAD); }))) {
            mixin(enumMixinStr_EOWNERDEAD);
        }
    }




    static if(!is(typeof(EKEYREJECTED))) {
        private enum enumMixinStr_EKEYREJECTED = `enum EKEYREJECTED = 129;`;
        static if(is(typeof({ mixin(enumMixinStr_EKEYREJECTED); }))) {
            mixin(enumMixinStr_EKEYREJECTED);
        }
    }




    static if(!is(typeof(EKEYREVOKED))) {
        private enum enumMixinStr_EKEYREVOKED = `enum EKEYREVOKED = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_EKEYREVOKED); }))) {
            mixin(enumMixinStr_EKEYREVOKED);
        }
    }




    static if(!is(typeof(EKEYEXPIRED))) {
        private enum enumMixinStr_EKEYEXPIRED = `enum EKEYEXPIRED = 127;`;
        static if(is(typeof({ mixin(enumMixinStr_EKEYEXPIRED); }))) {
            mixin(enumMixinStr_EKEYEXPIRED);
        }
    }




    static if(!is(typeof(ENOKEY))) {
        private enum enumMixinStr_ENOKEY = `enum ENOKEY = 126;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOKEY); }))) {
            mixin(enumMixinStr_ENOKEY);
        }
    }




    static if(!is(typeof(ECANCELED))) {
        private enum enumMixinStr_ECANCELED = `enum ECANCELED = 125;`;
        static if(is(typeof({ mixin(enumMixinStr_ECANCELED); }))) {
            mixin(enumMixinStr_ECANCELED);
        }
    }




    static if(!is(typeof(EMEDIUMTYPE))) {
        private enum enumMixinStr_EMEDIUMTYPE = `enum EMEDIUMTYPE = 124;`;
        static if(is(typeof({ mixin(enumMixinStr_EMEDIUMTYPE); }))) {
            mixin(enumMixinStr_EMEDIUMTYPE);
        }
    }




    static if(!is(typeof(ENOMEDIUM))) {
        private enum enumMixinStr_ENOMEDIUM = `enum ENOMEDIUM = 123;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOMEDIUM); }))) {
            mixin(enumMixinStr_ENOMEDIUM);
        }
    }




    static if(!is(typeof(EDQUOT))) {
        private enum enumMixinStr_EDQUOT = `enum EDQUOT = 122;`;
        static if(is(typeof({ mixin(enumMixinStr_EDQUOT); }))) {
            mixin(enumMixinStr_EDQUOT);
        }
    }




    static if(!is(typeof(EREMOTEIO))) {
        private enum enumMixinStr_EREMOTEIO = `enum EREMOTEIO = 121;`;
        static if(is(typeof({ mixin(enumMixinStr_EREMOTEIO); }))) {
            mixin(enumMixinStr_EREMOTEIO);
        }
    }




    static if(!is(typeof(EISNAM))) {
        private enum enumMixinStr_EISNAM = `enum EISNAM = 120;`;
        static if(is(typeof({ mixin(enumMixinStr_EISNAM); }))) {
            mixin(enumMixinStr_EISNAM);
        }
    }




    static if(!is(typeof(ENAVAIL))) {
        private enum enumMixinStr_ENAVAIL = `enum ENAVAIL = 119;`;
        static if(is(typeof({ mixin(enumMixinStr_ENAVAIL); }))) {
            mixin(enumMixinStr_ENAVAIL);
        }
    }




    static if(!is(typeof(ENOTNAM))) {
        private enum enumMixinStr_ENOTNAM = `enum ENOTNAM = 118;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTNAM); }))) {
            mixin(enumMixinStr_ENOTNAM);
        }
    }




    static if(!is(typeof(EUCLEAN))) {
        private enum enumMixinStr_EUCLEAN = `enum EUCLEAN = 117;`;
        static if(is(typeof({ mixin(enumMixinStr_EUCLEAN); }))) {
            mixin(enumMixinStr_EUCLEAN);
        }
    }




    static if(!is(typeof(ESTALE))) {
        private enum enumMixinStr_ESTALE = `enum ESTALE = 116;`;
        static if(is(typeof({ mixin(enumMixinStr_ESTALE); }))) {
            mixin(enumMixinStr_ESTALE);
        }
    }




    static if(!is(typeof(EINPROGRESS))) {
        private enum enumMixinStr_EINPROGRESS = `enum EINPROGRESS = 115;`;
        static if(is(typeof({ mixin(enumMixinStr_EINPROGRESS); }))) {
            mixin(enumMixinStr_EINPROGRESS);
        }
    }




    static if(!is(typeof(EALREADY))) {
        private enum enumMixinStr_EALREADY = `enum EALREADY = 114;`;
        static if(is(typeof({ mixin(enumMixinStr_EALREADY); }))) {
            mixin(enumMixinStr_EALREADY);
        }
    }




    static if(!is(typeof(EHOSTUNREACH))) {
        private enum enumMixinStr_EHOSTUNREACH = `enum EHOSTUNREACH = 113;`;
        static if(is(typeof({ mixin(enumMixinStr_EHOSTUNREACH); }))) {
            mixin(enumMixinStr_EHOSTUNREACH);
        }
    }




    static if(!is(typeof(EHOSTDOWN))) {
        private enum enumMixinStr_EHOSTDOWN = `enum EHOSTDOWN = 112;`;
        static if(is(typeof({ mixin(enumMixinStr_EHOSTDOWN); }))) {
            mixin(enumMixinStr_EHOSTDOWN);
        }
    }




    static if(!is(typeof(ECONNREFUSED))) {
        private enum enumMixinStr_ECONNREFUSED = `enum ECONNREFUSED = 111;`;
        static if(is(typeof({ mixin(enumMixinStr_ECONNREFUSED); }))) {
            mixin(enumMixinStr_ECONNREFUSED);
        }
    }




    static if(!is(typeof(ETIMEDOUT))) {
        private enum enumMixinStr_ETIMEDOUT = `enum ETIMEDOUT = 110;`;
        static if(is(typeof({ mixin(enumMixinStr_ETIMEDOUT); }))) {
            mixin(enumMixinStr_ETIMEDOUT);
        }
    }




    static if(!is(typeof(ETOOMANYREFS))) {
        private enum enumMixinStr_ETOOMANYREFS = `enum ETOOMANYREFS = 109;`;
        static if(is(typeof({ mixin(enumMixinStr_ETOOMANYREFS); }))) {
            mixin(enumMixinStr_ETOOMANYREFS);
        }
    }




    static if(!is(typeof(ESHUTDOWN))) {
        private enum enumMixinStr_ESHUTDOWN = `enum ESHUTDOWN = 108;`;
        static if(is(typeof({ mixin(enumMixinStr_ESHUTDOWN); }))) {
            mixin(enumMixinStr_ESHUTDOWN);
        }
    }




    static if(!is(typeof(ENOTCONN))) {
        private enum enumMixinStr_ENOTCONN = `enum ENOTCONN = 107;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTCONN); }))) {
            mixin(enumMixinStr_ENOTCONN);
        }
    }




    static if(!is(typeof(EISCONN))) {
        private enum enumMixinStr_EISCONN = `enum EISCONN = 106;`;
        static if(is(typeof({ mixin(enumMixinStr_EISCONN); }))) {
            mixin(enumMixinStr_EISCONN);
        }
    }




    static if(!is(typeof(_SYS_TYPES_H))) {
        private enum enumMixinStr__SYS_TYPES_H = `enum _SYS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_TYPES_H); }))) {
            mixin(enumMixinStr__SYS_TYPES_H);
        }
    }




    static if(!is(typeof(ENOBUFS))) {
        private enum enumMixinStr_ENOBUFS = `enum ENOBUFS = 105;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOBUFS); }))) {
            mixin(enumMixinStr_ENOBUFS);
        }
    }




    static if(!is(typeof(ECONNRESET))) {
        private enum enumMixinStr_ECONNRESET = `enum ECONNRESET = 104;`;
        static if(is(typeof({ mixin(enumMixinStr_ECONNRESET); }))) {
            mixin(enumMixinStr_ECONNRESET);
        }
    }




    static if(!is(typeof(ECONNABORTED))) {
        private enum enumMixinStr_ECONNABORTED = `enum ECONNABORTED = 103;`;
        static if(is(typeof({ mixin(enumMixinStr_ECONNABORTED); }))) {
            mixin(enumMixinStr_ECONNABORTED);
        }
    }




    static if(!is(typeof(ENETRESET))) {
        private enum enumMixinStr_ENETRESET = `enum ENETRESET = 102;`;
        static if(is(typeof({ mixin(enumMixinStr_ENETRESET); }))) {
            mixin(enumMixinStr_ENETRESET);
        }
    }




    static if(!is(typeof(ENETUNREACH))) {
        private enum enumMixinStr_ENETUNREACH = `enum ENETUNREACH = 101;`;
        static if(is(typeof({ mixin(enumMixinStr_ENETUNREACH); }))) {
            mixin(enumMixinStr_ENETUNREACH);
        }
    }




    static if(!is(typeof(ENETDOWN))) {
        private enum enumMixinStr_ENETDOWN = `enum ENETDOWN = 100;`;
        static if(is(typeof({ mixin(enumMixinStr_ENETDOWN); }))) {
            mixin(enumMixinStr_ENETDOWN);
        }
    }




    static if(!is(typeof(EADDRNOTAVAIL))) {
        private enum enumMixinStr_EADDRNOTAVAIL = `enum EADDRNOTAVAIL = 99;`;
        static if(is(typeof({ mixin(enumMixinStr_EADDRNOTAVAIL); }))) {
            mixin(enumMixinStr_EADDRNOTAVAIL);
        }
    }




    static if(!is(typeof(EADDRINUSE))) {
        private enum enumMixinStr_EADDRINUSE = `enum EADDRINUSE = 98;`;
        static if(is(typeof({ mixin(enumMixinStr_EADDRINUSE); }))) {
            mixin(enumMixinStr_EADDRINUSE);
        }
    }




    static if(!is(typeof(EAFNOSUPPORT))) {
        private enum enumMixinStr_EAFNOSUPPORT = `enum EAFNOSUPPORT = 97;`;
        static if(is(typeof({ mixin(enumMixinStr_EAFNOSUPPORT); }))) {
            mixin(enumMixinStr_EAFNOSUPPORT);
        }
    }




    static if(!is(typeof(EPFNOSUPPORT))) {
        private enum enumMixinStr_EPFNOSUPPORT = `enum EPFNOSUPPORT = 96;`;
        static if(is(typeof({ mixin(enumMixinStr_EPFNOSUPPORT); }))) {
            mixin(enumMixinStr_EPFNOSUPPORT);
        }
    }




    static if(!is(typeof(EOPNOTSUPP))) {
        private enum enumMixinStr_EOPNOTSUPP = `enum EOPNOTSUPP = 95;`;
        static if(is(typeof({ mixin(enumMixinStr_EOPNOTSUPP); }))) {
            mixin(enumMixinStr_EOPNOTSUPP);
        }
    }






    static if(!is(typeof(ESOCKTNOSUPPORT))) {
        private enum enumMixinStr_ESOCKTNOSUPPORT = `enum ESOCKTNOSUPPORT = 94;`;
        static if(is(typeof({ mixin(enumMixinStr_ESOCKTNOSUPPORT); }))) {
            mixin(enumMixinStr_ESOCKTNOSUPPORT);
        }
    }




    static if(!is(typeof(EPROTONOSUPPORT))) {
        private enum enumMixinStr_EPROTONOSUPPORT = `enum EPROTONOSUPPORT = 93;`;
        static if(is(typeof({ mixin(enumMixinStr_EPROTONOSUPPORT); }))) {
            mixin(enumMixinStr_EPROTONOSUPPORT);
        }
    }






    static if(!is(typeof(ENOPROTOOPT))) {
        private enum enumMixinStr_ENOPROTOOPT = `enum ENOPROTOOPT = 92;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOPROTOOPT); }))) {
            mixin(enumMixinStr_ENOPROTOOPT);
        }
    }






    static if(!is(typeof(EPROTOTYPE))) {
        private enum enumMixinStr_EPROTOTYPE = `enum EPROTOTYPE = 91;`;
        static if(is(typeof({ mixin(enumMixinStr_EPROTOTYPE); }))) {
            mixin(enumMixinStr_EPROTOTYPE);
        }
    }






    static if(!is(typeof(EMSGSIZE))) {
        private enum enumMixinStr_EMSGSIZE = `enum EMSGSIZE = 90;`;
        static if(is(typeof({ mixin(enumMixinStr_EMSGSIZE); }))) {
            mixin(enumMixinStr_EMSGSIZE);
        }
    }






    static if(!is(typeof(EDESTADDRREQ))) {
        private enum enumMixinStr_EDESTADDRREQ = `enum EDESTADDRREQ = 89;`;
        static if(is(typeof({ mixin(enumMixinStr_EDESTADDRREQ); }))) {
            mixin(enumMixinStr_EDESTADDRREQ);
        }
    }






    static if(!is(typeof(ENOTSOCK))) {
        private enum enumMixinStr_ENOTSOCK = `enum ENOTSOCK = 88;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTSOCK); }))) {
            mixin(enumMixinStr_ENOTSOCK);
        }
    }






    static if(!is(typeof(EUSERS))) {
        private enum enumMixinStr_EUSERS = `enum EUSERS = 87;`;
        static if(is(typeof({ mixin(enumMixinStr_EUSERS); }))) {
            mixin(enumMixinStr_EUSERS);
        }
    }






    static if(!is(typeof(ESTRPIPE))) {
        private enum enumMixinStr_ESTRPIPE = `enum ESTRPIPE = 86;`;
        static if(is(typeof({ mixin(enumMixinStr_ESTRPIPE); }))) {
            mixin(enumMixinStr_ESTRPIPE);
        }
    }






    static if(!is(typeof(ERESTART))) {
        private enum enumMixinStr_ERESTART = `enum ERESTART = 85;`;
        static if(is(typeof({ mixin(enumMixinStr_ERESTART); }))) {
            mixin(enumMixinStr_ERESTART);
        }
    }




    static if(!is(typeof(EILSEQ))) {
        private enum enumMixinStr_EILSEQ = `enum EILSEQ = 84;`;
        static if(is(typeof({ mixin(enumMixinStr_EILSEQ); }))) {
            mixin(enumMixinStr_EILSEQ);
        }
    }






    static if(!is(typeof(ELIBEXEC))) {
        private enum enumMixinStr_ELIBEXEC = `enum ELIBEXEC = 83;`;
        static if(is(typeof({ mixin(enumMixinStr_ELIBEXEC); }))) {
            mixin(enumMixinStr_ELIBEXEC);
        }
    }






    static if(!is(typeof(ELIBMAX))) {
        private enum enumMixinStr_ELIBMAX = `enum ELIBMAX = 82;`;
        static if(is(typeof({ mixin(enumMixinStr_ELIBMAX); }))) {
            mixin(enumMixinStr_ELIBMAX);
        }
    }




    static if(!is(typeof(ELIBSCN))) {
        private enum enumMixinStr_ELIBSCN = `enum ELIBSCN = 81;`;
        static if(is(typeof({ mixin(enumMixinStr_ELIBSCN); }))) {
            mixin(enumMixinStr_ELIBSCN);
        }
    }




    static if(!is(typeof(ELIBBAD))) {
        private enum enumMixinStr_ELIBBAD = `enum ELIBBAD = 80;`;
        static if(is(typeof({ mixin(enumMixinStr_ELIBBAD); }))) {
            mixin(enumMixinStr_ELIBBAD);
        }
    }






    static if(!is(typeof(ELIBACC))) {
        private enum enumMixinStr_ELIBACC = `enum ELIBACC = 79;`;
        static if(is(typeof({ mixin(enumMixinStr_ELIBACC); }))) {
            mixin(enumMixinStr_ELIBACC);
        }
    }




    static if(!is(typeof(EREMCHG))) {
        private enum enumMixinStr_EREMCHG = `enum EREMCHG = 78;`;
        static if(is(typeof({ mixin(enumMixinStr_EREMCHG); }))) {
            mixin(enumMixinStr_EREMCHG);
        }
    }






    static if(!is(typeof(EBADFD))) {
        private enum enumMixinStr_EBADFD = `enum EBADFD = 77;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADFD); }))) {
            mixin(enumMixinStr_EBADFD);
        }
    }




    static if(!is(typeof(ENOTUNIQ))) {
        private enum enumMixinStr_ENOTUNIQ = `enum ENOTUNIQ = 76;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTUNIQ); }))) {
            mixin(enumMixinStr_ENOTUNIQ);
        }
    }




    static if(!is(typeof(EOVERFLOW))) {
        private enum enumMixinStr_EOVERFLOW = `enum EOVERFLOW = 75;`;
        static if(is(typeof({ mixin(enumMixinStr_EOVERFLOW); }))) {
            mixin(enumMixinStr_EOVERFLOW);
        }
    }




    static if(!is(typeof(EBADMSG))) {
        private enum enumMixinStr_EBADMSG = `enum EBADMSG = 74;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADMSG); }))) {
            mixin(enumMixinStr_EBADMSG);
        }
    }




    static if(!is(typeof(EDOTDOT))) {
        private enum enumMixinStr_EDOTDOT = `enum EDOTDOT = 73;`;
        static if(is(typeof({ mixin(enumMixinStr_EDOTDOT); }))) {
            mixin(enumMixinStr_EDOTDOT);
        }
    }




    static if(!is(typeof(EMULTIHOP))) {
        private enum enumMixinStr_EMULTIHOP = `enum EMULTIHOP = 72;`;
        static if(is(typeof({ mixin(enumMixinStr_EMULTIHOP); }))) {
            mixin(enumMixinStr_EMULTIHOP);
        }
    }




    static if(!is(typeof(EPROTO))) {
        private enum enumMixinStr_EPROTO = `enum EPROTO = 71;`;
        static if(is(typeof({ mixin(enumMixinStr_EPROTO); }))) {
            mixin(enumMixinStr_EPROTO);
        }
    }




    static if(!is(typeof(ECOMM))) {
        private enum enumMixinStr_ECOMM = `enum ECOMM = 70;`;
        static if(is(typeof({ mixin(enumMixinStr_ECOMM); }))) {
            mixin(enumMixinStr_ECOMM);
        }
    }




    static if(!is(typeof(ESRMNT))) {
        private enum enumMixinStr_ESRMNT = `enum ESRMNT = 69;`;
        static if(is(typeof({ mixin(enumMixinStr_ESRMNT); }))) {
            mixin(enumMixinStr_ESRMNT);
        }
    }




    static if(!is(typeof(EADV))) {
        private enum enumMixinStr_EADV = `enum EADV = 68;`;
        static if(is(typeof({ mixin(enumMixinStr_EADV); }))) {
            mixin(enumMixinStr_EADV);
        }
    }




    static if(!is(typeof(ENOLINK))) {
        private enum enumMixinStr_ENOLINK = `enum ENOLINK = 67;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOLINK); }))) {
            mixin(enumMixinStr_ENOLINK);
        }
    }




    static if(!is(typeof(EREMOTE))) {
        private enum enumMixinStr_EREMOTE = `enum EREMOTE = 66;`;
        static if(is(typeof({ mixin(enumMixinStr_EREMOTE); }))) {
            mixin(enumMixinStr_EREMOTE);
        }
    }




    static if(!is(typeof(ENOPKG))) {
        private enum enumMixinStr_ENOPKG = `enum ENOPKG = 65;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOPKG); }))) {
            mixin(enumMixinStr_ENOPKG);
        }
    }




    static if(!is(typeof(ENONET))) {
        private enum enumMixinStr_ENONET = `enum ENONET = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_ENONET); }))) {
            mixin(enumMixinStr_ENONET);
        }
    }




    static if(!is(typeof(ENOSR))) {
        private enum enumMixinStr_ENOSR = `enum ENOSR = 63;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOSR); }))) {
            mixin(enumMixinStr_ENOSR);
        }
    }




    static if(!is(typeof(ETIME))) {
        private enum enumMixinStr_ETIME = `enum ETIME = 62;`;
        static if(is(typeof({ mixin(enumMixinStr_ETIME); }))) {
            mixin(enumMixinStr_ETIME);
        }
    }




    static if(!is(typeof(ENODATA))) {
        private enum enumMixinStr_ENODATA = `enum ENODATA = 61;`;
        static if(is(typeof({ mixin(enumMixinStr_ENODATA); }))) {
            mixin(enumMixinStr_ENODATA);
        }
    }




    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        private enum enumMixinStr___BIT_TYPES_DEFINED__ = `enum __BIT_TYPES_DEFINED__ = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___BIT_TYPES_DEFINED__); }))) {
            mixin(enumMixinStr___BIT_TYPES_DEFINED__);
        }
    }




    static if(!is(typeof(ENOSTR))) {
        private enum enumMixinStr_ENOSTR = `enum ENOSTR = 60;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOSTR); }))) {
            mixin(enumMixinStr_ENOSTR);
        }
    }




    static if(!is(typeof(EBFONT))) {
        private enum enumMixinStr_EBFONT = `enum EBFONT = 59;`;
        static if(is(typeof({ mixin(enumMixinStr_EBFONT); }))) {
            mixin(enumMixinStr_EBFONT);
        }
    }




    static if(!is(typeof(EDEADLOCK))) {
        private enum enumMixinStr_EDEADLOCK = `enum EDEADLOCK = EDEADLK;`;
        static if(is(typeof({ mixin(enumMixinStr_EDEADLOCK); }))) {
            mixin(enumMixinStr_EDEADLOCK);
        }
    }




    static if(!is(typeof(EBADSLT))) {
        private enum enumMixinStr_EBADSLT = `enum EBADSLT = 57;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADSLT); }))) {
            mixin(enumMixinStr_EBADSLT);
        }
    }




    static if(!is(typeof(EBADRQC))) {
        private enum enumMixinStr_EBADRQC = `enum EBADRQC = 56;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADRQC); }))) {
            mixin(enumMixinStr_EBADRQC);
        }
    }






    static if(!is(typeof(ENOANO))) {
        private enum enumMixinStr_ENOANO = `enum ENOANO = 55;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOANO); }))) {
            mixin(enumMixinStr_ENOANO);
        }
    }






    static if(!is(typeof(EXFULL))) {
        private enum enumMixinStr_EXFULL = `enum EXFULL = 54;`;
        static if(is(typeof({ mixin(enumMixinStr_EXFULL); }))) {
            mixin(enumMixinStr_EXFULL);
        }
    }






    static if(!is(typeof(EBADR))) {
        private enum enumMixinStr_EBADR = `enum EBADR = 53;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADR); }))) {
            mixin(enumMixinStr_EBADR);
        }
    }






    static if(!is(typeof(EBADE))) {
        private enum enumMixinStr_EBADE = `enum EBADE = 52;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADE); }))) {
            mixin(enumMixinStr_EBADE);
        }
    }




    static if(!is(typeof(EL2HLT))) {
        private enum enumMixinStr_EL2HLT = `enum EL2HLT = 51;`;
        static if(is(typeof({ mixin(enumMixinStr_EL2HLT); }))) {
            mixin(enumMixinStr_EL2HLT);
        }
    }




    static if(!is(typeof(ENOCSI))) {
        private enum enumMixinStr_ENOCSI = `enum ENOCSI = 50;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOCSI); }))) {
            mixin(enumMixinStr_ENOCSI);
        }
    }




    static if(!is(typeof(_UNISTD_H))) {
        private enum enumMixinStr__UNISTD_H = `enum _UNISTD_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__UNISTD_H); }))) {
            mixin(enumMixinStr__UNISTD_H);
        }
    }




    static if(!is(typeof(EUNATCH))) {
        private enum enumMixinStr_EUNATCH = `enum EUNATCH = 49;`;
        static if(is(typeof({ mixin(enumMixinStr_EUNATCH); }))) {
            mixin(enumMixinStr_EUNATCH);
        }
    }




    static if(!is(typeof(ELNRNG))) {
        private enum enumMixinStr_ELNRNG = `enum ELNRNG = 48;`;
        static if(is(typeof({ mixin(enumMixinStr_ELNRNG); }))) {
            mixin(enumMixinStr_ELNRNG);
        }
    }




    static if(!is(typeof(EL3RST))) {
        private enum enumMixinStr_EL3RST = `enum EL3RST = 47;`;
        static if(is(typeof({ mixin(enumMixinStr_EL3RST); }))) {
            mixin(enumMixinStr_EL3RST);
        }
    }




    static if(!is(typeof(_POSIX_VERSION))) {
        private enum enumMixinStr__POSIX_VERSION = `enum _POSIX_VERSION = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_VERSION); }))) {
            mixin(enumMixinStr__POSIX_VERSION);
        }
    }




    static if(!is(typeof(EL3HLT))) {
        private enum enumMixinStr_EL3HLT = `enum EL3HLT = 46;`;
        static if(is(typeof({ mixin(enumMixinStr_EL3HLT); }))) {
            mixin(enumMixinStr_EL3HLT);
        }
    }




    static if(!is(typeof(__POSIX2_THIS_VERSION))) {
        private enum enumMixinStr___POSIX2_THIS_VERSION = `enum __POSIX2_THIS_VERSION = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr___POSIX2_THIS_VERSION); }))) {
            mixin(enumMixinStr___POSIX2_THIS_VERSION);
        }
    }




    static if(!is(typeof(_POSIX2_VERSION))) {
        private enum enumMixinStr__POSIX2_VERSION = `enum _POSIX2_VERSION = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_VERSION); }))) {
            mixin(enumMixinStr__POSIX2_VERSION);
        }
    }




    static if(!is(typeof(_POSIX2_C_VERSION))) {
        private enum enumMixinStr__POSIX2_C_VERSION = `enum _POSIX2_C_VERSION = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_C_VERSION); }))) {
            mixin(enumMixinStr__POSIX2_C_VERSION);
        }
    }




    static if(!is(typeof(_POSIX2_C_BIND))) {
        private enum enumMixinStr__POSIX2_C_BIND = `enum _POSIX2_C_BIND = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_C_BIND); }))) {
            mixin(enumMixinStr__POSIX2_C_BIND);
        }
    }




    static if(!is(typeof(_POSIX2_C_DEV))) {
        private enum enumMixinStr__POSIX2_C_DEV = `enum _POSIX2_C_DEV = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_C_DEV); }))) {
            mixin(enumMixinStr__POSIX2_C_DEV);
        }
    }




    static if(!is(typeof(_POSIX2_SW_DEV))) {
        private enum enumMixinStr__POSIX2_SW_DEV = `enum _POSIX2_SW_DEV = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_SW_DEV); }))) {
            mixin(enumMixinStr__POSIX2_SW_DEV);
        }
    }




    static if(!is(typeof(_POSIX2_LOCALEDEF))) {
        private enum enumMixinStr__POSIX2_LOCALEDEF = `enum _POSIX2_LOCALEDEF = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX2_LOCALEDEF); }))) {
            mixin(enumMixinStr__POSIX2_LOCALEDEF);
        }
    }




    static if(!is(typeof(EL2NSYNC))) {
        private enum enumMixinStr_EL2NSYNC = `enum EL2NSYNC = 45;`;
        static if(is(typeof({ mixin(enumMixinStr_EL2NSYNC); }))) {
            mixin(enumMixinStr_EL2NSYNC);
        }
    }




    static if(!is(typeof(_XOPEN_VERSION))) {
        private enum enumMixinStr__XOPEN_VERSION = `enum _XOPEN_VERSION = 700;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_VERSION); }))) {
            mixin(enumMixinStr__XOPEN_VERSION);
        }
    }




    static if(!is(typeof(_XOPEN_XCU_VERSION))) {
        private enum enumMixinStr__XOPEN_XCU_VERSION = `enum _XOPEN_XCU_VERSION = 4;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_XCU_VERSION); }))) {
            mixin(enumMixinStr__XOPEN_XCU_VERSION);
        }
    }




    static if(!is(typeof(_XOPEN_XPG2))) {
        private enum enumMixinStr__XOPEN_XPG2 = `enum _XOPEN_XPG2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_XPG2); }))) {
            mixin(enumMixinStr__XOPEN_XPG2);
        }
    }




    static if(!is(typeof(_XOPEN_XPG3))) {
        private enum enumMixinStr__XOPEN_XPG3 = `enum _XOPEN_XPG3 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_XPG3); }))) {
            mixin(enumMixinStr__XOPEN_XPG3);
        }
    }




    static if(!is(typeof(_XOPEN_XPG4))) {
        private enum enumMixinStr__XOPEN_XPG4 = `enum _XOPEN_XPG4 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_XPG4); }))) {
            mixin(enumMixinStr__XOPEN_XPG4);
        }
    }




    static if(!is(typeof(_XOPEN_UNIX))) {
        private enum enumMixinStr__XOPEN_UNIX = `enum _XOPEN_UNIX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_UNIX); }))) {
            mixin(enumMixinStr__XOPEN_UNIX);
        }
    }




    static if(!is(typeof(_XOPEN_ENH_I18N))) {
        private enum enumMixinStr__XOPEN_ENH_I18N = `enum _XOPEN_ENH_I18N = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_ENH_I18N); }))) {
            mixin(enumMixinStr__XOPEN_ENH_I18N);
        }
    }




    static if(!is(typeof(_XOPEN_LEGACY))) {
        private enum enumMixinStr__XOPEN_LEGACY = `enum _XOPEN_LEGACY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__XOPEN_LEGACY); }))) {
            mixin(enumMixinStr__XOPEN_LEGACY);
        }
    }




    static if(!is(typeof(ECHRNG))) {
        private enum enumMixinStr_ECHRNG = `enum ECHRNG = 44;`;
        static if(is(typeof({ mixin(enumMixinStr_ECHRNG); }))) {
            mixin(enumMixinStr_ECHRNG);
        }
    }




    static if(!is(typeof(EIDRM))) {
        private enum enumMixinStr_EIDRM = `enum EIDRM = 43;`;
        static if(is(typeof({ mixin(enumMixinStr_EIDRM); }))) {
            mixin(enumMixinStr_EIDRM);
        }
    }




    static if(!is(typeof(ENOMSG))) {
        private enum enumMixinStr_ENOMSG = `enum ENOMSG = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOMSG); }))) {
            mixin(enumMixinStr_ENOMSG);
        }
    }




    static if(!is(typeof(STDIN_FILENO))) {
        private enum enumMixinStr_STDIN_FILENO = `enum STDIN_FILENO = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_STDIN_FILENO); }))) {
            mixin(enumMixinStr_STDIN_FILENO);
        }
    }




    static if(!is(typeof(STDOUT_FILENO))) {
        private enum enumMixinStr_STDOUT_FILENO = `enum STDOUT_FILENO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_STDOUT_FILENO); }))) {
            mixin(enumMixinStr_STDOUT_FILENO);
        }
    }




    static if(!is(typeof(STDERR_FILENO))) {
        private enum enumMixinStr_STDERR_FILENO = `enum STDERR_FILENO = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_STDERR_FILENO); }))) {
            mixin(enumMixinStr_STDERR_FILENO);
        }
    }




    static if(!is(typeof(EWOULDBLOCK))) {
        private enum enumMixinStr_EWOULDBLOCK = `enum EWOULDBLOCK = EAGAIN;`;
        static if(is(typeof({ mixin(enumMixinStr_EWOULDBLOCK); }))) {
            mixin(enumMixinStr_EWOULDBLOCK);
        }
    }




    static if(!is(typeof(ELOOP))) {
        private enum enumMixinStr_ELOOP = `enum ELOOP = 40;`;
        static if(is(typeof({ mixin(enumMixinStr_ELOOP); }))) {
            mixin(enumMixinStr_ELOOP);
        }
    }




    static if(!is(typeof(ENOTEMPTY))) {
        private enum enumMixinStr_ENOTEMPTY = `enum ENOTEMPTY = 39;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTEMPTY); }))) {
            mixin(enumMixinStr_ENOTEMPTY);
        }
    }




    static if(!is(typeof(ENOSYS))) {
        private enum enumMixinStr_ENOSYS = `enum ENOSYS = 38;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOSYS); }))) {
            mixin(enumMixinStr_ENOSYS);
        }
    }




    static if(!is(typeof(ENOLCK))) {
        private enum enumMixinStr_ENOLCK = `enum ENOLCK = 37;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOLCK); }))) {
            mixin(enumMixinStr_ENOLCK);
        }
    }




    static if(!is(typeof(ENAMETOOLONG))) {
        private enum enumMixinStr_ENAMETOOLONG = `enum ENAMETOOLONG = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_ENAMETOOLONG); }))) {
            mixin(enumMixinStr_ENAMETOOLONG);
        }
    }




    static if(!is(typeof(EDEADLK))) {
        private enum enumMixinStr_EDEADLK = `enum EDEADLK = 35;`;
        static if(is(typeof({ mixin(enumMixinStr_EDEADLK); }))) {
            mixin(enumMixinStr_EDEADLK);
        }
    }
    static if(!is(typeof(ERANGE))) {
        private enum enumMixinStr_ERANGE = `enum ERANGE = 34;`;
        static if(is(typeof({ mixin(enumMixinStr_ERANGE); }))) {
            mixin(enumMixinStr_ERANGE);
        }
    }




    static if(!is(typeof(EDOM))) {
        private enum enumMixinStr_EDOM = `enum EDOM = 33;`;
        static if(is(typeof({ mixin(enumMixinStr_EDOM); }))) {
            mixin(enumMixinStr_EDOM);
        }
    }




    static if(!is(typeof(EPIPE))) {
        private enum enumMixinStr_EPIPE = `enum EPIPE = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_EPIPE); }))) {
            mixin(enumMixinStr_EPIPE);
        }
    }




    static if(!is(typeof(EMLINK))) {
        private enum enumMixinStr_EMLINK = `enum EMLINK = 31;`;
        static if(is(typeof({ mixin(enumMixinStr_EMLINK); }))) {
            mixin(enumMixinStr_EMLINK);
        }
    }




    static if(!is(typeof(EROFS))) {
        private enum enumMixinStr_EROFS = `enum EROFS = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_EROFS); }))) {
            mixin(enumMixinStr_EROFS);
        }
    }




    static if(!is(typeof(ESPIPE))) {
        private enum enumMixinStr_ESPIPE = `enum ESPIPE = 29;`;
        static if(is(typeof({ mixin(enumMixinStr_ESPIPE); }))) {
            mixin(enumMixinStr_ESPIPE);
        }
    }




    static if(!is(typeof(ENOSPC))) {
        private enum enumMixinStr_ENOSPC = `enum ENOSPC = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOSPC); }))) {
            mixin(enumMixinStr_ENOSPC);
        }
    }




    static if(!is(typeof(EFBIG))) {
        private enum enumMixinStr_EFBIG = `enum EFBIG = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_EFBIG); }))) {
            mixin(enumMixinStr_EFBIG);
        }
    }




    static if(!is(typeof(ETXTBSY))) {
        private enum enumMixinStr_ETXTBSY = `enum ETXTBSY = 26;`;
        static if(is(typeof({ mixin(enumMixinStr_ETXTBSY); }))) {
            mixin(enumMixinStr_ETXTBSY);
        }
    }




    static if(!is(typeof(ENOTTY))) {
        private enum enumMixinStr_ENOTTY = `enum ENOTTY = 25;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTTY); }))) {
            mixin(enumMixinStr_ENOTTY);
        }
    }




    static if(!is(typeof(EMFILE))) {
        private enum enumMixinStr_EMFILE = `enum EMFILE = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_EMFILE); }))) {
            mixin(enumMixinStr_EMFILE);
        }
    }




    static if(!is(typeof(ENFILE))) {
        private enum enumMixinStr_ENFILE = `enum ENFILE = 23;`;
        static if(is(typeof({ mixin(enumMixinStr_ENFILE); }))) {
            mixin(enumMixinStr_ENFILE);
        }
    }




    static if(!is(typeof(EINVAL))) {
        private enum enumMixinStr_EINVAL = `enum EINVAL = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_EINVAL); }))) {
            mixin(enumMixinStr_EINVAL);
        }
    }




    static if(!is(typeof(EISDIR))) {
        private enum enumMixinStr_EISDIR = `enum EISDIR = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_EISDIR); }))) {
            mixin(enumMixinStr_EISDIR);
        }
    }




    static if(!is(typeof(ENOTDIR))) {
        private enum enumMixinStr_ENOTDIR = `enum ENOTDIR = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTDIR); }))) {
            mixin(enumMixinStr_ENOTDIR);
        }
    }




    static if(!is(typeof(L_SET))) {
        private enum enumMixinStr_L_SET = `enum L_SET = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_L_SET); }))) {
            mixin(enumMixinStr_L_SET);
        }
    }




    static if(!is(typeof(L_INCR))) {
        private enum enumMixinStr_L_INCR = `enum L_INCR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_L_INCR); }))) {
            mixin(enumMixinStr_L_INCR);
        }
    }




    static if(!is(typeof(L_XTND))) {
        private enum enumMixinStr_L_XTND = `enum L_XTND = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_L_XTND); }))) {
            mixin(enumMixinStr_L_XTND);
        }
    }




    static if(!is(typeof(ENODEV))) {
        private enum enumMixinStr_ENODEV = `enum ENODEV = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_ENODEV); }))) {
            mixin(enumMixinStr_ENODEV);
        }
    }




    static if(!is(typeof(EXDEV))) {
        private enum enumMixinStr_EXDEV = `enum EXDEV = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_EXDEV); }))) {
            mixin(enumMixinStr_EXDEV);
        }
    }




    static if(!is(typeof(EEXIST))) {
        private enum enumMixinStr_EEXIST = `enum EEXIST = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_EEXIST); }))) {
            mixin(enumMixinStr_EEXIST);
        }
    }




    static if(!is(typeof(EBUSY))) {
        private enum enumMixinStr_EBUSY = `enum EBUSY = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_EBUSY); }))) {
            mixin(enumMixinStr_EBUSY);
        }
    }




    static if(!is(typeof(ENOTBLK))) {
        private enum enumMixinStr_ENOTBLK = `enum ENOTBLK = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOTBLK); }))) {
            mixin(enumMixinStr_ENOTBLK);
        }
    }




    static if(!is(typeof(EFAULT))) {
        private enum enumMixinStr_EFAULT = `enum EFAULT = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_EFAULT); }))) {
            mixin(enumMixinStr_EFAULT);
        }
    }




    static if(!is(typeof(EACCES))) {
        private enum enumMixinStr_EACCES = `enum EACCES = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_EACCES); }))) {
            mixin(enumMixinStr_EACCES);
        }
    }




    static if(!is(typeof(ENOMEM))) {
        private enum enumMixinStr_ENOMEM = `enum ENOMEM = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOMEM); }))) {
            mixin(enumMixinStr_ENOMEM);
        }
    }




    static if(!is(typeof(EAGAIN))) {
        private enum enumMixinStr_EAGAIN = `enum EAGAIN = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_EAGAIN); }))) {
            mixin(enumMixinStr_EAGAIN);
        }
    }




    static if(!is(typeof(ECHILD))) {
        private enum enumMixinStr_ECHILD = `enum ECHILD = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_ECHILD); }))) {
            mixin(enumMixinStr_ECHILD);
        }
    }




    static if(!is(typeof(EBADF))) {
        private enum enumMixinStr_EBADF = `enum EBADF = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_EBADF); }))) {
            mixin(enumMixinStr_EBADF);
        }
    }




    static if(!is(typeof(ENOEXEC))) {
        private enum enumMixinStr_ENOEXEC = `enum ENOEXEC = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOEXEC); }))) {
            mixin(enumMixinStr_ENOEXEC);
        }
    }




    static if(!is(typeof(E2BIG))) {
        private enum enumMixinStr_E2BIG = `enum E2BIG = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_E2BIG); }))) {
            mixin(enumMixinStr_E2BIG);
        }
    }




    static if(!is(typeof(ENXIO))) {
        private enum enumMixinStr_ENXIO = `enum ENXIO = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_ENXIO); }))) {
            mixin(enumMixinStr_ENXIO);
        }
    }




    static if(!is(typeof(EIO))) {
        private enum enumMixinStr_EIO = `enum EIO = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_EIO); }))) {
            mixin(enumMixinStr_EIO);
        }
    }




    static if(!is(typeof(EINTR))) {
        private enum enumMixinStr_EINTR = `enum EINTR = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_EINTR); }))) {
            mixin(enumMixinStr_EINTR);
        }
    }




    static if(!is(typeof(ESRCH))) {
        private enum enumMixinStr_ESRCH = `enum ESRCH = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_ESRCH); }))) {
            mixin(enumMixinStr_ESRCH);
        }
    }




    static if(!is(typeof(ENOENT))) {
        private enum enumMixinStr_ENOENT = `enum ENOENT = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_ENOENT); }))) {
            mixin(enumMixinStr_ENOENT);
        }
    }




    static if(!is(typeof(EPERM))) {
        private enum enumMixinStr_EPERM = `enum EPERM = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_EPERM); }))) {
            mixin(enumMixinStr_EPERM);
        }
    }
    static if(!is(typeof(__GNUC_VA_LIST))) {
        private enum enumMixinStr___GNUC_VA_LIST = `enum __GNUC_VA_LIST = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___GNUC_VA_LIST); }))) {
            mixin(enumMixinStr___GNUC_VA_LIST);
        }
    }






    static if(!is(typeof(NULL))) {
        private enum enumMixinStr_NULL = `enum NULL = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_NULL); }))) {
            mixin(enumMixinStr_NULL);
        }
    }



}


struct iface;
struct __va_list_tag;
enum MAX_PAYLOAD = 1024;

struct nl_req {
    nlmsghdr n;
    ifinfomsg i;
    char[MAX_PAYLOAD] buf;
};

auto NLMSG_TAIL(T)(T nmsg)
{
 return (cast (rtattr *) ((cast(void *) (nmsg)) + ( ( ( (nmsg).nlmsg_len ) + 4U - 1 ) & ~ ( 4U - 1 ) )));
}

void addattr_l(nlmsghdr* n, int maxlen, ushort type, const void* data, ushort datalen)
{
 import std.exception : enforce;
 import std.format : format;

    ushort attr_len = ( ( ( ( ( rtattr ) .sizeof ) + 4U - 1 ) & ~ ( 4U - 1 ) ) + ( datalen ) );
    uint newlen = ( ( ( n.nlmsg_len ) + 4U - 1 ) & ~ ( 4U - 1 ) ) + ( ( ( attr_len ) + 4U - 1 ) & ~ ( 4U - 1 ) );
    enforce(newlen <= maxlen, format!"cannot add attribute. size (%d) exceeded maxlen (%d)\n"
            (newlen, maxlen));

    rtattr *rta;
    rta = NLMSG_TAIL(n);
    rta.rta_type = type;
    rta.rta_len = attr_len;
    if (datalen)
        memcpy(( cast( void * ) ( ( cast( char * ) ( rta ) ) + ( ( ( ( ( rtattr ) .sizeof ) + 4U - 1 ) & ~ ( 4U - 1 ) ) + ( 0 ) ) ) ), data, datalen);

    n.nlmsg_len = newlen;
}

rtattr* addattr_nest(nlmsghdr* n, int maxlen, ushort type)
{
    rtattr* nest = NLMSG_TAIL(n);

    addattr_l(n, maxlen, type, null, 0);
    return nest;
}

void addattr_nest_end(nlmsghdr *n, rtattr *nest)
{
    nest.rta_len = cast(void *)NLMSG_TAIL(n) - cast(void *)nest;
}


auto readResponse(int fd, msghdr* msg)
{
 import std.exception : enforce;
 import std.string : fromStringz;
    iovec *iov = msg.msg_iov;
    iov.iov_base = *response;
    iov.iov_len = MAX_PAYLOAD;

    ptrdiff_t resp_len = recvmsg(fd, msg, 0);
/+
    enforce(resp_len != 0, "EOF on netlink");
 enforce(resp_len > 0, format!"netlink receive error: %s(%s)"(strerr(( * __errno_location ( ) ))fromStringz,( * __errno_location ( ) )));
+/
    return resp_len;
}

void checkResponse(int sock_fd)
{
 import std.exception : enforce;
 import std.string : fromStringz;
 import std.exception : enforce;
 import std.format : format;
 import core.stdc.stdlib : free, malloc;

    iovec iov;
    msghdr msg = {
            msg_name : null,
            msg_namelen : 0,
            msg_iov : &iov,
            msg_iovlen : 1,
    };
    void* resp = malloc(MAX_PAYLOAD);

    ssize_t resp_len = readResponse(sock_fd, &msg, cast(char*) &resp);

    nlmsghdr *hdr = cast (nlmsghdr*) resp;
    int nlmsglen = hdr.nlmsg_len;
    int datalen = nlmsglen - sizeof(*hdr);


    if (datalen < 0 || nlmsglen > resp_len) {
        enforce(!(msg.msg_flags & MSG_TRUNC),"received truncated message");
        enforce(false,format!"malformed message: nlmsg_len=%d"(nlmsglen));
    }


    if (hdr.nlmsg_type == 0x2) {
        nlmsgerr *err = cast(nlmsgerr*) ( cast( void * ) ( ( cast( char * ) hdr ) + ( ( 0 ) + ( cast( int ) ( ( ( ( nlmsghdr ) .sizeof ) + 4U - 1 ) & ~ ( 4U - 1 ) ) ) ) ) );

        if (datalen < nlmsgerr.sizeof)
            fprintf(stderr, "ERROR truncated!\n");

        if(err.error) {
            ( * __errno_location ( ) ) = -err.error;
            enforce(false,format!"RTNETLINK: %s"(strerr(( * __errno_location ( ) )),( * __errno_location ( ) )));
        }
    }

    free(resp);
}

/+
int createSocket(int domain, int type, int protocol)
{
 import std.string : fromStringz;
 import std.exception : enforce;

    int sock_fd = socket(domain, type, protocol);
    enforce(sock_fd >= 0, format!"cannot open socket: %s(%s)"(strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));

    return sock_fd;
}

void send_nlmsg(int sock_fd, nlmsghdr* n)
{
 import std.string : fromStringz;
 import std.exception : enforce;

    iovec iov = {
            iov_base = n,
            iov_len = n.nlmsg_len
    };

    msghdr msg = {
            msg_name = null,
            msg_namelen = 0,
            msg_iov = &iov,
            msg_iovlen = 1
    };

    n.nlmsg_seq++;

    ssize_t status = sendmsg(sock_fd, &msg, 0);
    enforce(status >= 0, format!"cannot talk to rtnetlink: %s(%s)"(strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));

    check_response(sock_fd);
}

int get_netns_fd(int pid)
{
 import std.string : fromStringz;
 import std.exception : enforce;

    char[256] path;
    sprintf(path, "/proc/%d/ns/net", pid);

    int fd = open(path, 0);

    enforce(fd >= 0, format!"cannot read netns file %s: %s(%s)"(path,strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));

    return fd;
}

void ifUp(string interfaceName, string ip, string netMask)
{
 import std.string : fromStringz;
 import std.exception : enforce;

    int sock_fd = createSocket(2, SOCK_DGRAM, IPPROTO_IP);

    ifreq ifr;
    memset(&ifr, 0, ifreq.sizeof);
    strncpy(ifr.ifr_ifrn . ifrn_name, interfaceName.toStringz, interfaceName.length);

    sockaddr_in saddr;
    memset(&saddr, 0, sockaddr_in.sizeof);
    saddr.sin_family = 2;
    saddr.sin_port = 0;

    char *p = cast (char *) &saddr;

    saddr.sin_addr.s_addr = inet_addr(ip.toStringz);
    memcpy((cast(char *)&(ifr.ifr_ifru . ifru_addr)), p, sockaddr.sizeof);
    enforce(!ioctl(sock_fd, SIOCSIFADDR, &ifr),
        format!"cannot set ip addr %s, %s: %s"(ifname, ip,strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));

    saddr.sin_addr.s_addr = inet_addr(netmask);
    memcpy((cast(char *)&(ifr.ifr_ifru . ifru_addr)), p, sockaddr.sizeof);
    enforce(!ioctl(sock_fd, SIOCSIFNETMASK, &ifr),
        format!"cannot set netmask for addr %s, %s: %s(%s)"(ifname, netmask,strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));

    ifr.ifr_ifru . ifru_flags |= IFF_UP | IFF_BROADCAST | IFF_RUNNING | IFF_MULTICAST;
    enforce(!ioctl(sock_fd, SIOCSIFFLAGS, &ifr),
        format!"cannot set flags for addr %s, %s: %s(%s)"(ifname, ip,strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));

    close(sock_fd);
}



void createVeth(int sock_fd, string interfaceName, string peerName)
{
    ushort flags =
            0x01
            | 0x400
            | 0x200
            | 0x04;

 nlmsg_hdr n = {

   nlmsg_len : ( ifinfomsg.sizeof + (cast(int) ( ( nlmsghdr.sizeof + 4U - 1 ) & ~ ( 4U - 1 ) ) ) ),
   nlmsg_flags : flags,
            nlmsg_type : RTM_NEWLINK,
 };

 ifinfomsg i = {
  ifi_family : 16,
 };


    nl_req req = {
   n : n,
            i : i,
    };

    nlmsghdr* n = &req.n;
    int maxlen = req.sizeof;
    addattr_l(n, maxlen, IFLA_IFNAME, interfaceName.toStringz, interfaceName.length + 1);


    rtattr *linfo = addattr_nest(n, maxlen, IFLA_LINKINFO);

    addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, "veth", 5);


    rtattr *linfodata = addattr_nest(n, maxlen, IFLA_INFO_DATA);


    rtattr *peerinfo = addattr_nest(n, maxlen, VETH_INFO_PEER);
    n.nlmsg_len += ifinfomsg.sizeof;
    addattr_l(n, maxlen, IFLA_IFNAME, peerName.toStringz, peername.toStringz + 1);
    addattr_nest_end(n, peerinfo);

    addattr_nest_end(n, linfodata);
    addattr_nest_end(n, linfo);


    send_nlmsg(sock_fd, n);
}


void moveInterfaceToPidNetNS(int sock_fd, string interfaceName, int netns)
{
 nlmsg_hdf n = {
            nlmsg_len : ( ( ifinfomsg.sizeof ) + ( cast( int ) ( ( ( ( nlmsghdr ) .sizeof ) + 4U - 1 ) & ~ ( 4U - 1 ) ) ) ),
            nlmsg_flags : 0x01 | 0x04,
            nlmsg_type : RTM_NEWLINK,
    };

 ifinfomsg i = {
            ifi_family : 16,
    };

    nl_req req = {
            n : n,
   i : i,
    };

    addattr_l(&req.n, req.sizeof, IFLA_NET_NS_FD, &netns, 4);
    addattr_l(&req.n, req.sizeof, IFLA_IFNAME, interfaceName.toStringz, interfaceName.length+1);
    send_nlmsg(sock_fd, &req.n);
}

void prepareNetNS(int childPID)
{
    string veth = "veth0";
    string vpeer = "veth1";
    string veth_addr = "10.1.1.1";
    string vpeer_addr = "10.1.1.2";
    string netmask = "255.255.255.0";


    int sock_fd = createSocket( 16, SOCK_RAW | SOCK_CLOEXEC, 0);


    createVeth(sock_fd, veth, vpeer);



    ifUp(veth, veth_addr, netmask);






    int mynetns = get_netns_fd(getpid());
    int child_netns = get_netns_fd(childPID);


    move_if_to_pid_netns(sock_fd, vpeer, child_netns);


    enforce(!setns(child_netns, CLONE_NEWNET),format!"cannot setns for child at pid %d: %s(%s)"(childPID,strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));
    }


    ifUp(vpeer, vpeer_addr, netmask);


  enforce(!setns(mynetns, CLONE_NEWNET),format!"cannot restore previous netns: %s"(strerr(( * __errno_location ( ) )).fromStringz,( * __errno_location ( ) )));
    }

    close(sock_fd);
}
+/
