data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy_pr" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    dynamic "condition" {
      for_each = var.assume_role_policy_pr_conditions ? var.assume_role_policy_pr_conditions : local.default_assume_role_policy_pr_conditions
      content {
        test     = condition.value["test"]
        variable = condition.value["variable"]
        value    = condition.value["value"]
      }
    }

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
  }
}

data "aws_iam_policy_document" "assume_role_policy_main" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    dynamic "condition" {
      for_each = var.assume_role_policy_main_conditions ? var.assume_role_policy_main_conditions : local.default_assume_role_policy_main_conditions
      content {
        test     = condition.value["test"]
        variable = condition.value["variable"]
        value    = condition.value["value"]
      }
    }

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
  }
}
