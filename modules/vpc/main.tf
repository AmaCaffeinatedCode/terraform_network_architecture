resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-vpc",
      project_url = var.project_url
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-igw",
      project_url = var.project_url
    }
  )
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.az[0]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-subnet",
      project_url = var.project_url
    }
  )
}

resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_a
  availability_zone = var.az[1]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-subnet-a",
      project_url = var.project_url
    }
  )
}

resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_b
  availability_zone = var.az[2]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-subnet-b",
      project_url = var.project_url
    }
  )
}

resource "aws_eip" "nat" {
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-nat-eip",
      project_url = var.project_url
    }
  )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public.id
  depends_on = [aws_internet_gateway.igw]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-nat-gateway",
      project_url = var.project_url
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-rt",
      project_url = var.project_url
    }
  )
}

resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-rt",
      project_url = var.project_url
    }
  )
}

resource "aws_route" "private_nat_gateway" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
