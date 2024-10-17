# My personal Data engineering Repository

## Directory Structure

The repository is organized into the following directories:

- **terraform**: Contains the Infrastructure as Code (IaC) configurations.
  - **gcp**: Contains configurations for Google Cloud Platform (GCP) GitOps using ArgoCD.
  - **azure**: Contains configurations for Azure GitOps using ArgoCD.
  - **gitops**: Contains general configurations for GitOps using ArgoCD.

- **minio**: Contains configurations and setups for MinIO.

- **hive-metastore**: Contains configurations for the metadata store, used by various components.

- **airbyte**: Contains configurations and setups for Airbyte, including connectors and deployments.

- **lab-airflow**: Contains configurations for Apache Airflow, DBT Core, and Astronomer Cosmos for local development and testing.

- **airflow**: Contains configurations and Directed Acyclic Graphs (DAGs) for Apache Airflow.
  - **dbt**: Contains dbt models and related configurations for data transformation.

- **observability**: Contains configurations related to monitoring and observability tools.
  - **infra**: 
    - **grafana**: Contains configurations for Grafana dashboards and monitoring setups using ArgoCD.
    - **prometheus**: Contains configurations for Prometheus monitoring setups using ArgoCD.

### Standard Service Structure
```
service/
│
├── argocd-app-manifest/
│   └── app.yaml
│
├── helm/
│   └── values.yaml
│
└── README.md
```

## Deploying ArgoCD Applications

After deploying the [Kubernetes cluster (in this case, using GCP)](https://github.com/victoru2/trino-lakehouse-lab/tree/main/terraform/gcp), [deploy ArgoCD](https://github.com/victoru2/trino-lakehouse-lab/tree/main/terraform/gitops/argocd) and then execute the following commands to deploy the necessary applications:

```sh
# Create namespaces
kubectl create namespace minio
kubectl create namespace metastore
kubectl create namespace orchestrator

# Apply secrets
kubectl apply -f secrets.yaml

# Deploy applications
kubectl apply -f ./minio/argocd-app-manifest/app.yaml    # Deploy the MinIO application
kubectl apply -f ./airbyte/argocd-app-manifest/app.yaml   # Deploy the Airbyte application
kubectl apply -f ./hive-metastore/argocd-app-manifest/app.yaml # Deploy the Hive MetaStore application
kubectl apply -f ./nessie/argocd-app-manifest/app.yaml # Deploy the Nessie application
# kubectl apply -f ./trino/argocd-app-manifest/app.yaml # Deploy the Hive Trino application
helm install -f ./trino/helm/trino-values.yaml trino trino/trino --namespace warehouse --create-namespace --version 0.31.0
```

Update the file `airflow/dags/dbt/trino/profiles.yml` with the **external IP** of **Trino**, then execute the following command:
```sh
helm upgrade --install orchestrator-airflow apache-airflow/airflow -n orchestrator -f ./airflow/helm/values.yaml --version 1.15.0
```sh

Alternatively, open a new pull request (PR), merge it into the main branch, and then execute the following command:
```sh
kubectl apply -f ./airflow/argocd-app-manifest/app.yaml   # Deploy the Airflow application
```
