Manifests to add ACM to the registered cluster.
This is currently optional, just used to test FlexRAN
multiple cluster deployments.

NOTE: Due to a bug, when multiclusterhub has been applied,
the following annotation needs to be run:
oc annotate etcdcluster etcd-cluster etcd.database.coreos.com/scope=clusterwide -n open-cluster-management

NOTE: To properly clean up the the multicluster app, please execute
https://github.com/open-cluster-management/deploy/blob/master/hack/nuke.sh

