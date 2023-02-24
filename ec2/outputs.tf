output "ec2_instance_id" {
  value = "${aws_instance.ec2_instance.*.arn}"
}

output "security_group_ec2" {
  value = "${aws_security_group.ec2_security_group.id}"
}