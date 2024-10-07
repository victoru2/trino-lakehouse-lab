### Deploying with ArgoCD
```sh
kubectl apply -f ./metastore/argocd-app-manifest/app.yaml
```

helm show values bitnami/nessie > values.yaml