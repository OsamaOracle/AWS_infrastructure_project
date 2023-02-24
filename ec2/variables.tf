variable "instance_count" {
  type        = string
  description = "count of ec2"
}

variable "environment" {
  type        = string
  description = "environment for ec2 instance"
}

variable "prefix" {
  type        = string
  description = "prefix for ec2 instance"
}

variable "instance_ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = "default"
}

variable "public_ip" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}
variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "Osama-Key"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "enable_volume_tags" {
  description = "Whether to enable volume tags (if enabled it conflicts with root_block_device tags)"
  type        = bool
  default     = true
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "inline_policy"{
  description = "Inline Policy Documents"
  type        = list(map(string))
  default     = []
}



variable "user_tags" {
  type        = map
  description = "Tags supplied by the user to be applied to the resources"
  default     = {}
}

variable "instance_profile_name" {
  type        = string
  description = "An Instance profile name"
}

variable "machine_name"{
  type        = string
  description = "An Instance name"
}


variable "vpc_id" {
  type        = string
  description = "the vpc id of the active directory service."
}

variable "allowed_ipv4_addresses" {
  type        = list(string)
  description = "allowed ip addresses for rdp"
}

variable "required_tags" {
  type        = map
  description = "required tags"
  default     = {
    Name = ""
    Owner = ""
    Customer = ""
    Environment = ""
    Version = ""
  }
}

variable "rds_sg_id" {
  type = string
  description = "RDS security group ID"
}

variable "redis_sg_id" {
  type = string
  description = "Redis security group ID"
}