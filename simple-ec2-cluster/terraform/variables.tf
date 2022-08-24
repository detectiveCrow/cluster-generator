variable "vpc_cidr" {
  description = "cidr value of vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "public cidr values"
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
}

variable "instance_ami" {
  description = "ami of instances"
  type = string
  default     = "ami-0454bb2fefc7de534"
}

variable "instance_type" {
  description = "type of instances"
  type = string
  default = "t3.medium"
}

variable "public_key" {
  description = "value of public key"
  type = string
}
