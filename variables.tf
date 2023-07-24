variable "project_name" {
  type        = string
  description = "Project name for the ECS task and service."
}

variable "environment" {
  type        = string
  description = "The specific environment or stage that applies to this project. [example dev, uat, prod]"
}

variable "enable_container_insights" {
  type        = bool
  description = "Whether to enable container insights. https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights.html"
  default     = true
}

variable "execute_command_logging" {
  type        = string
  description = "The log setting to use for redirecting logs for your execute command results. Valid values are NONE, DEFAULT, or OVERRIDE. Defaults to DEFAULT."
  default     = "DEFAULT"

  validation {
    condition     = can(regex("^(NONE|DEFAULT|OVERRIDE)$", var.execute_command_logging))
    error_message = "execute_command_logging must be one of NONE, DEFAULT, or OVERRIDE."
  }
}

variable "execute_command_logs_retention" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group. If you select 0, the events in the log group are always retained and never expire."
  default     = 30
}

variable "execute_command_logs_skip_destroy" {
  type        = bool
  description = "Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state."
  default     = false
}

variable "execute_command_enable_encryption" {
  type        = bool
  description = "Whether to enable encryption for ECS execute command data between the local client and the container."
  default     = false
}

variable "execute_command_kms_deletion_window" {
  type        = number
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately."
  default     = 7

  validation {
    condition     = var.execute_command_kms_deletion_window >= 7 && var.execute_command_kms_deletion_window <= 30
    error_message = "kms_deletion_window_in_days must be between 7 and 30 days."
  }
}

variable "capacity_providers" {
  type        = list(string)
  description = "Set of names of one or more capacity providers to associate with the cluster."
  default     = ["FARGATE"]
}

variable "default_capacity_provider_strategy" {
  type = list(object({
    capacity_provider = string
    base              = number
    weight            = number
  }))
  description = "Cluster default capacity provider arguments."
  default     = []
}

variable "kms_enable_key_rotation" {
  type        = bool
  description = "Specifies whether key rotation is enabled. Defaults to true."
  default     = true
}
