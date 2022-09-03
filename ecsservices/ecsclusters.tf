#Datasource
data "terraform_remote_state" "main" {
  backend = "remote"

  config = {
    organization = "prepaire"
    workspaces = {
      name = "${var.environment}"
    }
  }
}

#ECS Cluster
resource "aws_ecs_cluster" "prepaire-ecs" {
  name = "prepaire-${var.environment}-ecs"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


resource "aws_ecs_capacity_provider" "prepaire-ecs-capacity-provider" {
  name = "prepaire-${var.environment}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.prepaire-ecs-asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
          }
  }
}

resource "aws_ecs_cluster_capacity_providers" "prepaire-ecs-capacity-providers" {
  cluster_name = aws_ecs_cluster.prepaire-ecs.name

  capacity_providers = [aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-ecs-capacity-provider.name
  }
}


#Capacity provider for pdf xdl
resource "aws_ecs_capacity_provider" "prepaire-pdf-xdl-ecs-capacity-provider" {
  name = "prepaire-${var.environment}-pdf-xdl-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.prepaire-pdf-xdl-ecs-asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
          }
  }
}

resource "aws_ecs_cluster_capacity_providers" "prepaire-pdf-xdl-ecs-capacity-providers" {
  cluster_name = aws_ecs_cluster.prepaire-ecs.name

  capacity_providers = [aws_ecs_capacity_provider.prepaire-pdf-xdl-ecs-capacity-provider.name]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = aws_ecs_capacity_provider.prepaire-pdf-xdl-ecs-capacity-provider.name
  }
}



resource "aws_launch_configuration" "prepaire-ecs-launch-config" {
	# checkov:skip=CKV_AWS_79: Instance metadata version1 enabled
  image_id             = "ami-061c10a2cb32f3491"
  name = "prepaire-${var.environment}-ecs-launch-config"
  iam_instance_profile = data.terraform_remote_state.main.outputs.prepaire-ecs-instance-profile-name
  security_groups      = [data.terraform_remote_state.main.outputs.prepaire-ecs-sg-id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=prepaire-${var.environment}-ecs >> /etc/ecs/ecs.config"
  instance_type        = "m5.xlarge"
  key_name = "prepaire-26May2022"
  root_block_device {
    volume_size = 50
    encrypted = true
  }
}

resource "aws_autoscaling_group" "prepaire-ecs-asg" {
  name                 = "prepaire-${var.environment}-ecs-asg"
  vpc_zone_identifier  = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id, data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
  launch_configuration = aws_launch_configuration.prepaire-ecs-launch-config.name
  desired_capacity          = 1
  min_size                  = 0
  max_size                  = 6
  health_check_grace_period = 300
  protect_from_scale_in     = true
  health_check_type         = "EC2"
  tag {
    key                 = "Name"
    value               = "prepaire-${var.environment}-ecs"
    propagate_at_launch = true
  }
  lifecycle {
    ignore_changes = [
      desired_capacity
    ]
  }
}

resource "aws_launch_configuration" "prepaire-pdf-xdl-ecs-launch-config" {
	# checkov:skip=CKV_AWS_79: user metadat version1
  image_id             = "ami-061c10a2cb32f3491"
  name = "prepaire-${var.environment}-pdf-xdl-ecs-launch-config"
  iam_instance_profile = data.terraform_remote_state.main.outputs.prepaire-ecs-instance-profile-name
  security_groups      = [data.terraform_remote_state.main.outputs.prepaire-ecs-sg-id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=prepaire-${var.environment}-ecs >> /etc/ecs/ecs.config"
  instance_type        = "c5.4xlarge"
  key_name = "prepaire-26May2022"
  root_block_device {
    volume_size = 50
    encrypted = true
  }
}

resource "aws_autoscaling_group" "prepaire-pdf-xdl-ecs-asg" {
  name                 = "prepaire-${var.environment}-pdf-xdl-ecs-asg"
  vpc_zone_identifier  = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id, data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
  launch_configuration = aws_launch_configuration.prepaire-pdf-xdl-ecs-launch-config.name
  desired_capacity          = 1
  min_size                  = 0
  max_size                  = 3
  health_check_grace_period = 300
  protect_from_scale_in     = true
  health_check_type         = "EC2"
  tag {
    key                 = "Name"
    value               = "prepaire-${var.environment}-pdf-xdl-ecs"
    propagate_at_launch = true
  }
  lifecycle {
    ignore_changes = [
      desired_capacity
    ]
  }
}

#Log group for ECS containers
resource "aws_cloudwatch_log_group" "drug-interaction-log-group" {
  name = "/ecs/drug-interaction-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}

resource "aws_cloudwatch_log_group" "text2xdl-log-group" {
  name = "/ecs/text2xdl-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}

resource "aws_cloudwatch_log_group" "toxicity-log-group" {
  name = "/ecs/toxicity-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}

resource "aws_cloudwatch_log_group" "drug-protein-log-group" {
  name = "/ecs/drug-protein-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}

resource "aws_cloudwatch_log_group" "solubility-log-group" {
  name = "/ecs/solubility-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}

resource "aws_cloudwatch_log_group" "drug-search-log-group" {
  name = "/ecs/drug-search-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}

resource "aws_cloudwatch_log_group" "pdf-xdl-log-group" {
  name = "/ecs/pdf-xdl-${var.environment}"
  retention_in_days = 90
  kms_key_id = "arn:aws:kms:us-east-1:665246913124:key/b4e48e06-f53a-46cb-8dc5-298bfe01f932"
}
