helm repo add trino https://trinodb.github.io/charts/
helm install my-trino trino/trino --version 0.31.0

helm pull trino/trino --untar -d ./trino/trino-repo
mkdir ./helm
cp ./trino/trino-repo/trino/values.yaml ./helm/values.yaml
rm -rf ./trino