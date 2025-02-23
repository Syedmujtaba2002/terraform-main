data "aws_subnet" "name" {
    filter {
      
      name = "tag:Name"
      values = [ "subnet-1" ]
    }
}
data "aws_security_groups" "syed" {
    filter {
      
      name = "tag:Name"
      values = [ "test" ]
    }
}

resource "aws_instance" "dev" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id
    vpc_security_group_ids =[data.aws_security_groups.syed.ids[0]]
}