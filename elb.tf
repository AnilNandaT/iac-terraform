#ELB for traffic

resource "aws_lb" "prepaire-ecs-elb" {
	# checkov:skip=CKV2_AWS_20: ADD REASON
  name               = "prepaire-${var.environment}-ecs-elb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.prepaire-ecs-elb-sg.id]
  subnets            = [aws_subnet.prepaire-pub-1a.id, aws_subnet.prepaire-pub-1b.id]
  drop_invalid_header_fields = true
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.prepaire-elb-logs-bucket.bucket
    prefix  = "prepaire-${var.environment}-ecs-elb"
    enabled = true
  }

  tags = {
    Name      = "prepaire-${var.environment}-ecs-elb"
    Terraform = "true"
  }
}


resource "aws_lb_target_group" "prepaire-drug-interaction-ecs-tg" {
  name     = "prepaire-${var.environment}-drug-inter-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
  }
}

resource "aws_lb_target_group" "prepaire-drug-protein-ecs-tg" {
  name     = "prepaire-${var.environment}-drug-protein-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
  }
}

resource "aws_lb_target_group" "prepaire-solubility-ecs-tg" {
  name     = "prepaire-${var.environment}-solubility-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
  }
}

resource "aws_lb_target_group" "prepaire-text2xdl-ecs-tg" {
  name     = "prepaire-${var.environment}-text2xdl-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
  }
}

resource "aws_lb_target_group" "prepaire-toxicity-ecs-tg" {
  name     = "prepaire-${var.environment}-toxicity-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
  }
}

resource "aws_lb_target_group" "prepaire-drug-search-ecs-tg" {
  name     = "prepaire-${var.environment}-drug-search-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
  }
}

resource "aws_lb_target_group" "prepaire-pdf-xdl-ecs-tg" {
  name     = "prepaire-${var.environment}-pdf-xdl-ecs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prepaire-vpc.id
  health_check {
    path = "/v2"
    interval = 120
  }
}


resource "aws_lb_listener" "prepaire-drug-interaction-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "80"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-drug-interaction-ecs-tg.arn
  }
}

resource "aws_lb_listener" "prepaire-text2xdl-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "8080"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-text2xdl-ecs-tg.arn
  }
}

resource "aws_lb_listener" "prepaire-drug-protein-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "8090"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-drug-protein-ecs-tg.arn
  }
}

resource "aws_lb_listener" "prepaire-solubility-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "9090"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-solubility-ecs-tg.arn
  }
}

resource "aws_lb_listener" "prepaire-toxicity-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "9200"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-toxicity-ecs-tg.arn
  }
}

resource "aws_lb_listener" "prepaire-drug-search-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "9500"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-drug-search-ecs-tg.arn
  }
}


resource "aws_lb_listener" "prepaire-pdf-xdl-ecs-elb-listener" {
  load_balancer_arn = aws_lb.prepaire-ecs-elb.arn
  port              = "9100"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = "arn:aws:acm:us-east-1:665246913124:certificate/465dbc04-bea7-4fc5-8660-21a51ec2cc33"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prepaire-pdf-xdl-ecs-tg.arn
  }
}