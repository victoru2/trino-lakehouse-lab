This folder contains the `Nessie` configurations.

### Fetch the default values file for Nessie and save it locally to customize
```sh
helm show values bitnami/nessie > values.yaml
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./metastore/argocd-app-manifest/app.yaml
```
