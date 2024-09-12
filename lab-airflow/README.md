Steps to Create and Push the Docker Repository

1. Log in to Docker Hub:
```sh
docker login
```

2. Build the Image:
```sh
docker build -t airflow-with-extra-packages-image:2.10.1 .
```

3. Tag the Image:
```sh
docker tag airflow-with-extra-packages-image:2.10.1 vurquiola2/airflow-with-extra-packages:2.10.1
```

4. Push the Image:
```sh
docker push vurquiola2/airflow-with-extra-packages:2.10.1
```

To download the Docker Compose manifest:
```sh
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.10.1/docker-compose.yaml' 
```