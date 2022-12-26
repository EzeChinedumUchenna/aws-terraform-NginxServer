
output "vpc-name" {
  value = aws_vpc.nedum_vpc.tags.Name
 
}

output "public-IP" {
  value = module.nginxServer.public_ip.public_ip
}

output "private-IP" {
  value = module.nginxServer.private_ip.private_ip
}

output "vpc-id" {
  value = aws_vpc.nedum_vpc.id
}