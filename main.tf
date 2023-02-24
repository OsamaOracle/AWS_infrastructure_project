# resource "aws_s3_bucket" "backend_bucket" {
#   bucket       = var.bucket_name
#   acl          = "private"
#   tags = {
#     Name        = "terraform backend bucket"
#     environment = "Dev"
#   }
#   provider      = aws.dr
# }

module "vpc" {
  source                 = "./vpc"
  vpc_cidr               = var.vpc_cidr
  public_list            = var.public_list
  private_list           = var.private_list
  public_security_group  = var.public_security_group
  private_security_group = var.private_security_group
  cluster_name           = var.eks_cluster_name
  prefix                 = local.prefix
}

module "ssm_parameter_store" {
  source                 = "./parameter_store"
  for_each               = fileset("${path.module}/parameters-files/prod", "*.json")
  environment            = var.environment
  secret_name            = "${var.secret_name}/${each.value}"
  json_filename          = "${path.module}/parameters-files/prod/${each.key}"
}

module "rds" {
  source                      = "./rds"
  subnet_list                 = module.vpc.private_subnet_ids
  cluster_name                = var.cluster_name
  cluster_engine              = var.cluster_engine
  cluster_master_username     = var.cluster_master_username
  cluster_master_password     = var.cluster_master_password
  cluster_instances           = var.cluster_instances
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  skip_final_snapshot         = var.skip_final_snapshot
  environment                 = var.environment
}


module "redis" {
    source                     =  "./redis"
    elasticache_cluster_name   = var.elasticache_cluster_name
    elasticache_engine         = var.elasticache_engine
    elasticache_engine_version = var.elasticache_engine_version
    elasticache_node_type      = var.elasticache_node_type
    elasticache_node_count     = var.elasticache_node_count
    redis_port                 = var.redis_port
    parameter_group_name       = var.parameter_group_name
    subnet_group_list          = module.vpc.private_subnet_ids
    environment                = var.environment
}

module "ec2_key_pair" {
  source                    = "./ec2-keypair"
  key_name                  = var.ec2_key_name
}
module "jump_server" {
  source                    = "./ec2-jump-server"
  public_subnet_ids         = module.vpc.public_subnet_ids
  vpc_id                    = module.vpc.vpc_id_modulevpc
  key_name                  = module.ec2_key_pair.key_name
  instance_profile_name     = var.jump_server_instance_profile
  prefix                    = local.prefix
  environment               = var.environment
  external_role_name        = module.eks.external_role_name
}

module "eks" {
  source           =  "./eks_module"
  cluster_name     = var.eks_cluster_name
  cluster_version  = var.eks_cluster_version
  subnet_ids       = module.vpc.public_subnet_ids
  vpc_id           = module.vpc.vpc_id_modulevpc
  manage_aws_auth  = var.manage_aws_auth
  enable_irsa      = var.enable_irsa
  desired_size     = var.desired_size
  max_size         = var.max_size
  min_size         = var.min_size
  instance_type    = var.eks_instance_type
  environment      = var.environment
}

module "lb-controller" {
  source       = "./lb-controller"
  enabled      = var.enabled
  cluster_name = module.eks.eks_cluster.name
  oidc         = module.eks.eks_oidc
  tags         = var.tags
}

module "ec2" {
    source                         = "./ec2"
    instance_count                 = 1
    vpc_id                         = module.vpc.vpc_id_modulevpc
    subnet_ids                     = module.vpc.public_subnet_ids
    instance_ami                   = data.aws_ami.ami_id.id
    instance_type                  = var.ec2_instance_type
    key_name                       = module.ec2_key_pair.key_name
    monitoring                     = var.ec2_monitoring
    root_block_device              = var.ec2_root_block_device
    ebs_block_device               = var.ec2_ebs_block_device
    instance_profile_name          = var.ec2_instance_profile_name
    machine_name                   = var.machine_name
    environment                    = var.environment
    required_tags                  = var.tags
    public_ip                      = var.public_ip
    prefix                         = local.prefix
    allowed_ipv4_addresses         = ["0.0.0.0/0"]
    depends_on                     = [module.ec2_key_pair]
    rds_sg_id = ""
    redis_sg_id = ""
  }


