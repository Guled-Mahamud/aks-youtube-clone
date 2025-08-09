variable "cloudflare_api_token" {
  description = "Cloudflare API Token used for managing DNS records."
  type        = string
  sensitive   = true
}

variable "domain_filters" {
  description = "List of domain filters for ExternalDNS to manage."
  type        = list(string)
}

variable "resource_group_name" {
  description = "Resource group name where AKS is deployed."
  type        = string
}

variable "location" {
  description = "Azure region where resources are deployed."
  type        = string
}

variable "aks_name" {
  description = "Name of the AKS cluster."
  type        = string
}


variable "cloudflare_email" {
  type        = string
  description = "Email associated with Cloudflare account."
}

variable "namespace" {
  description = "Kubernetes namespace where external-dns will be installed."
  type        = string
  default     = "default"
}

variable "secret_name" {
  type        = string
  description = "Kubernetes secret name used for Cloudflare token."
  default     = "cloudflare-api-token-secret"
}

variable "token_key" {
  type        = string
  description = "Key name inside the Cloudflare token secret."
  default     = "api-token"
}

variable "chart_version" {
  description = "Version of the external-dns Helm chart."
  type        = string
  default     = "6.25.0"
}
