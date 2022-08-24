terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.27.0"
    }
  }

  backend "s3" {
    bucket = "lhs-tfstate-bucket"
    key    = "cg/local/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "lhs-tfstate-bucket"
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
