az group deployment create \
    --resource-group myFarm \
    --template-uri https://raw.githubusercontent.com/GovindarajRangan/farm/master/arm/resourcegroupCleanup.json \
    --mode complete