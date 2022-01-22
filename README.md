# terraform-aws-tfaction

Terraform Modules for [tfaction](https://github.com/suzuki-shunsuke/tfaction) (AWS resources)

https://github.com/suzuki-shunsuke/tfaction/blob/main/docs/add-working-directory.md#aws-iam-role

## Resources

AWS IAM Roles and Policies.

## Example

```tf
module "aws" {
  source = "github.com/suzuki-shunsuke/terraform-aws-tfaction"

  name                               = "AWS"
  repo                               = "suzuki-shunsuke/tfaction-example"
  main_branch                        = "main"
  s3_bucket_tfmigrate_history_name   = "<S3 Bucket Name for tfmigrate hisotry>"
  s3_bucket_terraform_plan_file_name = "<S3 Bucket Name for terraform plan file>"
  s3_bucket_terraform_state_name     = "<S3 Bucket Name for terraform state>"
}

# Attach Policies

resource "aws_iam_role_policy_attachment" "terraform_apply_admin" {
  role       = module.aws.aws_iam_role_terraform_apply_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "terraform_plan_readonly" {
  role       = module.aws.aws_iam_role_terraform_plan_name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "tfmigrate_plan_readonly" {
  role       = module.aws.aws_iam_role_tfmigrate_plan_name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "tfmigrate_apply_readonly" {
  role       = module.aws.aws_iam_role_tfmigrate_apply_name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
```

## Input Variables

[variables.tf](variables.tf)

## Outputs

[outputs.tf](outputs.tf)

## LICENSE

[MIT](LICENSE)
