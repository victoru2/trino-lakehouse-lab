This folder contains the `Superset` configurations.

### Add repository to the cluster
```sh
helm repo add superset https://apache.github.io/superset
helm repo update
helm search repo superset
```
### Fetch the default values file for MinIO and save it locally to customize
```sh
helm show values superset/superset > values.yaml
```

### Generate a random SECRET_KEY
```sh
openssl rand -base64 42

configOverrides:
  secret: |
    SECRET_KEY = 'RANDOM_GENERATED_SECRET_KEY'
```

### Install Superset Using Helm
```sh
helm upgrade --install -f ./superset/helm/values.yaml superset superset/superset --namespace dataviz --create-namespace --version 0.12.11
```

trino://admin@trino-service.namespace.svc.cluster.local:8080/iceberg/gold


### Deploying with ArgoCD
```sh
kubectl apply -f ./superset/argocd-app-manifest/app.yaml
```
