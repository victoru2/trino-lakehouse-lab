### Fetch the default values file for Grafana and save it locally to customize
```sh
helm show values grafana/grafana > values.yaml
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./observability/infra/grafana/argocd-app-manifest/app.yaml
```
