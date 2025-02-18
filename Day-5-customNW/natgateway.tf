#creating Eip
resource "aws_eip" "prod" {
    domain = "vpc"
}

#creating nat gateway
resource "aws_nat_gateway" "prod" {
    allocation_id = aws_eip.prod.id
    subnet_id = aws_subnet.prod.id
    tags = {
      Name = "test_NG"
    }
    depends_on = [ aws_internet_gateway.prod ]
}

#creating private subnet
resource "aws_subnet" "prod_pvt" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "pvt_subnet"
    }
  }

#creating private route table
resource "aws_route_table" "prod_pvt" {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.prod.id
    }
  tags = {
    Name = "pvt-rt"
  }
}

#edit subnet
resource "aws_route_table_association" "prod_pvt" {
    subnet_id = aws_subnet.prod_pvt.id
    route_table_id = aws_route_table.prod_pvt.id
}