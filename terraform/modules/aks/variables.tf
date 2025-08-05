variable "aks_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet for AKS node pool"
}

variable "acr_id" {
  type        = string
  description = "ID of the Azure Container Registry"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for AKS"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool"
}

variable "env" {
  type        = string
  description = "Deployment environment"
}
