output "user_arns" {
    value = values(module.users)[*].user_arn
    description = "The ARNs of the IAM users"
}

# リスト内包表記
output "upper_names" {
    value = [for name in var.user_names : upper(name) if length(name) < 5]
}
