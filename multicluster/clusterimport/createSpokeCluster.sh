#Note this scripts assume that you have the kubeconfigs from the hub and the newly created spoke-cluster as a context
#like here: https://openshift.tips/oc/#merge-multiple-kubeconfigs

export CLUSTER_NAME=newspokecluster

oc --context=hub new-project ${CLUSTER_NAME}
oc --context=hub label namespace ${CLUSTER_NAME} cluster.open-cluster-management.io/managedCluster=${CLUSTER_NAME}

cat > managed-cluster.yaml <<EOF
apiVersion: cluster.open-cluster-management.io/v1
kind: ManagedCluster
metadata:
  name:  $CLUSTER_NAME
spec:
  hubAcceptsClient: true
EOF

oc apply -f managed-cluster.yaml

cat > klusterletaddonconfig.yaml <<EOF
apiVersion: agent.open-cluster-management.io/v1
kind: KlusterletAddonConfig
metadata:
  name:  $CLUSTER_NAME
  namespace:  $CLUSTER_NAME
spec:
  clusterName:   $CLUSTER_NAME
  clusterNamespace:   $CLUSTER_NAME
  applicationManager:
    enabled: true
  certPolicyController:
    enabled: true
  clusterLabels:
    cloud: auto-detect
    vendor: auto-detect
  iamPolicyController:
    enabled: true
  policyController:
    enabled: true
  searchCollector:
    enabled: true
  version: 2.0.0
EOF

oc --context=hub apply -f klusterletaddonconfig.yaml

oc --context=hub get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.crds\\.yaml} | base64 --decode > klusterlet-crd.yaml

#Note
oc  --context=hub get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.import\\.yaml} | base64 --decode > import.yaml


oc --context=newspokecluster apply -f klusterlet-crd.yaml
oc --context=newspokecluster apply -f import.yaml
