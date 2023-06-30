resource "aws_kms_key" "execute_command_key" {
  count                   = var.execute_command_enable_encryption == true ? 1 : 0
  description             = "${var.project_name}-${var.environment}-cluster KMS key for encryption of execute command data between the local client and the container"
  deletion_window_in_days = var.execute_command_kms_deletion_window
}
