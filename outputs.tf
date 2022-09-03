output "prepaire-drug-interaction-task-role-arn" {
    value = aws_iam_role.prepaire-drug-interaction-task-role.arn
}

output "prepaire-text2xdl-task-role-arn" {
    value = aws_iam_role.prepaire-text2xdl-task-role.arn
}

output "prepaire-drug-protein-task-role-arn" {
    value = aws_iam_role.prepaire-drug-protein-task-role.arn
}

output "prepaire-solubility-task-role-arn" {
    value = aws_iam_role.prepaire-solubility-task-role.arn
}

output "prepaire-toxicity-task-role-arn" {
    value = aws_iam_role.prepaire-toxicity-task-role.arn
}

output "prepaire-pdf-xdl-task-role-arn" {
  value = aws_iam_role.prepaire-pdf-xdl-task-role.arn
}

output "prepaire-drug-search-task-role-arn" {
    value = aws_iam_role.prepaire-drug-search-task-role.arn
}

output "prepaire-ecs-instance-profile-name" {
    value = aws_iam_instance_profile.prepaire-ecs-instance-profile.name
}

output "prepaire-ecs-sg-id" {
  value = aws_security_group.prepaire-ecs-sg.id
}

output "prepaire-drug-interaction-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-drug-interaction-ecs-tg.arn
}

output "prepaire-text2xdl-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-text2xdl-ecs-tg.arn
}

output "prepaire-drug-protein-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-drug-protein-ecs-tg.arn
}

output "prepaire-solubility-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-solubility-ecs-tg.arn
}

output "prepaire-toxicity-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-toxicity-ecs-tg.arn
}

output "prepaire-drug-search-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-drug-search-ecs-tg.arn
}

output "prepaire-pdf-xdl-ecs-tg-arn" {
  value = aws_lb_target_group.prepaire-pdf-xdl-ecs-tg.arn
}

output "prepaire-prvt-1a-id" {
    value = aws_subnet.prepaire-prvt-1a.id
}

output "prepaire-prvt-1b-id" {
    value = aws_subnet.prepaire-prvt-1b.id
}

output "drug-interaction-lambda-role-arn" {
    value = aws_iam_role.drug-interaction-lambda-role.arn
}

output "drug-protein-lambda-role-arn" {
    value = aws_iam_role.drug-protein-lambda-role.arn
}

output "text2xdl-lambda-role-arn" {
    value = aws_iam_role.text2xdl-lambda-role.arn
}

output "solubility-lambda-role-arn" {
    value = aws_iam_role.solubility-lambda-role.arn
}

output "toxicity-lambda-role-arn" {
    value = aws_iam_role.toxicity-lambda-role.arn
}

output "drug-search-lambda-role-arn" {
    value = aws_iam_role.drug-search-lambda-role.arn
}

output "backend-lambda-role-arn" {
    value = aws_iam_role.backend-lambda-role.arn
}

output "backend-pdf-xdl-lambda-role-arn" {
    value = aws_iam_role.backend-pdf-xdl-lambda-role.arn
}

output "backend-molecule-search-lambda-role-arn" {
    value = aws_iam_role.backend-molecule-search-lambda-role.arn
}

output "backend-lotus-lambda-role-arn" {
    value = aws_iam_role.backend-lotus-lambda-role.arn
}

output "backend-natural-products-lambda-role-arn" {
    value = aws_iam_role.backend-natural-products-lambda-role.arn
}

output "backend-xdl-add-lambda-role-arn" {
    value = aws_iam_role.backend-xdl-add-lambda-role.arn
}

output "backend-xdl-change-status-lambda-role-arn" {
    value = aws_iam_role.backend-xdl-change-status-lambda-role.arn
}

output "backend-xdl-get-details-lambda-role-arn" {
    value = aws_iam_role.backend-xdl-get-details-lambda-role.arn
}

output "backend-xdl-get-file-lambda-role-arn" {
    value = aws_iam_role.backend-xdl-get-file-lambda-role.arn
}

output "backend-xdl-get-list-lambda-role-arn" {
    value = aws_iam_role.backend-xdl-get-list-lambda-role.arn
}

