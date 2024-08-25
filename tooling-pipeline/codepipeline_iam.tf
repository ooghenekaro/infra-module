/*
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.project_name}-codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineReadOnlyAccess"
  ]
}
*/
