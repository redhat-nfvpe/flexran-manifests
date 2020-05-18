#!/bin/bash

NIC_PATTERN=${NIC_PATTERN:-""}
array_test=()
for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
do
  if [[ $iface == ${NIC_PATTERN}* ]]; then
    printf '***'
    printf $iface
    printf '***'
    ethtool -T $iface
  fi
done
