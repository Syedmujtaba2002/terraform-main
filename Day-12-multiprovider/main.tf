provider "aws" {
  region = "us-east-1"
}

provider "aws" {
    region = "ap-south-1"
    alias = "provd2"
  
}
resource "aws_s3_bucket" "provider-1" {
    bucket = "syedbuckertqqqqq"
    provider = aws.provd2   # s3 bucket will create into "ap-south-1"
  
}

resource "aws_instance" "name" {
    ami = "ami-05b10e08d247fb927"
    instance_type = "t2.micro"
    key_name = "ng"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dev"
    }
   
  
}