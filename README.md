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
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/18205e31-05af-4759-aa25-2bb2be2bc1d4/resourceGroups/myFarm"
az group deployment create --resource-group myFarm --template-file https://raw.githubusercontent.com/GovindarajRangan/farm/master/arm/foundation.json