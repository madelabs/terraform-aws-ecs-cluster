resource "aws_cloudwatch_log_group" "ecs_command_logs" {
  count             = var.execute_command_logging == "OVERRIDE" ? 1 : 0
  name              = "${var.project_name}-${var.environment}-ecs-cluster-execute-command"
  retention_in_days = var.execute_command_logs_retention
  skip_destroy      = var.execute_command_logs_skip_destroy
  kms_key_id        = aws_kms_key.execute_command_logging[0].arn

  depends_on = [aws_kms_key_policy.execute_command_logging_key_policy]
}
