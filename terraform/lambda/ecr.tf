resource "aws_ecr_repository" "tdp_model_ecr" {
  name = "tdp/the-docker-playbook-model"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}