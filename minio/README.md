helm pull minio/minio --untar -d ./minio/minio-repo
mkdir ./helm
cp ./minio/minio-repo/minio/values.yaml ./helm/values.yaml
rm -rf ./minio

helm install minio minio/minio --namespace minio-ns --create-namespace -f ./helm/values.yaml
