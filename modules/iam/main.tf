# ---------------- IAM Role ----------------
resource "aws_iam_role" "role" {
  name               = var.role_name
  assume_role_policy = jsonencode(var.assume_role_policy)

  tags = var.tags
}

# ---------------- IAM Policy ----------------
resource "aws_iam_policy" "policy" {
  name   = "${var.role_name}-policy"
  policy = jsonencode(var.policy)

  tags = var.tags
}

# ---------------- Attach Policy ----------------
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

# ---------------- Instance Profile ----------------
resource "aws_iam_instance_profile" "profile" {
  name = "${var.role_name}-profile"
  role = aws_iam_role.role.name
}