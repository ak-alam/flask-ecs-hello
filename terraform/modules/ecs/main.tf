resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  # family = var.task_definition_name
  family = var.container_definitions["task_definition_name"]
  execution_role_arn = var.task_execution_role   #aws_iam_role.ecs_task_execution_role.arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  # operating_system_family = "LINUX"
  # cpu = var.fargate_cpu
  # memory = var.fargate_memory
  cpu = var.container_definitions["fargate_cpu"]
  memory = var.container_definitions["fargate_memory"]
  container_definitions = jsonencode([
    {
      # name  = var.container_name
      name  = var.container_definitions["container_name"]
      image = var.image_url
      portMappings = [
        {
          # containerPort = var.container_port
          # hostPort      = var.host_port
          containerPort = var.container_definitions["container_port"]
          hostPort      = var.container_definitions["host_port"]
          protocol      = "tcp"
        }
      ]
      essential = true
    }
    ]
  )
  runtime_platform {
    operating_system_family = "LINUX"
    # cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "main" {
  name            = var.service_vars["service_name"]
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.service_vars["desired_count"]
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.ecs_sg]
    subnets          =  var.subnets_id   #aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group
    container_name   = var.container_definitions["container_name"]
    container_port   = var.container_definitions["container_port"]
  }

  # depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}