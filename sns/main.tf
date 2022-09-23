resource "aws_sns_topic" "sns" {
  name       = "${var.environment}-${var.name}-${var.fifo == true ? ".fifo" : ""}"
  fifo_topic = var.fifo
}

output "arn" {
  value = aws_sns_topic.sns.arn
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "fifo" {
  type    = bool
  default = false
}