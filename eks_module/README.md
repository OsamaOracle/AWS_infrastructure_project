# terraform-aws-cloud-infra

## This module is to creates eks cluster

## Usage for EKS

```hcl

module "eks" {
    source           =  "./eks_module"
    cluster_name     = var.eks_cluster_name
    cluster_version  = var.eks_cluster_version
    subnet_ids       = module.vpc.public_subnet_ids
    vpc_id           = module.vpc.vpc_id_modulevpc
    manage_aws_auth  = var.manage_aws_auth
    desired_size     = var.desired_size
    max_size         = var.max_size
    min_size         = var.min_size
    instance_type    = var.eks_instance_type
    environment      = var.environment
}

```


## Inputs for EKS

### vpc_id
vpc id where eks cluster is configured

### subnet_ids
list of private subnet id where eks cluster is configured

### eks_cluster_name
name for eks cluster 

### eks_cluster_version
version for eks cluster 

### manage_aws_auth
auth for eks cluster 


### instance_type
instance size for eks nodegroup

### desired_size
desired size for eks nodes

### max_size
max size for eks nodes

### min_size
min size for eks nodes

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod
