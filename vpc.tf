
resource "aws_vpc" "dev_vpc" {
  cidr_block              = "10.0.0.0/16"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support = true

  tags      = {
    Name    = "virtual private cloud"
  }
}

# create public subnet az1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet Az1"
  }
}

# create private subnet az1
# terraform aws create subnet
resource "aws_subnet" "private-subnet_az1" {
  vpc_id     = aws_vpc.dev_vpc.id 
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "private subnet Az1" 
  }
}

# create public subnet az2
# terraform aws create subnet
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet Az2"
  }
}

# create private subnet az2
# terraform aws create subnet
resource "aws_subnet" "private-subnet_az2" {
  vpc_id     = aws_vpc.dev_vpc.id 
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private subnet Az2" 
  }
}

# create internet gateway and attach it to vpc
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.dev_vpc.id

  tags      = {
    Name    = "vpc_internet gateway "
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.dev_vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "public route table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id       = aws_vpc.dev_vpc.id

  tags       = {
    Name     = "private route table"
  }
}

# associate public subnet az1 to "public route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  route_table_id      = aws_route_table.public_route_table.id
  subnet_id           = aws_subnet.public_subnet_az1.id 
  depends_on          = [aws_route_table.public_route_table, aws_subnet.public_subnet_az1]
}

# associate private subnet az1 to "private route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private_subnet_az1_route_table_association" {
  route_table_id      = aws_route_table.private_route_table.id
  subnet_id           = aws_subnet.private-subnet_az1.id 
}

# associate public subnet az2 to "public route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  route_table_id      = aws_route_table.public_route_table.id
  subnet_id           = aws_subnet.public_subnet_az2.id 
}

# associate private subnet az2 to "private route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private_subnet_az2_route_table_association" {
  route_table_id      = aws_route_table.private_route_table.id
  subnet_id           = aws_subnet.private-subnet_az2.id 
}




