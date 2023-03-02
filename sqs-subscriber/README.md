## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.test_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_sns_topic_subscription.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_iam_policy_document.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_iam_role_name"></a> [application\_iam\_role\_name](#input\_application\_iam\_role\_name) | n/a | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_event_key_name"></a> [event\_key\_name](#input\_event\_key\_name) | n/a | `string` | `"event_name"` | no |
| <a name="input_event_names"></a> [event\_names](#input\_event\_names) | n/a | `list(string)` | n/a | yes |
| <a name="input_fifo"></a> [fifo](#input\_fifo) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_sns_arn"></a> [sns\_arn](#input\_sns\_arn) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_arn"></a> [sns\_arn](#output\_sns\_arn) | n/a |
| <a name="output_sqs_arn"></a> [sqs\_arn](#output\_sqs\_arn) | n/a |
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.31 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.31 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role_policy.test_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_sns_topic_subscription.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue.deadletter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.policy_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_redrive_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_iam_role_name"></a> [application\_iam\_role\_name](#input\_application\_iam\_role\_name) | n/a | `string` | `""` | no |
| <a name="input_cron_rule"></a> [cron\_rule](#input\_cron\_rule) | n/a | `any` | `null` | no |
| <a name="input_dlq"></a> [dlq](#input\_dlq) | n/a | <pre>object({<br>    enable                    = optional(bool, false)<br>    max_receive_count         = optional(number, 2)<br>    message_retention_seconds = optional(number, 345600)<br>  })</pre> | <pre>{<br>  "enable": false<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_fifo"></a> [fifo](#input\_fifo) | n/a | `bool` | `false` | no |
| <a name="input_filters"></a> [filters](#input\_filters) | n/a | `any` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | n/a | <pre>object({<br>    deduplication_scope         = optional(string, null)<br>    content_based_deduplication = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_sns_arn"></a> [sns\_arn](#input\_sns\_arn) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_arn"></a> [sns\_arn](#output\_sns\_arn) | n/a |
| <a name="output_sqs_arn"></a> [sqs\_arn](#output\_sqs\_arn) | n/a |
| <a name="output_sqs_name"></a> [sqs\_name](#output\_sqs\_name) | n/a |
| <a name="output_sqs_url"></a> [sqs\_url](#output\_sqs\_url) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
