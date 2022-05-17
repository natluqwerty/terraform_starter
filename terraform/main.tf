################ Providers ################
provider "aws" {
  profile = var.profile
  region  = local.region

  #  assume_role {
  #    role_arn     = "arn:aws:iam::${var.account_id}:role/cicd-role"
  #    session_name = "ci-cd"
  #    external_id  = "asdf-asdf-asdf"
  #  }
}

module "auto_scaling" {
  source           = "./modules/auto-scaling"
  environment      = var.environment
  application_name = var.application_name
  ecs_cluster      = module.ecs.ecs_cluster
  ecs_service      = module.ecs.ecs_service
  tags             = local.tags
}

module "ec2" {
  source           = "./modules/ec2"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "ecr" {
  source           = "./modules/ecr"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "ecs" {
  source                    = "./modules/ecs"
  environment               = var.environment
  application_name          = var.application_name
  aws_key                   = module.ec2.aws_key
  log_group                 = module.logs.log_group
  asg_max_size              = 1
  asg_min_size              = 1
  maximum_scaling_step_size = 1
  minimum_scaling_step_size = 1
  target_capacity           = 1
  tags                      = local.tags
  ecs_role                  = module.iam.ecs_role
  ecs_sg                    = module.vpc.ecs_sg
  ecs_subnet_a              = module.vpc.ecs_subnet_a
  ecs_subnet_b              = module.vpc.ecs_subnet_b
  ecs_subnet_c              = module.vpc.ecs_subnet_c
  ecs_target_group          = module.elb.ecs_target_group
}

module "elb" {
  source                 = "./modules/elb"
  environment            = var.environment
  application_name       = var.application_name
  hosted_zone_id         = var.hosted_zone_id
  load_balancer_sg       = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.load_balancer_subnet_a
  load_balancer_subnet_b = module.vpc.load_balancer_subnet_b
  load_balancer_subnet_c = module.vpc.load_balancer_subnet_c
  vpc                    = module.vpc.vpc
  tags                   = local.tags
}
module "iam" {
  source           = "./modules/iam"
  environment      = var.environment
  application_name = var.application_name
  elb              = module.elb.elb
  tags             = local.tags
}

module "logs" {
  source           = "./modules/logs"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "route53" {
  source           = "./modules/route53"
  environment      = var.environment
  application_name = var.application_name
  elb              = module.elb.elb
  hosted_zone_id   = var.hosted_zone_id
  tags             = local.tags
}

module "s3" {
  source           = "./modules/s3"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "vpc" {
  source           = "./modules/vpc"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}
