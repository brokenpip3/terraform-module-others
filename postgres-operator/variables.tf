variable "namespace" {
  default = "postgres"
}

variable "node_selector" {
  default = "owner=brokenpip3"
}

variable "configKubernetes_enable_pod_disruption_budget" {
  default = "false"
}

variable "configKubernetes_pod_terminate_grace_period" {
  default = "1m"
}

variable "configKubernetes_pod_deletion_wait_timeout" {
  default = "1m"
}

variable "configLoadBalancer_db_hosted_zone" {
  default = "db.bk3-local-db.com"
}

variable "configLogicalBackup_logical_backup_s3_bucket" {
  default = "postgresql-backup"
}
