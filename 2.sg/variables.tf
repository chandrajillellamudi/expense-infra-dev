variable "project_name" {
  default = "expense"
}


variable "environment" {
  default = "dev"
}



variable "common_tags" {
  default = {
    Environment = "Dev"
    Project     = "Expense"
    Terraform   = "True"
  }
}

variable "vpn_sg_rules" {
  default =[
    {
      from_port   = 943
      to_port     = 943
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "vpn accepting connections from the internet"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "vpn accepting connections from the internet"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
      description = "vpn accepting connections from the internet"
    },
    {
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
       cidr_blocks = ["0.0.0.0/0"]
      description = "vpn accepting connections from the internet"
    }
  ]
}