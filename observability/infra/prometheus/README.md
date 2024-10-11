### Fetch the default values file for Prometheus and save it locally to customize
```sh
helm show values prometheus-community/prometheus > values.yaml
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./observability/infra/prometheus/argocd-app-manifest/app.yaml
```