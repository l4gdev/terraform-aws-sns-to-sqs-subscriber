resource "aws_iam_role_policy" "test_policy" {
  count  = var.application_iam_role_name != "" ? 1 : 0
  name   = "allow-access-to-${aws_sqs_queue.sqs.name}"
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
    resources = [aws_sqs_queue.sqs.arn]
  }
}
