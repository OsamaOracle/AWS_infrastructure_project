# terraform-aws-cloud-infra

## This module is to creates a vpc 
## Usage for VPC

```hcl

module "vpc" {
    source                 = "./vpc"
    vpc_cidr               = var.vpc_cidr
    public_list            = var.public_list
    private_list           = var.private_list
    public_security_group  = var.public_security_group
    private_security_group = var.private_security_group
    prefix                 = local.prefix
}

```

## Inputs for vpc

### vpc_cidr
The CIDR block for the VPC

### public_list
provide list of public subnet

### private_list
provide list of private subnet

### public_security_group
name of public security group

### private_security_group
name of private security group

### prefix
name for identifier Eg. cloud , iac etc

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod

