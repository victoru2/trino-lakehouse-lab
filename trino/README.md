This folder contains the `Trino` configurations.

### Add repository to the cluster
```sh
helm repo add trino https://trinodb.github.io/charts/
helm repo update
```
### Fetch the default values file for MinIO and save it locally to customize
```sh
helm show values trino/trino > values.yaml
```

### Set Up MinIO Credentials
```sh
kubectl create namespace warehouse

kubectl create secret generic minio-credentials \
  --from-literal=AWS_ACCESS_KEY_ID=minio \
  --from-literal=AWS_SECRET_ACCESS_KEY=minio123 \
  --namespace warehouse
```

### Install Trino Using Helm
```sh
helm install -f ./trino/helm/values.yaml trino trino/trino --namespace warehouse --create-namespace --version 0.31.0
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./trino/argocd-app-manifest/app.yaml
```
