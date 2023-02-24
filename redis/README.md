# terraform-aws-cloud-infra

## This Module is to creates  redis cluster

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

### required_tags
tags for ec2 instance. keys:
Name
Owner
Customer
Environment
Version