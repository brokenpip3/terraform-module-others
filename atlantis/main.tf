provider "kubernetes" {
}

resource "kubernetes_namespace" "atlantis" {
  metadata {
    name = var.basename

    annotations = {
      "scheduler.alpha.kubernetes.io/node-selector" = var.node_selector
    }
  }
}

resource "kubernetes_service" "atlantis" {
  metadata {
    name = var.basename
  }

  spec {
    port {
      name        = var.basename
      port        = var.exposingport
      target_port = "4141"
    }

    selector = {
      app = var.basename
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service_account" "atlantis" {
  metadata {
    name = var.basename
  }
}

resource "kubernetes_cluster_role_binding" "admin" {
  metadata {
    name = "admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.basename
    namespace = var.basename
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin"
  }
}


resource "kubernetes_stateful_set" "atlantis" {
  depends_on = [kubernetes_namespace.atlantis]
  metadata {
    name      = var.basename
    namespace = var.basename
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.basename
      }
    }

    template {
      metadata {
        labels = {
          app = var.basename
        }
      }

      spec {
        container {
          name  = var.basename
          image = var.image

          port {
            name           = var.basename
            container_port = 4141
          }

          env_from {
            secret_ref {
              name = "minio-secret"
            }
          }

          env {
            name = "ATLANTIS_REPO_ALLOWLIST"

            value_from {
              secret_key_ref {
                name = "atlantis-vcs"
                key  = "ATLANTIS_REPO_ALLOWLIST"
              }
            }
          }

          env {
            name = "ATLANTIS_GITLAB_USER"

            value_from {
              secret_key_ref {
                name = "atlantis-vcs"
                key  = "ATLANTIS_GITLAB_USER"
              }
            }
          }

          env {
            name = "ATLANTIS_GITLAB_TOKEN"

            value_from {
              secret_key_ref {
                name = "atlantis-vcs"
                key  = "token"
              }
            }
          }

          env {
            name = "ATLANTIS_GITLAB_WEBHOOK_SECRET"

            value_from {
              secret_key_ref {
                name = "atlantis-vcs"
                key  = "webhook-secret"
              }
            }
          }

          env {
            name  = "ATLANTIS_DATA_DIR"
            value = "/atlantis"
          }

          env {
            name  = "ATLANTIS_PORT"
            value = "4141"
          }

          resources {
            limits = {
              cpu    = "100m"
              memory = "256Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
          }

          volume_mount {
            name       = "atlantis-data"
            mount_path = "/atlantis"
          }

          liveness_probe {
            http_get {
              path   = "/healthz"
              port   = "4141"
              scheme = "HTTP"
            }

            period_seconds = 60
          }

          readiness_probe {
            http_get {
              path   = "/healthz"
              port   = "4141"
              scheme = "HTTP"
            }

            period_seconds = 60
          }
        }

        service_account_name = var.basename

        security_context {
          fs_group = 1000
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "atlantis-data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]

        resources {
          requests = {
            storage = "5Gi"
          }
        }
      }
    }

    service_name = var.basename

    update_strategy {
      type = "RollingUpdate"
    }
  }
}
