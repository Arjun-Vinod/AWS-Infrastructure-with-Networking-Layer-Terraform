resource "aws_vpc" "aws_project" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "aws-project"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.aws_project.id
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "aws-project-public-subnet-1"
    Type = "Public"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.aws_project.id
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "aws-project-public-subnet-2"
    Type = "Public"
  }
}