#ECS service creation

resource "aws_ecs_service" "prepaire-drug-interaction-service" {
  name            = "drug-interaction"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.drug-interaction.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  health_check_grace_period_seconds = 60
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
    weight = 1
  }


  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-drug-interaction-ecs-tg-arn
    container_name   = "drug-interaction"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}

resource "aws_ecs_service" "prepaire-text2xdl-service" {
  name            = "text2xdl"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.text2xdl.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  health_check_grace_period_seconds = 90
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
    weight = 1
  }


  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-text2xdl-ecs-tg-arn
    container_name   = "text2xdl"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}

resource "aws_ecs_service" "prepaire-drug-protein-service" {
  name            = "drug-protein"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.drug-protein.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  health_check_grace_period_seconds = 60
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
    weight = 1
  }


  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-drug-protein-ecs-tg-arn
    container_name   = "drug-protein"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}

resource "aws_ecs_service" "prepaire-solubility-service" {
  name            = "solubility"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.solubility.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
    weight = 1
  }


  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-solubility-ecs-tg-arn
    container_name   = "solubility"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}

resource "aws_ecs_service" "prepaire-toxicity-service" {
  name            = "toxicity"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.toxicity.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
    weight = 1
  }


  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-toxicity-ecs-tg-arn
    container_name   = "toxicity"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}

resource "aws_ecs_service" "prepaire-drug-search-service" {
  name            = "drug-search"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.drug-search.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  health_check_grace_period_seconds = 420
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
    weight = 1
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-drug-search-ecs-tg-arn
    container_name   = "drug-search"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}

resource "aws_ecs_service" "prepaire-pdf-xdl-service" {
  name            = "pdf-xdl"
  cluster         = aws_ecs_cluster.prepaire-ecs.id
  task_definition = aws_ecs_task_definition.pdf-xdl.arn
  desired_count   = 1
  iam_role        = "arn:aws:iam::665246913124:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  health_check_grace_period_seconds = 90
  capacity_provider_strategy {
    base = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-pdf-xdl-ecs-capacity-provider.name
    weight = 1
  }


  load_balancer {
    target_group_arn = data.terraform_remote_state.main.outputs.prepaire-pdf-xdl-ecs-tg-arn
    container_name   = "pdf-xdl"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [
      desired_count, # Preserve desired count when updating an autoscaled ECS Service
      task_definition
    ]
  }
}
