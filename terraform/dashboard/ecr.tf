resource "aws_ecr_repository" "tdp_dashboard_ecr" {
  name = "tdp/the-docker-playbook-dashboard"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}