# terraform-aws-cloud-infra

## This Module is to creates iam-role-for-serviceaccount for eks

This module is to create a iam-role-for-serviceaccount 


## Usage for iam-role-for-serviceaccount

```hcl

module "cloud" {
  source         = "../iam-role-for-serviceaccount"
  count          = var.enabled ? 1 : 0
  name           = join("-", ["cloud", local.name])
  namespace      = local.namespace
  serviceaccount = local.serviceaccount
  oidc_url       = var.oidc.url
  oidc_arn       = var.oidc.arn
  policy_arns    = [aws_iam_policy.lbc.0.arn]
  tags           = var.tags
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

