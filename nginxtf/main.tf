# ApplicationSet resource to deploy the Nginx app using ArgoCD
resource "argocd_application_set" "nginx_applicationset" {
  metadata {
    name      = "nginx-applicationset"
    namespace = "argocd"
  }

  spec {
    # Generator to generate applications for different environments
    generator {
      list {
        elements = [
          {
            name        = "nginx-prod"
            namespace   = "production"
            values_file = "prod-values.yaml"
          },
          {
            name        = "nginx-staging"
            namespace   = "staging"
            values_file = "staging-values.yaml"
          }
        ]
      }
    }

    # Template for deploying the Helm chart with environment-specific values
    template {
      metadata {
        name      = "{{name}}"
        namespace = "{{namespace}}"
      }

      spec {
        project = "default"
        
        source {
          repo_url        = "https://github.com/Raisal-A/repo5.git"
          path            = "nginxhelm"  # Path to the Helm chart in repo5
          target_revision = "HEAD"
          helm {
            value_files = [
              "https://github.com/Raisal-A/repo6.git/values/{{values_file}}"  # Points to environment variables in repo6
            ]
          }
        }

        destination {
          server    = "https://kubernetes.default.svc"
          namespace = "{{namespace}}"
        }

        sync_policy {
          automated {
            prune     = true
            self_heal = true
          }
        }
      }
    }
  }
}
