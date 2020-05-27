### CodeBuild Project ###

# CodeBuild GitHub Webhook
resource "aws_codebuild_webhook" "github" {
  project_name = aws_codebuild_project.cv_pipeline.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH,PULL_REQUEST_MERGED"
    }
  }
}


# CodeBuild Pipeline
resource "aws_codebuild_project" "cv_pipeline" {
  name          = "cv-pipeline"
  description   = "LaTeX CV build pipeline."
  build_timeout = "10"
  badge_enabled = true
  service_role  = aws_iam_role.cv_pipeline.arn

  artifacts {
    type                = "S3"
    location            = aws_s3_bucket.cv_bucket.id
    path                = "/"
    encryption_disabled = true
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.cv_bucket.id}/logs/codebuild"
    }
  }

  source {
    type                = "GITHUB"
    location            = var.cv_repo
    git_clone_depth     = 1
    report_build_status = true
  }

  #tags = local.tags_map
}
