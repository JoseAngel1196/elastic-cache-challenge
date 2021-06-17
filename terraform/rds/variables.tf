variable "namespace" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "public_subnet_id_in" {}

variable "private2_subnet_id_in" {}

variable "username" {
  type    = string
  default = "jhidalgo"
}

variable "sg_id_in" {}
