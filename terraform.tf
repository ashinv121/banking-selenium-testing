# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

# Create a subnet for instances with internet access
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.33.0/24"

  tags = {
    Name = "PublicSubnet"
  }
}

# Attach the Internet Gateway to the VPC
resource "aws_vpc_attachment" "my_igw_attachment" {
  vpc_id              = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.my_igw.id
}

# Route all traffic from the public subnet to the Internet Gateway
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_instance" "selenium-server" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id  # Specify the public subnet
  key_name      = "ansible" 
  vpc_security_group_ids = [aws_security_group.selenium-group.id]

  tags = {
    Name = "selenium-server"
  }
}

resource "aws_instance" "test-server" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id  # Specify the public subnet
  key_name      = "ansible" 
  vpc_security_group_ids = [aws_security_group.test-server-group.id]

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
