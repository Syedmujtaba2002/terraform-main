# creating vpc
 resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags ={
       Name = "test_vpc"
    } 
 }

 # creating subnet
 resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "test_subnet"
    }
 }
 
#creating Internet Gateway
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
      Name = "test_IG"
    }
  }

#creating Route Table and edit RT
resource "aws_route_table" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
      Name = "test_rt"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod.id
    }
  }

#route table subnet assoiation
resource "aws_route_table_association" "prod" {
    route_table_id = aws_route_table.prod.id
    subnet_id = aws_subnet.prod.id
  }

#creatig security group
resource "aws_security_group" "prod" {
    name = "test_sg"
    description = "allow "
    vpc_id = aws_vpc.prod.id
    
    
    ingress {
        description = "allow shh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
        description = "allow http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_test"
  }
}

