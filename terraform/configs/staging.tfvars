vpc_ = {
  vpc_cidr = "10.0.0.0/16"
  public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
}

lb_IngressTraffic= {
  "80" = ["0.0.0.0/0"]
}
ecs_IngressTraffic={
  "5000" = ["0.0.0.0/0"]
}
#Load balancer
tg_settings = [
    {
    HC_interval            = 10
    path                   = ""
    HC_healthy_threshold   = 5
    HC_unhealthy_threshold = 5
    HC_timeout             = null
    protocol               = "TCP"
    deregistration_delay   = 60
    port                   = 3306
    lb_name                = "NLB"
  },
  {
    HC_interval            = 10
    path                   = "/"
    HC_healthy_threshold   = 5
    HC_unhealthy_threshold = 5
    HC_timeout             = 5
    protocol               = "HTTP"
    deregistration_delay   = 60
    port                   = 80
    lb_name                = "ALB"
  }
]
deregistration_delay="60"
#ECR
ecr_name="akbar-flaskapp"
#ROLE
task_role_name="akbar"
#ECS
cluster_name="flask-app-cluster"
# task_definition_name="akbar-ecs-farget-terraform"
# fargate_cpu=512
# fargate_memory=1024
# container_name="flask-backend"
# image_url="489994096722.dkr.ecr.us-west-2.amazonaws.com/akbar-flaskapp"
# container_port=5000
# host_port=5000

container_definitions = {
  task_definition_name = "akbar-ecs-farget-terraform"
  fargate_cpu = 512
  fargate_memory = 1024
  container_name = "flask-backend"
  container_port = 5000
  host_port = 5000
}
service_vars = {
    service_name = "akbar-service"
    desired_count = 0
  }

test="d"