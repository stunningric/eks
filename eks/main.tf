resource "aws_vpc" "rcdemo" {
  cidr_block = var.vpc-cidr
}

resource "aws_subnet" "rcdemo-public-subnets" {
  count                   = length(var.public-subnet)
  vpc_id                  = aws_vpc.rcdemo.id
  cidr_block              = element(var.public-subnet, count.index)
  availability_zone       = element(var.availability-zones, count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "rcdemo-private-subnets" {
  count             = length(var.private-subnet)
  vpc_id            = aws_vpc.rcdemo.id
  cidr_block        = element(var.private-subnet, count.index)
  availability_zone = element(var.availability-zones, count.index)
}

resource "aws_internet_gateway" "rcdemo-gw" {
  vpc_id = aws_vpc.rcdemo.id
}

resource "aws_route_table" "rcdemo-routetable-public" {
  vpc_id = aws_vpc.rcdemo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rcdemo-gw.id
  }
}

resource "aws_route_table" "rcdemo-routetable-private" {
  vpc_id = aws_vpc.rcdemo.id
}

resource "aws_route_table_association" "rcdemora-public" {
  count          = length(var.public-subnet)
  subnet_id      = element(aws_subnet.rcdemo-public-subnets[*].id, count.index)
  route_table_id = aws_route_table.rcdemo-routetable-public.id
}

resource "aws_route_table_association" "rcdemora-private" {
  count          = length(var.private-subnet)
  subnet_id      = element(aws_subnet.rcdemo-private-subnets[*].id, count.index)
  route_table_id = aws_route_table.rcdemo-routetable-private.id
}

resource "aws_security_group" "rcdemo-sg" {
  name        = "rcdemo-sg"
  description = "Allow"
  vpc_id      = aws_vpc.rcdemo.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
