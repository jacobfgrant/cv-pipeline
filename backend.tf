##### CV Pipeline – Backend ######

### Configure Backend ###

# Terraform S3 Backend
terraform {
  backend "s3" {
    bucket = "jacobfgrant-tfstate"
    key    = "cv-pipeline/terraform.tfstate"
    region = "us-west-1"
  }
}
