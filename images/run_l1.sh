#!/bin/bash
source /opt/flexran_env_vars.sh
bash ./configure_cfg_files.sh

if [ -n "$TESTFILE" ]; then
	pushd /opt/flexran/bin/lte/testmac
	./l2.sh --testfile=${TESTFILE}
else
	pushd /opt/flexran/bin/lte/l1
	./l1.sh -e
fi
popd
