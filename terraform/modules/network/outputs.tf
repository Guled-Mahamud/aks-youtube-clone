output "aks_subnet_id" {
  description = "The subnet ID for the AKS cluster"
  value       = azurerm_subnet.aks_subnet.id
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_name" {
  description = "The name of the AKS subnet"
  value       = azurerm_subnet.aks_subnet.name
}


