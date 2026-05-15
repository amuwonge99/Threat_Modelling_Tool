resource "aws_secretsmanager_secret" "app" {
  name = "threat-modelling-tool-secrets"
}

resource "aws_secretsmanager_secret_version" "app" {
  secret_id = aws_secretsmanager_secret.app.id

  secret_string = jsonencode({
    API_KEY = var.api_key
  })
}