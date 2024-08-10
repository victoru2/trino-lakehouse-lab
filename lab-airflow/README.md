Steps to Create and Push the Docker Repository

1. Log in to Docker Hub:
```sh
docker login
```

2. Build the Image:
```sh
docker build -t airflow-with-extra-packages-image:2.9.3 .
```

3. Tag the Image:
```sh
docker tag airflow-with-extra-packages-image:2.9.3 vurquiola2/airflow-with-extra-packages:2.9.3
```

4. Push the Image:
```sh
docker push vurquiola2/airflow-with-extra-packages:2.9.3
```

To download the Docker Compose manifest:
```sh
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.9.3/docker-compose.yaml' 
```