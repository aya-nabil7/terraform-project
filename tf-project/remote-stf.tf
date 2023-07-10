#create resources that need a remote backend

# Create S3 bucket
resource "aws_s3_bucket" "remote-state-file" {
  bucket = "remote-stf-ayan"
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "s3-version" {
  bucket = aws_s3_bucket.remote-state-file.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Create DynamoDB table for locking state
resource "aws_dynamodb_table" "lock-state-db" {
  name         = "terraform_locks_ayan"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

#Enable remote backend:
terraform {
  backend "s3" {
    bucket         = "remote-stf-ayan"
    key            = "dev/teraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks_ayan"
    encrypt        = true
  }
}