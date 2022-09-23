resource "aws_sqs_queue" "sqs" {
  name       = replace("${var.environment}-${var.name}-${var.fifo == true ? ".fifo" : ""}", "_", "-")
  fifo_queue = var.fifo
}
resource "aws_sqs_queue_redrive_policy" "policy" {
  count     = var.dlq.enable ? 1 : 0
  queue_url = aws_sqs_queue.sqs.url
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter.0.arn
    maxReceiveCount     = var.dlq.max_receive_count
  })
}

resource "aws_sqs_queue" "deadletter" {
  count      = var.dlq.enable ? 1 : 0
  name       = "${var.environment}-${var.name}-deadletter-${var.fifo == true ? ".fifo" : ""}"
  fifo_queue = var.fifo
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sqs.arn]
  })
}


resource "aws_sqs_queue_policy" "policy" {
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
  topic_arn     = var.sns_arn
  protocol      = "sqs"
  endpoint      = aws_sqs_queue.sqs.arn
  filter_policy = jsonencode(var.filters)
}


