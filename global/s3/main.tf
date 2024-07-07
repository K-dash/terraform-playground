terraform {
    # tfstateファイル格納先のリモートストレージ設定
    backend "s3" {
        key = "global/s3/terraform.tfstate"
    }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-state-remote-storage-s3-for-kdash"

    # 誤ってS3バケットを削除するのを防止する
    lifecycle {
        prevent_destroy = true
    }
}

# tfstateファイルの履歴が残るようにバージョン管理する
resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

# サーバーサイド暗号化を有効化する
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
    bucket = aws_s3_bucket.terraform_state.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# S3バケットに対する全パブリックアクセスを拒否する
resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.terraform_state.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

# tfstateファイルのロック用DynamoDB
resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-state-remote-storage-s3-for-kdash-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}
