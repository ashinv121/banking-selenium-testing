# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

resource "aws_instance" "selenium-server" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.selenium-group.id]
  private_ip    = "10.0.1.10" 
  key_name      = "ansible.pem" 

  tags = {
    Name = "selenium-server"
  }
}

resource "aws_instance" "test-server" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.test-server-group.id]
  private_ip    = "10.0.1.11"
  key_name      = "ansible.pem"  

  tags = {
    Name = "test-server"
  }
}

resource "aws_security_group" "selenium-group" {
  name_prefix = "my-security-group"
  description = "My security group"

  # Allow SSH (port 22) and HTTP (port 8080) traffic from any IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "test-server-group" {
  name_prefix = "my-security-group"
  description = "My security group"

  # Allow SSH (port 22) and HTTP (port 8080) traffic from any IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
