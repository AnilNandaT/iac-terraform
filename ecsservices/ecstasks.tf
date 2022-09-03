#ECS task definition specification
resource "aws_ecs_task_definition" "drug-interaction" {
  family                = "drug-interaction-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 1100
  memory                   = 4096
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/drug-interaction.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-drug-interaction-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}


resource "aws_ecs_task_definition" "text2xdl" {
  family                = "text2xdl-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 1100
  memory                   = 3072
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/text2xdl.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-text2xdl-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}

resource "aws_ecs_task_definition" "drug-protein" {
  family                = "drug-protein-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 1024
  memory                   = 6144
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/drug-protein.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-drug-protein-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}

resource "aws_ecs_task_definition" "solubility" {
  family                = "solubility-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 1700
  memory                   = 6144
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/solubility.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-solubility-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}

resource "aws_ecs_task_definition" "toxicity" {
  family                = "toxicity-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 1700
  memory                   = 6144
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/toxicity.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-toxicity-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}

resource "aws_ecs_task_definition" "drug-search" {
  family                = "drug-search-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 2048
  memory                   = 12288
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/drug-search.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-drug-search-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}

resource "aws_ecs_task_definition" "pdf-xdl" {
  family                = "pdf-xdl-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  memory                   = 20480
  execution_role_arn = "arn:aws:iam::665246913124:role/ecsTaskExecutionRole"
  container_definitions = file("aws-task-definitions/${var.environment}/pdf-xdl.json")
  task_role_arn = data.terraform_remote_state.main.outputs.prepaire-pdf-xdl-task-role-arn
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
}