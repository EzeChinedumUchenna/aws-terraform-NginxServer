variable "name" {
  description = "this is the name of the VPC/Subnet" 
}

variable "cidr_block" {
  description = "this is the IP address space of the vpc/subnet" 
  type = string
}

variable "availability_zone" {}
variable "vpc_id" {}
variable "default_route_table_id" {}