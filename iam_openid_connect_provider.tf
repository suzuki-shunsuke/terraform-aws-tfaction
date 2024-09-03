resource "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 1 : 0

  url = "https://token.actions.githubusercontent.com"
  # This is not required for GitHub Action OIDC integration with AWS but thumbprint_list is required so it pinned to the latest thumbprint
  # ref: https://github.blog/changelog/2023-07-13-github-actions-oidc-integration-with-aws-no-longer-requires-pinning-of-intermediate-tls-certificates/
  thumbprint_list = [
    "d89e3bd43d5d909b47a18977aa9d5ce36cee184c",
  ]
  client_id_list = ["sts.amazonaws.com"]

  lifecycle {
    ignore_changes = [
      thumbprint_list,
    ]
  }
}
