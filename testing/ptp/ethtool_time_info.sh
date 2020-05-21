#!/bin/bash

NIC_PREFIX=${NIC_PREFIX:-""}
for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
do
    if [[ $iface == ${NIC_PREFIX}* ]]; then
        ethtool -T $iface
    fi
done
