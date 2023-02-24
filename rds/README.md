# terraform-aws-cloud-infra

## This Module is to creates rds cluster 


## Usage for RDS

```hcl


module "rds" {
    source              = "./rds"
    subnet_list         = module.vpc.private_subnet_ids
    security_groups     = [module.vpc.vpc_security_group_private]
    cluster_name        = var.cluster_name
    master_username     = var.master_username
    master_password     = var.master_password
    engine              = var.engine
    engine_version      = var.engine_version
    instance_class      = var.instance_class
    dbname              = var.dbname
    username            = var.username
    password            = var.password
    port                = var.port
    allocated_storage   = 20
    skip_final_snapshot = var.skip_final_snapshot
    multi_az            = var.multi_az
    environment         = var.environment
}
 

```

## Inputs for rds

### subnet_list
subnet list for rds provided by output of vpc

### security_groups
security group list for rds provided by output of vpc

### cluster_name
This is the name of the cluster of rds

### master_username
The name of the rds master username

### master_password
password for rds password

### engine
RDS Engine type (postgres, mysql, mssql)

### engine_version
Engine Version Type

### instance_class
RDS instance type

### dbname
RDS database name

### username
Database username

### password
RDS password

### port
RDS port for security group to allow inbound

### skip_final_snapshot
Final Snapshot prior to deleting 

### rds_multi_az
Mulit Avaliability Zones

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod

### required_tags
tags for ec2 instance. keys:
Name
Owner
Customer
Environment
Version
