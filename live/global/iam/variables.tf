variable "user_names" {
    description = "The names of the IAM users to create"
    type = list
    default = ["neo", "trinity", "morpheus"]
    # default = ["neo", "morpheus"]
}
