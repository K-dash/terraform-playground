terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "stage/services/webserver-cluster/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

module "webserver_cluster" {
    source = "../../../modules/services/webserver-cluster"

    cluster_name = "webservers-stage"
    db_remote_state_bucket = "terraform-state-remote-storage-s3-for-kdash"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    min_size = 2
    max_size = 2
}

# moduleのoutputを利用してalbのsecurity_groupにルールを追加
resource "aws_security_group_rule" "allow_testing_inbound" {
    type = "ingress"
    security_group_id = module.webserver_cluster.alb_security_group_id
    from_port = 12345
    to_port = 12345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
