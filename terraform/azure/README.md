az login
az account set --subscription "2ca86e66-79be-47bb-8134-477cc846b187"
az vm list-sizes --location east_us2

terraform init
terraform plan
terraform apply -auto-approve

az aks get-credentials --resource-group rg-victor-lab --name victor-lab --overwrite-existing