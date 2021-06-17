variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "public_key" {
  type = string
}

variable "namespace" {
  default = "Elastic-TEST"
  type    = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}