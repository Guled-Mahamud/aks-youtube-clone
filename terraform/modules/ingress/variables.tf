variable "namespace" {
  type        = string
  description = "The namespace for the ingress controller"
}

variable "depends_on_aks" {
  description = "Explicit dependency on AKS module"
}
