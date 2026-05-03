provider "aws" {
  region = var.region
}

# ---------------- VPC ----------------
module "vpc" {
  source = "../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

# ---------------- SG ----------------
module "sg" {
  source = "../modules/sg"

  vpc_id            = module.vpc.vpc_id
  alb_ingress_ports = var.alb_ingress_ports
  app_port          = var.app_port
  db_port           = var.db_port
  tags              = var.tags
}

# ---------------- ALB ----------------
module "alb" {
  source = "../modules/alb"

  name          = var.alb_name
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.public_subnets
  sg_id         = module.sg.alb_sg_id
  target_port   = var.target_port
  listener_port = var.listener_port
  tags          = var.tags
}

# ---------------- IAM ----------------
module "iam" {
  source = "../modules/iam"

  role_name          = var.iam_role_name
  assume_role_policy = var.assume_role_policy
  policy             = var.iam_policy
  tags               = var.tags
}

# ---------------- EC2 ----------------
module "ec2" {
  source = "../modules/ec2"

  name                       = var.ec2_name
  instance_type              = var.instance_type
  private_subnet_ids         = module.vpc.private_subnets
  sg_id                      = module.sg.app_sg_id
  iam_instance_profile_name  = module.iam.instance_profile_name
  target_group_arn           = module.alb.target_group_arn
  min_size                   = var.min_size
  max_size                   = var.max_size
  desired_capacity           = var.desired_capacity
  tags                       = var.tags
}

# ---------------- RDS ----------------
module "rds" {
  source = "../modules/rds"

  identifier           = var.db_identifier
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  private_subnet_ids   = module.vpc.private_subnets
  sg_id                = module.sg.rds_sg_id
  tags                 = var.tags
}

# ---------------- S3 ----------------
module "s3" {
  source = "../modules/s3"

  bucket_name          = var.bucket_name
  versioning_enabled   = var.bucket_versioning
  public_access_block  = var.bucket_public_access_block
  enable_encryption    = var.bucket_encryption
  force_destroy        = var.bucket_force_destroy

  bucket_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = module.iam.role_arn
      }
      Action   = ["s3:GetObject"]
      Resource = "arn:aws:s3:::${var.bucket_name}/*"
    }]
  })

  tags = var.tags
}