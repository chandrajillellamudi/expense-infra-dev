resource "aws_key_pair" "vpn_key" {
  key_name   = "openvpn"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHTqrsF143weRH5ekqurypBr3fY9wrYmgKnOcthvUX5DtvebSB8aWUcliOepnTMEbIFwSra6/KDsRsmVm/f8BJLXnXKZVeisjYArS8J1R4dOIo3c/WO4RjStTMjlrpVbwTgIzJpLZ/zLcKbD4xeqcPQWLbXCrubJLvxyXe4PlVbRXKbRTN5Qz2F3H/e1557rGvqqutGsl7qRMSXu7OgukLkaH/JZFz5V6KKr2SQS1nfv+FTO5/v1mImPxBsCp67QAD8NTa0gj8aYs5gYPLUPTmklGK4yPNzA/Tm6LMQkpSd94Y6m7cxCzyAbwZ+AZb2P0SOV1LoeKorLNYvQMoGPr8bRhZ18ECQrt4TaQ2qeA/+jFPrj9bVDsDtNqGfQLT+em/oP1aghct1iSvUAFpvyehP8DHCTTr0buN6W9IeZj0A5lCHd3sS5x3bcXnfKqX66ULRK5sPtTIs3eNS0+2a/XG0lr0AkqcmbpKx1U7Sndly12cTbQEZkvAIhuRjsxcK5U= surya@SuryaJillellamudi"
}


module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.project_name}-${var.environment}-vpn"
  key_name   = aws_key_pair.vpn_key.key_name
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  instance_type = var.instance_type
  subnet_id     = local.subnet_ids
  ami = data.aws_ami.ami_id.id
  create_security_group = false

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}