variable "name" {
  description = "this is the name of the VPC/Subnet" 
}

variable "cidr_blocks" {
  description = "this is the IP address space of the vpc/subnet" 
  type = string
}

variable "my-IP" {}
variable "instance_type" {}
variable "availability_zone" {}
variable "public_key" {}
variable "vpc_id" {}
variable "subnet_id" {}