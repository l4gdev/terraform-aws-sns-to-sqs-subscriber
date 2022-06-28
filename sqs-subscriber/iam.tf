resource "aws_iam_role_policy" "test_policy" {
  name   = "allow-access-to-${aws_sqs_queue.sqs.name}"
  role   = var.application_iam_role_arn
  policy = data.aws_iam_policy_document.allow.json
}



data "aws_iam_policy_document" "allow" {
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