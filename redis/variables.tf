variable "service" {
    type    = string
    default = "redis"
}

variable "environment" {
    type    = string
}

variable "elasticache_cluster_name" {
    type = string
}

variable "elasticache_engine" {
    type = string
}

variable "elasticache_engine_version" {
    type = string
}

variable "elasticache_node_type" {
    type = string
}

variable "elasticache_node_count" {
    type = string
}

variable "redis_port" {
    type = string
}

variable "parameter_group_name" {
    type = string
}

variable "subnet_group_name_redis" {
    type    = string
    default = "redis-subnet"
}

variable "subnet_group_list" {
    type = list(string)
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
