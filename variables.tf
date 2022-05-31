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