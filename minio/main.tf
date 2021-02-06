provider "helm" {
  kubernetes {
  }
}

resource "helm_release" "minio-terraform-state" {
  name       = "minio-tf-state"
  namespace  = "minio"
  repository = "https://helm.min.io"
  chart      = "minio"

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  set {
    name  = "mcImage.tag"
    value = var.mcImage_tag
  }

  set {
    name  = "StatefulSetUpdate.updateStrategy"
    value = var.StatefulSetUpdate_updateStrategy
  }

  set {
    name  = "replicas"
    value = var.replicas
  }

  set {
    name  = "resources.requests.memory"
    value = var.resources_requests_memory
  }

  set {
    name  = "resources.requests.cpu"
    value = var.resources_requests_cpu
  }

  set {
    name  = "resources.requests.cpu"
    value = var.resources_requests_cpu
  }

  set {
    name  = "resources.limits.cpu"
    value = var.resources_limits_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.resources_limits_memory
  }

  set {
    name  = "persistence.size"
    value = var.persistence_size
  }

  set {
    name  = "service.annotations.prometheus\\.io/scrape"
    value = var.service_annotations_prometheus_io_scrape
  }

  set {
    name  = "service.annotations.prometheus\\.io/path"
    value = var.service_annotations_prometheus_io_path
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = var.service_annotations_prometheus_io_port
  }
  set {
    name  = "defaultBucket.enabled"
    value = var.defaultBucket_enabled
  }
  set {
    name  = "defaultBucket.name"
    value = var.defaultBucket_name
  }
}
