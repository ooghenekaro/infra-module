/*
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-${var.environment}-terraform-state"
  acl    = "private"

  tags = {
    Name        = "terraform-state-${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "${var.project_name}-${var.environment}-terraform-lock"
  billing_mode    = "PAY_PER_REQUEST"
  hash_key        = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-lock-${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_lock.name
}
*/
