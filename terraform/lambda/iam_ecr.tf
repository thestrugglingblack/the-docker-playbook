resource "aws_ecrpublic_repository" "tdp_model_public_policy" {
  repository_name = aws_ecr_repository.tdp_model_ecr.name

  repository_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "ecr-public:GetDownloadUrlForLayer",
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:BatchGetImage"
        ]
      }
    ]
  })
}