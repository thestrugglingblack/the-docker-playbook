# Define the-docker-playbook-model-lamba-role
resource "aws_iam_role" "tdp_lambda_role"{
  name = "tdp_model_execution_role"
  assume_role_policy = jsonencode({
    Version =  "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the LambdaBasicExecution policy to the tdp_lambda_role
resource "aws_iam_policy_attachment" "tdp_lambda_policy_attach"{
  name= "tdp_model_lambda_policy_attachment"
  roles = [aws_iam_role.tdp_lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Define S3 Access Policy
resource "aws_iam_policy" "s3_access_policy" {
  name = "tdp_model_s3_access_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Effect = "Allow"
        Resource = [
          data.aws_s3_bucket.tdp_data.arn,
          "${data.aws_s3_bucket.tdp_data.arn}/*"
        ]
      }
    ]
  })
}

# Attach the S3 policy to the tdp_lambda_role
resource "aws_iam_policy_attachment" "tdp_s3_policy_attach"{
  name = "tdp_model_s3_policy_attachment"
  roles = [aws_iam_role.tdp_lambda_role.name]
  policy_arn = aws_iam_policy.s3_access_policy.arn
}


# Define the ECR policy to the tdp_lambda_role
# ECR Access Policy
resource "aws_iam_policy" "ecr_access_policy" {
  name = "tdp_model_ecr_access_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "arn:aws:ecr:*:378737770782:repository/tdp/the-docker-playbook-model"
      },
      {
        Effect = "Allow"
        Action = "ecr:GetAuthorizationToken"
        Resource = "*"
      }
    ]
  })
}

# Attach ECR policy to the lambda role
resource "aws_iam_policy_attachment" "tdp_ecr_policy_attach" {
  name       = "tdp_model_ecr_policy_attachment"
  roles      = [aws_iam_role.tdp_lambda_role.name]
  policy_arn = aws_iam_policy.ecr_access_policy.arn
}


