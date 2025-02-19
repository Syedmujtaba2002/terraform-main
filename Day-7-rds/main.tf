#creating rds
resource "aws_db_instance" "rds" {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Syed1234"
  db_subnet_group_name    = aws_db_subnet_group.db.name
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot = true 

  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

   # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = "arn:aws:iam::664418968609:role/rdds"
  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = false
    # Skip final snapshot
 # skip_final_snapshot = false

  tags = {
    Name = "test-rds"
  }
}
# creating db subnet group
resource "aws_db_subnet_group" "db" {
    name = "mydb-subnet"
    subnet_ids = ["subnet-0af73664c2223a7fe","subnet-048ce317f01630865"]
    tags = {
      Name = "db-sub-grp"
    }
}


