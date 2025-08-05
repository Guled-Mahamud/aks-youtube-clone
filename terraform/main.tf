resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

module "network" {
  source              = "./modules/network"
  location            = var.location
  resource_group_name = var.resource_group
  vnet_name           = var.vnet_name
}

module "acr" {
  source              = "./modules/acr"
  location            = var.location
  resource_group_name = var.resource_group
  acr_name            = var.acr_name
}

module "aks" {
  source              = "./modules/aks"
  location            = var.location
  resource_group_name = var.resource_group
  aks_name            = var.aks_name
  subnet_id           = module.network.aks_subnet_id
  acr_id              = module.acr.acr_id
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  env                 = var.env
}

module "argocd" {
  source = "./modules/argocd"
  namespace = "argocd"

  depends_on = [
    module.ingress,
    module.certmanager
  ]

  providers = {
    kubectl = kubectl
  }
}


module "ingress" {
  source     = "./modules/ingress"
  namespace  = "ingress-nginx"
  depends_on_aks = module.aks
}

module "certmanager" {
  source               = "./modules/certmanager"
  namespace            = "cert-manager"
  cloudflare_api_token = var.cloudflare_api_token
  depends_on_ingress   = module.ingress

  providers = {
    kubectl = kubectl
  }
}


module "monitoring" {
  source = "./modules/monitoring"
  
  
  depends_on = [module.ingress]
}


