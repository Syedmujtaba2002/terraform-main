resource "aws_instance" "dev" {
    ami = "ami-053a45fff0a704a47"
    instance_type = "t2.micro"
    key_name = "ng"
    subnet_id = aws_subnet.prod_pvt.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    tags = {
      Name = " pvt-ec2"
    }
  }