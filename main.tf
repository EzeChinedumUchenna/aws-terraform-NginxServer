provider "aws" {
    region = "us-east-1"
    # access_key = "................."
    # secret_key = "................."

  # Configuration options
}

variable "name" {
  description = "this is the name of the VPC/Subnet" 
}

variable "rtb-id" {
  description = "this is the default route table ID" 
}

variable "cidr_block" {
  description = "this is the IP address space of the vpc/subnet" 
  type = list(string)
}

variable "my-IP" {}



resource "aws_vpc" "nedum_vpc" {
  cidr_block = var.cidr_block[0]
  tags = {
    "Name" = "${var.name}-vpc"
  }
}

resource "aws_subnet" "nedum_subnet" {
 vpc_id =  aws_vpc.nedum_vpc.id
 cidr_block = var.cidr_block[1]
 availability_zone = "us-east-1a"
 tags = {
    "Name" = "${var.name}-subnet-1" 
  }
}

resource "aws_internet_gateway" "nedum-igw" {
  vpc_id = aws_vpc.nedum_vpc.id 

  tags = {
    Name = "${var.name}-igw" 
  }
}

/* // Incase you want to create a new route table aside the defualt rt created by terraform use this below:

resource "aws_route_table" "my-rtb" {
  vpc_id = aws_vpc.nedum_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nedum-igw.id
  }

  tags = {
    Name = "${var.name}-rtb" 
  }
}



resource "aws_route_table_association" "rtb-to-subnet-association" {
  subnet_id      = aws_subnet.nedum_subnet.id
  route_table_id = aws_route_table.my-rtb.id 
}
*/

resource "aws_default_route_table" "my-rtb" {
  default_route_table_id = aws_vpc.nedum_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nedum-igw.id
  }

  tags = {
    Name = "${var.name}-rtb"
  }
}// we dont have to explicitely associate the route table to the subnet as all subnet within the VPC will automatically be assigned the route table unless explicitly assigned

// Creating a Security Group
resource "aws_default_security_group" "my-default-SG" {
  vpc_id      = aws_vpc.nedum_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my-IP]
    
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-SecurityGroup"
  }
}

output "vpc-name" {
  value = aws_vpc.nedum_vpc.tags.Name
 
}

output "vpc-id" {
  value = aws_vpc.nedum_vpc.id
}