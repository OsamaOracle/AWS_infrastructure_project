output "bastion_sg_id" {
  value       = aws_security_group.bastion_sg.id
}

output "jump_server_role_arn" {
  value       = aws_iam_instance_profile.ec2_jumpserver.arn
}

output "ec2_private_dns" {
  value       = aws_instance.bastion.private_dns

}

output ami_id {
  value       = data.aws_ami.ami_id.id
}