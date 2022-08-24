data "aws_availability_zones" "available" {
  state = "available"
}

/**
  * VPC
  */
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "cg-vpc"
  }
}

/**
  * Internet Gateway
  */
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "cg-igw"
  }
}

/**
  * Subnet
  */
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name    = "cg-snet-pub-${count.index + 1}"
  }
}

/**
  * Routing Table
  */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "cg-rt-pub"
  }
}

resource "aws_route" "public" {
  route_table_id              = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
