terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }

    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "prod/data-stores/mysql/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
    alias = "primary"
}

provider "aws" {
    region = "us-west-1"
    alias = "replica"
}

module "mysql_primary" {
    source = "github.com/K-dash/terraform-playground-modules//data-stores/mysql?ref=v0.0.10"

    # primaryプロバイダを使用する
    providers = {
        aws = aws.primary
    }

    db_password = var.db_password
    db_username = var.db_username
    instance_type = var.instance_type
    db_name = "prod_mysql_db"

    # レプリケーションを有効化
    backup_retention_period = 1
}

module "mysql_replica" {
    source = "github.com/K-dash/terraform-playground-modules//data-stores/mysql?ref=v0.0.10"

    # replicaプロバイダを使用する
    providers = {
        aws = aws.replica
    }
    instance_type = var.instance_type


    # プライマリのレプリカとして設定
    replication_source_db = module.mysql_primary.arn
}
