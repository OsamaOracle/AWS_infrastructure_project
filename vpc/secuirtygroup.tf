# variable "vpc_id"{}
resource "aws_security_group" "public_security_group" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.cloud_vpc.id
  name        = var.public_security_group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_security_group"
  }
}

resource "aws_security_group" "private_security_group" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.cloud_vpc.id
  name        = var.private_security_group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "private_security_group"

  }
}



