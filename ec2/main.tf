resource "aws_instance" "ec2_instance" {
  count                             = var.instance_count
  ami                               = var.instance_ami
  instance_type                     = var.instance_type
  subnet_id                         = var.subnet_ids[1]
  key_name                          = var.key_name
  monitoring                        = var.monitoring
  vpc_security_group_ids            = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address       = var.public_ip
  ebs_optimized                     = var.ebs_optimized
  user_data_base64                  = data.cloudinit_config.user_data.rendered
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination         = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted                     = lookup(root_block_device.value, "encrypted", null)
      iops                          = lookup(root_block_device.value, "iops", null)
      kms_key_id                    = lookup(root_block_device.value, "kms_key_id", null)
      volume_size                   = lookup(root_block_device.value, "volume_size", null)
      volume_type                   = lookup(root_block_device.value, "volume_type", null)
      tags                          = var.required_tags
    }
  }
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination         = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name                   = ebs_block_device.value.device_name
      encrypted                     = lookup(ebs_block_device.value, "encrypted", null)
      iops                          = lookup(ebs_block_device.value, "iops", null)
      kms_key_id                    = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id                   = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size                   = lookup(ebs_block_device.value, "volume_size", null)
      volume_type                   = lookup(ebs_block_device.value, "volume_type", null)
      tags                          = var.required_tags
    }
  }
  iam_instance_profile              = "${aws_iam_instance_profile.myinstance_profile.name}"
  tags = merge({
    Name = "${var.machine_name}-${var.environment}-${var.prefix}-EC2"
  }, var.required_tags)

}
resource "aws_iam_instance_profile" "myinstance_profile" {
  name          = "${var.environment}-${var.instance_profile_name}"
  role          = "${aws_iam_role.ec2_role.name}"
  tags = merge({
    Name = "${var.machine_name}-${var.environment}-${var.prefix}-InstanceProfile"
  }, var.required_tags)
}

resource "aws_iam_role" "ec2_role" {
  name                = "ec2-role"
  dynamic "inline_policy" {
    for_each = var.inline_policy
    content {
      name         = lookup(inline_policy.value, "name", null)
      policy       = inline_policy.value.policy
    }
  }
  assume_role_policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Sid": ""
        }
    ]
}
EOF
  tags = merge({
    Name = "${var.machine_name}-${var.environment}-${var.prefix}-IAM"
  }, var.required_tags)
}

resource "aws_security_group" "ec2_security_group" {
  name        = "${var.machine_name}-sg"
  description = "Default Security Group for the EC2"
  vpc_id        = var.vpc_id
  ingress {
    protocol    = "TCP"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "TCP"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "TCP"
    from_port   = 3306
    to_port     = 3306
    security_groups = [ var.rds_sg_id ]
  }
  ingress {
    protocol    = "TCP"
    from_port   = 6379
    to_port     = 6379
    security_groups = [ var.redis_sg_id ]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge({
    Name = "${var.machine_name}-${var.environment}-${var.prefix}-SG"
  }, var.required_tags)
}
