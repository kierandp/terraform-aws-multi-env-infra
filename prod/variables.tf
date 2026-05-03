variable "region" { type = string }

# VPC
variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "availability_zones" { type = list(string) }

# SG
variable "alb_ingress_ports" { type = list(number) }
variable "app_port" { type = number }
variable "db_port" { type = number }

# ALB
variable "alb_name" { type = string }
variable "target_port" { type = number }
variable "listener_port" { type = number }

# EC2
variable "ec2_name" { type = string }
variable "instance_type" { type = string }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "desired_capacity" { type = number }

# IAM
variable "iam_role_name" { type = string }
variable "assume_role_policy" { type = any }
variable "iam_policy" { type = any }

# RDS
variable "db_identifier" { type = string }
variable "db_engine" { type = string }
variable "db_engine_version" { type = string }
variable "db_instance_class" { type = string }
variable "db_allocated_storage" { type = number }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }

# S3
variable "bucket_name" { type = string }
variable "bucket_versioning" { type = bool }
variable "bucket_public_access_block" { type = bool }
variable "bucket_encryption" { type = bool }
variable "bucket_force_destroy" { type = bool }
variable "bucket_policy" {
  type    = string
  default = null
}

# Global
variable "tags" {
  type = map(string)
}