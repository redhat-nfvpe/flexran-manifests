This contains a set of manifests to execute performance
testing.

Performance tests with cyclictest
*********************************
The objective of the test is to put the system under load, then run
cyclictest on a guaranteed pod to be able to collect results.
The first step will be to apply the stress-ng.yaml manifest.
This will run stress-ng on each core of the worker that you are
targettig. A replica needs to be running on each core. To calculate
the number of replicas, follow this rule:
- get the total number of cores of the cpu
- substract 2 as there will be the reserved cores
- substract 4 for cyclictest to run
- this final number will be the total replicas for stress-ng

Second step is to run cyclictest, with cyclictest.yaml manifest.
We can run this in a guaranteed pod, with 200M of RAM and 4 cores. You
can configure the duration of the test, the longer it is the more
reliable results you will get.
