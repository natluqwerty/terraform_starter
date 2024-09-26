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

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}

# variable "profile" {
#   description = "IAM Profile"
#   type        = string
#   sensitive   = true
# }
#
# variable "aws_external_role_id" {
#   description = "AWS IAM External Role ID"
#   type        = string
#   sensitive   = true
# }

variable "region" {
  default     = "ap-southeast-2"
  type        = string
  description = "The region you want to deploy the infrastructure in"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.account_id) == 12 && length(regexall("[^0-9]", var.account_id)) == 0
    error_message = "The account number must be 12 characters, and only contain numbers."
  }
}

# variable "vpc_id" {
#   description = "AWS region"
#   type        = string
#
#   validation {
#     # regex(...) fails if it cannot find a match
#     condition     = can(regex("^vpc-", var.vpc_id))
#     error_message = "The vpc_id value must be a valid VPC id, starting with \"vpc-\"."
#   }
# }

# variable "public_subnets" {
#   description = "AWS public subnets"
# }
#
# variable "private_subnets" {
#   description = "AWS private subnets"
# }

variable "hosted_zone_id" {
  type        = string
  description = "The id of the hosted zone of the Route 53 domain you want to use"
}

variable "host_name" {
  type        = string
  description = "The Route 53 domain host name you want to use"
}

variable "notification_recipients" {
  description = "Email address list of notification recipients."
}

variable "aad_group_name" {}
variable "tenant_id" {}
variable "authorization_endpoint" {}
variable "client_id" {}
variable "client_secret" {}
variable "issuer" {}
variable "token_endpoint" {}
variable "user_info_endpoint" {}

#API Gateway Setup
variable "api_gw_method" {
  description = "API Gateway method (GET,POST...)"
  default     = "POST"
}

variable "api_gw_dependency_list" {
  description = "List of aws_api_gateway_integration* that require aws_api_gateway_deployment dependency"
  type        = list(string)
  default     = []
}

variable "api_gw_disable_resource_creation" {
  description = "Specify whether to create or not the default /api/messages path or stop at /api"
  default     = "false"
}

variable "api_gw_endpoint_configuration_type" {
  description = "Specify the type of endpoint for API GW to be setup as. [EDGE, REGIONAL, PRIVATE]. Defaults to EDGE"
  default     = "EDGE"
}
