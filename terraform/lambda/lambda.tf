# Define the Lambda function that pulls from the already created Docker Hub
resource "aws_lambda_function" "tdp_model_lambda" {
  function_name = "tdp-model-docker"
  package_type = "Image"
  role = aws_iam_role.tdp_lambda_role.arn
  image_uri = "378737770782.dkr.ecr.us-east-1.amazonaws.com/tdp/the-docker-playbook-model:latest"
  timeout = 300
  memory_size = 512
  depends_on = [
    aws_ecr_repository.tdp_model_ecr
  ]

  environment {
    variables = {
      S3_BUCKET_NAME = data.aws_s3_bucket.tdp_data.bucket
      DATA_FOLDER = "/raw-data"
      RESULTS_FOLDER = "/results"
      MODEL_FOLDER = "/model"
    }
  }
}