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
}
