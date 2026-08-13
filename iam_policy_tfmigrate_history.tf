resource "aws_iam_policy" "read_tfmigrate_history" {
  name   = "GitHubActions_Terraform_${var.name}_read_tfmigrate_history"
  policy = data.aws_iam_policy_document.read_tfmigrate_history.json
}

data "aws_iam_policy_document" "read_tfmigrate_history" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_tfmigrate_history_name}/*"]
    actions   = ["s3:GetObject"]
  }
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_tfmigrate_history_name}"]
    actions   = ["s3:ListBucket"]
  }
  # s3:GetObject requires kms:Decrypt if the bucket is encrypted with customer managed keys.
  # This policy is attached to all IAM Roles reading tfmigrate history, so they can decrypt it.
  dynamic "statement" {
    for_each = length(var.s3_bucket_tfmigrate_history_kms_key_arns) == 0 ? [] : [1]
    content {
      resources = var.s3_bucket_tfmigrate_history_kms_key_arns
      actions   = ["kms:Decrypt"]
    }
  }
}

resource "aws_iam_policy" "put_tfmigrate_history" {
  name   = "GitHubActions_Terraform_${var.name}_write_tfmigrate_history"
  policy = data.aws_iam_policy_document.put_tfmigrate_history.json
}

data "aws_iam_policy_document" "put_tfmigrate_history" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_tfmigrate_history_name}/*"]
    actions   = ["s3:PutObject"]
  }
  # s3:PutObject requires kms:GenerateDataKey if the bucket is encrypted with customer managed keys.
  # kms:Decrypt is granted by the policy read_tfmigrate_history, which is attached to all IAM Roles
  # writing tfmigrate history too.
  dynamic "statement" {
    for_each = length(var.s3_bucket_tfmigrate_history_kms_key_arns) == 0 ? [] : [1]
    content {
      resources = var.s3_bucket_tfmigrate_history_kms_key_arns
      actions   = ["kms:GenerateDataKey"]
    }
  }
}
