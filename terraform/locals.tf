locals {
  account_id            = data.aws_caller_identity.this.account_id
  region                = data.aws_region.current.name
  required_tags = {
    Application-id   = "Terraform Starter",
    Business-Service = "ToDo"
    Environment      = var.environment,
    Owner            = "ToDo"
    Terraform        = "true"
  }
  tags = merge(var.resource_tags, local.required_tags)
  // User data for EC2 instances as required
  user_data = <<EOF
#!/bin/bash
echo "Hello From Terraform!"
EOF
}
