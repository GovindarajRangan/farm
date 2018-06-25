#Things to change when building a new cluster in a new provider or in a different resource group
# loadBalancerIP
# Default DNS for the AKSPublicIP is aksgovind.eastus.cloudapp.azure.com
# SSH Key value
# Storage account and secret
# 

az acs create \
    --name myFarm \
    --resource-group myFarm \
    --master-count 1 \
    --agent-count 3 \
    --admin-username govindr \
    --agent-vm-size Standard_D2_v2 \
    --dns-prefix myFarm \
    --ssh-key-value "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA5rLPzTKtynuUMYFQ9Avwpbmms0d2CZzRh/8a2rrbSRag39zt8rAkXcuzfO3apLkrDKj9PYbO5LJPWXtZpay+STKWvYEdrhhpaT0/7v35BmIoJGj6xchCnHM8J0/C0Osz8FfAbOVjGA9podjYeNnl1KwoIpbb1HOAaYnRRpAFE3zIGzz5LS5tnHrIe2f52YWuIChRkITVNBi6uKSzJ/Q4Nmu8xBmQHAgSa6i2/MEZ3CcCffuaVw48aHCqGXlL/ivBlapvgMKhfam+YynoW88JgOb6eUiuYIbez2kcL1O/MMsiE1BcraX0/+9q4J1X56K4S0eJfwbvULL4cL2JIXVbIw== govindaraj.rangan@wipro.com" \
    --orchestrator-type kubernetes \
    --service-principal 3d957a5d-76d3-4b20-acc0-02881c366401 \
    --client-secret tLIB7wi+mGV8nnQskftuIYeJMr9FSIbBoHxFQwz4ERw=

az aks create \
    --name myFarm \
    --resource-group myFarm \
    --node-count 2 \
    --admin-username govindr \
    --node-vm-size Standard_DS1_v2 \
    --node-osdisk-size 32 \
    --dns-name-prefix myFarm \
    --ssh-key-value "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA5rLPzTKtynuUMYFQ9Avwpbmms0d2CZzRh/8a2rrbSRag39zt8rAkXcuzfO3apLkrDKj9PYbO5LJPWXtZpay+STKWvYEdrhhpaT0/7v35BmIoJGj6xchCnHM8J0/C0Osz8FfAbOVjGA9podjYeNnl1KwoIpbb1HOAaYnRRpAFE3zIGzz5LS5tnHrIe2f52YWuIChRkITVNBi6uKSzJ/Q4Nmu8xBmQHAgSa6i2/MEZ3CcCffuaVw48aHCqGXlL/ivBlapvgMKhfam+YynoW88JgOb6eUiuYIbez2kcL1O/MMsiE1BcraX0/+9q4J1X56K4S0eJfwbvULL4cL2JIXVbIw== govindaraj.rangan@wipro.com" \
    --service-principal 3d957a5d-76d3-4b20-acc0-02881c366401 \
    --client-secret tLIB7wi+mGV8nnQskftuIYeJMr9FSIbBoHxFQwz4ERw=

az resource move --destination-group MC_myFarm_myFarm_eastus --ids /subscriptions/18205e31-05af-4759-aa25-2bb2be2bc1d4/resourceGroups/myFarm/providers/Microsoft.Network/publicIPAddresses/AKSPublicIP
az aks get-credentials --resource-group myFarm --name myFarm
kubectl --namespace kube-system create serviceaccount tiller
helm init --service-account tiller
# Wait for tiller pod to be deployed
helm repo update
# https://docs.microsoft.com/en-us/azure/aks/ingress
helm install stable/nginx-ingress --name mwingress --namespace kube-system --set controller.service.loadBalancerIP=138.91.112.229 --set rbac.create=false --set rbac.createRole=false --set rbac.createClusterRole=false
# Wait for Load balancer to be up and ingress controller to be running
kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sStorage.yaml
helm repo add myFarm https://raw.githubusercontent.com/GovindarajRangan/farm/master/helmrepo/
helm install icescrum

# Docker registry
kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sStorage-docker-registry.yaml
helm install --set persistence.accessMode=ReadWriteMany,persistence.enabled=true,persistence.size=50Gi,persistence.storageClass=my-farm-storage,persistence.existingClaim=pvc-docker-registry stable/docker-registry
# Edit Ingress for the docker-registry service name for now, need to convert this into helm chart
kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sIngress-docker-registry.yaml

#helm dry run
helm install --debug --dry-run icescrum


# Get SSH connection
kubectl run -it --rm aks-ssh --image=debian
apt-get update && apt-get install openssh-client -y
# Reset azureuser password if you want to login
#kubectl cp ~/.ssh/id_rsa <aks-ssh pod_name>:/id_rsa
kubectl cp ..\.ssh\aks_id_rsa.pub aks-ssh-56d9d4d98-wwhr8:/id_rsa
cd /
chmod 0600 id_rsa
ssh -i id_rsa azureuser@10.240.0.6
# Re-attach
kubectl attach aks-ssh-56d9d4d98-cp5hd -c aks-ssh -i -t


#####################################################
### TESTED & ARCHIVED
# Tuleap Project Management tool
# kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/pmoTuleap.yaml
# samole services
# kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sSamplePod2.yaml
# kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sIngress.yaml
# kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/pmoIceScrum.yaml
# helm repo add monocular https://kubernetes-helm.github.io/monocular
# helm install monocular/monocular

