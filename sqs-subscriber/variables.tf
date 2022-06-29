
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

variable "sns_arn" {
  type = string
}

variable "filters" {
  type = object({})
}

variable "application_iam_role_name" {
  type    = string
  default = ""
}