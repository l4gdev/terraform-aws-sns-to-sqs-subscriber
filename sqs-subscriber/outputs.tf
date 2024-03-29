
output "sns_arn" {
  value = var.sns_arn
}

output "sqs_url" {
  value = aws_sqs_queue.sqs.url
}

output "sqs_arn" {
  value = aws_sqs_queue.sqs.arn
}

output "sqs_name" {
  value = aws_sqs_queue.sqs.name
}
