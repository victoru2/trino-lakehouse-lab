Add Permissions in IAM
[Open IAM in the Google Cloud Console](https://console.cloud.google.com/iam-admin/serviceaccounts?hl=en)

Assign the following roles to the service account:
- Service Account Admin
- Compute Instance Admin (Beta)
- Compute Instance Admin (v1)
- Kubernetes Engine Cluster Admin
- Service Account User

Install [gcloud](https://cloud.google.com/sdk/docs/install?hl=pt-br)
<!-- 
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
source ~/.zshrc
gcloud init
gcloud auth application-default login
-->

Initializing Terraform
```sh
terraform init
terraform plan
```

Applying configuration to create the GKE cluster
```sh
terraform apply -auto-approve
```

after config gcloud
```sh
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials victor-lab --region us-central1 --project victor-lab
```

Destroying the GKE cluster
```sh
terraform destroy -auto-approve
```
