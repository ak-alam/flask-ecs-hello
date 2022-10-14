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

variable "ecs_sg" {
}
variable "target_group" {
}
variable "subnets_id" {
}
variable "task_execution_role" {
  
}
variable "image_url" {
}
