resource "aws_instance" "syed" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "mumbaikeypair"
}

resource "aws_s3_bucket" "prod" {
    bucket = "hhhhddsjfks" 
}

#terraform apply -target=aws_s3_bucket.prod
#terraform destroy -target=aws_s3_bucket.prod

#Example below for multiple targets
#terraform apply -target=aws_s3_bucket.prod -target=aws_instance.syed 