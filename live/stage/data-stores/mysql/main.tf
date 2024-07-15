terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }

    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "stage/data-stores/mysql/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

module "mysql" {
    source = "github.com/K-dash/terraform-playground-modules//data-stores/mysql?ref=v0.0.1"
    db_password = var.db_password
    db_username = var.db_username
    instance_type = var.instance_type
    db_name = "stage_mysql_db"

    # レプリケーションは無効
    backup_retention_period = 0
}
