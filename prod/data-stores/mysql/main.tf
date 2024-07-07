terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "prod/data-stores/mysql/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

module "mysql" {
    source = "../../../modules/data-stores/mysql"
    db_password = var.db_password
    db_username = var.db_username
    instance_type = "db.t3.micro"
}
