helm repo add prometheus https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus

### Fetch the default values file for Prometheus and save it locally to customize
```sh
helm show values prometheus/kube-prometheus-stack > values.yaml
```

helm upgrade --install -f values.yaml theus-stack prometheus/kube-prometheus-stack -n monitoring-infra --create-namespace
<!-- helm upgrade --install theus-stack prometheus/kube-prometheus-stack --namespace monitoring --set grafana.adminPassword="mkanusm_123*" --create-namespace -->




### Deploying with ArgoCD
```sh
kubectl apply -f ./observability/infra/prometheus/argocd-app-manifest/app.yaml
```