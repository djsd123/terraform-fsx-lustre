output "ec2_sec_grp_id" {
  value = aws_security_group.ec2_sec_grp.id
}

output "file_system_sec_grp_id" {
  value = aws_security_group.file_system_sec_grp.id
}

output "file_system_id" {
  value = aws_fsx_lustre_file_system.fsx_filesystem.id
}

output "ec2_instance_id" {
  value = aws_instance.amazon_linux_instance.id
}

output "ec2_instance_public_dns_name" {
  value = aws_instance.amazon_linux_instance.public_dns
}

output "ami_id" {
  value = data.aws_ami.amazon_linux_2.image_id
}
