variable "region" {
  description = "AWS region"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
}

variable "db_instance_class" {
  description = "Instance class for the RDS instance"
}

variable "db_password" {
  description = "Password for the RDS instance"
}