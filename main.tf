provider "aws" {
    region = "us-east-1"
    # access_key = "................."
    # secret_key = "................."

  # Configuration options
}

variable "aws_vpc_name" {
  description = "this is the name of the VPC" 
  default = "nedum-dev-vpc" 
}

variable "aws_subnet_name" {
  description = "this is the name of the Subnet" 
  default = "nedum-dev-subnet" 
}

variable "cidr_block" {
  description = "this is the IP address space of the vpc/subnet" 
  type = list(string)
}

resource "aws_vpc" "nedum_vpc" {
  cidr_block = var.cidr_block[0]
  tags = {
    "Name" = var.aws_vpc_name 
  }
}

resource "aws_subnet" "nedum_subnet" {
 vpc_id =  aws_vpc.nedum_vpc.id
 cidr_block = var.cidr_block[1]
 availability_zone = "us-east-1a"
 tags = {
    "Name" = var.aws_subnet_name 
  }
}

data "aws_vpc" "selected" {
  id = "vpc-03131b6ee59b88afe"
}

resource "aws_subnet" "example" {
  vpc_id            = data.aws_vpc.selected.id
  availability_zone = "us-east-1a"
  cidr_block        = "172.31.48.0/20"
  tags = {
    Name ="nedum"
  }
}

output "default-vpc-name" {
  value = aws_subnet.example.tags.Name
}

output "default-vpc-id" {
  value = aws_subnet.example.vpc_id
}