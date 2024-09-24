provider "helm" {
  kubernetes {
    host                   = var.kubernetes_host
    token                  = var.kubernetes_token
    cluster_ca_certificate = base64decode(var.kubernetes_ca_cert)
  }
}

resource "helm_release" "nginx_app" {
  name       = "nginx-app"
  chart      = "${path.module}/../nginxhelm"  # Path to the Helm chart
  namespace  = var.app_namespace

  values = [
    file("${path.module}/../../repo6/${var.values_file}")  # Load values from repo6
  ]
}
