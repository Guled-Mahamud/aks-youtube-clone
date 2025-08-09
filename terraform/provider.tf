terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.69.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Single k8s provider – no kubeconfig file required
# If you prefer non-admin creds, swap kube_admin_config -> kube_config.
provider "kubernetes" {
  host                   = module.aks.kube_config.host
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config.host
    cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
    client_certificate     = base64decode(module.aks.kube_config.client_certificate)
    client_key             = base64decode(module.aks.kube_config.client_key)
  }
}

provider "kubectl" {
  host                   = module.aks.kube_config.host
  cluster_ca_certificate = base64decode(module.aks.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.aks.kube_config.client_certificate)
  client_key             = base64decode(module.aks.kube_config.client_key)
  apply_retry_count      = 10
}