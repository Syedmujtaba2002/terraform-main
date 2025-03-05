resource "aws_vpc" "three_tier_vpc" {
  enable_dns_hostnames = true
  enable_dns_support = true
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "three-tier-vpc"
  }
}

resource "aws_security_group" "allow_all" {
  vpc_id = aws_vpc.three_tier_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "3-tier-SG"
  }
}

resource "aws_subnet" "public1" {
  map_public_ip_on_launch = true
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  map_public_ip_on_launch = true
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "front_1a" {
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "front-1a"
  }
}

resource "aws_subnet" "front_1b" {
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "front-1b"
  }
}

resource "aws_subnet" "backend_1a" {
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "backend-1a"
  }
}

resource "aws_subnet" "backend_1b" {
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "backend-1b"
  }
}

resource "aws_subnet" "Db_1a" {
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Db-1a"
  }
}

resource "aws_subnet" "db_1b" {
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "db-1b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.three_tier_vpc.id
  
  tags = {
    Name = "3-tier-IG"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

#### public association
resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private1_assoc" {
  subnet_id      = aws_subnet.backend_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2_assoc" {
  subnet_id      = aws_subnet.backend_1b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private3_assoc" {
  subnet_id      = aws_subnet.front_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private4_assoc" {
  subnet_id      = aws_subnet.front_1b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private5_assoc" {
  subnet_id      = aws_subnet.Db_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private6_assoc" {
  subnet_id      = aws_subnet.db_1b.id
  route_table_id = aws_route_table.private_rt.id
}
