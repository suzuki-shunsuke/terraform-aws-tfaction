output "aws_iam_role_terraform_plan_arn" {
  value       = aws_iam_role.terraform_plan.arn
  description = "AWS IAM Role ARN for terraform plan"
}

output "aws_iam_role_terraform_apply_arn" {
  value       = aws_iam_role.terraform_apply.arn
  description = "AWS IAM Role ARN for terraform apply"
}

output "aws_iam_role_tfmigrate_plan_arn" {
  value       = aws_iam_role.tfmigrate_plan.arn
  description = "AWS IAM Role ARN for tfmigrate plan"
}

output "aws_iam_role_tfmigrate_apply_arn" {
  value       = aws_iam_role.tfmigrate_apply.arn
  description = "AWS IAM Role ARN for tfmigrate apply"
}

output "aws_iam_role_terraform_plan_name" {
  value       = aws_iam_role.terraform_plan.name
  description = "AWS IAM Role ARN for terraform plan"
}

output "aws_iam_role_terraform_apply_name" {
  value       = aws_iam_role.terraform_apply.name
  description = "AWS IAM Role ARN for terraform apply"
}

output "aws_iam_role_tfmigrate_plan_name" {
  value       = aws_iam_role.tfmigrate_plan.name
  description = "AWS IAM Role ARN for tfmigrate plan"
}

output "aws_iam_role_tfmigrate_apply_name" {
  value       = aws_iam_role.tfmigrate_apply.name
  description = "AWS IAM Role ARN for tfmigrate apply"
}
