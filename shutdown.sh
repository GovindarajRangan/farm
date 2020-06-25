az resource move --destination-group myFarm --ids /subscriptions/18205e31-05af-4759-aa25-2bb2be2bc1d4/resourceGroups/MC_myFarm_myFarm_eastus/providers/Microsoft.Network/publicIPAddresses/AKSPublicIP

az group deployment create \
    --resource-group myFarm \
    --template-uri https://raw.githubusercontent.com/GovindarajRangan/farm/master/infra/resourcegroupCleanup.json?token=AB3G5LJ5KFUGTPEVLQ3REMS66TS7Y \
    --mode complete
