variable "app_namespace" {
  description = "Namespace for the application"
  type        = string
}

variable "values_file" {
  description = "Environment-specific values file from repo6"
  type        = string
}

variable "kubernetes_host" {
  description = "Kubernetes API server host"
  type        = string
}

variable "kubernetes_token" {
  description = "Kubernetes API access token"
  type        = string
}

variable "kubernetes_ca_cert" {
  description = "Base64-encoded Kubernetes CA certificate"
  type        = string
}
