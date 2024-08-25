# Analysis Codebuild Project
resource "aws_codebuild_project" "code_analysis" {
  name         = "${var.project_name}-CodeAnalysisProject"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type  = "BUILD_GENERAL1_SMALL"
    image         = "aws/codebuild/standard:5.0"
    type          = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec =file("${path.module}/buildspec-analysis.yaml")
  }
}

locals {
  environment_map = { for env in var.environments : env => env }
}

resource "aws_codebuild_project" "plan" {
  for_each = local.environment_map

  name         = "${var.project_name}-${each.key}PlanProject"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type  = "BUILD_GENERAL1_SMALL"
    image         = "aws/codebuild/standard:5.0"
    type          = "LINUX_CONTAINER"
   }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec-plan.yaml")
  }
}

resource "aws_codebuild_project" "apply" {
  for_each = local.environment_map

  name         = "${var.project_name}-${each.key}ApplyProject"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type  = "BUILD_GENERAL1_SMALL"
    image         = "aws/codebuild/standard:5.0"
    type          = "LINUX_CONTAINER"
  
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec-apply.yaml")
  }
}

















