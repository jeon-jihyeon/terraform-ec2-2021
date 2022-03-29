// alb log bucket
resource "aws_s3_bucket" "alb" {
  bucket = "${var.name}-${var.environment}-alb-log"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.alb_account_id}:root"   
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.name}-${var.environment}-alb-log/*"
    }
  ]
}
  EOF

  lifecycle_rule {
    id      = "log_lifecycle"
    prefix  = ""
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}


