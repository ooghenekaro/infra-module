resource "aws_codepipeline" "infra_pipeline" {
  name     = "${var.project_name}-InfraPipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_bucket
    type     = "S3"
  }

   # Source Stage
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = var.repo_name
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "CodeAnalysis"

    action {
      name             = "CodeAnalysis"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 2
      input_artifacts  = ["source_output"]
      output_artifacts = ["analysis_output"]

      configuration = {
        ProjectName = "${var.project_name}-CodeAnalysisProject"
      }
    }
  }

  # DEV Environment
  stage {
    name = "DEV_Plan"

    action {
      name             = "DevPlan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["dev_plan_output"]
      configuration = {
        ProjectName = "${var.project_name}-devPlanProject"
      }
    }
  }

  stage {
    name = "DEV_Approval"

    action {
      name      = "DevApproval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      input_artifacts = []
      configuration = {
        CustomData = "Approve DEV Deployment?"
      }
    }
  }

  stage {
    name = "DEV_Apply"

    action {
      name             = "DevApply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["dev_plan_output"]
      output_artifacts = ["dev_apply_output"]
      configuration = {
        ProjectName = "${var.project_name}-devApplyProject"
      }
    }
  }

  # STAGING Environment
  stage {
    name = "STAGE_Plan"

    action {
      name             = "StagePlan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["dev_apply_output"]
      output_artifacts = ["stage_plan_output"]
      configuration = {
        ProjectName = "${var.project_name}-stagePlanProject"
      }
    }
  }

  stage {
    name = "STAGE_Approval"

    action {
      name      = "StageApproval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      input_artifacts = []
      configuration = {
        CustomData = "Approve STAGE Deployment?"
      }
    }
  }

  stage {
    name = "STAGE_Apply"

    action {
      name             = "StageApply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["stage_plan_output"]
      output_artifacts = ["stage_apply_output"]
      configuration = {
        ProjectName = "${var.project_name}-stageApplyProject"
      }
    }
  }

  # PROD Environment
  stage {
    name = "PROD_Plan"

    action {
      name             = "ProdPlan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["stage_apply_output"]
      output_artifacts = ["prod_plan_output"]
      configuration = {
        ProjectName = "${var.project_name}-prodPlanProject"
      }
    }
  }

  stage {
    name = "PROD_Approval"

    action {
      name      = "ProdApproval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      input_artifacts = []
      configuration = {
        CustomData = "Approve PROD Deployment?"
      }
    }
  }

  stage {
    name = "PROD_Apply"

    action {
      name             = "ProdApply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["prod_plan_output"]
      configuration = {
        ProjectName = "${var.project_name}-prodApplyProject"
      }
    }
  }
}
