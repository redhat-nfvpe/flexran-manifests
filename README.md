# FlexRAN manifests

This project contains a set of manifests that will configure an OpenShift platform to run RAN workloads on it.

## Getting Started

First thing will be to apply the extra operators missing. This needs to be done at first stage,
because they take time to be applied. This can be done with:

```
kubectl apply -k additional_components
```
 
The manifests are created with 2 layers, base and site, so people can create independent sites for their own settings.
Manifests can be applied on a running cluster, by simple running:

```
kubectl apply -k cluster_configuration/path/to/site/
```

### Prerequisites

Have a running OpenShift >=4.4 cluster installed and running, export KUBECONFIG to access it.
```
