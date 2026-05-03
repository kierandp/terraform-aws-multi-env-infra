# ---------------- S3 Bucket ----------------
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}

# ---------------- Versioning ----------------
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

# ---------------- Public Access Block ----------------
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.public_access_block
  block_public_policy     = var.public_access_block
  ignore_public_acls      = var.public_access_block
  restrict_public_buckets = var.public_access_block
}

# ---------------- KMS Key  ----------------
resource "aws_kms_key" "key" {

  description             = "S3 encryption key"
  deletion_window_in_days = 10
}

# ---------------- Encryption ----------------
resource "aws_s3_bucket_server_side_encryption_configuration" "enc" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# ---------------- Bucket Policy  ----------------
resource "aws_s3_bucket_policy" "policy" {

  bucket = aws_s3_bucket.bucket.id
  policy = var.bucket_policy
}