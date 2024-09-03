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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.put_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.put_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.terraform_apply](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.terraform_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.tfmigrate_apply](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.tfmigrate_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.terraform_apply_put_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.terraform_apply_read_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.terraform_plan_read_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tfmigrate_apply_put_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tfmigrate_apply_put_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tfmigrate_apply_read_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tfmigrate_apply_read_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tfmigrate_plan_read_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tfmigrate_plan_read_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy_main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_policy_pr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.put_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.put_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_tfmigrate_history](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy_main_conditions"></a> [assume\_role\_policy\_main\_conditions](#input\_assume\_role\_policy\_main\_conditions) | n/a | <pre>list(object({<br>    test     = string<br>    variable = string<br>    values   = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_assume_role_policy_pr_conditions"></a> [assume\_role\_policy\_pr\_conditions](#input\_assume\_role\_policy\_pr\_conditions) | n/a | <pre>list(object({<br>    test     = string<br>    variable = string<br>    values   = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | n/a | `bool` | `false` | no |
| <a name="input_main_branch"></a> [main\_branch](#input\_main\_branch) | n/a | `string` | `"main"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | n/a | `string` | n/a | yes |
| <a name="input_s3_bucket_terraform_state_name"></a> [s3\_bucket\_terraform\_state\_name](#input\_s3\_bucket\_terraform\_state\_name) | n/a | `string` | `""` | no |
| <a name="input_s3_bucket_tfmigrate_history_name"></a> [s3\_bucket\_tfmigrate\_history\_name](#input\_s3\_bucket\_tfmigrate\_history\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_iam_role_terraform_apply_arn"></a> [aws\_iam\_role\_terraform\_apply\_arn](#output\_aws\_iam\_role\_terraform\_apply\_arn) | AWS IAM Role ARN for terraform apply |
| <a name="output_aws_iam_role_terraform_apply_name"></a> [aws\_iam\_role\_terraform\_apply\_name](#output\_aws\_iam\_role\_terraform\_apply\_name) | AWS IAM Role name for terraform apply |
| <a name="output_aws_iam_role_terraform_plan_arn"></a> [aws\_iam\_role\_terraform\_plan\_arn](#output\_aws\_iam\_role\_terraform\_plan\_arn) | AWS IAM Role ARN for terraform plan |
| <a name="output_aws_iam_role_terraform_plan_name"></a> [aws\_iam\_role\_terraform\_plan\_name](#output\_aws\_iam\_role\_terraform\_plan\_name) | AWS IAM Role name for terraform plan |
| <a name="output_aws_iam_role_tfmigrate_apply_arn"></a> [aws\_iam\_role\_tfmigrate\_apply\_arn](#output\_aws\_iam\_role\_tfmigrate\_apply\_arn) | AWS IAM Role ARN for tfmigrate apply |
| <a name="output_aws_iam_role_tfmigrate_apply_name"></a> [aws\_iam\_role\_tfmigrate\_apply\_name](#output\_aws\_iam\_role\_tfmigrate\_apply\_name) | AWS IAM Role name for tfmigrate apply |
| <a name="output_aws_iam_role_tfmigrate_plan_arn"></a> [aws\_iam\_role\_tfmigrate\_plan\_arn](#output\_aws\_iam\_role\_tfmigrate\_plan\_arn) | AWS IAM Role ARN for tfmigrate plan |
| <a name="output_aws_iam_role_tfmigrate_plan_name"></a> [aws\_iam\_role\_tfmigrate\_plan\_name](#output\_aws\_iam\_role\_tfmigrate\_plan\_name) | AWS IAM Role name for tfmigrate plan |

## LICENSE

[MIT](LICENSE)

---

This document is generated by [terraform-docs](https://terraform-docs.io/)
