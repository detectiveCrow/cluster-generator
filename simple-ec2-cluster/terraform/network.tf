locals {
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
}

data "aws_availability_zones" "available" {
  state = "available"
}

/**
  * VPC
  */
resource "aws_vpc" "this" {
  cidr_block           = local.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "cg-vpc"
  }
}

/**
  * Internet Gateway
  */
resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "cg-igw"
  }
}

/**
  * Subnet
  */
resource "aws_subnet" "public" {
  for_each = { for i, v in local.public_subnet_cidr : i + 1 => v }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[each.key]

  tags = {
    Name    = "cg-snet-pub-${each.key}"
  }
}
