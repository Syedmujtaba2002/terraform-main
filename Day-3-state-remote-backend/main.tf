resource "aws_instance" "name" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"
    key_name = "mumbaikeypair"
    tags = {
      Name = "dev"
    }
  
}
resource "aws_s3_bucket" "name" {
    bucket = "syedsmh1423"
  
}