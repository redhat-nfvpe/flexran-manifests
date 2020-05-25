PTP hardware testing
====================

In order to check for hardware dependencies, a check with ethtool needs to be
executed. As in RHCOS we don't have the needed tools, this needs to be run
inside a container with net=host privileges.

To execute that, please run:

```podman run --net=host --env NIC_PREFIX=eno quay.io/yrobla/ptp_hardware_checker```

This will return all the timing settings for the nics starting with
the prefix you are passing into NIC_PREFIX env var.

NOTE: Although we provide the manifest yaml file, you cannot execute with
`podman play kube`, as the hostNetwork flag is not recognized by the
podman version installed on RHCOS
