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
kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sStorage.yaml
kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sSamplePod2.yaml

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl create -f https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/k8sTiller.yaml
helm init --service-account tiller