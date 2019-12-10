module symmetry.linux.capabilities;
import core.sys.posix.sys.capabilities;
import core.sys.linux.sys.capability;
import symmetry.sildoc;

version(Posix):


enum LinuxCapability
{

	@SILdoc("Enable and disable kernel auditing; change auditing filter rules; retrieve auditing status and filtering rules")
	auditControl = CAP_AUDIT_CONTROL,

	@SILdoc("Read records from kernel auditing log")
	auditRead = CAP_AUDIT_READ,

	@SILdoc("Write records to kernel auditing log")
	auditWrite = CAP_AUDIT_WRITE,

	@SILdoc("Employ features that can block system suspend (epoll(7) EPOLLWAKEUP, /proc/sys/wake_lock)")
	blockSuspend = CAP_BLOCK_SUSPEND,

	@SILdoc("Make arbitrary changes to file UIDs and GIDs (see chown(2))")
	chown = CAP_CHOWN,

	@SILdoc("Bypass file read, write, and execute permission checks")
	discretionaryAccessControlOverride = CAP_DAC_OVERRIDE,

	@SILdoc("Bypass file read permission checks and directory read and execute permission checks")
	discretionaryAccessControlReadSearch = CAP_DAC_READ_SEARCH,

	@SILdoc("Bypass permission checks on operations that normally require the file system UID of the process to match the UID of the file (e.g., chmod(2), utime(2)), excluding those operations covered by CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH:

			- set extended file attributes (see chattr(1)) on arbitrary files;
			- set Access Control Lists (ACLs) on arbitrary files;
			- ignore directory sticky bit on file deletion;
			- specify O_NOATIME for arbitrary files in open(2) and fcntl(2)")
	fOwner = CAP_FOWNER,

	@SILdoc("Don't clear set-user-ID and set-group-ID permission bits when a file is modified; set the set-group-ID bit for a file whose GID does not match the file system or any of the supplementary GIDs of the calling process")
	fSetID = CAP_FSETID,

	@SILdoc("Lock memory (mlock(2), mlockall(2), mmap(2), shmctl(2))")
	ipcLock = CAP_IPC_LOCK,

	@SILdoc("Bypass permission checks for operations on System V IPC objects")
	ipcOwner = CAP_IPC_OWNER,

	@SILdoc("Bypass permission checks for sending signals (see kill(2)). This includes use of the ioctl(2) KDSIGACCEPT operation")
	kill = CAP_KILL,

	@SILdoc("Establish leases on arbitrary files (see fcntl(2))")
	lease = CAP_LEASE,

    	@SILdoc("Set the FS_APPEND_FL and FS_IMMUTABLE_FL i-node flags (see chattr(1)).")
    	linuxImmutable = CAP_LINUX_IMMUTABLE,
    
    	@SILdoc("Override Mandatory Access Control (MAC). Implemented for the Smack Linux Security Module (LSM)")
    	macAdmin = CAP_MAC_ADMIN,
    
    	@SILdoc("Allow MAC configuration or state changes. Implemented for the Smack LSM.")
    	macOverride = CAP_MAC_OVERRIDE,
    
    	@SILdoc("Create special files using mknod(2)")
    	mknod = CAP_MKNOD,
    
    	@SILdoc("Perform various network-related operations:
    			- interface configuration;
    			- administration of IP firewall, masquerading, and accounting
    			- modify routing tables;
    			- bind to any address for transparent proxying;
    			- set type-of-service (TOS)
    			- clear driver statistics;
    			- set promiscuous mode;
    			- enabling multicasting;
    			- use setsockopt(2) to set the following socket options: SO_DEBUG, SO_MARK, SO_PRIORITY (for a priority outside the range 0 to 6), SO_RCVBUFFORCE, and SO_SNDBUFFORCE")
    	netAdmin = CAP_NET_ADMIN,
    
    	@SILdoc("Bind a socket to Internet domain privileged ports (port numbers less than 1024)")
    	netBindService = CAP_NET_BIND_SERVICE,
    
    	@SILdoc("(Unused) Make socket broadcasts, and listen to multicasts")
    	netBroadcast = CAP_NET_BROADCAST,
    
    	@SILdoc("use RAW and PACKET sockets; bind to any address for transparent proxying")
    	netRaw = CAP_NET_RAW,
    
    	@SILdoc("Make arbitrary manipulations of process GIDs and supplementary GID list; forge GID when passing socket credentials via UNIX domain sockets")
    	setGID = CAP_SETGID,
    
    	@SILdoc("Set file capabilities")
    	setFileCapabilities = CAP_SETFCAP,
    
    	@SILdoc("If file capabilities are not supported: grant or remove any capability in the caller's permitted capability set to or from any other process. (This property of CAP_SETPCAP is not available when the kernel is configured to support file capabilities, since CAP_SETPCAP has entirely different semantics for such kernels.)
    			If file capabilities are supported: add any capability from the calling thread's bounding set to its inheritable set; drop capabilities from the bounding set (via prctl(2) PR_CAPBSET_DROP); make changes to the securebits flags")
    	capSetProcessCapabilities = CAP_SETPCAP,
    
    	@SILdoc("Make arbitrary manipulations of process UIDs (setuid(2), setreuid(2), setresuid(2), setfsuid(2)); make forged UID when passing socket credentials via UNIX domain sockets")
    	setUID = CAP_SETUID,
    
    	@SILdoc("Perform a range of system administration operations including: quotactl(2), mount(2), umount(2), swapon(2), swapoff(2), sethostname(2), and setdomainname(2):
    			- perform privileged syslog(2) operations (since Linux 2.6.37, CAP_SYSLOG should be used to permit such operations);
    			- perform VM86_REQUEST_IRQ vm86(2) command;
    			- perform IPC_SET and IPC_RMID operations on arbitrary System V IPC objects;
    			- perform operations on trusted and security Extended Attributes (see attr(5));
    			- use lookup_dcookie(2);
    			- use ioprio_set(2) to assign IOPRIO_CLASS_RT and (before Linux 2.6.25) IOPRIO_CLASS_IDLE I/O scheduling classes;
    			- forge UID when passing socket credentials;
    			- exceed /proc/sys/fs/file-max, the system-wide limit on the number of open files, in system calls that open files (e.g., accept(2), execve(2), open(2), pipe(2));
    			- employ CLONE_* flags that create new namespaces with clone(2) and unshare(2);
    			- call perf_event_open(2);
    			- access privileged perf event information;
    			- call setns(2);
    			- call fanotify_init(2);
    			- perform KEYCTL_CHOWN and KEYCTL_SETPERM keyctl(2) operations;
    			- perform madvise(2) MADV_HWPOISON operation;
    			- employ the TIOCSTI ioctl(2) to insert characters into the input queue of a terminal other than the caller's controlling terminal.
    			- employ the obsolete nfsservctl(2) system call;
    			- employ the obsolete bdflush(2) system call;
    			- perform various privileged block-device ioctl(2) operations;
    			- perform various privileged file-system ioctl(2) operations;
    			- perform administrative operations on many device drivers.")
    	sysAdmin = CAP_SYS_ADMIN,
    
    	@SILdoc("Use reboot(2) and kexec_load(2)")
    	sysBoot = CAP_SYS_BOOT,
    
    	@SILdoc("Use chroot(2)")
    	chroot = CAP_SYS_CHROOT,
    
    	@SILdoc("Load and unload kernel modules (see init_module(2) and delete_module(2)); in kernels before 2.6.25: drop capabilities from the system-wide capability bounding set")
    	sysModule = CAP_SYS_MODULE,
    
    	@SILdoc("Raise process nice value (nice(2), setpriority(2)) and change the nice value for arbitrary processes;
    			- set real-time scheduling policies for calling process, and set scheduling policies and priorities for arbitrary processes (sched_setscheduler(2), sched_setparam(2));
    			- set CPU affinity for arbitrary processes (sched_setaffinity(2));
    			- set I/O scheduling class and priority for arbitrary processes (ioprio_set(2));
    			- apply migrate_pages(2) to arbitrary processes and allow processes to be migrated to arbitrary nodes;
    			- apply move_pages(2) to arbitrary processes;
    			- use the MPOL_MF_MOVE_ALL flag with mbind(2) and move_pages(2).")
    	sysNice = CAP_SYS_NICE,
    
    	@SILdoc("Use Acct")
    	sysProcessAccount = CAP_SYS_PACCT,
    
    	@SILdoc("Trace arbitrary processes using ptrace(2); apply get_robust_list(2) to arbitrary processes; inspect processes using kcmp(2).")
    	ptrace = CAP_SYS_PTRACE,
    
    	@SILdoc("Perform I/O port operations (iopl(2) and ioperm(2));
    			- access /proc/kcore;
    			- employ the FIBMAP ioctl(2) operation;
    			- open devices for accessing x86 model-specific registers (MSRs, see msr(4))
    			- update /proc/sys/vm/mmap_min_addr;
    			- create memory mappings at addresses below the value specified by /proc/sys/vm/mmap_min_addr;
    			- map files in /proc/pci/bus;
    			- open /dev/mem and /dev/kmem;
    			- perform various SCSI device commands;
    			- perform certain operations on hpsa(4) and cciss(4) devices;
    			- perform a range of device-specific operations on other devices.")
    
    	sysRawIO = CAP_SYS_RAWIO,
    
    	@SILdoc("Use reserved space on ext2 file systems;
    			- make ioctl(2) calls controlling ext3 journaling;
    			- override disk quota limits;
    			- increase resource limits (see setrlimit(2));
    			- override RLIMIT_NPROC resource limit;
    			- override maximum number of consoles on console allocation;
    			- override maximum number of keymaps;
    			- allow more than 64hz interrupts from the real-time clock;
    			- raise msg_qbytes limit for a System V message queue above the limit in /proc/sys/kernel/msgmnb (see msgop(2) and msgctl(2));
    			- override the /proc/sys/fs/pipe-size-max limit when setting the capacity of a pipe using the F_SETPIPE_SZ fcntl(2) command.
    			- use F_SETPIPE_SZ to increase the capacity of a pipe above the limit specified by /proc/sys/fs/pipe-max-size;
    			- override /proc/sys/fs/mqueue/queues_max limit when creating POSIX message queues (see mq_overview(7));
    			- employ prctl(2) PR_SET_MM operation; set
    				/proc/PID/oom_score_adj to a value lower than the value last set by a process with CAP_SYS_RESOURCE.")
    	sysResource = CAP_SYS_RESOURCE,
    
    	@SILdoc("Set system clock (settimeofday(2), stime(2), adjtimex(2)); set real-time (hardware) clock.")
    	sysTime = CAP_SYS_TIME,
    
    	@SILdoc("Use vhangup(2); employ various privileged ioctl(2) operations on virtual terminals")
    	sysTTYConfig = CAP_SYS_TTY_CONFIG,
    
    	@SILdoc("Perform privileged syslog(2) operations. See syslog(2) for information on which operations require privilege.
    			View kernel addresses exposed via /proc and other interfaces when /proc/sys/kernel/kptr_restrict has the value 1. (See the discussion of the kptr_restrict in proc(5).)")
    	sysLog = CAP_SYSLOG,
    
    	@SILdoc("Trigger something that will wake up the system (set CLOCK_REALTIME_ALARM and CLOCK_BOOTTIME_ALARM timers).")
    	wakeAlarm = CAP_WAKE_ALARM,
}
