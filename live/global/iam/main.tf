terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "global/iam/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

module "users" {
    source = "github.com/K-dash/terraform-playground-modules//landing-zone/iam-user?ref=v0.0.2"
    for_each = toset(var.user_names)
    user_name = each.value
}
