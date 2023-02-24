# terraform-aws-cloud-infra

## This Module is to creates a ec2 instance

## Usage for EC2

```hcl

module "ec2" {
  source                         = "./ec2"
  instance_count                 = 1
  vpc_id                         = module.vpc.vpc_id_modulevpc
  subnet_ids                     = module.vpc.public_subnet_ids
  instance_ami                   = var.ec2_ami
  instance_type                  = var.ec2_instance_type
  key_name                       = var.ec2_key_name
  monitoring                     = var.ec2_monitoring
  root_block_device              = var.ec2_root_block_device
  ebs_block_device               = var.ec2_ebs_block_device
  instance_profile_name          = var.ec2_instance_profile_name
  machine_name                   = var.machine_name
  environment                    = var.environment
  required_tags                  = var.tags
  public_ip                      = var.public_ip
  prefix                         = local.prefix
  allowed_ipv4_addresses         = ["0.0.0.0/0"]
}

```

## Inputs for ec2

### instance_count
The instance count for EC2

### vpc_id
The vpc id where instance to be launched

### subnet_ids
provide list subnet

### instance_ami
instance ami 

### instance_type
type of instance like t2.micro

### key_name
keyname for instance

### machine_name
name for instance

### monitoring
enable true for detail monitoring

### required_tags
tags for ec2 instance. keys:
Name
Owner
Customer
Environment
Version

### public_ip
public ip for ec2 instance true or false

### allowed_ipv4_addresses
allow inbound for sg of ec2

### prefix
name for identifier Eg. cloud , iac etc

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod

### redis and rds security group IDs