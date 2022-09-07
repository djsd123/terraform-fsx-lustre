resource "aws_security_group" "ec2_sec_grp" {
  name        = "${var.name}-ec2-sec-grp"
  description = "Security group for Amazon EC2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = module.vpc.private_subnets_cidr_blocks
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self      = true
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ec2-sec-grp"
  }
}

resource "aws_security_group" "file_system_sec_grp" {
  name        = "${var.name}-file-system-sec-grp"
  description = "Security group for Amazon FSx"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 988
    protocol        = "tcp"
    to_port         = 988
    security_groups = [aws_security_group.ec2_sec_grp.id]
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self      = true
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-file-system-sec-grp"
  }
}

resource "aws_security_group" "ssm_endpoints" {
  name        = "ssm-endpoints"
  description = "Access to SSM VPC endpoints"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "ssm-endpoints"
  }
}

resource "aws_security_group_rule" "ssm_endpoint_ingress_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ssm_endpoints.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  description       = "HTTPS to SSM Endpoints"
}
