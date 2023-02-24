variable "service" {
    type    = string
    default = "rds"
}

variable "environment" {
    type    = string
}

variable "cluster_name" {
    type = string
}

variable "cluster_engine" {
    type = string
}

variable "cluster_instances" {
    type = string
}

variable "cluster_master_username"{
    type = string
}

variable "cluster_master_password"{
    description = "Enter atleast 8 characters otherwise it will not work"
    type = string
}

variable "engine"{
    type = string
}

variable "engine_version"{
    type = string
}

variable "instance_class"{
    type = string
}


variable "subnet_list"{
    type = list(string)
}

variable "skip_final_snapshot"{
    type    = bool
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