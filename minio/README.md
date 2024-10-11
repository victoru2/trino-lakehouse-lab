This folder contains the `MinIO` configurations.

### Add repository to the cluster
```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo minio
```
### Fetch the default values file for MinIO and save it locally to customize
```sh
helm show values bitnami/minio > values.yaml
```

### Set Up MinIO Credentials

```sh
kubectl create secret generic minio-credentials \
  --from-literal=rootUser=myminiouser \
  --from-literal=rootPassword=myminiopassword \
  -n minio
```

### Install MinIO Using Helm
```sh
helm install minio bitnami/minio --namespace minio --create-namespace -f ./helm/values.yaml --version 14.7.15
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./minio/argocd-app-manifest/app.yaml
```
