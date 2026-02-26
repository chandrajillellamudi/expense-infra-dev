module "bastion_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.project_name}-${var.environment}-bastion"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  instance_type = var.instance_type
  subnet_id     = local.subnet_ids
  ami = data.aws_ami.ami_id.id
  create_security_group = false
  user_data = file("bastion.sh")

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-bastion"
    }
  )
}