data "aws_ami" "amazon_linux_2023" {
    most_recent = true
    owners = [ "amazon"]
    filter {
      name = "name"
      values = ["al2023-ami-*-x86_64"]
    }
   filter {
    name = "root-device-type"
    values = [ "ebs" ]
   }
   filter {
     name = "virtualization-type"
     values = [ "hvm" ]
   }
   filter {
     name = "architecture"
     values = [ "x86_64" ]
   }
  
}

resource "aws_instance" "dev" {
    ami = data.aws_ami.amazon_linux_2023.id
    instance_type = "t2.micro"
}