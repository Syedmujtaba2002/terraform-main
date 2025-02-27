resource "aws_instance" "name" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "mumbaikeypair"
    
    tags = {
      Name = "dev"
    }
  
}