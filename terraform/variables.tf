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