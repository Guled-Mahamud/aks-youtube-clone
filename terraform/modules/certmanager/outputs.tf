output "cert_manager_namespace" {
  value = kubernetes_namespace.cert_manager.metadata[0].name
}

output "cloudflare_secret_name" {
value = kubernetes_secret.cloudflare_api_token.metadata[0].name
}