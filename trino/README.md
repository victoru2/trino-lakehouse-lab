This folder contains the `Trino` configurations.

### Add repository to the cluster
```sh
helm repo add trino https://trinodb.github.io/charts/
helm repo update
```
### Fetch the default values file for MinIO and save it locally to customize
```sh
helm show values trino/trino > trino-values.yaml
```

### Install Trino Using Helm
```sh
helm install -f ./trino/helm/trino-values.yaml trino trino/trino --namespace warehouse --create-namespace --version 0.31.0
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./trino/argocd-app-manifest/app.yaml
```
