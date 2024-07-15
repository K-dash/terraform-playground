terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }

    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "multi-account/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
    alias = "parent"
}

provider "aws" {
    region = "us-east-2"
    alias = "child"

    assume_role {
        role_arn = "arn:aws:iam::${var.child_account_id}:role/OrganizationAccountAccessRole"
    }
}

module "multi_account_example" {
    source = "github.com/K-dash/terraform-playground-modules//multi-account?ref=v0.0.12"
    providers = {
        aws.parent = aws.parent
        aws.child  = aws.child
    }
}
