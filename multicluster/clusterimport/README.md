Apply those manifests on the cluster that you want to import.

Please ensure that you properly replace those values:

* 04_pull-secret.yaml -> Replace DOCKERCONFIGJSON with your
base64-encoded pull-secret.json
* 05_connmgr_secret.yaml -> Replace KUBECONFIGHUB with your
base64-encodeded kubeconfig file from the cluster that
you want to import
