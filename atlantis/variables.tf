variable "warningmessage" {
  default = "Please show this"
}

variable "basename" {
  default = "atlantis"
}

variable "node_selector" {
  default = "owner=brokenpip3"
}

variable "exposingport" {
  default = 80
}

variable "replicas" {
  default = 1
}

variable "image" {
  default = "runatlantis/atlantis:v0.16.1"
}
