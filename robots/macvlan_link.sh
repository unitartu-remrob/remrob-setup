#!/bin/bash
# https://blog.oddbit.com/post/2018-03-12-using-docker-macvlan-networks/

NIC_NAME=enp4s0
BRIDGE_IP=192.168.200.199/32
CONTAINER_SUBNET=192.168.200.96/27

echo "deleting old link..."
ip link delete remrob_bridge

echo "recreating..."
ip link add remrob_bridge link $NIC_NAME type macvlan mode bridge

# Give the link an IP address
ip addr add $BRIDGE_IP dev remrob_bridge # can be set to anything free within the subnet
ip link set remrob_bridge up
ip route add $CONTAINER_SUBNET dev remrob_bridge # Route the container IP's through the link