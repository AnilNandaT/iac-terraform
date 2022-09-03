# resource "aws_route53_zone" "prepaire-backend-domain" {
#   name = "backend.prepaire.com"
# }


# resource "aws_route53_record" "drug-interaction-domain" {
#   zone_id = aws_route53_zone.prepaire-backend-domain.zone_id
#   name    = "drug-interaction-dev"
#   type    = "A"

#   alias {
#     name                   = aws_lb.prepaire-ecs-elb.dns_name
#     zone_id                = aws_lb.prepaire-ecs-elb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "text2xdl-domain" {
#   zone_id = aws_route53_zone.prepaire-backend-domain.zone_id
#   name    = "text2xdl-dev"
#   type    = "A"

#   alias {
#     name                   = aws_lb.prepaire-ecs-elb.dns_name
#     zone_id                = aws_lb.prepaire-ecs-elb.zone_id
#     evaluate_target_health = true
#   }
# }

resource "aws_sqs_queue" "useremail" {
  name                      = "prepaire-${var.environment}-user-email"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled = true
}