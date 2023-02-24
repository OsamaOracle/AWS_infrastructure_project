data "aws_region" "current" {}

locals {
  oidc = {
    url = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  }
}


resource "null_resource" "wait_for_cluster" {
   triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command     =  <<EOH
    aws eks --region "${data.aws_region.current.name}" update-kubeconfig --name "${var.cluster_name}"
    EOH
    interpreter = ["/bin/sh", "-c"]
  }
  depends_on = [ module.eks]
}
