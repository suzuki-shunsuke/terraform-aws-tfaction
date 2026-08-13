resource "aws_iam_policy" "read_terraform_state" {
  count  = var.s3_bucket_terraform_state_name == "" ? 0 : 1
  name   = "GitHubActions_Terraform_${var.name}_read_terraform_state"
  policy = data.aws_iam_policy_document.read_terraform_state.json
}

data "aws_iam_policy_document" "read_terraform_state" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_state_name}/*"]
    actions   = ["s3:GetObject"]
  }
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_state_name}"]
    actions   = ["s3:ListBucket"]
  }
  # s3:GetObject requires kms:Decrypt if the bucket is encrypted with customer managed keys.
  # This policy is attached to all IAM Roles reading Terraform State, so they can decrypt it.
  dynamic "statement" {
    for_each = local.terraform_state_kms
    content {
      resources = var.s3_bucket_terraform_state_kms_key_arns
      actions   = ["kms:Decrypt"]
    }
  }
}

resource "aws_iam_policy" "put_terraform_state" {
  count  = var.s3_bucket_terraform_state_name == "" ? 0 : 1
  name   = "GitHubActions_Terraform_${var.name}_write_terraform_state"
  policy = data.aws_iam_policy_document.put_terraform_state.json
}

data "aws_iam_policy_document" "put_terraform_state" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_state_name}/*"]
    actions   = ["s3:PutObject"]
  }
  # s3:PutObject requires kms:GenerateDataKey if the bucket is encrypted with customer managed keys.
  # kms:Decrypt is granted by the policy read_terraform_state, which is attached to all IAM Roles
  # writing Terraform State too.
  dynamic "statement" {
    for_each = local.terraform_state_kms
    content {
      resources = var.s3_bucket_terraform_state_kms_key_arns
      actions   = ["kms:GenerateDataKey"]
    }
  }
}

data "aws_iam_policy_document" "lock_terraform_state" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_state_name}/*.tflock"]
    actions   = ["s3:PutObject", "s3:DeleteObject"]
  }
  # Lock files are encrypted as well as Terraform State, so creating them requires
  # kms:GenerateDataKey. This is needed by terraform plan, which doesn't put Terraform State.
  dynamic "statement" {
    for_each = local.terraform_state_kms
    content {
      resources = var.s3_bucket_terraform_state_kms_key_arns
      actions   = ["kms:GenerateDataKey"]
    }
  }
}

resource "aws_iam_policy" "lock_terraform_state" {
  count  = var.s3_bucket_terraform_state_name == "" ? 0 : 1
  name   = "GitHubActions_Terraform_${var.name}_lock_terraform_state"
  policy = data.aws_iam_policy_document.lock_terraform_state.json
}
