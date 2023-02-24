# terraform-aws-cloud-infra

## This Module is to creates lb-controller for eks

This module is to create a lb-controller


## Usage for lb-controller

```hcl

module "lb-controller" {
  source       = "./lb-controller"
  enabled      = false
  cluster_name = module.eks.eks_cluster.name
  oidc         = module.eks.eks_oidc
  tags         = var.tags
}
```

## Inputs for iam-role-for-serviceaccount

### enabled
whether to create a service account or no

### name
name of the service account

### namespace
namespace for eks cluster

### serviceaccount
value for service account like aws-load-balancer-controller

### oidc_url
name of private security group

### oidc_arn
name of aplication load balancer

### policy_arns
policy arn for lb-controller

### tags
tags for aws lb-controller

### prefix
name for identifier Eg. cloud , iac etc

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod

