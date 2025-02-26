# resource "aws_instance" "name" {
#     ami = "ami-0d682f26195e9ec0f"
#     instance_type = "t2.micro"
#     key_name = "mumbaikeypair"
#     availability_zone = "ap-south-1a"
#     count = 2
#     # tags = {
#     #   Name = "dev"   two resource will create on same name 
#     # }
#     tags = {
#       Name = "dev-${count.index}"
#     }
# }
#

#####diff name 

variable "smh" {
  type    = list(string)
  default = [ "syed", "hussaini"]
}

resource "aws_instance" "name" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "mumbaikeypair"
    availability_zone = "ap-south-1a"
    count = length(var.smh)

    tags = {
      Name = var.smh[count.index]
    }
}
