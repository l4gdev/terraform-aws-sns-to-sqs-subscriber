variable "application_iam_role_name" {
  type = string
}
resource "aws_iam_role_policy" "sqs" {
  name   = replace(var.sqs_name, ".", "-")
  role   = var.application_iam_role_name
  policy = data.aws_iam_policy_document.allow.json
}

data "aws_iam_policy_document" "allow" {
  statement {
    sid = "1"

    actions = [
      "sqs:ListQueues",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ReceiveMessage",
      "sqs:GetQueueAttributes",
      "sqs:ListQueueTags"
    ]
    resources = [data.aws_sqs_queue.queue.arn]
  }
}


variable "sqs_name" {
  type = string
}

data "aws_sqs_queue" "queue" {
  name = var.sqs_name
}
