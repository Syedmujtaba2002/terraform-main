variable "stroage" {
    type = number
    default = 10
}
variable "db_name" {
    type = string
    default = ""
}
variable "engine" {
    type = string
    default = ""
}
variable "rds_version" {
    type = string
    default = ""
}
variable "class" {
    type = string
    default = ""
}

variable "user" {
    type = string
    default = ""
}
variable "pass" {
    type = string
    default = ""
}
variable "subnet" {
    type = string
    default = ""
}
variable "parameter" {
    type = string
    default = ""
}
variable "back_per" {
    type = number
    default = 7
}
variable "backwindow" {
    type = string
    default = ""
}
variable "snapshot" {
    type = bool
    default = true
}


####DB grp
variable "name" {
    type = string
    default = ""
}

variable "sub_id" {
     type = list(string)
    default = []
}
variable "tags" {
     type = string
    default = ""
}

###replica
variable "idnt" {
    type = string
    default = ""
}

variable "rep_id" {
    type = string
    default = ""
}

variable "rep_class" {
    type = string
    default = ""
}
variable "rep_st" {
    type = number
    default = 10
}
variable "rep_snap" {
    type = bool
    default = true
}
