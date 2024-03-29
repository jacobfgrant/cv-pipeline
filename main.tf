##### CV Pipeline – Main ######

### Configure local values ###

locals {
  # Name/value map for resource tags
  tags_map = {
    Name        = "CV Pipeline"
    Workspace   = terraform.workspace
    Environment = var.pipeline_environment
  }
}


### Configure the AWS Providers ###

# Primary AWS Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}


# AWS East (Northern Virginia) Provider
provider "aws" {
  alias = "east"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
}


# Terraform Required Providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 0.13"
}
