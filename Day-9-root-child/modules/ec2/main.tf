resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.ins_type

  tags = {
    Name = "syed-EC2"
  }
}