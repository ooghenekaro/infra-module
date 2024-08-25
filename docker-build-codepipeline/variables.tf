variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "Ajala-globetrotter"
}

variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar connection"
  type        = string
  default     = "arn:aws:codestar-connections:eu-west-2:335871625378:connection/a0dd4905-7501-41fd-96c3-7d504c11706a"
}

variable "repo_name" {
  description = "The GitHub repository name in the format owner/repo"
  type        = string
  default     = "ooghenekaro/flask-app"
}

variable "github_branch" {
  description = "The branch to use from the GitHub repository"
  type        = string
  default     = "main"
}

variable "s3_bucket" {
  description = "The S3 bucket to store pipeline artifacts"
  type        = string
  default     = "karo-bucket-name"
}

/*
variable "ecr_repo" {
  description = "The ECR repository URI where the Docker image will be pushed"
  type        = string
}
*/
