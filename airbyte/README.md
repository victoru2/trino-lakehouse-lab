This folder contains the [Airbyte](https://airbyte.com/product/airbyte-open-source) configurations.

## Steps:

### 1. Add Airbyte Helm Chart Repository
```sh
helm repo add airbyte https://airbytehq.github.io/helm-charts
helm repo update
```

### 2. Fetch the default values file for Airbyte and save it locally to customize
```sh
helm show values airbyte/airbyte > values.yaml
```

### 3. Install the Airbyte Service
```sh
helm install -f ./airbyte/helm/values.yaml airbyte airbyte/airbyte --namespace ingestion --create-namespace --version 1.1.0
```

### Extra. Update the airbyte-db PVC
```sh
kubectl get pvc airbyte-pvc-name
kubectl patch pvc airbyte-pvc-name -p '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
```

### Deploying with ArgoCD
```sh
kubectl apply -f ./airbyte/argocd-app-manifest/app.yaml
```

###Credits

Thanks to [Simon Thelin](https://github.com/Thelin90) for their contributions. Check out their work at [datapains-airbyte](https://github.com/Thelin90/datapains-airbyte).

<!-- # For delete the Airbyte service
# helm delete ingestion-airbyte -->
