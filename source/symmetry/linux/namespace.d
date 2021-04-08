module symmetry.linux.namespace;
import symmetry.sildoc;

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
	deleteNetworkNamespace(name);
	auto ret = system(format!"ip netns add %s"(name));
	enforce(ret.status ==0, ret.output);
}

void deleteNetworkNamespace(string name)
{
	import std.format : format;
	import std.exception : enforce;
	auto ret = system(format!"ip netns del %s"(name));
}

void createVethPair(string name, string peerName)
{
	import std.format : format;
	import std.exception : enforce;
	auto ret = system(format!"ip link add %s type veth peer name %s"(name, peerName));
	enforce(ret.status ==0, ret.output);
}

void deleteVethPair(string name)
{
	import std.format : format;
	import std.exception : enforce;
	auto ret = system(format!"ip link delete %s"(name));
}

void addVethPairToNamespace(string peerName, string namespace)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip link set %s netns %s"(peerName, namespace));
	enforce(ret.status ==0, ret.output);
}

void addAddressesIP4(string addresses, string deviceName, string namespace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (namespace.length > 0) ? "-n " ~ namespace ~ " ": "";
	auto ret = system(format!"ip %saddr add %s dev %s"(ns,addresses,deviceName));
	enforce(ret.status ==0, ret.output);
}

void addAddressesIP4Peer(string nameSpace, string addresses, string deviceName)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip netns exec %s ip addr add %s dev %s"(nameSpace,addresses,deviceName));
	enforce(ret.status ==0, ret.output);
}

// return addresses in JSON format
string showAddresses(string nameSpace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (nameSpace.length > 0) ? "-n " ~ nameSpace ~ " ": "";
	auto ret = system(format!"ip -j %saddr show"(ns));
	enforce(ret.status ==0, ret.output);
	return ret.output;
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

void setLinkUp(string deviceName, string nameSpace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (nameSpace.length > 0) ? "-n " ~ nameSpace ~ " ": "";
	auto ret = system(format!"ip %slink set %s up"(ns,deviceName));
	enforce(ret.status ==0, ret.output);
}

// return link info in JSON format
string showLink(string nameSpace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (nameSpace.length > 0) ? "-n " ~ nameSpace ~ " ": "";
	auto ret = system(format!"ip -j %slink show"(ns));
	enforce(ret.status ==0, ret.output);
	return ret.output;
}

// return route info in JSON format
string showRoute(string nameSpace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (nameSpace.length > 0) ? "-n " ~ nameSpace ~ " ": "";
	auto ret = system(format!"ip -j %sroute show"(ns));
	enforce(ret.status ==0, ret.output);
	return ret.output;
}

// return route get info in JSON format
string getRoute(string destinationIP, string nameSpace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (nameSpace.length > 0) ? "-n " ~ nameSpace ~ " ": "";
	auto ret = system(format!"ip -j %sroute get %s"(ns,destinationIP));
	enforce(ret.status ==0, ret.output);
	return ret.output;
}

// return route get info in JSON format
string addRoute(string route, string device, string nameSpace = null)
{
	import std.exception : enforce;
	import std.format : format;
	auto ns = (nameSpace.length > 0) ? "-n " ~ nameSpace ~ " ": "";
	auto ret = system(format!"ip -j %sroute add %s dev %s"(ns,route,device));
	enforce(ret.status ==0, ret.output);
	return ret.output;
}

string executeNamespace(string nameSpace, string cmd)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip netns exec %s %s"(nameSpace,cmd));
	enforce(ret.status ==0, ret.output);
	return ret.output;
}

void addDefaultRoutePeer(string nameSpace, string defaultGateway)
{
	import std.exception : enforce;
	import std.format : format;
	auto ret = system(format!"ip netns exec %s ip route add default via %s"(nameSpace,defaultGateway));
	enforce(ret.status ==0, ret.output);
}

void setHostForwarding(bool enableForwarding = true)
{
	import std.file : write;
	// Enable IP-forwarding.
	write("/proc/sys/net/ipv4/ip_forward",enableForwarding ? "1\n" : "0\n");
}


void allowForwarding(string hostDeviceName, string clientDeviceName)
{
	import std.exception : enforce;
	import std.format : format;

	// Allow forwarding between eth0 and v-eth1.
	auto ret = system(format!"iptables -A FORWARD -i %s -o %s -j ACCEPT"(hostDeviceName, clientDeviceName));
	enforce(ret.status ==0, ret.output);
	ret = system(format!"iptables -A FORWARD -o %s -i %s -j ACCEPT"(hostDeviceName,clientDeviceName)); 
	enforce(ret.status ==0, ret.output);
}

void flushNatRules()
{
	import std.exception : enforce;
	import std.file : write;
	import std.format : format;
	// Flush nat rules.
	auto ret = system("iptables -t nat -F");
	enforce(ret.status ==0, ret.output);
}

void enableMasquerading(string peerAddress, string interfaceName)
{
	import std.exception : enforce;
	import std.file : write;
	import std.format : format;
	// Enable masquerading of 10.200.1.0.
	auto ret = system(format!"iptables -t nat -A POSTROUTING -s %s/255.255.255.0 -o %s -j MASQUERADE"(peerAddress,interfaceName));
	enforce(ret.status ==0, ret.output);
}

void setPolicyDropDefault()
{
	import std.exception : enforce;
	import std.file : write;
	import std.format : format;
	// set policy DROP by default
	auto ret = system("iptables -P FORWARD DROP");
	enforce(ret.status ==0, ret.output);
}

void flushForwardRules()
{
	import std.exception : enforce;
	import std.file : write;
	import std.format : format;
	// set policy DROP by default
	auto ret = system("iptables -F FORWARD");
	enforce(ret.status ==0, ret.output);
}

@SILdoc("Share internet access between host and namespace")
void setHostForwarding(string hostDeviceName, string clientDeviceName, string address)
{
	import std.exception : enforce;
	import std.file : write;
	import std.format : format;

	setHostForwarding(true);
	setPolicyDropDefault();
	flushForwardRules();
	flushNatRules();
	enableMasquerading(address,hostDeviceName);
	allowForwarding(hostDeviceName,clientDeviceName);
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
