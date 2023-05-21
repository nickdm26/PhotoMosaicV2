variable "resource_group_name" {
  default = "TF_PhotoMosaicV2"
}

variable "location" {
  default = "westus"
}

variable "tag" {
  description = "tags for PhotoMosaicV2 Resource's"
  default = {
    Project    = "PhotoMosaicV2"
    Enviroment = "Test"
  }
}

variable "docker_image" {
  default = "photomosaicv2api"
}

variable "docker_image_tag" {
  default = "latest"
}