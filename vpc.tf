resource "aws_vpc" "as-app-vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "as-app-vpc"
  }
}

resource "aws_subnet" "public-1" {
  vpc_id = aws_vpc.as-app-vpc.id
  cidr_block = "10.0.0.0/25"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "as-app-public-subnet-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id = aws_vpc.as-app-vpc.id
  cidr_block = "10.0.0.128/25"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1b"

  tags = {
    Name = "as-app-public-subnet-2"
  }
}

resource "aws_internet_gateway" "as-app-gateway" {
  vpc_id = aws_vpc.as-app-vpc.id

  tags = {
    Name = "as-app-gateway"
  }
}
resource "aws_route" "as-app-public-route" {
  route_table_id = aws_vpc.as-app-vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.as-app-gateway.id
}