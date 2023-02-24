data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
locals {
  role_to_user_map = {
      external_admin = "admin",
      external_developer = "developer"
    }

  role_map_obj = [
    for role_name, user in local.role_to_user_map: {
      rolearn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/${role_name}"
      username = user
      groups = [ "system:masters" ] 
    }
  ]
}

resource "aws_iam_role" "external_admin" {
  name = "external_admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = var.assume_developer_role,
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "external_admin_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["eks:DescribeCluster"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

resource "aws_iam_role" "external_developer" {
  name = "external_developer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = var.assume_developer_role
        }
      },
    ]
  })

  inline_policy {
    name = "external_developer_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["eks:DescribeCluster"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

