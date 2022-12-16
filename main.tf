terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.available_zone
}

provider "random" {
  # Configuration options
}