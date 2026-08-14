locals {
  # `for_each` of the `dynamic` blocks granting permissions of the KMS Keys.
  # `length()` is known at plan time even if the elements are unknown, such as ARNs of KMS Keys
  # created in the same plan.
  terraform_state_kms   = length(var.s3_bucket_terraform_state_kms_key_arns) == 0 ? [] : [1]
  tfmigrate_history_kms = length(var.s3_bucket_tfmigrate_history_kms_key_arns) == 0 ? [] : [1]

  default_assume_role_policy_main_conditions = [
    {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    },
    {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo}:ref:refs/heads/${var.main_branch}"]
    },
  ]

  default_assume_role_policy_pr_conditions = [
    {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    },
    {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo}:*"]
    },
  ]
}
