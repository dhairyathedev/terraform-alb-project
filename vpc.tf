resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "Main VPC TF"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "Main IGW TF"
  }
}

resource "aws_subnet" "main_public_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

  tags = {
    "Name" = "Main Public Subnet A"
  }
}

resource "aws_subnet" "main_public_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    "Name" = "Main Public Subnet B"
  }
}

resource "aws_route_table" "main_public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    "Name" = "Main Public Route Table"
  }
}

resource "aws_route_table_association" "main_public_subnet_a_rt_assoc" {
  subnet_id      = aws_subnet.main_public_subnet_a.id
  route_table_id = aws_route_table.main_public_route_table.id
}

resource "aws_route_table_association" "main_public_subnet_b_rt_assoc" {
  subnet_id      = aws_subnet.main_public_subnet_b.id
  route_table_id = aws_route_table.main_public_route_table.id

}
