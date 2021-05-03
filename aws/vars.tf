
variable "environment_name" {
  description = "Please insert here the environment name"
  default     = "staging"
}

variable "app_name" {
  description = "Please insert here the app name"
  default     = "staging"
}

variable "base_tags" {
  type    = map(string)
  default = {}
}

variable "company" {
  type        = string
  default     = "Cubbit"
  description = "Please insert here the company name"
}

variable "target_branch" {
  type        = string
  default     = "develop"
  description = "Target branch for release the environment"
}

variable "repository_location" {
  type = string
  default = ""
  description = "Target GIT repository"
}

variable "region" {
  type = string
  default = "eu-west-1"
  description = "AWS Target Region"
}

variable "account_id" {
  type = string
  default = "123456789012"
  description = "AWS Account ID"
}

variable "github_token" {
  type = string
  default = ""
  description = "GITHUB TOKEN to give access to repository, otherwise you can use codestar!"
}


variable "github_repositoryname" {
  type = string
  description = "GIT Repository name"
}

variable "github_owner" {
  type = string
  default = "bollohz"
  description = "GitHub User"
}

