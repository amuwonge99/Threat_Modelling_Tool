resource "aws_secretsmanager_secret" "app" {
  name = "threat-modelling-tool-secrets"
}
##################################################

# Storing API key in Secrets Manager
resource "aws_secretsmanager_secret_version" "api_key" {
  secret_id     = aws_secretsmanager_secret.app.id
  secret_string = var.api_key
}