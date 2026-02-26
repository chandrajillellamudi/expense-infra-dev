module "db" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "db-sg"
  sg_description = "Security group for database servers"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "backend" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "backend-sg"
  sg_description = "Security group for backend servers"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags

}
module "frontend" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "frontend-sg"
  sg_description = "Security group for frontend servers"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags

}
module "bastion" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "bastion-sg"
  sg_description = "Security group for bastion hosts"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags

}

module "app-alb" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "app-alb-sg"
  sg_description = "Security group for application ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags

}

module "vpn" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "vpn-sg"
  sg_description = "Security group for VPN"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
  inbound_rules  = var.vpn_sg_rules
}

module "web-alb" {
  source         = "git::https://github.com/chandrajillellamudi/modules.git//terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "web-alb-sg"
  sg_description = "Security group for web application ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}


# SG Inbound Rules
# db accepting connection from backend
resource "aws_security_group_rule" "db_backend" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id        = module.db.sg_id
}

# db accepting connection from bastion
resource "aws_security_group_rule" "db_bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.db.sg_id
}
# db accepting connection from vpn
resource "aws_security_group_rule" "db_vpn" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.db.sg_id
}

# backend acception from bastion
resource "aws_security_group_rule" "backend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.backend.sg_id
}
# backend accepting connection from application load balancer
resource "aws_security_group_rule" "backend_app-alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app-alb.sg_id
  security_group_id        = module.backend.sg_id
}
# backend accepting connection from vpn ssh
resource "aws_security_group_rule" "backend_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}
# backend accepting connection from vpn http
resource "aws_security_group_rule" "backend_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}


# frontend accepting connection from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.frontend.sg_id
}
# frontend accepting connection from vpn
resource "aws_security_group_rule" "frontend_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.frontend.sg_id
}

#bastion accepting connection from public internet
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# app-alb accepting connection from vpn
resource "aws_security_group_rule" "app-alb_vpn" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.app-alb.sg_id
}
#app-alb accepting connection from frontend
resource "aws_security_group_rule" "frontend_app-alb" { 
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.app-alb.sg_id
}
# vpn accepting connection from public internet
resource "aws_security_group_rule" "vpn_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
# web-alb accepting connections from public
resource "aws_security_group_rule" "app-alb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web-alb.sg_id
