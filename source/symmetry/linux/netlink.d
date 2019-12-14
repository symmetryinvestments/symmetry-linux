module symmetry.linux.netlink;
import symmetry.sildoc;
version(None):

version(Posix):

extern(C) @nogc nothrow int setns(int fd, int nstype);
					 
import symmetry.linux.process : CloneFlag, posixCloneFlags;
import symmetry.linux.file : fdopen;
import symmetry.linux.cgroups: ChildConfig;
import symmetry.linux.mount : fnMount, unmount;
import core.sys.linux.mount : MountType, UmountFlag;

private auto system(string s)
{
	import std.process: executeShell;
	return executeShell("sudo " ~ s);
}

int createSocket(int domain, int type, int protocol)
{
	int sockFD = socket(domain,type,protocol);
	enforce(sockFD >=0, "cannot open socket");
	return sockFD;
}



void setNamespace(string path, CloneFlag[] cloneFlags)
{
	import core.sys.posix.fcntl: O_RDONLY;
	if (path.length ==0)
		return;
	auto flags = posixCloneFlags(cloneFlags);
	setNamespace_(path,flags);
}

version(Posix)
void setNamespace_(string path, int flags)
{
	import core.sys.posix.fcntl: O_RDONLY;
	if (path.length ==0)
		return;
	auto fd = fdopen(path, O_RDONLY);
	setns(fd,flags);
}

void createNetworkNamespace(string name)
{
	import std.format : format;
	import std.exception : enforce;
	auto ret = system(format!"ip netns del %s"(name));
	//enforce(ret.status ==0, ret.output);
	ret = system(format!"ip netns add %s"(name));
	enforce(ret.status ==0, ret.output);
}

void createVethPair(string name, string peerName)
{
	import std.format : format;
	import std.exception : enforce;
	auto ret = system(format!"ip link add %s type veth peer name %s"(name, peerName));
	enforce(ret.status ==0, ret.output);
}

void addVethPairToNamespace(string peerName, string namespace)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip link set %s netns %s"(peerName, namespace));
	enforce(ret.status ==0, ret.output);
}

void addAddressesIP4(string addresses, string deviceName)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip addr add %s dev %s"(addresses,deviceName));
	enforce(ret.status ==0, ret.output);
}

void addAddressesIP4Peer(string nameSpace, string addresses, string deviceName)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip netns exec %s ip addr add %s dev %s"(nameSpace,addresses,deviceName));
	enforce(ret.status ==0, ret.output);
}

void setLinkUpPeer(string nameSpace, string deviceName)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip netns exec %s ip link set %s up"(nameSpace, deviceName));
	enforce(ret.status ==0, ret.output);
	ret = system("dhcpcd");
	enforce(ret.status ==0, ret.output);
}

void setLinkUp(string deviceName)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip link set %s up"(deviceName));
	enforce(ret.status ==0, ret.output);
}

void addDefaultRoutePeer(string nameSpace, string defaultGateway)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip netns exec %s ip route add default via %s"(nameSpace,defaultGateway));
	enforce(ret.status ==0, ret.output);
}

void setHostForwarding(string hostDeviceName, string clientDeviceName, string address)
{
	import std.exception : enforce;
	import std.file : write;
	import std.format : format;
	// Share internet access between host and NS.

	// Enable IP-forwarding.
	write("/proc/sys/net/ipv4/ip_forward","1\n");

	// Flush forward rules, policy DROP by default.
	auto ret = system("iptables -P FORWARD DROP");
	enforce(ret.status ==0, ret.output);
	ret = system("iptables -F FORWARD");
	enforce(ret.status ==0, ret.output);

	// Flush nat rules.
	ret = system("iptables -t nat -F");
	enforce(ret.status ==0, ret.output);

	// Enable masquerading of 10.200.1.0.
	ret = system(format!"iptables -t nat -A POSTROUTING -s %s/255.255.255.0 -o %s -j MASQUERADE"(address,hostDeviceName));
	enforce(ret.status ==0, ret.output);

	// Allow forwarding between eth0 and v-eth1.
	ret = system(format!"iptables -A FORWARD -i %s -o %s -j ACCEPT"(hostDeviceName, clientDeviceName));
	enforce(ret.status ==0, ret.output);
	ret = system(format!"iptables -A FORWARD -o %s -i %s -j ACCEPT"(hostDeviceName,clientDeviceName)); 
	enforce(ret.status ==0, ret.output);
}


