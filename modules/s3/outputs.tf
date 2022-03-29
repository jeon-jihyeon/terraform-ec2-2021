output "alb_bucket_id" {
  value = join("", aws_s3_bucket.alb.*.id)
}