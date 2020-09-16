#!/bin/bash
# mode will be set as LTE or 5G
MODE=$1
if [ "$MODE" != "5G" ] && [ "$MODE" != "LTE" ]; then
	echo "Please specify MODE as an argument, it needs to be 5G or LTE"
	exit 1
fi

source /opt/flexran_env_vars.sh
bash ./configure_cfg_files.sh

if [ -n "$TESTFILE" ]; then
	if [ $MODE = 5G ]; then
		pushd /opt/flexran/bin/nr5g/gnb/testmac
	fi
	if [ $MODE = LTE ]; then
		pushd /opt/flexran/bin/lte/testmac
	fi
	./l2.sh --testfile=${TESTFILE}
else
	if [ $MODE = 5G ]; then
		pushd /opt/flexran/bin/nr5g/gnb/l1
	fi
	if [ $MODE = LTE ]; then
		pushd /opt/flexran/bin/lte/l1
	fi
	./l1.sh -e
fi
popd
