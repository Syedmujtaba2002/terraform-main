provider "aws" {
  region = local.region
}
locals {
  region = "us-east-1"
  environment = "dev"
  instance_type = "t2.micro"
  ami = "ami-05b10e08d247fb927"
  Name = "ec-2"
}

resource "aws_instance" "name" {
    ami = local.ami
    instance_type = local.instance_type
    tags = {
      Name = local.Name
    }
  
}