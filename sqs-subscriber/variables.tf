variable "name" {
  type = string
}

variable "dlq" {
  type = object({
    enable            = optional(bool, false)
    max_receive_count = optional(number, 2)
  })
  default = {
    enable = false
  }
}

variable "environment" {
  type = string
}

variable "fifo" {
  type    = bool
  default = false
}

variable "sns_arn" {
  type    = string
  default = ""
}

variable "filters" {
  type    = any
  default = ""
}

variable "application_iam_role_name" {
  type    = string
  default = ""
}

variable "settings" {
  type = object({
      deduplication_scope   = optional(string, null)
    content_based_deduplication = optional(bool, false)
  })
  default = {}
}