# ---------------- ALB ----------------
resource "aws_lb" "alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.sg_id]
  subnets         = var.subnet_ids

  tags = merge(var.tags, {
    Name = var.name
  })
}

# ---------------- Target Group ----------------
resource "aws_lb_target_group" "tg" {
  name     = "${var.name}-tg"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# ---------------- Listener ----------------
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}