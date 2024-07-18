provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "admin_user" {
  name = "jack"
  tags = {
    Description = "This user is created for managing AWS Resources"
  }
}

resource "aws_iam_access_key" "ak" {
  user = aws_iam_user.admin_user.name
}

resource "aws_iam_user_policy" "admin_policy" {
  name   = "adminPolicy"
  user   = aws_iam_user.admin_user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "ec2_policy" {
  name   = "ec2Policy"
  user   = aws_iam_user.admin_user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "s3_policy" {
  name   = "s3Policy"
  user   = aws_iam_user.admin_user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
