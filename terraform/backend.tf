terraform {
  backend "s3" {
    bucket         = "threat-modelling-tool-gm"
    key            = "ecs-project/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "threat-modelling-tool-locks"
  }
}