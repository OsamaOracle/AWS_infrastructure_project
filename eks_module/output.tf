output "external_role_name" {
  value       = "${aws_iam_role.external_admin.name}"
}

output "eks_cluster" {
  description = "The EKS cluster attributes"
  value = {
    name          = module.eks.cluster_id
    data_plane = {
      node_groups         =  null
      managed_node_groups =  null
      fargate             =  null
    }
  }
}

output "eks_oidc" {
  description = "The OIDC provider attributes for IAM Role for ServiceAccount"
  value = zipmap(
    ["url", "arn"],
    [local.oidc.url , module.eks.oidc_provider_arn]
  )
}

output "eks_oidc_arn" {
  description = "The OIDC provider attributes for IAM Role for ServiceAccount"
  value = module.eks.oidc_provider_arn
}