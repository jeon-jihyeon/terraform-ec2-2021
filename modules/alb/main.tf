# acm
data "aws_acm_certificate" "amazon_issued" {
  domain      = var.domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

# alb
resource "aws_alb" "alb" {
  name               = "${var.environment}-alb"
  internal           = false
  security_groups    = var.alb_sg_ids
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  access_logs {
    bucket  = var.alb_bucket_id
    prefix  = "${var.environment}-alb"
    enabled = true
  }

  tags = {
    Name        = "${var.name}-alb-${var.environment}"
    Environment = var.environment
  }
}

# alb target group
resource "aws_alb_target_group" "main" {
  name        = "${var.environment}-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "20"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.name}-tg-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_alb_target_group_attachment" "backend" {
  count            = length(var.backend_ids)
  target_group_arn = aws_alb_target_group.main.arn
  target_id        = element(var.backend_ids, count.index)
  port             = 80
}

# Redirect to https listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb.id
  port              = 80
  protocol          = "HTTP"

#  default_action {
#    target_group_arn = aws_alb_target_group.main.id
#    type             = "forward"
#  }
#}
  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Redirect traffic to target group
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.alb.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.amazon_issued.arn

  default_action{
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.id
  }
#    type = "fixed-response"
#    fixed_response {
#      content_type = "text/plain"
#      message_body = "INVALID DEVICE"
#      status_code  = "400"
#    }
}

# Listener Rule
#resource "aws_alb_listener_rule" "main" {
#  listener_arn = aws_alb_listener.https.arn

#  action {
#    type             = "forward"
#    target_group_arn = aws_alb_target_group.main.id
#  }

#  condition {
#    http_header {
#      http_header_name = var.listener_rule_key
#      values           = var.listener_rule_values
#    }
#  }
#}


# Route 53
data "aws_route53_zone" "selected" {
  name         = var.domain_name
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.environment}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name     = aws_alb.alb.dns_name
    zone_id  = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}