# Configure the AWS Provider
provider "aws" {
  region     = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {}
variable "aws_secret_key" {}


# Set the existing VPC ID
variable "existing_vpc_id" {
  default = "vpc-0c9e049ba97ebee48"
}

# Create subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.existing_vpc_id
  cidr_block              = "172.31.48.0/20"
  availability_zone       = "eu-north-1a"  # Specify the appropriate availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Create security groups
resource "aws_security_group" "selenium_group" {
  vpc_id      = var.existing_vpc_id
  name_prefix = "selenium-security-group"
  description = "My security group for Selenium"

  # Allow SSH (port 22) and HTTP (port 8080) traffic from any IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}

resource "aws_security_group" "test_server_group" {
  vpc_id      = var.existing_vpc_id
  name_prefix = "test-server-security-group"
  description = "My security group for Test Server"

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
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}

# Create EC2 instances
resource "aws_instance" "selenium-server" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "ansible"
  vpc_security_group_ids = [aws_security_group.selenium_group.id]
  private_ip    = "172.31.48.35"  # Assign private IP address

  tags = {
    Name = "selenium-server"
  }
}

resource "aws_instance" "test-server" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "ansible"
  vpc_security_group_ids = [aws_security_group.test_server_group.id]
  private_ip    = "172.31.48.33"  # Assign private IP address

  tags = {
    Name = "test-server"
  }
}
