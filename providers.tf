terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = "<Your Access Key>"
  secret_key = "<Your Secret Key>"
}

data "aws_availability_zones" "available" {
  state = "available"
}