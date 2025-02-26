
# #example-2
# variable "aws_region" {
#   description = "The region in which to create the infrastructure"
#   type        = string
#   default     = "us-west-2" #here we need to define either us-west-1 or eu-west-2 if i give other region will get error 
#   validation {
#     condition = var.aws_region == "us-west-2" || var.aws_region == "eu-west-1"
#     error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, eu-west-1"
#   }
# }

#  resource "aws_s3_bucket" "dev" {
#     bucket = "syegdvhdbhsbbjbjbvdj"
    
  
# }

#example-1 s3 buvket creation condition based 
provider "aws" {
  region = "us-east-1"
}

variable "create_bucket" {
  description = "Set to true to create the S3 bucket."
  type        = bool
  default     = true
}

resource "aws_s3_bucket" "example" {
  count = var.create_bucket ? 1 : 0
  bucket= "dyeygfgdhbhcb"
  

  tags = {
    Name        = "ConditionalBucket"
    Environment = "Dev"
  }
}
