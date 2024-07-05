terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "stage/data-stores/mysql/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-kdash-example"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t3.micro"
    db_name = "example_database"
    skip_final_snapshot = true
    username = var.db_username
    password = var.db_password
}
