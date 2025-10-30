# ECR Repository
resource "aws_ecr_repository" "app_repository" {
  name                 = "app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    name = "app-repo"
  }
}

# TBR (To be researched vvvvvv)
# ECR Lifecycle Policy
# resource "aws_ecr_lifecycle_policy" "app_lifecycle_policy" {
#   repository = aws_ecr_repository.app_repository.name

#   policy = <<POLICY
# {
#   "rules": [
#     {
#       "rulePriority": 1,
#       "description": "Expire untagged images older than 30 days",
#       "selection": {
#         "tagStatus": "untagged",
#         "countType": "sinceImagePushed",
#         "countUnit": "days",
#         "countNumber": 30
#       },
#       "action": {
#         "type": "expire"
#       }
#     }
#   ]
#}