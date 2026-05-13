# ECS CloudWatch Log Group
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/threat-app"
  retention_in_days = 7
}
###############################################################

# ECS CloudWatch Alarm for CPU Utilization
resource "aws_cloudwatch_metric_alarm" "ecs_high_cpu" {
  alarm_name          = "threat-modelling-tool-ecs-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.app.name
  }

  alarm_description = "ECS service CPU utilization is too high"
  treat_missing_data = "notBreaching"
}
######################################################################

# ECS CloudWatch Alarm for Memory Utilization
resource "aws_cloudwatch_metric_alarm" "ecs_high_memory" {
  alarm_name          = "threat-modelling-tool-ecs-high-memory-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.app.name
  }

  alarm_description = "ECS service memory utilization is too high"

  treat_missing_data = "notBreaching"
}