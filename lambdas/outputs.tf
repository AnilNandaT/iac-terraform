output "drug-interaction-lambda-invoke_arn" {
  value = aws_lambda_function.drug-interaction-lambda.invoke_arn
}

output "drug-interaction-lambda-function_name" {
    value = aws_lambda_function.drug-interaction-lambda.function_name 
}

output "drug-protein-lambda-invoke_arn" {
  value = aws_lambda_function.drug-protein-lambda.invoke_arn
}

output "drug-protein-lambda-function_name" {
    value = aws_lambda_function.drug-protein-lambda.function_name 
}

output "text2xdl-lambda-invoke_arn" {
  value = aws_lambda_function.text2xdl-lambda.invoke_arn
}

output "text2xdl-lambda-function_name" {
    value = aws_lambda_function.text2xdl-lambda.function_name 
}

output "toxicity-lambda-invoke_arn" {
  value = aws_lambda_function.toxicity-lambda.invoke_arn
}

output "toxicity-lambda-function_name" {
    value = aws_lambda_function.toxicity-lambda.function_name 
}

output "solubility-lambda-invoke_arn" {
  value = aws_lambda_function.solubility-lambda.invoke_arn
}

output "solubility-lambda-function_name" {
    value = aws_lambda_function.solubility-lambda.function_name 
}

output "drug-search-lambda-invoke_arn" {
  value = aws_lambda_function.drug-search-lambda.invoke_arn
}

output "drug-search-lambda-function_name" {
    value = aws_lambda_function.drug-search-lambda.function_name 
}

output "pdf-xdl-lambda-invoke_arn" {
  value = aws_lambda_function.pdf-xdl-lambda.invoke_arn
}

output "pdf-xdl-lambda-function_name" {
    value = aws_lambda_function.pdf-xdl-lambda.function_name 
}

output "drugshot-search-lambda-invoke_arn" {
  value = aws_lambda_function.drugshot-search-lambda.invoke_arn
}

output "drugshot-search-lambda-function_name" {
    value = aws_lambda_function.drugshot-search-lambda.function_name 
}

output "drugshot-associate-lambda-invoke_arn" {
  value = aws_lambda_function.drugshot-associate-lambda.invoke_arn
}

output "drugshot-associate-lambda-function_name" {
    value = aws_lambda_function.drugshot-associate-lambda.function_name
}


#Backend lambda outputs

output "drugbank-lambda-invoke_arn" {
  value = aws_lambda_function.drugbank-lambda.invoke_arn
}

output "drugbank-lambda-function_name" {
    value = aws_lambda_function.drugbank-lambda.function_name 
}

output "drugbankQuery-lambda-invoke_arn" {
  value = aws_lambda_function.drugbankQuery-lambda.invoke_arn
}

output "drugbankQuery-lambda-function_name" {
    value = aws_lambda_function.drugbankQuery-lambda.function_name 
}

output "targetsQuery-lambda-invoke_arn" {
  value = aws_lambda_function.targetsQuery-lambda.invoke_arn
}

output "targetsQuery-lambda-function_name" {
    value = aws_lambda_function.targetsQuery-lambda.function_name 
}


output "categoriesQuery-lambda-invoke_arn" {
  value = aws_lambda_function.categoriesQuery-lambda.invoke_arn
}

output "categoriesQuery-lambda-function_name" {
    value = aws_lambda_function.categoriesQuery-lambda.function_name 
}

output "drugsByCategory-lambda-invoke_arn" {
  value = aws_lambda_function.drugsByCategory-lambda.invoke_arn
}

output "drugsByCategory-lambda-function_name" {
    value = aws_lambda_function.drugsByCategory-lambda.function_name 
}

output "getAfPdbUrl-lambda-invoke_arn" {
  value = aws_lambda_function.getAfPdbUrl-lambda.invoke_arn
}

output "getAfPdbUrl-lambda-function_name" {
    value = aws_lambda_function.getAfPdbUrl-lambda.function_name 
}

output "calculateMaintenanceDosage-lambda-invoke_arn" {
  value = aws_lambda_function.calculateMaintenanceDosage-lambda.invoke_arn
}

output "calculateMaintenanceDosage-lambda-function_name" {
    value = aws_lambda_function.calculateMaintenanceDosage-lambda.function_name 
}

