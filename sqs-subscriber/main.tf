resource "aws_sqs_queue" "sqs" {
  name                        = replace("${var.environment}-${var.name}${var.fifo == true ? ".fifo" : ""}", "_", "-")
  fifo_queue                  = var.fifo
  content_based_deduplication = var.cron_rule != null ? true : var.settings.content_based_deduplication
  #  deduplication_scope   = try(var.settings.deduplication_scope, var.cron_rule != null? "perMessageGroupId": null)
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
  count                     = var.dlq.enable ? 1 : 0
  name                      = replace("${var.environment}-${var.name}-dl${var.fifo == true ? ".fifo" : ""}", "_", "-")
  message_retention_seconds = var.dlq.message_retention_seconds
  fifo_queue                = var.fifo
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sqs.arn]
  })
}

resource "aws_sqs_queue_policy" "policy" {
  count = var.sns_arn != "" ? 1 : 0

  queue_url = aws_sqs_queue.sqs.id
  policy    = local.policy_s
}
resource "aws_sqs_queue_policy" "policy_dlq" {
  count = var.dlq != "" ? 1 : 0

  queue_url = aws_sqs_queue.deadletter[0].id
  policy    = local.policy_dlq
}

locals {
  policy_s = jsonencode(
    {
      "Version" : "2012-10-17",
      "Id" : "sqspolicy",
      "Statement" : [
        {
          "Sid" : "First",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "sqs:SendMessage",
          "Resource" : aws_sqs_queue.sqs.arn
          "Condition" : {
            "ArnEquals" : {
              "aws:SourceArn" : var.sns_arn
            }
          }
        },
        {
          "Sid" : "EventsToMyQueue",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "events.amazonaws.com"
          },
          "Action" : "sqs:SendMessage",
          "Resource" : aws_sqs_queue.sqs.arn,
          "Condition" : {
            "ArnEquals" : {
              "aws:SourceArn" : "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
            }
          }
        }
      ]
  })


  policy_dlq = jsonencode(
    {
      "Version" : "2012-10-17",
      "Id" : "sqspolicy",
      "Statement" : [
        {
          "Sid" : "First",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "sqs:SendMessage",
          "Resource" : aws_sqs_queue.deadletter[0].arn
          "Condition" : {
            "ArnEquals" : {
              "aws:SourceArn" : var.sns_arn
            }
          }
        },
        {
          "Sid" : "EventsToMyQueue",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "events.amazonaws.com"
          },
          "Action" : "sqs:SendMessage",
          "Resource" : aws_sqs_queue.deadletter[0].arn,
          "Condition" : {
            "ArnEquals" : {
              "aws:SourceArn" : "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
            }
          }
        }
      ]
  })
}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_sns_topic_subscription" "sns" {
  count = var.sns_arn != "" ? 1 : 0

  topic_arn     = var.sns_arn
  protocol      = "sqs"
  endpoint      = aws_sqs_queue.sqs.arn
  filter_policy = jsonencode(var.filters)
}

