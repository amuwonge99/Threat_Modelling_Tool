variable "region" {
  type        = string
}

variable "vpc_cidr" {
  type        = string

validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "azs" {
  type        = list(string)
}

variable "container_image" {
  type        = string
  description = "Docker image URI for ECS task"
}

variable "domain_name" {
  type        = string
  description = "Primary domain name for the application"
}
