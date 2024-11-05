#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <old_interface> <new_interface>"
  exit 1
fi

OLD_INTERFACE=$1
NEW_INTERFACE=$2

OLD_IP_ADDR=$(ip -4 addr show dev "$OLD_INTERFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+')

if [ -z "$OLD_IP_ADDR" ]; then
  echo "No IP address found for interface $OLD_INTERFACE"
  exit 1
else
  echo "The IP address of $OLD_INTERFACE is: $OLD_IP_ADDR"
fi

# 設置新 interface 的 IP 地址
sudo ip addr add "$OLD_IP_ADDR" dev "$NEW_INTERFACE"
sudo ip link set "$NEW_INTERFACE" up

# 從舊 interface 刪除 IP 地址
sudo ip addr del "$OLD_IP_ADDR" dev "$OLD_INTERFACE"

# 設置默認路由 (假設默認 gateway 是已知的)
GATEWAY_IP="192.168.40.254"
sudo ip route add default via "$GATEWAY_IP" dev "$NEW_INTERFACE"

echo "IP configuration has been moved from $OLD_INTERFACE to $NEW_INTERFACE."
