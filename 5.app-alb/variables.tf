variable "project_name" {
    type = string
    default = "expense"
}
variable "environment" {
    type = string
    default = "dev"
}
variable "common_tags" {
    type = map(string)
    default = {
        Project     = "Expense"
        Environment = "DEV"
        Terraform   = "true"
    }
}
variable "zone_name" {
    type = string
    default = "chandradevops.online"
}