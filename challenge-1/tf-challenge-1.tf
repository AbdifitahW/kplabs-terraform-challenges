provider "aws" {
  region = "us-east-1" 
}
terraform {
  required_providers {
    aws = {
      source = "aws"
      version = "~> 2.54"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "digitalocean" {
}



resource "aws_eip" "kplabs_app_ip" {
  vpc = true
}
