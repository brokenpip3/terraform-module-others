resource "kubernetes_namespace" "postgres" {
  metadata {
    name = var.namespace

    annotations = {
      "scheduler.alpha.kubernetes.io/node-selector" = var.node_selector
    }
  }
}

resource "helm_release" "zalando_postgres_operator" {

  depends_on = [kubernetes_namespace.postgres]
  name       = "postgres-operator"
  namespace  = var.namespace
  chart      = "https://github.com/zalando/postgres-operator/raw/master/charts/postgres-operator/postgres-operator-1.6.0.tgz"


  set {
    name  = "configKubernetes.pod_deletion_wait_timeout"
    value = var.configKubernetes_pod_deletion_wait_timeout
  }

  set {
    name  = "configLoadBalancer.db_hosted_zone"
    value = var.configLoadBalancer_db_hosted_zone
  }

  set {
    name  = "configAwsOrGcp.aws_region"
    value = ""
  }

  set {
    name  = "configAwsOrGcp.enable_ebs_gp3_migration"
    value = ""
  }

  set {
    name  = "configLogicalBackup.logical_backup_s3_bucket"
    value = "postgresql-backup"
  }
}
