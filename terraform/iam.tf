# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
######################################################################################

# Attaching AmazonECSTaskExecutionRolePolicy to ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
#######################################################################################

# Custom IAM Policy for ECS Tasks to access Secrets Manager
resource "aws_iam_policy" "secrets_access" {
  name = "ecs-secrets-access"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = aws_secretsmanager_secret.app.arn
      }
    ]
  })
}
#######################################################################

# Attaching the custom secrets access policy to the ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_secrets" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.secrets_access.arn
}
############################################################################

# Custom IAM Policy for Terraform to access DynamoDB for state locking
resource "aws_iam_policy" "terraform_dynamodb_lock" {
  name = "terraform-dynamodb-lock-access"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ]

        Resource = "arn:aws:dynamodb:eu-west-2:044260499053:table/threat-modelling-tool-locks"
      }
    ]
  })
}
############################################################################
# Attaching the Terraform DynamoDB lock policy to the IAM user "Gus"
resource "aws_iam_user_policy_attachment" "attach_lock_policy" {
  user       = "Gus"
  policy_arn = aws_iam_policy.terraform_dynamodb_lock.arn
}