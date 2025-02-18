resource "aws_instance" "import" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"
    key_name = "mumbaikeypair"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "test-ec2"
       }
       #lifecycle {
        # ignore_changes = [ tags ]
       #}
      # lifecycle {
        # create_before_destroy = true
       #}
       lifecycle {
         prevent_destroy = false
         
       }
}

