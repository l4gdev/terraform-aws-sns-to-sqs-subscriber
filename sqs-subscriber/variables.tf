
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

variable "event_key_name" {
  type    = string
  default = "event_name"
}

variable "event_names" {
  type = list(string)
}

variable "application_iam_role_arn" {
  type = string
  default = ""
}