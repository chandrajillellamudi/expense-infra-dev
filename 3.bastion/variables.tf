variable "project_name" {
    type = string
    default = "expense"
}
variable "environment" {
    type = string
    default = "dev"
}
variable "instance_type" {
    type    = string
    default = "t3.micro"
}
variable "common_tags" {
    type = map(string)
    default = {
        Project     = "Expense"
        Environment = "DEV"
        Terraform   = "true"
    }
}