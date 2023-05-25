terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.environment}-wordpress-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  cidr_block = var.public_subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.this.id
  tags = {
    Name = "${var.environment}-wordpress-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.environment}-wordpress-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.environment}-wordpress-public-rt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "wordpress" {
  name        = "${var.environment}-wordpress-sg"
  description = "Allow inbound traffic for WordPress"
  vpc_id      = aws_vpc.this.id
}

resource "aws_security_group_rule" "wordpress" {
  security_group_id = aws_security_group.wordpress.id

  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public[0].id

  vpc_security_group_ids = [aws_security_group.wordpress.id]

  tags = {
    Name = "${var.environment}-wordpress-ec2"
  }
}

resource "aws_db_instance" "wordpress" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.db_instance_class
  username               = "admin"
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.wordpress.id]
  db_subnet_group_name   = aws_db_subnet_group.wordpress.name
  skip_final_snapshot    = true
  tags = {
    Name = "${var.environment}-wordpress-rds"
  }
}

resource "aws_db_subnet_group" "wordpress" {
  name       = "${var.environment}-wordpress-db-subnet-group"
  subnet_ids = aws_subnet.public.*.id
}

# resource "aws_s3_bucket" "wordpress" {
#   bucket = "${var.environment}-wordpress-bucket"
#   acl    = "private"
# }
