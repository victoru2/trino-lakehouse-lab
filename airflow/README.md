# Airflow Service
In this folder, we have the configuration to install Airflow 2.10.1, DBT core, and Astronomer Cosmos to run our DBT model.
- **argocd-app-manifest**: Contains the application to synchronize Airflow with ArgoCD.
- **dags**: Contains the DAGs and the DBT project.
- **helm**: Contains the configuration to install Airflow.

## Add repository to the cluster
```sh
helm repo add apache-airflow https://airflow.apache.org
helm repo update
```

## Create the secret with the git credentials
- To create these credentials, we use [Personal access tokens](https://github.com/settings/tokens)
```sh
kubectl apply -f ./airflow/helm/git-credentials-secret.yaml --namespace orchestrator
```

## To create the customized image, we use the configuration in the `lab-airflow` folder
- lab-airflow/requirements.txt
- lab-airflow/Dockerfile

## Deploy in the production environment
- [Helm chart Values](https://github.com/apache/airflow/blob/main/chart/values.yaml)
```sh
helm upgrade --install orchestrator-airflow apache-airflow/airflow -n orchestrator -f ./airflow/helm/values.yaml --version 1.15.0
```
## To access Airflow
```sh
kubectl port-forward svc/orchestrator-airflow-webserver 8080:8080 --namespace orchestrator
```
Use the corresponding credentials


###Credits

Thanks to [Luan Moreno](https://github.com/luanmorenomaciel) for their contributions. Check out their work at [Luan Moreno | Engenharia de Dados Academy](https://www.youtube.com/@LuanMorenoMMaciel).
<!-- 
helm delete orchestrator-airflow
-->