output "backend-pdf-xdl-lambda-invoke_arn" {
  value = aws_lambda_function.backend-pdf-xdl-lambda.invoke_arn
}

output "backend-pdf-xdl-lambda-function_name" {
    value = aws_lambda_function.backend-pdf-xdl-lambda.function_name 
}

output "backend-molecule-search-lambda-invoke_arn" {
  value = aws_lambda_function.backend-molecule-search-lambda.invoke_arn
}

output "backend-molecule-search-lambda-function_name" {
    value = aws_lambda_function.backend-molecule-search-lambda.function_name 
}

output "backend-lotus-lambda-invoke_arn" {
  value = aws_lambda_function.backend-lotus-lambda.invoke_arn
}

output "backend-lotus-lambda-function_name" {
    value = aws_lambda_function.backend-lotus-lambda.function_name 
}

output "backend-natural-products-lambda-invoke_arn" {
  value = aws_lambda_function.backend-natural-products-lambda.invoke_arn
}

output "backend-natural-products-lambda-function_name" {
    value = aws_lambda_function.backend-natural-products-lambda.function_name 
}

output "backend-xdl-add-lambda-invoke_arn" {
  value = aws_lambda_function.backend-xdl-add-lambda.invoke_arn
}

output "backend-xdl-add-lambda-function_name" {
    value = aws_lambda_function.backend-xdl-add-lambda.function_name 
}

output "backend-xdl-change-status-lambda-invoke_arn" {
  value = aws_lambda_function.backend-xdl-change-status-lambda.invoke_arn
}

output "backend-xdl-change-status-lambda-function_name" {
    value = aws_lambda_function.backend-xdl-change-status-lambda.function_name 
}

output "backend-xdl-get-details-lambda-invoke_arn" {
  value = aws_lambda_function.backend-xdl-get-details-lambda.invoke_arn
}

output "backend-xdl-get-details-lambda-function_name" {
    value = aws_lambda_function.backend-xdl-get-details-lambda.function_name 
}

output "backend-xdl-get-file-lambda-invoke_arn" {
  value = aws_lambda_function.backend-xdl-get-file-lambda.invoke_arn
}

output "backend-xdl-get-file-lambda-function_name" {
    value = aws_lambda_function.backend-xdl-get-file-lambda.function_name 
}

output "backend-xdl-get-list-lambda-invoke_arn" {
  value = aws_lambda_function.backend-xdl-get-list-lambda.invoke_arn
}

output "backend-xdl-get-list-lambda-function_name" {
    value = aws_lambda_function.backend-xdl-get-list-lambda.function_name 
}

output "backend-xdl-search-lambda-invoke_arn" {
  value = aws_lambda_function.backend-xdl-search-lambda.invoke_arn
}

output "backend-xdl-search-lambda-function_name" {
    value = aws_lambda_function.backend-xdl-search-lambda.function_name 
}

output "backend-plot3d-lambda-invoke_arn" {
  value = aws_lambda_function.backend-3d-plot-lambda.invoke_arn
}

output "backend-plot3d-lambda-function_name" {
    value = aws_lambda_function.backend-3d-plot-lambda.function_name 
}



#Auth

output "backend-auth-forgetpasswordfirststep-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-forgetpasswordfirststep-lambda.invoke_arn
}

output "backend-auth-forgetpasswordfirststep-lambda-function_name" {
    value = aws_lambda_function.backend-auth-forgetpasswordfirststep-lambda.function_name 
}


output "backend-auth-forgetpasswordsecondstep-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-forgetpasswordsecondstep-lambda.invoke_arn
}

output "backend-auth-forgetpasswordsecondstep-lambda-function_name" {
    value = aws_lambda_function.backend-auth-forgetpasswordsecondstep-lambda.function_name 
}

output "backend-auth-login-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-login-lambda.invoke_arn
}

output "backend-auth-login-lambda-function_name" {
    value = aws_lambda_function.backend-auth-login-lambda.function_name 
}

output "backend-auth-refreshtoken-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-refreshtoken-lambda.invoke_arn
}

output "backend-auth-refreshtoken-lambda-function_name" {
    value = aws_lambda_function.backend-auth-refreshtoken-lambda.function_name 
}

output "backend-auth-resendforgetpasswordcode-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-resendforgetpasswordcode-lambda.invoke_arn
}

