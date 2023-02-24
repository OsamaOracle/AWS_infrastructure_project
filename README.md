# terraform-aws-cloud-infra

## This infra is to creates a vpc , eks cluster , rds cluster and redis cluster

This infra is to create 4 Modules.

The following modules are created
- vpc
- eks
- rds
- redis
- ssm parameter store
- s3

## Usage for VPC

```hcl

module "vpc" {
    source                 = "./vpc"
    vpc_cidr               = var.vpc_cidr
    public_list            = var.public_list
    private_list           = var.private_list
    public_security_group  = var.public_security_group
    private_security_group = var.private_security_group
    alb_name               = var.alb_name
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

### alb_name
name of aplication load balancer

### prefix
name for identifier Eg. cloud , iac etc

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod


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


## Usage for Redis

```hcl


module "redis" {
    source                     =  "./redis"
    elasticache_cluster_name   = var.elasticache_cluster_name
    elasticache_engine         = var.elasticache_engine
    elasticache_engine_version = var.elasticache_engine_version
    elasticache_node_type      = var.elasticache_node_type
    elasticache_node_count     = var.elasticache_node_count
    redis_port                 = var.redis_port
    parameter_group_name       = var.parameter_group_name
    subnet_group_list          = module.vpc.private_subnet_ids
    environment                = var.environment
}

```

## Inputs for redis

### elasticache_cluster_name
This is the name of the elasticache cluster of for redis

### elasticache_engine
elastic Cache Engine 

### elasticache_engine_version
elastic Cache Engine version

### elasticache_node_type
elastic cache node type 

### elasticache_node_count
elastic cache node count

### redis_port
redis port for elastic cache

### parameter_group_name
rds parameter group 

### subnet_group_list
rds subnet list

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod


## Usage for EKS

```hcl

module "eks" {
    source  = "./eks"
    private_subnet_ids      = module.vpc.private_subnet_ids
    eks_role_name           = var.eks_role_name
    eks_policy_name         = var.eks_policy_name
    eks_cluster_name        = var.eks_cluster_name
    eks_node_role_name      = var.eks_node_role_name
    eks_node_policy_name    = var.eks_node_policy_name
    node_group_name         = var.node_group_name
    desired_size            = var.desired_size
    max_size                = var.max_size
    min_size                = var.min_size
    environment             = var.environment
}

```


## Inputs for EKS

### private_subnet_ids
list of private subnet id where eks cluster is configured

### eks_role_name
role name for eks cluster 

### eks_cluster_name
name for eks cluster 

### eks_node_role_name
role name for eks node group name

### node_group_name
name for eks node group

### desired_size
desired size for eks nodes

### max_size
max size for eks nodes

### min_size
min size for eks nodes

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod
