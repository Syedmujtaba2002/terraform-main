resource "aws_db_instance" "my-primary" {
  allocated_storage       = var.stroage
  db_name                 = var.db_name
  engine                  = var.engine
  engine_version          = var.rds_version
  instance_class          = var.class
  username                = var.user
  password                = var.pass
  db_subnet_group_name    = aws_db_subnet_group.db.name
  parameter_group_name    = var.parameter
  backup_retention_period = var.back_per  # ✅ Enables automatic backups (7 days)
  backup_window           = var.backwindow
  skip_final_snapshot     = var.snapshot
}


resource "aws_db_subnet_group" "db" {
  name = var.name
  subnet_ids = var.sub_id
  tags = {
    Name = var.tags
  }
}

resource "aws_db_instance" "myreadreplica" {
  identifier            = var.idnt
  replicate_source_db   = var.rep_id # ✅ Direct reference, no quotes
  instance_class        = var.rep_class
  allocated_storage     = var.rep_st
  skip_final_snapshot   = var.rep_snap

  depends_on = [aws_db_instance.my-primary]  # ✅ Ensures primary DB is created first
}

