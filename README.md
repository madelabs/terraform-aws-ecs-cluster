# terraform-aws-ecs-cluster

<!-- BEGIN MadeLabs Header -->
![MadeLabs is for hire!](https://d2xqy67kmqxrk1.cloudfront.net/horizontal_logo_white.png)
MadeLabs is proud to support the open source community with these blueprints for provisioning infrastructure to help software builders get started quickly and with confidence. 

We're also for hire: [https://www.madelabs.io](https://www.madelabs.io)
<!-- END MadeLabs Header -->

---
A Terraform module for managing an AWS ECS Cluster.

## Requirements

- An existing AWS Account

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ecs_command_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.cluster_capacity_providers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_kms_key.execute_command_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | Set of names of one or more capacity providers to associate with the cluster. | `list(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_default_capacity_provider_strategy"></a> [default\_capacity\_provider\_strategy](#input\_default\_capacity\_provider\_strategy) | Cluster default capacity provider arguments. | <pre>list(object({<br>    base              = optional(number)<br>    weight            = optional(number)<br>    capacity_provider = string<br>  }))</pre> | <pre>[<br>  {<br>    "base": 1,<br>    "capacity_provider": "FARGATE",<br>    "weight": 100<br>  }<br>]</pre> | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | Whether to enable container insights. https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights.html | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The specific environment or stage that applies to this project. [example dev, uat, prod] | `string` | n/a | yes |
| <a name="input_execute_command_enable_encryption"></a> [execute\_command\_enable\_encryption](#input\_execute\_command\_enable\_encryption) | Whether to enable encryption for ECS execute command data between the local client and the container. | `bool` | `false` | no |
| <a name="input_execute_command_kms_deletion_window"></a> [execute\_command\_kms\_deletion\_window](#input\_execute\_command\_kms\_deletion\_window) | The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately. | `number` | `7` | no |
| <a name="input_execute_command_logging"></a> [execute\_command\_logging](#input\_execute\_command\_logging) | The log setting to use for redirecting logs for your execute command results. Valid values are NONE, DEFAULT, or OVERRIDE. Defaults to DEFAULT. | `string` | `"DEFAULT"` | no |
| <a name="input_execute_command_logs_retention"></a> [execute\_command\_logs\_retention](#input\_execute\_command\_logs\_retention) | Specifies the number of days you want to retain log events in the specified log group. If you select 0, the events in the log group are always retained and never expire. | `number` | `30` | no |
| <a name="input_execute_command_logs_skip_destroy"></a> [execute\_command\_logs\_skip\_destroy](#input\_execute\_command\_logs\_skip\_destroy) | Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state. | `bool` | `false` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name for the ECS task and service. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
<!-- END_TF_DOCS -->