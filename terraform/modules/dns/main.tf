# modules/externaldns/main.tf

resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = kubernetes_namespace.external_dns.metadata[0].name
  }

  data = {
    "api-token" = var.cloudflare_api_token
  }

  type = "Opaque"
}

resource "helm_release" "external_dns" {
  name             = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version
  timeout          = 600

  values = [
    templatefile("${path.module}/values/externaldns-values.yaml.tpl", {
      cloudflare_email = var.cloudflare_email
      domain_filters   = var.domain_filters
      secret_name      = var.secret_name
      token_key        = var.token_key
    })
  ]

  depends_on = [
    kubernetes_secret.cloudflare_api_token
  ]
}
