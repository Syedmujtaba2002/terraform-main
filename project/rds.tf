resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "mydatabase"
  username           = "admin"
  password           = "syed1234"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
 
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "rds-instance"
  }
   
}


resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.Db_1a.id, aws_subnet.db_1b.id]

  tags = {
    Name = "db-subnet-group"
  }
}



output "rds_endpoint" {
  value = aws_db_instance.rds_instance.address
}
