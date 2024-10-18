## Add repository to the cluster
```sh
helm repo add bigdata-gradiant https://gradiant.github.io/bigdata-charts/
helm repo update
```
## Fetch the default values file for Airflow and save it locally to customize
```sh
helm show values bigdata-gradiant/hive-metastore > values.yaml
```

### Install Hive MetaStore Using Helm
```sh
helm install hivems bigdata-gradiant/hive-metastore -n metastore -f ./hive-metastore/helm/values.yaml --create-namespace
```

### Checking Hive Metastore Connection on Kubernetes
```sh
kubectl -n metastore exec -it hivems-hive-metastore-0 -- /bin/sh
    nc -zv localhost 9083
```

###Credits
[Medium Article](https://jboothomas.medium.com/hive-metastore-on-k8s-with-s3-external-table-607102a11e56)
