#Note this scripts assume that you have the kubeconfigs from the hub and the newly created spoke-cluster as a context
#like here: https://openshift.tips/oc/#merge-multiple-kubeconfigs
# in this example we have
# oc config get-contexts
#  CURRENT   NAME            CLUSTER        AUTHINFO        NAMESPACE
#         kubehub      cluster-09ec   hubcluster      
#         kubespoke1   acmdemo        spokecluster1   

echo -ne "Enter your CLUSTER_NAME"
read -s CLUSTER_NAME
echo -ne "Enter your HUB_CONTEXT"
read -s HUB_CONTEXT
echo -ne "\nEnter your SPOKE_CONTEXT"
read -s SPOKE_CONTEXT

#export CLUSTER_NAME=spokecluster1 
#export HUB_CONTEXT=kubehub
#export SPOKE_CONTEXT=kubespoke1

oc --context=$HUB_CONTEXT new-project ${CLUSTER_NAME}
oc --context=$HUB_CONTEXT label namespace ${CLUSTER_NAME} cluster.open-cluster-management.io/managedCluster=${CLUSTER_NAME}

cat > managed-cluster.yaml <<EOF
apiVersion: cluster.open-cluster-management.io/v1
kind: ManagedCluster
metadata:
  name:  $CLUSTER_NAME
spec:
  hubAcceptsClient: true
EOF

oc --context=$HUB_CONTEXT apply -f managed-cluster.yaml

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

oc --context=$HUB_CONTEXT  apply -f klusterletaddonconfig.yaml

sleep 2

oc --context=$HUB_CONTEXT  get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.crds\\.yaml} | base64 --decode > klusterlet-crd.yaml

oc  --context=$HUB_CONTEXT  get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.import\\.yaml} | base64 --decode > import.yaml


oc --context=$SPOKE_CONTEXT  apply -f klusterlet-crd.yaml

sleep 2

oc --context=$SPOKE_CONTEXT  apply -f import.yaml
