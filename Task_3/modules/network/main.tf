data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name,
    Env = var.env
    }
}

resource "aws_subnet" "subnets" {
  vpc_id     = aws_vpc.vpc.id
  count             = length(var.public_subnet_names)
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = var.public_subnet_names[count.index],
    Env = var.env
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name,
    Env = var.env
  }
}

resource "aws_route_table" "pb-rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.pb_rtb_name,
    Env = var.env
  }
}

resource "aws_route_table_association" "public-associations" {
  count = length(var.public_subnet_names)
  subnet_id = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.pb-rtb.id
}