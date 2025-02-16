terraform {
  backend "s3" {
    bucket = "syedmujtaba"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
