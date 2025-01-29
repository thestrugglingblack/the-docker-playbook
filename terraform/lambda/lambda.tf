# Define the Lambda function that pulls from the already created Docker Hub
resource "aws_lambda_function" "tdp_model_lambda" {
  function_name = "tdp-model-docker"
  package_type = "Image"
  role = aws_iam_role.tdp_lambda_role.arn
  image_uri = "docker.io/zhunter92/the-docker-playbook-model:latest"
  timeout = 300
  memory_size = 512
}