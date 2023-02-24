data "cloudinit_config" "user_data" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = <<-USERDATA
      #!/bin/bash
        sudo apt-get update
        sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
        sudo chmod +x ./kubectl && sudo  mv kubectl  /usr/local/bin
    USERDATA
  }
}

data "aws_ami" "ami_id" {
most_recent = true
owners = ["amazon"] # Canonical
  filter {
      name   = "name"
      values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}


# aws eks --region us-east-1  update-kubeconfig --name dev-eks-cluster
# kubectl get configmap aws-auth -n kube-system -o yaml
