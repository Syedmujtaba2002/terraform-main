module "syed-rds" {
source = "../Day-7-rds"

##master
stroage = 10
db_name = "mydb"
engine = "mysql"
rds_version = "8.0"
class = "db.t4g.micro"
user = "admin"
pass = "syed1234"
subnet = "aws_db_subnet_group.db.name"
parameter = "default.mysql8.0"
back_per = 7
backwindow = "02:00-03:00"
snapshot = true


###DB 
name = "my-db-sub"
sub_id = ["subnet-009a44dc8123314ac","subnet-039f1d951c89ed574"]
tags = "db-sub-grp"


##replica
idnt = "myreplica"
rep_id = "aws_db_instance.my-primary.identifier"
rep_class = "db.t4g.micro"
rep_st = 10
rep_snap = true
}