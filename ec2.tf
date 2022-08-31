resource "aws_instance" "amazon_linux_instance" {
  ami                         = data.aws_ami.amazon_linux_2.image_id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  key_name                    = var.ec2_key_pair
  vpc_security_group_ids      = [aws_security_group.ec2_sec_grp.id]
  subnet_id                   = module.vpc.private_subnets[0]
  user_data                   = data.cloudinit_config.user_data.rendered
  user_data_replace_on_change = true

  tags = {
    Name = var.name
  }
}
