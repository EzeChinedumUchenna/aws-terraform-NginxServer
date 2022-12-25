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
variable "instance_type" {}
variable "availability_zone" {}
variable "publicKey-Location" {}
variable "vpc_id" {}
variable "default_route_table_id" {}