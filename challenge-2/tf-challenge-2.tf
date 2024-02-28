terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "splunk" {
  default = "8088"
}
resource "aws_security_group" "payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]

  # Below ingress allows HTTPS  from DEV VPC
  ingress {
    description = "Below ingress allows HTTPS from DEV VPC"
    from_port   = var.https
    to_port     = var.https
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Below ingress allows APIs access from DEV VPC

  ingress {
    description = "Below ingress allows APIs access from DEV VPC"
    from_port   = var.app_port
    to_port     = var.app_port 
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Below ingress allows APIs access from Prod App Public IP.

  ingress {
    description = "Below ingress allows APIs access from Prod App Public IP."
    from_port   = var.prod_api
    to_port     = var.prod_api
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }
  egress {
  description = "Allow access to public internet"
  from_port   = var.splunk
  to_port     = var.splunk
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.terraform_tag
}



resource "aws_eip" "example" {
  tags = var.terraform_tag
  domain = "vpc"
}