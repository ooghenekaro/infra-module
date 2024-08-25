resource "aws_codebuild_project" "docker_build" {
  name         = "${var.project_name}-DockerBuild"
  description  = "Builds Docker image from source code"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "DOCKER_BUILDKIT"
      value = "1"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec.yml")
  }
}


