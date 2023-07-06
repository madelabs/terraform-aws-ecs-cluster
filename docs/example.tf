module "ecs_cluster" {
  source       = "madelabs/ecs-cluster/aws"
  project_name = "my-ecs-cluster"
  environment  = "dev"

  enable_container_insights = true

  execute_command_logging             = "OVERRIDE"
  execute_command_logs_retention      = 14
  execute_command_logs_skip_destroy   = false
  execute_command_enable_encryption   = true
  execute_command_kms_deletion_window = 7
}
