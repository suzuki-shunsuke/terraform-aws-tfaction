variable "name" {
  type = string
}

variable "repo" {
  type = string
}

variable "main_branch" {
  type    = string
  default = "main"
}

variable "s3_bucket_tfmigrate_history_name" {
  type = string
}

variable "s3_bucket_terraform_plan_file_name" {
  type = string
}

variable "s3_bucket_terraform_state_name" {
  type    = string
  default = ""
}
