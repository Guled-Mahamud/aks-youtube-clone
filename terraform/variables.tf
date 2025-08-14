variable "location" {
  type        = string
  description = "Azure region for the deployment"
}

variable "resource_group" {
  type        = string
  description = "The resource group name"
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network"
}

variable "aks_name" {
  type        = string
  description = "The name of the AKS cluster"
}

variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry"
}

variable "node_count" {
  type        = number
  description = "Number of nodes for the AKS default node pool"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix used for the AKS cluster"
}

variable "env" {
  type        = string
  description = "Environment name "
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token for DNS-01 challenge"
  type        = string
}