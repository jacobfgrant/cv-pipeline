### CV Pipeline – Variables ###

# AWS Variables

variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}


# CloudFront Variables

variable "cloudfront_retain_on_delete" {
  type        = string
  description = "Disable distribution instead of deleting when destroying"
  default     = false
}

variable "cloudfront_wait_for_deployment" {
  type        = string
  description = "Wait for distribution to complete deploying"
  default     = false
}

variable "enable_cloudfront" {
  type        = string
  description = "Whether the CloudFront distribution is enabled"
  default     = true
}


# CV Pipeline Variables

variable "cv_bucket" {
  type        = string
  description = "S3 bucket for the CV"
}

variable "cv_repo" {
  type        = string
  description = "Repository with CV source"
}

variable "pipeline_environment" {
  type        = string
  description = "Environment (production, development, testing, etc.)"
  default     = ""
}

variable "pipeline_output_object" {
  type        = string
  description = "Object (artifact) output by the CodeBuild pipeline"
  default     = "cv.pdf"
}


# Route 53 Variables

variable "route_53_zone_id" {
  type        = string
  description = "ID of the Route 53 DNS zone"
}

variable "domain_name" {
  type        = string
  description = "Domain name used for the CloudFront site"
}


# S3 Variables
variable "s3_versioning_enabled" {
  type        = string
  description = "Enable versioning on the S3 bucket (Enabled/Suspended)"
  default     = "Suspended"
}
