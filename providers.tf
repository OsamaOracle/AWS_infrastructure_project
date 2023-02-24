provider "aws" {
  region = "eu-west-1"
}

# provider "aws" {
#   alias  = "dr"
#   region = "eu-central-1"
# }

terraform {
  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
  }
}

# provider "kubernetes" {
#   config_path    = "~/.kube/config"
# }
