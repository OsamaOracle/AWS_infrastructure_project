data "aws_ami" "ami_id" {
most_recent = true
owners = ["amazon"] # Canonical
  filter {
      name   = "name"
      values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}
