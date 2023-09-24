resource "aws_iam_role" "tfmigrate_apply" {
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy_main.json
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "GitHubActions_Terraform_${var.name}_tfmigrate_apply"
}

resource "aws_iam_role_policy_attachment" "tfmigrate_apply_read_tfmigrate_history" {
  role       = aws_iam_role.tfmigrate_apply.name
  policy_arn = aws_iam_policy.read_tfmigrate_history.arn
}

resource "aws_iam_role_policy_attachment" "tfmigrate_apply_put_tfmigrate_history" {
  role       = aws_iam_role.tfmigrate_apply.name
  policy_arn = aws_iam_policy.put_tfmigrate_history.arn
}

resource "aws_iam_role_policy_attachment" "tfmigrate_apply_read_terraform_state" {
  count = var.s3_bucket_terraform_state_name == "" ? 0 : 1

  role       = aws_iam_role.tfmigrate_apply.name
  policy_arn = aws_iam_policy.read_terraform_state[0].arn
}

resource "aws_iam_role_policy_attachment" "tfmigrate_apply_put_terraform_state" {
  count = var.s3_bucket_terraform_state_name == "" ? 0 : 1

  role       = aws_iam_role.tfmigrate_apply.name
  policy_arn = aws_iam_policy.put_terraform_state[0].arn
}

resource "aws_iam_role_policy_attachment" "tfmigrate_apply_delete_plan_file" {
  role       = aws_iam_role.tfmigrate_apply.name
  policy_arn = aws_iam_policy.delete_plan_file.arn
}
