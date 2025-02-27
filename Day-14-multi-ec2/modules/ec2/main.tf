provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    tags = {
      Name = var.tags
    }
  
}