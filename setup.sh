#!/bin/bash
yum -y install make gcc openssl-devel autoconf automake rpm-build redhat-rpm-config

yum -y install python-devel openssl-devel kernel-devel kernel-debug-devel libtool wget


#LTS长周期支持版本
wget http://openvswitch.org/releases/openvswitch-2.5.5.tar.gz
mkdir -p ~/rpmbuild/SOURCES
cp openvswitch-2.5.5.tar.gz ~/rpmbuild/SOURCES/ 
cd ~/rpmbuild/SOURCES
tar xvfz openvswitch-2.5.5.tar.gz
sed 's/openvswitch-kmod, //g' openvswitch-2.5.5/rhel/openvswitch.spec > openvswitch-2.5.5/rhel/openvswitch_no_kmod.spec

rpmbuild -bb --nocheck openvswitch-2.5.5/rhel/openvswitch_no_kmod.spec

yum localinstall ~/rpmbuild/RPMS/x86_64/openvswitch-2.5.5-1.x86_64.rpm

#查看ovs有没有启动
#service openvswitch restart
echo "example:"
echo "ovs-vsctl add-br brX"
echo "ovs-vsctl del-br brX"

# 1.添加网桥：ovs-vsctl add-br 交换机名 
# 2.删除网桥：ovs-vsctl del-br 交换机名 
# 3.添加端口：ovs-vsctl add-port 交换机名 端口名（网卡名） 
# 4.删除端口：ovs-vsctl del-port 交换机名 端口名（网卡名） 
# 5.连接控制器：ovs-vsctl set-controller 交换机名 tcp:IP地址:端口号 
# 6.断开控制器：ovs-vsctl del-controller 交换机名 
# 7.列出所有网桥：ovs-vsctl list-br 
# 8.列出网桥中的所有端口：ovs-vsctl list-ports 交换机名 
# 9.列出所有挂接到网卡的网桥：ovs-vsctl port-to-br 端口名（网卡名） 
# 10.查看open vswitch的网络状态：ovs-vsctl show 
# 11.查看 Open vSwitch 中的端口信息（交换机对应的 dpid，以及每个端口的 OpenFlow 端口编号，端口名称，当前状态等等）：ovs-ofctl show 交换机名 
# 12.修改dpid：ovs-vsctl set bridge 交换机名 other_config:datapath-id=新DPID 
# 13.修改端口号：ovs-vsctl set Interface 端口名 ofport_request=新端口号 
# 14.查看交换机中的所有 Table：ovs-ofctl dump-tables ovs-switch 
# 15.查看交换机中的所有流表项：ovs−ofctl dump−flows ovs-switch 
# 16.删除编号为 100 的端口上的所有流表项：ovs-ofctl del-flows ovs-switch “in_port=100” 
# 17.添加流表项（以“添加新的 OpenFlow 条目，修改从端口 p0 收到的数据包的源地址为 9.181.137.1”为例）： 
# ovs-ofctl add-flow ovs-switch “priority=1 idle_timeout=0,in_port=100,actions=mod_nw_src:9.181.137.1,normal” 
# 18.查看 OVS 的版本信息：ovs-appctl –version 
# 19.查看 OVS 支持的 OpenFlow 协议的版本：ovs-ofctl –version