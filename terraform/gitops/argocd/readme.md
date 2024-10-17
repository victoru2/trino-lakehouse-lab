# GitOps using ArgoCD

### install
```sh
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
```

### build
```sh
terraform init
terraform plan
terraform apply -auto-approve
```

### configure [manual]
```sh
kubectl get svc argocd-server -n gitops
kubectl patch svc argocd-server -n gitops -p '{"spec": {"type": "LoadBalancer"}}'
kubectl -n gitops get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo


argocd login 0.0.0.0 --username admin --password "password" --insecure
argocd cluster add gke_victor-lab_us-central1_victor-lab --name victor-lab

kubectl apply -f git-repo.yaml -n gitops
```

###Credits

Thanks to [Luan Moreno](https://github.com/luanmorenomaciel) for their contributions. Check out their work at [Luan Moreno | Engenharia de Dados Academy](https://www.youtube.com/@LuanMorenoMMaciel).
