#!/bin/bash
sudo ip tuntap add tap0 mode tap
if [ $? == 0 ]
then
    sudo ip addr add 172.16.0.1/24 dev tap0
    sudo ip link set tap0 up
    sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
    sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
    sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A FORWARD -i tap0 -o ens33 -j ACCEPT
fi

# sudo ip link del tap0
