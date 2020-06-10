#!/bin/bash

# this is needed to add a new driver to use sriov in unsupported cards
SERVER=$1

echo "Fixing driver in $SERVER"
scp ./ixgbe-5.7.1-1.x86_64.rpm core@${SERVER}:/tmp/

ssh core@${SERVER} <<EOF
cd /tmp/
rpm2cpio ./ixgbe-5.7.1-1.x86_64.rpm | cpio -idmv

sudo ostree admin unlock --hotfix
sudo cp lib/modules/4.18.0-147.8.1.el8_1.x86_64/updates/drivers/net/ethernet/intel/ixgbe/ixgbe.ko /usr/lib/modules/4.18.0-147.8.1.el8_1.x86_64/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko.xz
sudo rmmod ixgbe
sudo modprobe ixgbe

sudo mkdir /etc/rc.d
sudo touch /etc/rc.d/rc.local
echo "#!/bin/sh
rmmod ixgbe && modprobe ixgbe" | sudo tee /etc/rc.d/rc.local
sudo chmod a+x /etc/rc.d/rc.local
EOF

