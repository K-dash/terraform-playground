terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "prod/services/webserver-cluster/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}


module "webserver_cluster" {
    source = "github.com/K-dash/terraform-playground-modules//services/webserver-cluster?ref=v0.0.6b"

    server_text = "New Server Text for Prod"

    cluster_name = "webservers-prod"
    db_remote_state_bucket = "terraform-state-remote-storage-s3-for-kdash"
    db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    min_size = 2
    max_size = 10
    enable_auto_scaling = true

    custom_tags = {
        Owner = "K-dash"
        DeployedBy = "Terraform"
    }
}
