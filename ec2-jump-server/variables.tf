variable "environment" {
  type        = string
  description = "environment for ec2 instance"
}

variable "prefix" {
  type        = string
  description = "prefix for ec2 instance"
}

variable "public_subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}


variable "machine_name" {
  type        = string
  description = "An Instance profile name"
  default     = "bastion"
}


variable "vpc_id" {
  type        = string
  description = "the vpc id of the active directory service."
  default = ""
}

variable "instance_profile_name" {
  type        = string
  description = "An Instance profile name"
}

variable "instance_role_name" {
  type        = string
  description = "An Instance profile name"
  default     = "bastion-role"
}

variable "external_role_name" {
  type        = string
  description = "An Instance profile name"
  default     = ""
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "Osama-Key"
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