output "backend-plot3d-lambda-role-arn" {
    value = aws_iam_role.backend-plot3d-lambda-role.arn
}

output "backend-xdl-search-lambda-role-arn" {
    value = aws_iam_role.backend-xdl-search-lambda-role.arn
}

output "backend-auth-forgetpasswordfirststep-lambda-role-arn" {
    value = aws_iam_role.backend-auth-forgetpasswordfirststep-lambda-role.arn
}

output "backend-auth-forgetpasswordsecondstep-lambda-role-arn" {
    value = aws_iam_role.backend-auth-forgetpasswordsecondstep-lambda-role.arn
}

output "backend-auth-login-lambda-role-arn" {
    value = aws_iam_role.backend-auth-login-lambda-role.arn
}

output "backend-auth-refreshtoken-lambda-role-arn" {
    value = aws_iam_role.backend-auth-refreshtoken-lambda-role.arn
}

output "backend-auth-resendforgetpasswordcode-lambda-role-arn" {
    value = aws_iam_role.backend-auth-resendforgetpasswordcode-lambda-role.arn
}

output "backend-auth-resendverificationcode-lambda-role-arn" {
    value = aws_iam_role.backend-auth-resendverificationcode-lambda-role.arn
}

output "backend-auth-verifyaccount-lambda-role-arn" {
    value = aws_iam_role.backend-auth-verifyaccount-lambda-role.arn
}

output "backend-auth-sendemail-lambda-role-arn" {
    value = aws_iam_role.backend-auth-sendemail-lambda-role.arn
}

output "backend-auth-reset-password-first-time-lambda-role-arn" {
    value = aws_iam_role.backend-auth-reset-password-first-time-lambda-role.arn
}

output "backend-auth-register-lambda-role-arn" {
    value = aws_iam_role.backend-auth-register-lambda-role.arn
}

output "backend-auth-loginWith3rdParty-lambda-role-arn" {
    value = aws_iam_role.backend-auth-loginWith3rdParty-lambda-role.arn
}

output "backend-profile-get-lambda-role-arn" {
    value = aws_iam_role.backend-profile-get-lambda-role.arn
}

output "backend-profile-update-lambda-role-arn" {
    value = aws_iam_role.backend-profile-update-lambda-role.arn
}

output "backend-profile-changepassword-lambda-role-arn" {
    value = aws_iam_role.backend-profile-changepassword-lambda-role.arn
}

output "backend-usersmanagement-add-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-add-lambda-role.arn
}

output "backend-usersmanagement-delete-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-delete-lambda-role.arn
}

output "backend-usersmanagement-update-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-update-lambda-role.arn
}

output "backend-usersmanagement-details-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-details-lambda-role.arn
}

output "backend-usersmanagement-list-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-list-lambda-role.arn
}

output "backend-usersmanagement-deactivate-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-deactivate-lambda-role.arn
}

output "backend-usersmanagement-approve-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-approve-lambda-role.arn
}

output "backend-usersmanagement-changeApiKey-lambda-role-arn" {
    value = aws_iam_role.backend-usersmanagement-changeapikey-lambda-role.arn
}

output "pdf-xdl-lambda-role-arn" {
    value = aws_iam_role.pdf-xdl-lambda-role.arn
}

output "backend-get-af-pdb-url-lambda-role-arn" {
  value = aws_iam_role.backend-get-af-pdb-url-lambda-role.arn
}

output "drugshot-search-lambda-role-arn" {
    value = aws_iam_role.drugshot-search-lambda-role.arn
}

output "drugshot-associate-lambda-role-arn" {
    value = aws_iam_role.drugshot-associate-lambda-role.arn
}

output "api-authoriser-lambda-role-arn" {
    value = aws_iam_role.api-authoriser-lambda-role.arn
}

output "prepaire-lambda-artifact-bucket-id" {
  value = aws_s3_bucket.prepaire-lambda-artifact-bucket.id
}

output "prepaire-lambda-sg-id" {
  value = aws_security_group.prepaire-lambda-sg.id
}

output "user-email-sqs-queue-arn" {
    value = aws_sqs_queue.useremail.arn
}