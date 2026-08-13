# terraform-aws-tfaction

Terraform Modules for [tfaction](https://github.com/suzuki-shunsuke/tfaction) (AWS resources)

https://suzuki-shunsuke.github.io/tfaction/docs/config/add-working-directory/#aws-iam-role

## Example

```tf
module "aws" {
  source = "github.com/suzuki-shunsuke/terraform-aws-tfaction"

  name                               = "AWS"
  repo                               = "suzuki-shunsuke/tfaction-example"
  main_branch                        = "main"
  s3_bucket_tfmigrate_history_name   = "<S3 Bucket Name for tfmigrate hisotry>"
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

## S3 Buckets encrypted with customer managed keys

If S3 Buckets are encrypted with customer managed keys (SSE-KMS), IAM Roles need permissions of the
KMS Keys in addition to the permissions of the buckets. Otherwise `terraform init` fails:

```
Error: Error refreshing state: Unable to access object "<key>" in S3 bucket "<bucket>": operation error S3: GetObject, https response error StatusCode: 403, api error AccessDenied: User: <IAM Role> is not authorized to perform: kms:Decrypt on resource: <KMS Key> because no identity-based policy allows the kms:Decrypt action
```

Set the ARNs of the KMS Keys, then the module grants `kms:Decrypt` and `kms:GenerateDataKey` to the
IAM Roles which need them:

```tf
module "aws" {
  source = "github.com/suzuki-shunsuke/terraform-aws-tfaction"

  name                                     = "AWS"
  repo                                     = "suzuki-shunsuke/tfaction-example"
  main_branch                              = "main"
  s3_bucket_tfmigrate_history_name         = aws_s3_bucket.tfmigrate_history.id
  s3_bucket_terraform_state_name           = aws_s3_bucket.terraform_state.id
  s3_bucket_tfmigrate_history_kms_key_arns = [aws_kms_key.tfmigrate_history.arn]
  s3_bucket_terraform_state_kms_key_arns   = [aws_kms_key.terraform_state.arn]
}
```

These variables are lists rather than strings so that several KMS Keys can be granted, for instance
while migrating from one KMS Key to another, where objects encrypted with the old key still have to
be decrypted.

ARNs of KMS Keys created in the same plan can be passed too, though the policies are shown as
`(known after apply)` in the plan then.
