# terraform-aws-cloud-infra

## This Module is to creates parameter store

### Usage for ssm_parameter_store

```hcl

module "ssm_parameter_store" {
  source                 = "./parameter_store"
  for_each               = fileset("${path.module}/parameters-files", "*.json")
  environment            = var.environment
  parameter_name         = "${var.parameter_name}/${each.value}"
  json_filename          = "${path.module}/parameters-files/${each.key}"
}


```

## Inputs for ssm_parameter_store

### parameter_name
name of parametr store

### json_filename
name of json file to be stores in parameter store

### for_each
list of file to be which files are stored

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod
