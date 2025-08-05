terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}


resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}


