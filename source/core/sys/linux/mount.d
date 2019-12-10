module core.sys.linux.mount;
import std.conv : hexString;

/* Header file for mounting/unmount Linux filesystems.
   Copyright (C) 1996-2019 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

/* This is taken from /usr/include/linux/fs.h.  */

//import core.sys.linux.ioctl;
//import core.sys.linux.features;

enum BLOCK_SIZE	= 1024;
enum BLOCK_SIZE_BITS = 10;


/* These are the fs-independent mount-flags: up to 16 flags are
   supported  */
enum
{
  MS_RDONLY = 1,		/* Mount read-only.  */
  MS_NOSUID = 2,		/* Ignore suid and sgid bits.  */
  MS_NODEV = 4,			/* Disallow access to device special files.  */
  MS_NOEXEC = 8,		/* Disallow program execution.  */
  MS_SYNCHRONOUS = 16,		/* Writes are synced at once.  */
  MS_REMOUNT = 32,		/* Alter flags of a mounted FS.  */
  MS_MANDLOCK = 64,		/* Allow mandatory locks on an FS.  */
  MS_DIRSYNC = 128,		/* Directory modifications are synchronous.  */
  MS_NOATIME = 1024,		/* Do not update access times.  */
  MS_NODIRATIME = 2048,		/* Do not update directory access times.  */
  MS_BIND = 4096,		/* Bind directory at different place.  */
  MS_MOVE = 8192,
  MS_REC = 16384,
  MS_SILENT = 32768,
  MS_POSIXACL = 1 << 16,	/* VFS does not apply the umask.  */
  MS_UNBINDABLE = 1 << 17,	/* Change to unbindable.  */
  MS_PRIVATE = 1 << 18,		/* Change to private.  */
  MS_SLAVE = 1 << 19,		/* Change to slave.  */
  MS_SHARED = 1 << 20,		/* Change to shared.  */
  MS_RELATIME = 1 << 21,	/* Update atime relative to mtime/ctime.  */
  MS_KERNMOUNT = 1 << 22,	/* This is a kern_mount call.  */
  MS_I_VERSION =  1 << 23,	/* Update inode I_version field.  */
  MS_STRICTATIME = 1 << 24,	/* Always perform atime updates.  */
  MS_LAZYTIME = 1 << 25,	/* Update the on-disk [acm]times lazily.  */
  MS_ACTIVE = 1 << 30,
  MS_NOUSER = 1 << 31
}

enum MountType
{
	@SILdoc("Mount read-only")
	readOnly = MS_RDONLY,

	@SILdoc("Ignore suid and sgid bits")
	noSUID = MS_NOSUID,

	@SILdoc("Disallow access to device special files")
	noDev = MS_NODEV,

	@SILdoc("Disallow program execution")
	noExec = MS_NOEXEC,

	@SILdoc("Writes are synced at once")
	synchronous = MS_SYNCHRONOUS,

	@SILdoc("Alter flags of a mounted filesystem")
	remount = MS_REMOUNT,

	@SILdoc("Allow mandatory locks on a file system")
	mandatoryLock = MS_MANDLOCK, 

	@SILdoc("Directory modifications are synchronous")
	dirSync = MS_DIRSYNC,

	@SILdoc("Do not update acccess times")
	noAccessTime = MS_NOATIME,

	@SILdoc("Do not update directory access times")
	noDirectoryAccessTime = MS_NODIRATIME,

	@SILdoc("Bind directory at different place")
	bind = MS_BIND,

	@SILdoc("Move")
	move = MS_MOVE,

	@SILdoc("Rec")
	rec = MS_REC,

	@SILdoc("Silent")
	silent = MS_SILENT,

	@SILdoc("posixACL; VFS does not apply the umask")
	posixACL = MS_POSIXACL,

	@SILdoc("Change to unbindable")
	unbindable = MS_UNBINDABLE,

	@SILdoc("Change to private")
	private_ = MS_PRIVATE,

