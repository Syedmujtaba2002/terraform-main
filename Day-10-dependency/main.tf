resource "aws_vpc" "custom_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "cst_vpc"
    }
  }
resource "aws_security_group" "prod" {
    name = "test_sg"
    description = "allow "
    vpc_id = aws_vpc.custom_vpc.id
    
    
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
  depends_on = [ aws_vpc.custom_vpc ]
}


resource "aws_s3_bucket" "syed" {
  bucket = "syedsdnjdfdsjdj"
  
}

resource "aws_instance" "dev" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    depends_on = [ aws_s3_bucket.syed]
}