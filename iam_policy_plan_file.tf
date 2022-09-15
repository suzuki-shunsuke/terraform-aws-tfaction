resource "aws_iam_policy" "read_plan_file" {
  name   = "GitHubActions_Terraform_${var.name}_read_plan_file"
  policy = data.aws_iam_policy_document.read_plan_file.json
}

data "aws_iam_policy_document" "read_plan_file" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_plan_file_name}/*"]
    actions   = ["s3:GetObject"]
  }
}

resource "aws_iam_policy" "put_plan_file" {
  name   = "GitHubActions_Terraform_${var.name}_write_plan_file"
  policy = data.aws_iam_policy_document.put_plan_file.json
}

data "aws_iam_policy_document" "put_plan_file" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_plan_file_name}/*"]
    actions   = ["s3:PutObject"]
  }
}

resource "aws_iam_policy" "delete_plan_file" {
  name   = "GitHubActions_Terraform_${var.name}_delete_plan_file"
  policy = data.aws_iam_policy_document.delete_plan_file.json
}

data "aws_iam_policy_document" "delete_plan_file" {
  statement {
    resources = ["arn:aws:s3:::${var.s3_bucket_terraform_plan_file_name}/*"]
    actions   = ["s3:DeleteObject"]
  }
}
