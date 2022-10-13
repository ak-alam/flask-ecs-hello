data "aws_availability_zones" "azs" {
}

resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc["vpc_cidr"]
  instance_tenancy = "default"

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  count = length(var.vpc["public_subnet"])
  cidr_block = element(var.vpc["public_subnet"], count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  tags = {
    Name = "${var.env}-pub-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  count = length(var.vpc["private_subnet"])
  cidr_block = element(var.vpc["private_subnet"], count.index)
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  tags = {
    Name = "${var.env}-private-${count.index + 1}"
  }
}