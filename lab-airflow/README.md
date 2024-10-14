Steps to Create and Push the Docker Repository

1. Log in to Docker Hub:
```sh
docker login
```

2. Build the Image:
```sh
docker build -t airflow-with-extra-packages-image:2.10.2 .
```

3. Tag the Image:
```sh
docker tag airflow-with-extra-packages-image:2.10.2 vurquiola2/airflow-with-extra-packages:2.10.2
```

4. Push the Image:
```sh
docker push vurquiola2/airflow-with-extra-packages:2.10.2
```

To download the Docker Compose manifest:
```sh
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.10.2/docker-compose.yaml'
```
