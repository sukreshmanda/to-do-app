resource "aws_vpc" "as-app-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "as-app-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.as-app-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "as-app-public-subnet"
  }
}