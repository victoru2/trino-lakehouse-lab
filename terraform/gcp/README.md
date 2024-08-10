Initializing Terraform
```sh
terraform init
```

Applying configuration to create the GKE cluster
```sh
terraform apply -auto-approve
```

Destroying the GKE cluster
```sh
terraform destroy -auto-approve
```

Install [gcloud](https://cloud.google.com/sdk/docs/install?hl=pt-br)
after config gcloud
```sh
gcloud container clusters get-credentials trino-lakehouse-gke --region us-east1 --project trino-lakehouse
```
