resource "aws_fsx_lustre_file_system" "fsx_filesystem" {
  import_path        = var.fsx_s3_import_path
  storage_capacity   = var.fsx_storage_capacity
  security_group_ids = [aws_security_group.file_system_sec_grp.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  tags = {
    Name = var.name
  }
}
