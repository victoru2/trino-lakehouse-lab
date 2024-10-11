## Add repository to the cluster
```sh
helm repo add bigdata-gradiant https://gradiant.github.io/bigdata-charts/
helm repo update
```
## Fetch the default values file for Airflow and save it locally to customize
```sh
helm show values bigdata-gradiant/hive-metastore > values.yaml
```

helm search repo bigdata-gradiant
kubectl create namespace metastore

### Set Up MinIO Credentials
```sh
kubectl create secret generic minio-credentials \
  --from-literal=rootUser=myminiouser \
  --from-literal=rootPassword=myminiopassword \
  -n metastore
```
### Install Hive MetaStore Using Helm
```sh
helm install hivems bigdata-gradiant/hive-metastore -n metastore -f values.yaml
```

### Checking Hive Metastore Connection on Kubernetes
```sh
kubectl -n metastore exec -it hivems-hive-metastore-0 -- /bin/sh
    nc -zv localhost 9083
```

###Credits
[Medium Article](https://jboothomas.medium.com/hive-metastore-on-k8s-with-s3-external-table-607102a11e56)
