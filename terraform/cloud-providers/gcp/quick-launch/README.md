## Launch GKE cluster using Terraform

```bash
gcloud auth login
terraform init
terraform apply
gcloud container clusters get-credentials CLUSTER_NAME --location=CONTROL_PLANE_LOCATION
```
