resource "aws_db_subnet_group" "rds_subnet" {
    name       = "${var.service}-dbsubnet"
    subnet_ids = "${var.subnet_list}"
    tags       = merge({
      Name = "${var.environment}-${var.service}-dbsubnet"
    }, var.required_tags)
}

resource "aws_rds_cluster" "rds_cluster" {
    cluster_identifier               = var.cluster_name
    db_subnet_group_name             = aws_db_subnet_group.rds_subnet.name
    engine                           = var.cluster_engine
    master_username                  = var.cluster_master_username
    master_password                  = var.cluster_master_password
    skip_final_snapshot              = true
    allow_major_version_upgrade      = false
    apply_immediately                = true
    backup_retention_period          =  1
    tags = merge({
      Name = "${var.environment}-${var.service}-cluster"
    }, var.required_tags)
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                     = var.cluster_instances
  identifier                = "${var.service}-cluster-instance-${count.index}"
  cluster_identifier        = aws_rds_cluster.rds_cluster.id
  instance_class            = var.instance_class
  engine                    = aws_rds_cluster.rds_cluster.engine
  engine_version            = aws_rds_cluster.rds_cluster.engine_version
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet.name
  tags    = merge({
    Name = "${var.environment}-${var.service}-dbparameter"
  }, var.required_tags)
}

resource "null_resource" "rds_commands" {
  count = var.cluster_instances
  triggers = {
    "ip" = aws_rds_cluster_instance.cluster_instances[count.index].endpoint
  }
  provisioner "local-exec" { 
    command = "mysql -h${aws_rds_cluster_instance.cluster_instances[count.index].endpoint} -u${var.cluster_master_username} -p${var.cluster_master_password} < ./files/commands.sql"
  }
}