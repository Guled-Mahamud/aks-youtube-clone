output "aks_fqdn" {
  value = module.aks.aks_fqdn
}

output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
output "node_rg" {
  value = module.aks.node_resource_group
}

