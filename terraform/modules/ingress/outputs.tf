#output "ingress_public_ip" {
  #description = "Public IP of ingress-nginx"
  #value       = data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip
#}

output "ingress_public_ip" {
  description = "Public IP of the NGINX Ingress controller"
  value       = try(
    data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip,
    "IP not available yet"
  )
}
