terraform {
  required_providers {
    aws = {
      version = "~> 5.12.0"
      source  = "hashicorp/aws"
    }
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
