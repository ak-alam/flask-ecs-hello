variable "name" {
  type = string
  default = "ak"
}
#VPC Variables
variable "vpc_" {
  type = object({
  vpc_cidr = string
  public_subnet = list(string)
  private_subnet = list(string)
  })  
}

variable "lb_IngressTraffic" {
  type = map
  default = {
   "80" = ["0.0.0.0/0"]
  }
}
variable "ecs_IngressTraffic"{
  type = map
}
#Load balancer
variable "deregistration_delay" {}
variable "tg_settings" {}
variable "target_instance" {
  type = string
  default = ""
}

#ECR 
variable "ecr_name" {
}

#IAM Role
variable "task_role_name" {
}

#ECS
variable "cluster_name" {
  type = string
}
variable "container_definitions" {
  type = object({
  task_definition_name = string
  fargate_cpu = number 
  fargate_memory = number
  container_name = string
  container_port = number
  host_port = number
  })
}

variable "service_vars"{
  type = object({
    service_name = string
    desired_count = number
        
  })
}
# variable "ecs_sg" {
# }
# variable "target_group" {
# }
# variable "" {
# }