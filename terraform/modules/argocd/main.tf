terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.24.1"
  timeout          = 600
  create_namespace = true

  values = [
    file("${path.root}/../k8s-manifests/values/argocd-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.argocd
  ]
}

resource "kubectl_manifest" "app_of_apps" {
  yaml_body = file("${path.root}/../k8s-manifests/app-of-apps.yaml")

  depends_on = [
    helm_release.argocd
  ]
}
