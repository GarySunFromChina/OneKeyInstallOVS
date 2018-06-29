#!/bin/bash

#添加网桥 4口

ovs-vsctl add-br br0
ovs-vsctl add-br br1
ovs-vsctl add-br br2
ovs-vsctl add-br br3

echo -e "DEVICE=br0\n
TYPE=OVSBridge\n
ONBOOT=yes\n
BOOTPROTO=DHCP\n" > /etc/sysconfig/network-scripts/ifcfg-br0

echo -e "DEVICE=br1\n
TYPE=OVSBridge\n
ONBOOT=yes\n
BOOTPROTO=static\n
IPADDR=192.168.20.10\n
NETMASK=255.255.255.0\n
GATEWAY=192.168.20.1\n
DNS1=192.168.20.1" > /etc/sysconfig/network-scripts/ifcfg-br1

echo -e "DEVICE=br2\n
TYPE=OVSBridge\n
ONBOOT=yes\n
BOOTPROTO=DHCP\n" > /etc/sysconfig/network-scripts/ifcfg-br2


echo -e "DEVICE=br3\n
TYPE=OVSBridge\n
ONBOOT=yes\n
BOOTPROTO=DHCP\n" > /etc/sysconfig/network-scripts/ifcfg-br3

echo "ovs-vsctl add-port name"
