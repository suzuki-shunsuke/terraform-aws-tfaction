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

variable "s3_bucket_terraform_state_name" {
  type    = string
  default = ""
}

# These variables are lists rather than strings so that several KMS Keys can be granted, for
# instance while migrating from one KMS Key to another, where objects encrypted with the old key
# still have to be decrypted.
variable "s3_bucket_terraform_state_kms_key_arns" {
  type        = list(string)
  default     = []
  description = "ARNs of KMS Keys encrypting the S3 Bucket for Terraform State. If the bucket is encrypted with customer managed keys, you have to set this variable so that IAM Roles can read and write Terraform State."
}

variable "s3_bucket_tfmigrate_history_kms_key_arns" {
  type        = list(string)
  default     = []
  description = "ARNs of KMS Keys encrypting the S3 Bucket for tfmigrate history. If the bucket is encrypted with customer managed keys, you have to set this variable so that IAM Roles can read and write tfmigrate history."
}

variable "create_oidc_provider" {
  type    = bool
  default = false
}

variable "assume_role_policy_main_conditions" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  default = null
}

variable "assume_role_policy_pr_conditions" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  default = null
}
