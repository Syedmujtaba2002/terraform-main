resource "aws_instance" "bastion" {
  ami             = "ami-00bb6a80f01f03502"  # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  key_name = "mumbaikeypair"
  subnet_id       = aws_subnet.public1.id
  availability_zone = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "bastion-server"
  }
 
}


resource "aws_instance" "frontend" {
  ami             = "ami-00bb6a80f01f03502"  # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  key_name = "mumbaikeypair"
  availability_zone = "ap-south-1a"
  subnet_id       = aws_subnet.front_1a.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "frontend-server"
  }
}

resource "aws_instance" "backend" {
  ami             = "ami-00bb6a80f01f03502"  # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  key_name = "mumbaikeypair"
  availability_zone = "ap-south-1a"
  subnet_id       = aws_subnet.backend_1a.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "backend-server"
  }
  
}

resource "aws_ec2_instance_connect_endpoint" "syed" {
  subnet_id = aws_subnet.public1.id
  tags = {
     Name = "vpc"
   }
}