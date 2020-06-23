This manifest will spin a pod with two containers, the first one
runs the L1 LTE app that will start listening to requests.
The second one will run the testmac testing. It accepts a
TESTFILE env var that can be: /opt/flexran/tests/lte/dl/testmac_dl.cfg,
/opt/flexran/tests/lte/ul/testmac_ul.cfg,
/opt/flexran/tests/lte/fd/testmac_fd.cfg
