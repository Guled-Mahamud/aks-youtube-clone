terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}


resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.namespace
  }
}


resource "kubernetes_secret" "cloudflare_api_token_certmanager" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "cert-manager"
  }
  data = {
    "api-token" = var.cloudflare_api_token
  }
  type = "Opaque"
}

resource "kubernetes_secret" "cloudflare_api_token_default" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "default"
  }
  data = {
    "api-token" = var.cloudflare_api_token
  }
  type = "Opaque"
}


resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  namespace        = var.namespace
  version          = "v1.13.3"
  create_namespace = false

  values = [
    file("${path.root}/../k8s-manifests/values/certmanager-values.yaml")

  ]



  depends_on = [
    kubernetes_namespace.cert_manager,
    var.depends_on_ingress
  ]
}


resource "kubectl_manifest" "cluster_issuer" {
  yaml_body = file("${path.root}/../k8s-manifests/issuer.yaml")

  depends_on = [
    helm_release.cert_manager
  ]
}
