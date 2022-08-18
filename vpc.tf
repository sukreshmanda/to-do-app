resource "aws_vpc" "as-app-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "as-app-vpc"
  }
}

resource "aws_subnet" "public-1" {
  vpc_id = aws_vpc.as-app-vpc.id
  cidr_block = "10.0.0.0/25"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "as-app-public-subnet-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id = aws_vpc.as-app-vpc.id
  cidr_block = "10.0.0.128/25"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "as-app-public-subnet-2"
  }
}

resource "aws_internet_gateway" "as-app-gateway" {
  vpc_id = aws_vpc.as-app-vpc.id

  tags = {
    Name = "main"
  }
}