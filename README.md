# FlexRAN manifests

This project contains a set of manifests that will configure an OpenShift platform to run RAN workloads on it.

## Getting Started

First thing will be to apply the extra operators that are missing. This needs to be done at first stage,
because they take some time to be applied. This can be done with:

```
oc apply -k additional_components
```
 
The manifests are created with 2 layers, base and site, so people can create independent sites for their own settings.
Manifests can be applied on a running cluster, by simple running:

```
oc apply -k cluster_configuration/path/to/site/
```

for example you can run:

```
cd flexran-manifests
oc apply -k /redhat-nfvpe/flexran-manifests/tree/master/multicluster/placement/sites/sample_site
```

### Prerequisites

Have a running OpenShift >=4.4 cluster installed and running, export KUBECONFIG to access it.
These manifests have been tested using a 3-node footprint (3 masters/workers combined).
```
