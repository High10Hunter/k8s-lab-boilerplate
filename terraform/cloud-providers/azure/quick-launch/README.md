## Launch AKS cluster using Terraform

```bash
az login
az account list
az account set --subscription <id>
terraform init
terraform apply
az aks get-credentials --resource-group <resource-group-name> --name <aks-cluster-name> 
# e.g: az aks get-credentials --resource-group simpleshopping --name dev-simpleshop-cluster
```
