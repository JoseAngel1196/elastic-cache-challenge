terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAWZPSF4A3LUEFDC7D"
  secret_key = "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"
}
