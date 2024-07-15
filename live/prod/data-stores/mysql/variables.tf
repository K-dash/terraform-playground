variable "db_username" {
    description = "The username for the database"
    type = string
    sensitive = true
}

variable "db_password" {
    description = "The password for the database"
    type = string
    sensitive = true
}

variable "instance_type" {
    description = "The type of EC2 Instances to run (e.g. t2.micro)"
    type = string
    default = "db.t3.micro"
}
