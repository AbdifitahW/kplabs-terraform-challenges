app_port = 8080
https = 443
prod_api = 8443
vpc_cidr = "172.31.0.0/16"
terraform_tag = {
  "Managed_by" = "Terraform"
  "Name" = "payments_app"
  "Env" = "Prod"
}