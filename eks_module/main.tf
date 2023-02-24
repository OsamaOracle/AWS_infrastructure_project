module "eks" {
  source           = "terraform-aws-modules/eks/aws"
  version          = "v17.24.0"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  subnets          = var.subnet_ids
  vpc_id           = var.vpc_id
  map_roles        = local.role_map_obj
  manage_aws_auth  = true
  enable_irsa      = true
  node_groups = {
    demo = {
      desired_capacity = var.desired_size
      max_capacity     = var.max_size
      min_capacity     = var.min_size
      instance_types   = var.instance_type
      k8s_labels = {
        Environment =  var.environment
      }
    }
  }

}