	@SILdoc("Change to slave")
	slave = MS_SLAVE,

	@SILdoc("Change to shared")
	shared_ = MS_SHARED,

	@SILdoc("Update atime relative to mtime/ctime")
	relAccessTime = MS_RELATIME,

	@SILdoc("This is a kern_mount call")
	kernelMount = MS_KERNMOUNT,

	@SILdoc("Update inode I_version field")
	iVersion = MS_I_VERSION,

	@SILdoc("Always perform atime updates")
	strictAccessTime = MS_STRICTATIME,

	@SILdoc("Update the on-disk [acm]times lazily")
	lazyTime = MS_LAZYTIME,

	@SILdoc("Active")
	active = MS_ACTIVE,

	@SILdoc("No User")
	noUser = MS_NOUSER,
}


/* Flags that can be altered by MS_REMOUNT  */
enum MS_RMT_MASK = (MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION |MS_LAZYTIME);


/* Magic mount flag number. Has to be or-ed to the flag values.  */

enum MS_MGC_VAL = hexString!"c0ed0000";	/* Magic flag number to indicate "new" flags */
enum MS_MGC_MSK = hexString!"ffff0000";	/* Magic flag number mask */


/+
FIXME - TODO
/* The read-only stuff doesn't really belong here, but any other place
   is probably as bad and I don't want to create yet another include
   file.  */

#define BLKROSET   _IO(0x12, 93) /* Set device read-only (0 = read-write).  */
#define BLKROGET   _IO(0x12, 94) /* Get read-only status (0 = read_write).  */
#define BLKRRPART  _IO(0x12, 95) /* Re-read partition table.  */
#define BLKGETSIZE _IO(0x12, 96) /* Return device size.  */
#define BLKFLSBUF  _IO(0x12, 97) /* Flush buffer cache.  */
#define BLKRASET   _IO(0x12, 98) /* Set read ahead for block device.  */
#define BLKRAGET   _IO(0x12, 99) /* Get current read ahead setting.  */
#define BLKFRASET  _IO(0x12,100) /* Set filesystem read-ahead.  */
#define BLKFRAGET  _IO(0x12,101) /* Get filesystem read-ahead.  */
#define BLKSECTSET _IO(0x12,102) /* Set max sectors per request.  */
#define BLKSECTGET _IO(0x12,103) /* Get max sectors per request.  */
#define BLKSSZGET  _IO(0x12,104) /* Get block device sector size.  */
#define BLKBSZGET  _IOR(0x12,112,size_t)
#define BLKBSZSET  _IOW(0x12,113,size_t)
#define BLKGETSIZE64 _IOR(0x12,114,size_t) /* return device size.  */

+/

/* Possible value for FLAGS parameter of `umount2'.  */
enum 
{
	MNT_FORCE = 1,		/* Force unmounting.  */
	MNT_DETACH = 2,		/* Just detach from the tree.  */
	MNT_EXPIRE = 4,		/* Mark for expiry.  */
	UMOUNT_NOFOLLOW = 8		/* Don't follow symlink on umount.  */
}

enum UmountFlag
{
	@SILdoc("Force unmounting")
	force = MNT_FORCE,

	@SILdoc("Just detach from the tree")
	detach = MNT_DETACH,

	@SILdoc("Mark for expiry")
	expire = MNT_EXPIRE,

	@SILdoc("Don't follow symlink on umount")
	noFollow = UMOUNT_NOFOLLOW,
}


extern(C) nothrow @nogc
{
	/* Mount a filesystem.  */
	int mount (const (char)* __special_file, const(char)* __dir, const(char)* __fstype, ulong __rwflag,
		  const(void) *__data);

	/* Unmount a filesystem.  */
	int umount(const(char)* __special_file);

	/* Unmount a filesystem.  Force unmounting if FLAGS is set to MNT_FORCE.  */
	int umount2(const(char)* __special_file, int __flags);
}

