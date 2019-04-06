# Terraform versioner

This module should be the first to deploy in a remote state version fashion architecture.

Note: your AWS credentials will automatically be retrieved by Terraform as long as there are located in `~/.aws/credentials` (under `[default]` section).

Don't forget to setup your sensitive information inside a `variables.tf`
e.g.
```terraform
variable "aws-account-id" {
  default = "[YOUR-AWS-ACCOUNT-ID]"
  description = "AWS account ID"
}


variable "aws-region" {
  default = "[YOUR-AWS-REGION]"
  description = "AWS region"
}

variable "ami-id" {
  default = "[YOUR-AWS-EC2-AMI-ID]"
  description = "AWS Image ID"
}

variable "ami-type" {
  default = "[YOUR-AWS-EC2-INSTANCE-TYPE]"
  description = "AWS Image type"
}

```

Once this module is deployed, then you can use this code in a `terraform.tf` in subsequent modules to version your deployments

```terraform
terraform {
 backend "s3" {
  encrypt = true
  bucket = "terraform-remote-state-storage-s3-minus-et-cortex"
  dynamodb_table = "terraform-state-lock-dynamo"
  key = "[YOUR-MODULE]/terraform.tfstate" // or path/to/file which will contains the versioned changes
 }
}
```
