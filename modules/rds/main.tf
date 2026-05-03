# ---------------- Subnet Group ----------------
resource "aws_db_subnet_group" "db" {
  name       = "${var.identifier}-db-subnet"
  subnet_ids = var.private_subnet_ids

  tags = var.tags
}

# ---------------- RDS Instance ----------------
resource "aws_db_instance" "db" {
  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.username
  password = var.password

  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name   = aws_db_subnet_group.db.name

  skip_final_snapshot = true

  tags = var.tags
}