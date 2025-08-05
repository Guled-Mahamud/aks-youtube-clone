variable "namespace" {
  type        = string
  description = "The namespace for cert-manager"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token for DNS challenge"
  type        = string
  sensitive   = true
}

variable "depends_on_ingress" {
  description = "Dependency on ingress controller"
}