variable "prefix" {
  type    = string
  default = "dev"
}

variable "environment" {
  type    = string
  default = "test-prod"
}

variable "bucket_name" {
  type    = string
  default = "cloud-backend-hasnain"
}

#variable for vpc
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
  type        = string
}

variable "public_list" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "private_list" {
  type    = list(string)
  default = ["10.0.4.0/24" , "10.0.3.0/24"]
}

variable "public_security_group" {
  type    = string
  default = "public_security_group"
}

variable "private_security_group" {
  type    = string
  default = "private_security_group"
}

#variables for module ssm parameter
variable "secret_name" {
  type    = string
  default = "meta"
}

variable "filename" {
  default = "ssm-parameter"
}

#variables for rds cluster
variable "cluster_name" {
  type    = string
  default = "mariadb-cluster"
}
variable "cluster_engine" {
  type    = string
  default = "aurora-mysql"
}
variable "cluster_instances" {
  type    = string
  default = 1
}

variable "cluster_master_username" {
  type    = string
  default = "cloudmasteruser"
}
variable "cluster_master_password" {
  description = "Enter atleast 8 characters otherwise it will not work"
  type        = string
  default     = "cloud1234"
}

variable "engine" {
  type    = string
  default = "mariadb"
}

variable "engine_version" {
  type    = string
  default = "10.4.13"
}
variable "instance_class" {
  type    = string
  default = "db.t2.small"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "dbname" {
  type    = string
  default = "clouddb"
}

variable "username" {
  type    = string
  default = "clouduser"
}

variable "password" {
  type        = string
  description = "Enter atleast 8 characters otherwise it will not work"
  default     = "cloud1234"
}

variable "port" {
  type    = string
  default = "3306"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "multi_az" {
  type    = bool
  default = false
}

#variables for redis cluster
variable "elasticache_cluster_name" {
  type    = string
  default = "cloud-redis"
}

variable "elasticache_engine" {
  type    = string
  default = "redis"
}

variable "elasticache_engine_version" {
  type    = string
  default = "3.2.10"
}

variable "elasticache_node_type" {
  type    = string
  default = "cache.t2.micro"
}

variable "elasticache_node_count" {
  type    = string
  default = "1"
}

variable "redis_port" {
  type    = number
  default = 6379
}

variable "parameter_group_name" {
  type    = string
  default = "default.redis3.2"
}


#variables for modules eks cluster 

variable "eks_role_name" {
  type    = string
  default = "prod-eks-cluster-role"
}

variable "eks_cluster_name" {
  type    = string
  default = "prod-eks-cluster"
}

variable "eks_cluster_version" {
  type    = string
  default = "1.21"
}

variable "eks_instance_type" {
  type        = list(string)
  description = "The type of EC2 instance to start"
  default     = ["t2.micro"]
}

variable "manage_aws_auth" {
  type    = bool
  default = true
}

variable "enable_irsa" {
  type    = bool
  default = true
}
variable "eks_node_role_name" {
  type    = string
  default = "dev-eks-node-role"
}

variable "node_group_name" {
  type    = string
  default = "dev-eks-general-node"
}

variable "desired_size" {
  type    = number
  default = 3
}

variable "max_size" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 3
}

variable "enabled" {
  type    = bool
  default = true
}

variable "service" {
  type    = string
  default = "eks"
}

variable "tags" {
  description = "The key-value maps for tagging"
  type        = map(string)
  default     = {}
}

# variable "ec2_ami" {
#   type        = string
#   description = "ID of EC2 Instance AMI to use for the instance"
#   default     = "ami-0ed9277fb7eb570c9"
# }
variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to start"
  default     = "t2.micro"
}
variable "ec2_key_name" {
  type        = string
  description = "The key name to use for the EC2"
  default     = "Osama-Key"
}

variable "ec2_monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "ec2_root_block_device" {
  type        = list(any)
  description = "Customize details about the root block device of the EC2."
  default = [
    {
      delete_on_termination = true,
      volume_size           = 20,
      volume_type           = "gp2",
      device_name           = "/dev/sda1"
      encrypted             = false
    }
  ]
}

variable "ec2_ebs_block_device" {
  type        = list(map(string))
  description = "Additional EBS block devices to attach to the EC2"
  default     = []
}

variable "ec2_instance_profile_name" {
  type        = string
  description = "The role name to create for ec2 ad EC2"
  default     = "cloud"
}

variable "jump_server_instance_profile" {
  type        = string
  description = "The role name to create for ec2 ad EC2"
  default     = "jump-ec2"
}

variable "machine_name" {
  type        = string
  description = "The role name to create for ec2 ad EC2"
  default     = "EC2-Instance"
}

variable "public_ip" {
  type        = bool
  description = "public ip for EC2 instance"
  default     = true
}
