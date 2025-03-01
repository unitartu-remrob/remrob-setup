#!/bin/bash
# https://blog.oddbit.com/post/2018-03-12-using-docker-macvlan-networks/

echo "deleting old link..."
ip link delete remrob_bridge

echo "recreating..."
ip link add remrob_bridge link enp4s0 type macvlan mode bridge
# Give the link an IP address
ip addr add 192.168.200.199/32 dev remrob_bridge # .199 is not special, can be set to anything free within the subnet
ip link set remrob_bridge up
ip route add 192.168.200.96/27 dev remrob_bridge # Route the container IP's through the link