resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.type_in
    key_name = var.key
  
}