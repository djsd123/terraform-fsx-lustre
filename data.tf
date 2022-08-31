data "aws_caller_identity" "current" {}

data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

data "cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "userdata.yaml"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/assets/userdata.yaml", {
      FileSystemId = aws_fsx_lustre_file_system.fsx_filesystem.id
      Region       = var.region
    })
  }
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ec2_policy_for_ssm" {
  name = "AmazonSSMManagedInstanceCore"
}