void containNetwork(string namespace, string hostDeviceName, string deviceName, string peerName, string addresses = "10.200.1.1/24")
{
	import std.exception : enforce;
	import std.format : format;
	import std.string : lastIndexOf;

	createNetworkNamespace(namespace);
	createVethPair(deviceName,peerName);
	addVethPairToNamespace(peerName,namespace);
	addAddressesIP4(addresses,deviceName);
	setLinkUp(deviceName);
	addAddressesIP4Peer(namespace,addresses,peerName);
	setLinkUpPeer(namespace,peerName);
	setLinkUpPeer(namespace,"lo");
	addDefaultRoutePeer(namespace,"10.200.1.1");
	auto address = addresses[0..addresses.lastIndexOf(".")] ~ ".0";
	setHostForwarding(hostDeviceName, deviceName, address);
}
void mounts(ChildConfig config)
{
	import std.exception : enforce;
	import std.file : tempDir, rmdir,chdir;
	import std.path : baseName;
	import std.format : format;
	import std.stdio: stderr, writeln, writefln;

	stderr.writeln("=> remounting everyting with MS_PRIVATE...");
	fnMount(null,"/",null, [MountType.rec, MountType.private_], null);
	stderr.writeln("=> making a temp directory and a bind mount there...");
	auto mountDir = tempDir();
	enforce(mountDir != ".", "failed making a temp directory");
	fnMount(config.mountDir,mountDir,null,[MountType.bind, MountType.private_], null);
	auto innerMountDir = format!"%s/oldroot"(mountDir);
	stderr.writeln("done");
	stderr.writeln("=> pivoting root");
	auto oldRootDir = format!"%s/"(innerMountDir.baseName());
	auto oldRoot = oldRootDir;
	chdir("/");
	unmount(oldRoot,[UmountFlag.detach]);
	rmdir(oldRoot);
	stderr.writefln("done");
}


void teardownChroot(ChildConfig childConfig)
{
	import std.format : format;
	foreach(m;	[	"proc", "sys", "sys/firmware/efi/efivars", "dev/pts", "dev/shm", "dev", "run", "tmp"])
	{
		unmount(format!"%s/%s"(childConfig.mountDir,m));
	}
}

void setupChroot(ChildConfig childConfig)
{
	import std.format : format;
	fnMount("proc",format!"%s/proc"(childConfig.mountDir), "proc",[MountType.noSUID,MountType.noExec, MountType.noDev]);
	fnMount("sys",format!"%s/sys"(childConfig.mountDir), "sysfs",[MountType.noSUID,MountType.noExec, MountType.noDev,MountType.readOnly]);
	try
	{
		fnMount("efivars",format!"%s/sys/firmware/efi/efivars"(childConfig.mountDir), "efivars",[MountType.noSUID,MountType.noExec, MountType.noDev]);
	}
	catch(Exception e)
	{
	}

	fnMount("udev",format!"%s/dev"(childConfig.mountDir), "devtmpfs",[MountType.noSUID],"mode=0755");
	fnMount("devpts",format!"%s/dev/pts"(childConfig.mountDir), "devpts",[MountType.noSUID,MountType.noExec],"mode=0620,gid=5");
	fnMount("shm",format!"%s/dev/shm"(childConfig.mountDir), "tmpfs",[MountType.noSUID,MountType.noDev],"mode=1777");
	fnMount("/run",format!"%s/run"(childConfig.mountDir), "--bind",[]);
	fnMount("tmp",format!"%s/tmp"(childConfig.mountDir), "tmpfs",[MountType.strictAccessTime,MountType.noDev,MountType.noSUID],"mode=1777");
}
