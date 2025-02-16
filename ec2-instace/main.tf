terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "workspace-example/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "example" {
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = terraform.workspace == "default" ? "t2.micro" : "t2.medium"
}
