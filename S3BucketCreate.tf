provider "aws" {
  region = "us-east-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "dev" {
  bucket = "dev-9353730"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# Upload a file into the S3 bucket
resource "aws_s3_object" "example_object" {
  bucket = aws_s3_bucket.dev.id
  key    = "s3.txt"
  source = "/home/ubuntu/terraform/s3.txt"
}

# Create an IAM group
resource "aws_iam_group" "my_group" {
  name = "my-group" # Replace with your desired group name
}

# Attach the IAM group to the bucket policy
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.dev.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:group/${aws_iam_group.my_group.name}"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.dev.arn,
          "${aws_s3_bucket.dev.arn}/*"
        ]
      }
    ]
  })
}


# Data source to get current AWS account ID
data "aws_caller_identity" "current" {}

# Output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.dev.bucket
}
