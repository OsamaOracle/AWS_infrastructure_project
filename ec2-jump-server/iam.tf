resource "aws_iam_instance_profile" "ec2_jumpserver" {
  name          = "${var.environment}-${var.instance_profile_name}-prod"
  role          =  var.external_role_name
  tags = merge({
    Name = "${var.machine_name}-${var.environment}-${var.prefix}-InstanceProfile"
  }, var.required_tags)
}