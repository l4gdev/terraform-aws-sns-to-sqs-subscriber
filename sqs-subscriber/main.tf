resource "aws_sqs_queue" "sqs" {
  for_each = var.event_names
  name       = "${var.name}-${var.environment}${var.fifo == true ? ".fifo" : ""}"
  fifo_queue = true
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.sqs.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Id" : "sqspolicy",
      "Statement" : [
        {
          "Sid" : "First",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "sqs:SendMessage",
          "Resource" : aws_sqs_queue.sqs.arn,
          "Condition" : {
            "ArnEquals" : {
              "aws:SourceArn" : var.sns_arn
            }
          }
        }
      ]
  })
}

resource "aws_sns_topic_subscription" "sns" {
  topic_arn = var.sns_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs.arn
  filter_policy = jsonencode({
    "${var.event_key_name}" : var.event_names
  })
}


