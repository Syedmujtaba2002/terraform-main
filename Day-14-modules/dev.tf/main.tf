provider "aws" {
    region = "ap-south-1"
}

module "dev_ec2" {
    source = ".."
  
}