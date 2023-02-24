variable "environment" {
  type        = string
  default     = "prod"
  description = "description"
}

variable "prefix" {
  type        = string
  description = "description"
}

variable  "vpc_cidr" {
  type        = string
  description = "Cidr of VPC"
}

variable "public_list"{
  type = list(string)
}

variable "private_list"{
  type = list(string)
}

#CIDR for Public and Private route table
variable "public_routetable_cidr" {
  description = "The CIDR block for the Public Route Table."
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_security_group" {
  type        = string
}

variable "private_security_group" {
  type        = string
}

variable "cluster_name" {
  type        = string
}