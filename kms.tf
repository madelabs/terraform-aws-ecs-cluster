resource "aws_kms_key" "execute_command" {
  count                   = var.execute_command_enable_encryption == true ? 1 : 0
  description             = "${var.project_name}-${var.environment}-cluster KMS key for encryption of execute command data between the local client and the container."
  deletion_window_in_days = var.execute_command_kms_deletion_window
  enable_key_rotation     = var.kms_enable_key_rotation
}

resource "aws_kms_key" "execute_command_logging" {
  count                   = var.execute_command_logging == "OVERRIDE" ? 1 : 0
  description             = "${var.project_name}-${var.environment}-cluster KMS key for encryption of execute command cloudwatch logs."
  deletion_window_in_days = var.execute_command_kms_deletion_window
  enable_key_rotation     = var.kms_enable_key_rotation
}

resource "aws_kms_alias" "execute_command_key_alias" {
  count         = var.execute_command_enable_encryption == true ? 1 : 0
  name          = "alias/${var.project_name}-${var.environment}-cluster-execute-command"
  target_key_id = aws_kms_key.execute_command[0].id
}

resource "aws_kms_alias" "execute_command_logging_alias" {
  count         = var.execute_command_logging == "OVERRIDE" ? 1 : 0
  name          = "alias/${var.project_name}-${var.environment}-cluster-execute-command-logging"
  target_key_id = aws_kms_key.execute_command_logging[0].id
}

resource "aws_kms_key_policy" "execute_command_logging_key_policy" {
  count  = var.execute_command_logging == "OVERRIDE" ? 1 : 0
  key_id = aws_kms_key.execute_command_logging[0].id
  policy = data.aws_iam_policy_document.execute_command_logging_policy[0].json
}

data "aws_iam_policy_document" "execute_command_logging_policy" {
  count = var.execute_command_logging == "OVERRIDE" ? 1 : 0
  statement {
    sid     = "Enable IAM User Permissions"
    effect  = "Allow"
    actions = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = [aws_kms_key.execute_command_logging[0].arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }

    resources = [aws_kms_key.execute_command_logging[0].arn]

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }
}
