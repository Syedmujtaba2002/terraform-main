provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  ins_type = var.inst_type
}

module "aws_s3_bucket" {
    source = "./modules/s3"
    name = var.buc_name
    acl = var.acl_buck
    
  }