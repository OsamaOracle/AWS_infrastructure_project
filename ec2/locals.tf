data "aws_caller_identity" "current" {} 
data "aws_region" "current" {}

data "cloudinit_config" "user_data" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = <<-USERDATA
      #!/bin/bash
        sudo yum update
        sudo yum group install "Development Tools"
        sudo yum install libffi-devel
        sudo yum install openssl-devel
        sudo yum install cyrus-sasl-devel
        sudo yum install openldap-devel
        sudo yum install mariadb-devel
        sudo yum install epel-release
        sudo yum install xz-devel
        sudo yum install gcc-c++
    USERDATA
  }
}