output "backend-auth-resendforgetpasswordcode-lambda-function_name" {
    value = aws_lambda_function.backend-auth-resendforgetpasswordcode-lambda.function_name 
}

output "backend-auth-resendverificationcode-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-resendverificationcode-lambda.invoke_arn
}

output "backend-auth-resendverificationcode-lambda-function_name" {
    value = aws_lambda_function.backend-auth-resendverificationcode-lambda.function_name 
}

output "backend-auth-verifyaccount-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-verifyaccount-lambda.invoke_arn
}

output "backend-auth-verifyaccount-lambda-function_name" {
    value = aws_lambda_function.backend-auth-verifyaccount-lambda.function_name 
}

output "backend-auth-sendemail-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-sendemail-lambda.invoke_arn
}

output "backend-auth-sendemail-lambda-function_name" {
    value = aws_lambda_function.backend-auth-sendemail-lambda.function_name 
}

output "backend-auth-reset-password-first-time-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-reset-password-first-time-lambda.invoke_arn
}

output "backend-auth-reset-password-first-time-lambda-function_name" {
    value = aws_lambda_function.backend-auth-reset-password-first-time-lambda.function_name 
}

output "backend-auth-register-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-register-lambda.invoke_arn
}

output "backend-auth-register-lambda-function_name" {
    value = aws_lambda_function.backend-auth-register-lambda.function_name 
}

output "backend-auth-loginWith3rdParty-lambda-invoke_arn" {
  value = aws_lambda_function.backend-auth-loginWith3rdParty-lambda.invoke_arn
}

output "backend-auth-loginWith3rdParty-lambda-function_name" {
    value = aws_lambda_function.backend-auth-loginWith3rdParty-lambda.function_name 
}

#profile
output "backend-profile-get-lambda-invoke_arn" {
  value = aws_lambda_function.backend-profile-get-lambda.invoke_arn
}

output "backend-profile-get-lambda-function_name" {
    value = aws_lambda_function.backend-profile-get-lambda.function_name 
}

output "backend-profile-update-lambda-invoke_arn" {
  value = aws_lambda_function.backend-profile-update-lambda.invoke_arn
}

output "backend-profile-update-lambda-function_name" {
    value = aws_lambda_function.backend-profile-update-lambda.function_name 
}

output "backend-profile-changepassword-lambda-invoke_arn" {
  value = aws_lambda_function.backend-profile-changepassword-lambda.invoke_arn
}

output "backend-profile-changepassword-lambda-function_name" {
    value = aws_lambda_function.backend-profile-changepassword-lambda.function_name 
}

#usermanagement

output "backend-usersmanagement-add-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-add-lambda.invoke_arn
}

output "backend-usersmanagement-add-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-add-lambda.function_name 
}

output "backend-usersmanagement-delete-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-delete-lambda.invoke_arn
}

output "backend-usersmanagement-delete-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-delete-lambda.function_name 
}

output "backend-usersmanagement-update-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-update-lambda.invoke_arn
}

output "backend-usersmanagement-update-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-update-lambda.function_name 
}

output "backend-usersmanagement-details-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-details-lambda.invoke_arn
}

output "backend-usersmanagement-details-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-details-lambda.function_name 
}

output "backend-usersmanagement-list-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-list-lambda.invoke_arn
}

output "backend-usersmanagement-list-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-list-lambda.function_name 
}

output "backend-usersmanagement-deactivate-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-deactivate-lambda.invoke_arn
}

output "backend-usersmanagement-deactivate-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-deactivate-lambda.function_name 
}

output "backend-usersmanagement-approve-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-approve-lambda.invoke_arn
}

output "backend-usersmanagement-approve-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-approve-lambda.function_name 
}

output "backend-usersmanagement-changeApiKey-lambda-invoke_arn" {
  value = aws_lambda_function.backend-usersmanagement-changeApiKey-lambda.invoke_arn
}

output "backend-usersmanagement-changeApiKey-lambda-function_name" {
    value = aws_lambda_function.backend-usersmanagement-changeApiKey-lambda.function_name 
}

output "api-authoriser-lambda-invoke_arn" {
  value = aws_lambda_function.api-authoriser-lambda.invoke_arn
}

output "api-authoriser-lambda-arn" {
  value = aws_lambda_function.api-authoriser-lambda.arn
}

output "api-authoriser-lambda-function_name" {
    value = aws_lambda_function.api-authoriser-lambda.function_name 
}