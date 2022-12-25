
output "vpc-name" {
  value = aws_vpc.nedum_vpc.tags.Name
 
}

output "public-IP" {
  value = aws_instance.my-web-server.public_ip
}

output "private-IP" {
  value = aws_instance.my-web-server.private_ip
}

output "vpc-id" {
  value = aws_vpc.nedum_vpc.id
}