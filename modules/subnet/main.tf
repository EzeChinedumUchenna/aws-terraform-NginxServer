resource "aws_subnet" "nedum_subnet" {
 vpc_id =  var.vpc_id
 cidr_block = var.cidr_block
 availability_zone = var.availability_zone
 tags = {
    "Name" = "${var.name}-subnet-1" 
  }
}

resource "aws_internet_gateway" "nedum-igw" {
  vpc_id = var.vpc_id 

  tags = {
    Name = "${var.name}-igw" 
  }
}

resource "aws_default_route_table" "my-rtb" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nedum-igw.id
  }

  tags = {
    Name = "${var.name}-rtb"
  }
}// we dont have to explicitely associate the route table to the subnet as all subnet within the VPC will automatically be assigned the route table unless explicitly assigned
 
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