variable "cron_rule" {
  default  = null
  nullable = true
}

resource "aws_cloudwatch_event_rule" "rule" {
  for_each            = (try(var.filters["eventName"], []) != []) && (var.cron_rule != null) ? toset(var.filters["eventName"]) : toset([])
  name                = replace("${substr(var.environment, 0, 5)}-${var.name}-${substr(each.value, 0, 5)}","_","-")
  schedule_expression = var.cron_rule
  tags = {
    eventName = each.key
  }
}

resource "aws_cloudwatch_event_target" "sns" {
  for_each  = aws_cloudwatch_event_rule.rule
  target_id = "${var.environment}-${replace(var.name, ":", "-")}"
  arn       = aws_sqs_queue.sqs.arn

  sqs_target {
    message_group_id = each.value.tags.eventName
  }
  rule = each.value.name

}
