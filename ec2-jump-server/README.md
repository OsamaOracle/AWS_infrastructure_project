# terraform-aws-cloud-infra

## This Module is to creates a ec2 bastion host to access eks cluster

## Usage for EC2-jump-server

```hcl

module "jump_server" {
  source                    = "./ec2-jump-server"
  public_subnet_ids         = module.vpc.public_subnet_ids
  vpc_id                    = module.vpc.vpc_id_modulevpc
  key_name                  = var.key_name
  instance_profile_name     = var.jump_server_instance_profile
  prefix                    = local.prefix
  environment               = var.environment
  external_role_name        = module.eks.external_role_name
}

```

## Inputs for EC2-jump-server

### instance_count
The instance count for EC2

### vpc_id
The vpc id where instance to be launched

### public_subnet_ids
provide list of public subnets ids

### instance_ami
instance ami 

### instance_type
type of instance like t2.micro

### key_name
keyname for instance

### external_role_name
role name to be attached with ec2 jump server to login into eks

### required_tags
tags for ec2 instance

### prefix
name for identifier Eg. cloud , iac etc

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod

### required_tags
tags for ec2 instance. keys:
Name
Owner
Customer
Environment
Version
CostCenter/BusinessUnit