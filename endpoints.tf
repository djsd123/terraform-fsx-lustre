data "aws_vpc_endpoint_service" "ssm_service" {
  service = "ssm"
}

data "aws_vpc_endpoint_service" "ssm_messages_service" {
  service = "ssmmessages"
}

data "aws_vpc_endpoint_service" "ec2_messages_service" {
  service = "ec2messages"
}

resource "aws_vpc_endpoint" "ssm_endpoint" {
  service_name        = data.aws_vpc_endpoint_service.ssm_service.service_name
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.ssm_endpoints.id]
}

resource "aws_vpc_endpoint" "ssm_messages_endpoint" {
  service_name        = data.aws_vpc_endpoint_service.ssm_messages_service.service_name
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.ssm_endpoints.id]
}

resource "aws_vpc_endpoint" "ec2_messages_endpoint" {
  service_name        = data.aws_vpc_endpoint_service.ec2_messages_service.service_name
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.ssm_endpoints.id]
}
