################ Variables ################
variable "application_name" {
  description = "Name of the application."
  type        = string
  default     = "example"
}

variable "environment" {
  description = "Name of the environment."
  type        = string
  default     = "dev"

  validation {
    condition     = length(var.environment) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.environment)) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}

variable "load_balancer_sg" {}
variable "vpc_id" {}
variable "private_subnets" {}
variable "certificate" {}
variable "authorization_endpoint" {}
variable "client_id" {}
variable "client_secret" {}
variable "issuer" {}
variable "token_endpoint" {}
variable "user_info_endpoint" {}