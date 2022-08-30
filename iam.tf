resource "aws_iam_role" "ec2_instance_role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_policy" {
  policy_arn = data.aws_iam_policy.ec2_policy_for_ssm.arn
  role       = aws_iam_role.ec2_instance_role.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}
