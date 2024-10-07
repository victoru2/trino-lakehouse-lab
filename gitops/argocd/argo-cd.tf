resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm/"
  chart            = "argo-cd"
  namespace        = "gitops"
  create_namespace = true
  version          = "7.6.8"
  verify           = false
  values           = [file("values.yaml")]
}
