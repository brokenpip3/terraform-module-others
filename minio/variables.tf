variable "image_tag" {
  default = "latest"
}

variable "mcImage_tag" {
  default = "latest"
}

variable "StatefulSetUpdate_updateStrategy" {
  default = "OnDelete"
}

variable "replicas" {
  default = "1"
}

variable "resources_requests_memory" {
  default = "500Mi"
}

variable "resources_requests_cpu" {
  default = "200m"
}

variable "resources_limits_cpu" {
  default = "1"
}

variable "resources_limits_memory" {
  default = "1Gi"
}

variable "persistence_size" {
  default = "10Gi"
}

variable "service_annotations_prometheus_io_scrape" {
  default = "'true'"
}

variable "service_annotations_prometheus_io_path" {
  default = "'/minio/prometheus/metrics'"
}

variable "service_annotations_prometheus_io_port" {
  default = "'9000'"
}
variable "defaultBucket_enabled" {
  default = "true"
}
variable "defaultBucket_name" {
  default = "terraform-state"
}
