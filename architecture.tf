provider "aws" {
  region = "${var.aws-region}"
}

# terraform state file setup
# create an S3 bucket to store the state file in
# beware : terraform destroy will not be able to delete the s3 bucket as long as there are files in it
# so when you will delete the files of the state it won't be able to sync and destroy too
# meaning the s3 resource is the only one you will to destroy manually
resource "aws_s3_bucket" "terraform-state-storage-s3" {
    bucket = "terraform-remote-state-storage-s3-${var.aws-account-id}"
 
    versioning {
      enabled = true
    }
 
    lifecycle {
      prevent_destroy = true
    }
 
    tags {
      Name = "S3 Remote Terraform State Store"
    }      
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
