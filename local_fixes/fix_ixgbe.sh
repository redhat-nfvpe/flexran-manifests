#!/bin/bash

# this is needed to add a new driver to use sriov in unsupported cards
SERVER=$1
KERNEL_VERSION=$(ssh core@$SERVER uname -r)

echo "Fixing driver in $SERVER"

if [[ $KERNEL_VERSION == *"rt"* ]]; then
  scp ./ixgbe-5.7.1-1-rt.x86_64.rpm core@${SERVER}:/tmp/ixgbe.rpm
else
  scp ./ixgbe-5.7.1-1.x86_64.rpm core@${SERVER}:/tmp/ixgbe.rpm
fi

ssh core@${SERVER} <<EOF
cd /tmp/
rpm2cpio ./ixgbe.rpm | cpio -idmv

sudo ostree admin unlock --hotfix
sudo cp lib/modules/${KERNEL_VERSION}/updates/drivers/net/ethernet/intel/ixgbe/ixgbe.ko /usr/lib/modules/${KERNEL_VERSION}/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko.xz
sudo rmmod ixgbe
sudo modprobe ixgbe

sudo mkdir /etc/rc.d || true
sudo touch /etc/rc.d/rc.local
echo "#!/bin/sh
rmmod ixgbe && modprobe ixgbe" | sudo tee /etc/rc.d/rc.local
sudo chmod a+x /etc/rc.d/rc.local
EOF

