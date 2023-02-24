resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ami_id.id
  key_name                    = var.key_name
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  iam_instance_profile        = "${aws_iam_instance_profile.ec2_jumpserver.name}"
  user_data_base64            = data.cloudinit_config.user_data.rendered
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_ids[0]
  tags = merge({
    Name = "${var.machine_name}-${var.environment}-${var.prefix}-EC2"
  }, var.required_tags)
}

resource "aws_security_group" "bastion_sg" {
  name          = "eks_bastion_sg"
  vpc_id        = var.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}