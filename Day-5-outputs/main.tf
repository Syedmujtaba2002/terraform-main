resource "aws_instance" "dev" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"
    key_name = "mumbaikeypair"
       tags = {
      Name = "dev"
    }
  
}