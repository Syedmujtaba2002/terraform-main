variable "ami_id" {
    type = string
    default = "ami-05b10e08d247fb927"
  
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "az" {
    type = string
    default = "us-east-1a"
}
variable "tags" {
    type = string
    default = "test"
}