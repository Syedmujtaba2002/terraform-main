module "syed" {
      source = "../Day-2-basic-code"
    ami_id = "ami-0ddfba243cbee3768"
    type_in = "t2.micro"
    
    key = "mumbaikeypair"
}
