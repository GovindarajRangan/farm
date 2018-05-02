# Infrastructure farm for running Azure based applications

## arm
ARM templates for basic Azure services consumed to build the farm

## devops
Start/Stop devops pod within AKS

## ops
Services necessary for monitoring, logging, alerting, reporting


Batch:
az login
az group create --name myFarm --location "East US"
az network public-ip create --resource-group myFarm --name myAKSPublicIP --allocation-method static

Accessing the cluster:
az aks install-cli --install-location c:\users\govin\k8s
az aks browse --resource-group myFarm --name myFarm
az aks get-credentials --resource-group myFarm --name myFarm
kubectl get nodes

kubectl exec -it <pod-name> -- /bin/bash