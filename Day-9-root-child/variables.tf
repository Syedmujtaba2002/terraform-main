  variable "inst_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
type = string
default = "ami-0ddfba243cbee3768"
}

###S3
variable "buc_name" {
    type = string
    default = "syed1111syed"
}
variable "acl_buck" {
    type = string
    default = "private"
}
