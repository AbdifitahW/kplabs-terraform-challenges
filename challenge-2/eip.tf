resource "aws_eip" "example" {
  tags = var.terraform_tag
  domain = "vpc"
}