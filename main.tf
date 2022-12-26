provider "aws" {
    region = "us-east-1"
    # access_key = "................."
    # secret_key = "................."

  # Configuration options
}



module "nginxServer-subnet" {
  source = "./modules/subnet"  
  vpc_id = aws_vpc.nedum_vpc.id
  cidr_block = var.cidr_block[0]
  name = var.name
  availability_zone = var.availability_zone
  default_route_table_id = aws_vpc.nedum_vpc.default_route_table_id
}


module "nginxServer" {
  source = "./modules/nginxServer"
  cidr_blocks = var.cidr_block[1]
  name = var.name
  public_key = var.publicKey-Location        
  instance_type = var.instance_type
  vpc_id = aws_vpc.nedum_vpc.id
  my-IP = var.my-IP
  subnet_id = module.nginxServer-subnet.subnet.id 
  availability_zone = var.availability_zone
}

resource "aws_vpc" "nedum_vpc" {
  cidr_block = var.cidr_block [0]
  tags = {
    "Name" = "${var.name}-vpc"
  }
}


