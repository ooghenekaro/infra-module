variable "project_name" {
  description = "The name of the project/repo."
  type        = string
}

variable "environments" {
  description = "List of environments for the project (e.g., dev, stage, prod)."
  type        = list(string)
}

variable "repo_name" {
  description = "The name of the repository in GitHub."
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket name for storing Terraform state files."
  type        = string
}

/*
variable "account_ids" {
  description = "Map of environment names to AWS account IDs."
  type        = map(string)
}
*/

variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar connection to GitHub."
  type        = string
}

