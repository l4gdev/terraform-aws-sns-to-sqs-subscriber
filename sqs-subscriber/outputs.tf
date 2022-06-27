
output "sns_arn" {
  value = var.sns_arn
}

output "sqs_arn" {
  value = aws_sqs_queue.sqs.arn
}
