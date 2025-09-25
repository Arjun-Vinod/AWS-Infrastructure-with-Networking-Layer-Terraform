resource "aws_eip" "nat_eip_1" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.aws_project_igw]
  tags = {
    Name = "aws-project-nat-eip-1"
  }
}

resource "aws_eip" "nat_eip_2" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.aws_project_igw]
  tags = {
    Name = "aws-project-nat-eip-2"
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "aws-project-nat-gateway-1"
  }
  depends_on = [aws_internet_gateway.aws_project_igw]
}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "aws-project-nat-gateway-2"
  }
  depends_on = [aws_internet_gateway.aws_project_igw]
}