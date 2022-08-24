terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.27.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-2"

  default_tags {
    tags = {
      Owner   = "lhs"
      Service = "simple-ec2-cluster"
      Terraform = true
    }
  }
}
