This folder contains the [Airbyte](https://airbyte.com/product/airbyte-open-source) configurations.

## Steps:

### 1. Add Airbyte Helm Chart Repository
```sh
helm repo add airbyte https://airbytehq.github.io/helm-charts
helm repo update
```

### 2. Obtain the [values.yaml](https://github.com/airbytehq/airbyte-platform/blob/main/charts/airbyte/values.yaml) File
```sh
helm pull airbyte/airbyte --untar -d ./airbyte/airbyte-repo --version 0.551.0
mkdir ./airbyte/helm
cp ./airbyte/airbyte-repo/airbyte/values.yaml ./airbyte/helm/values.yaml
rm -rf ./airbyte/airbyte-repo
```

### 3. Install the Airbyte Service
```sh
helm install -f ./airbyte/helm/values.yaml ingestion-airbyte airbyte/airbyte --namespace ingestion --version 0.551.0
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

# NOTES: Get the application URL by running these commands:
```sh
export POD_NAME=$(kubectl get pods --namespace ingestion -l "app.kubernetes.io/name=webapp" -o jsonpath="{.items[0].metadata.name}")
export CONTAINER_PORT=$(kubectl get pod --namespace ingestion $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
kubectl --namespace ingestion port-forward $POD_NAME 8080:$CONTAINER_PORT
```

###Credits

Thanks to [Simon Thelin](https://github.com/Thelin90) for their contributions. Check out their work at [datapains-airbyte](https://github.com/Thelin90/datapains-airbyte).

<!-- # For delete the Airbyte service
# helm delete ingestion-airbyte -->
