resource "aws_vpc" "cloud_vpc" {
  cidr_block                        = var.vpc_cidr
  assign_generated_ipv6_cidr_block  = false
  instance_tenancy                  = "default"
  enable_dns_support                = "true"
  enable_dns_hostnames              = "true"
  tags = {
    Name = "${var.environment}-${var.prefix}-VPC"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnets"{
    count                   = length(var.public_list)
    vpc_id                  = aws_vpc.cloud_vpc.id
    cidr_block              = var.public_list[count.index]
    availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names) ]
    map_public_ip_on_launch = "true"
    tags = {
    Name = "${var.environment}-${var.prefix}-public-subnet-${count.index}" 
    "kubernetes.io/role/elb"	= "1" 
    "kubernetes.io/cluster/${var.cluster_name}"	= "shared"
  }
}

resource "aws_subnet" "private_subnets"{
    count                   = length(var.private_list)
    vpc_id                  = "${aws_vpc.cloud_vpc.id}"
    cidr_block              = var.private_list[count.index]
    availability_zone       = data.aws_availability_zones.available.names[ count.index % length(data.aws_availability_zones.available.names) ]
    map_public_ip_on_launch = "false"
    tags = {
    Name = "${var.environment}-${var.prefix}-private-subnet-${count.index}"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc                      = true
  tags = {
    Name = "${var.environment}-${var.prefix}-EIP"
  }
}

resource "aws_internet_gateway" "cloud_igw" {
  vpc_id = aws_vpc.cloud_vpc.id
  tags = {
    Name = "${var.environment}-${var.prefix}-NATGateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id                   = aws_vpc.cloud_vpc.id
  route {
      cidr_block           = var.public_routetable_cidr
      gateway_id           = aws_internet_gateway.cloud_igw.id
    }
  tags = {
    Name = "${var.environment}-${var.prefix}-publicroute-Table"
  }
}


resource "aws_route_table_association" "public_routetable_association" {
  count                   = length(var.public_list)
  subnet_id               = aws_subnet.public_subnets[count.index].id
  route_table_id          = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id                 = aws_vpc.cloud_vpc.id
  route {
      cidr_block         = var.public_routetable_cidr
      gateway_id         = aws_nat_gateway.aws_nat_gateway.id
    }
  tags = {
    Name = "${var.environment}-${var.prefix}-privateroute-Table"
  }
}

resource "aws_route_table_association" "private_routetable_association" {
  count                 = length(var.private_list)
  subnet_id             = aws_subnet.private_subnets[count.index].id
  route_table_id        = aws_route_table.private_route_table.id
}

resource "aws_nat_gateway" "aws_nat_gateway" {
  allocation_id         = "${aws_eip.nat_gateway.id}"
  subnet_id             = aws_subnet.public_subnets[0].id
  tags = {
    Name = "${var.environment}-${var.prefix}-NatGateway"
  }
}
