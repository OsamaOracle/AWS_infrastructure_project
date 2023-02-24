
resource "aws_elasticache_subnet_group" "redis_cloud_subnet" {
  name                 = var.subnet_group_name_redis
  subnet_ids           = var.subnet_group_list
}

resource "aws_elasticache_cluster" "redis_cloud" {
  cluster_id           = var.elasticache_cluster_name
  engine               = var.elasticache_engine
  engine_version       = var.elasticache_engine_version
  node_type            = var.elasticache_node_type
  num_cache_nodes      = var.elasticache_node_count
  port                 = var.redis_port
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.redis_cloud_subnet.id
  tags = merge({
      Name = "${var.environment}-${var.service}"
    }, var.required_tags)
}