output "vpc_id_modulevpc" {
    value = "${aws_vpc.cloud_vpc.id}"
}

output "public_subnet_ids" {
    value = "${aws_subnet.public_subnets.*.id}"
} 

output "private_subnet_ids" {
    value = "${aws_subnet.private_subnets.*.id}"
} 

output "private_subnets" {
    value = "${aws_subnet.private_subnets}"
}

output "vpc_security_group_public" {
    value = "${aws_security_group.public_security_group.id}"
}

output "vpc_security_group_private" {
    value = "${aws_security_group.private_security_group.id}"
}