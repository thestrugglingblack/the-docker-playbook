# Retrieve S3 "the-docker-playbook-data" arn
data "aws_s3_bucket" "tdp_data" {
  bucket = "the-docker-playbook-data"
}

# Create an S3 Event Notification for the Lambda Function
resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = data.aws_s3_bucket.tdp_data.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.tdp_model_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_lambda_function.tdp_model_lambda]
}
