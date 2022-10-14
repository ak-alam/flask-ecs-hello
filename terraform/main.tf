#VPC modules
module "vpc" {
  source = "./modules/vpc"
  vpc = {
    vpc_cidr = var.vpc_["vpc_cidr"]
    public_subnet = var.vpc_["public_subnet"]
    private_subnet = var.vpc_["private_subnet"]
  }
  prefix = "akbar"
}

module "lb-Sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpcId
  ingress_traffic = var.lb_IngressTraffic
  protocol = "tcp"
  prefix = "lb"
}

module "ecs_sg"{
  source = "./modules/sg"
  vpc_id = module.vpc.vpcId
  ingress_traffic = var.ecs_IngressTraffic
  protocol = "tcp"
  prefix = "ecs"
}

module "applicationLB" {
  source = "./modules/lb"
  internal = false 
  type = "application"
  security_groups = ["${module.lb-Sg.security_group}"]
  subne_Ids = module.vpc.public_subnet
  vpc_Id = module.vpc.vpcId
  deregistration_delay = var.deregistration_delay
  tg_vars = local.alb.1
  prefix = "alb"

}

module "ecr" {
  source = "./modules/ecr"
  ecr_name = var.ecr_name
}
module "ecs_task_execution_role" {
  source = "./modules/roles"
  task_role_name = var.task_role_name
}

module "ecs" {
  source = "./modules/ecs"
  cluster_name = var.cluster_name
  
  image_url = module.ecr.ecr_uri
  task_execution_role = module.ecs_task_execution_role.ecs_tasks_role
  # fargate_cpu = var.fargate_cpu
  # fargate_memory = var.fargate_memory
  # container_name = var.container_name
  # task_definition_name = var.task_definition_name
  # container_port = var.container_port
  # host_port = var.host_port
  container_definitions = {
  fargate_cpu = var.container_definitions["fargate_cpu"]
  fargate_memory = var.container_definitions["fargate_memory"]
  container_name = var.container_definitions["container_name"]
  task_definition_name = var.container_definitions["task_definition_name"]
  container_port = var.container_definitions["container_port"]
  host_port = var.container_definitions["host_port"]
  }
  service_vars = {
    service_name = var.service_vars["service_name"]
    desired_count = var.service_vars["desired_count"]
  }
  ecs_sg = module.ecs_sg.security_group
  target_group = module.applicationLB.target_arns
  subnets_id = module.vpc.public_subnet
}