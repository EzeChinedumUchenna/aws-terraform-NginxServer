// Creating a Security Group
resource "aws_default_security_group" "my-default-SG" {
  vpc_id      = var.vpc_id

  ingress { 
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_blocks]
    
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port        = 80
  #   to_port          = 80
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
    
  # }

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

// creating the EC2 instance

data "aws_ami" "ubuntu-image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

 owners = ["amazon"]
}

// To Generate and automate the SSH Key pair.
resource "aws_key_pair" "SSH-Key" {
  key_name = "server-key"  
  public_key = "${file(var.public_key)}" // the instance will generate a public Key from your local machine public key. 
}


resource "aws_instance" "my-web-server" {
  ami           = data.aws_ami.ubuntu-image.id
  instance_type = var.instance_type
  user_data = file("./script.sh")
  // user_data_replace_on_change  = true
  tags = {
    Name = "${var.name}-EC2" 
  }

  subnet_id = var.subnet_id // Lunching this EC2 into our created subnet
  vpc_security_group_ids = [aws_default_security_group.my-default-SG.id] // asssociating our created Security Group. please Note that SG is a list ([])of rules

  associate_public_ip_address = true
  
  key_name = aws_key_pair.SSH-Key.key_name  // NOTE You can generate Key pair on Aws, download it to your machine. Then move the .pem to .ssh folder and SSH into the EC2 instance using "ssh ~/.ssh/my-Aws-LinuxEC2-KeyPairs.pem ec2-user@34.227.56.135"
   
 
  /*user_data = <<-EOF
          sudo yum update -y && sudo yum install -y docker
          sudo systemctl start docker
          sudo usermod -aG docker ec2-user
          docker run --name some-nginx -d -p 8080:80 nginx
          EOF
*/
}
