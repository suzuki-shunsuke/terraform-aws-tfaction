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
}

data "aws_iam_policy_document" "lock_terraform_state" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_state_name}/*.tflock"]
    actions   = ["s3:PutObject", "s3:DeleteObject"]
  }
}

resource "aws_iam_policy" "lock_terraform_state" {
  count  = var.s3_bucket_terraform_state_name == "" ? 0 : 1
  name   = "GitHubActions_Terraform_${var.name}_lock_terraform_state"
  policy = data.aws_iam_policy_document.lock_terraform_state.json
}
