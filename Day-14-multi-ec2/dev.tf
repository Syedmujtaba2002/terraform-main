
module "dev" {
    source = "./modules/ec2"
    ami_id = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    tags = "dev"
  
}