# AWS S3 Bucket for AppSpec file
resource "aws_s3_bucket" "appspec_bucket" {
  bucket = "karo-appspec-bucket" 

  tags = {
    Name = "AppSpecBucket"
  }
}


