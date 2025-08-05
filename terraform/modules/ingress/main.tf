resource "kubernetes_namespace" "ingress" {
  metadata {
    name = var.namespace
  }
  depends_on = [var.depends_on_aks]
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = kubernetes_namespace.ingress.metadata[0].name
  version    = "4.10.0"

   values = [
    file("${path.root}/../k8s-manifests/values/ingress-values.yaml")
  ]

  depends_on = [kubernetes_namespace.ingress]
}

data "kubernetes_service" "nginx_ingress_controller" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = kubernetes_namespace.ingress.metadata[0].name
  }
  depends_on = [helm_release.nginx_ingress]
}

