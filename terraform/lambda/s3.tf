# Retrieve S3 "the-docker-playbook-data" arn
data "aws_s3_bucket" "tdp_data" {
  bucket = "the-docker-playbook-data"
}

# Allow S3 to invoke Lambda
resource "aws_lambda_permission" "tdp_lambda_s3_invoke_permission" {
  statement_id = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tdp_model_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn = "arn:aws:s3:::the-docker-playbook-data"
}

# Create an S3 Event Notification for the Lambda Function
resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = data.aws_s3_bucket.tdp_data.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.tdp_model_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "raw-data/"
  }

  depends_on = [
    aws_lambda_permission.tdp_lambda_s3_invoke_permission,
    aws_lambda_function.tdp_model_lambda
  ]
}