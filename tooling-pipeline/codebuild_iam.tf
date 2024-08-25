# IAM role for CodeBuild in the tooling account
resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-CodeBuildRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach policies to the CodeBuild role
resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn  = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"  # Allows access to CodeBuild resources
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Allows access to S3 buckets
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"  # Allows access to CloudWatch logs
}

resource "aws_iam_role_policy_attachment" "sts_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn  = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"  # Allows read-only access to IAM roles
}




resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn  = "arn:aws:iam::aws:policy/AdministratorAccess"
}
