# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}
############################################################################

# ECS Task Definition and Service
resource "aws_ecs_task_definition" "app" {
  family                   = "threat-modelling-tool-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "threat-modelling-tool"
      image = var.container_image

      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]

       secrets = [
  {
    name      = "API_KEY"
    valueFrom = "${aws_secretsmanager_secret.app.arn}:API_KEY::"
  }
]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
#################################################################################
# ECS Service
resource "aws_ecs_service" "app" {
  name            = "threat-modelling-tool-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 2
  launch_type   = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private[*].id
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "threat-modelling-tool"
    container_port   = 3000
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_role_policy
  ]
}