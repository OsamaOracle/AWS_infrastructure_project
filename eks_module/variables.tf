variable "cluster_name" {
    type    = string
}

variable "cluster_version" {
    type    = string
}

variable "subnet_ids" {
    type    = list(string)
}

variable "vpc_id" {
  type        = string
  description = "the vpc id of the active directory service."
  default = ""
}

variable "desired_size" {
    type    = number
}

variable "max_size" {
    type    = number
}

variable "min_size" {
    type    = number
}

variable "instance_type" {
    type        = list(string)
}

variable "service" {
    type    = string
    default = "eks"
}

variable "environment" {
    type    = string
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap. See examples/basic/variables.tf for example format."
  type        = list(string)
  default     = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap. See examples/basic/variables.tf for example format."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap. See examples/basic/variables.tf for example format."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}


variable "manage_aws_auth" {
  type        = bool
  default     = true
  description = "Whether to apply the ConfigMap to allow worker nodes to join the EKS cluster and allow additional users, accounts and roles to acces the cluster"
}

variable "wait_for_cluster_timeout" {
  description = "A timeout (in seconds) to wait for cluster to be available."
  type        = number
  default     = 300
}

variable "assume_developer_role" {
  description = "A list of ARN's of users/roles that can assume the cluster_developer role"
  type	      = list(string)
  default     = ["arn:aws:iam::489994096722:role/EC2FullAccessKashan"]
}

variable "enable_irsa" {
  description = "A list of ARN's of users/roles that can assume the cluster_developer role"
  type	      = bool
}


variable "cluster_create_timeout" {
  description = "Timeout value when creating the EKS cluster."
  type        = string
  default     = "10m"
}

variable "cluster_delete_timeout" {
  description = "Timeout value when deleting the EKS cluster."
  type        = string
  default     = "10m"
}

variable "cluster_update_timeout" {
  description = "Timeout value when updating the EKS cluster."
  type        = string
  default     = "10m"
}
