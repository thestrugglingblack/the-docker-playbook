# Create SNS topic
resource "aws_sns_topic" "tdp_lambda_success_topic"{
  name = "tdp-lambda-success-topic"
}
resource "aws_sns_topic" "tdp_lambda_failure_topic"{
  name = "tdp-lambda-failure-topic"
}



# Subscribe to SNS topic via email
resource "aws_sns_topic_subscription" "tdp_email_success_subscription"{
  topic_arn = aws_sns_topic.tdp_lambda_success_topic.arn
  protocol = "email"
  endpoint = "thestrugglingblack@gmail.com"
}
# Subscribe to SNS topic via email
resource "aws_sns_topic_subscription" "tdp_email_failure_subscription"{
  topic_arn = aws_sns_topic.tdp_lambda_failure_topic.arn
  protocol = "email"
  endpoint = "thestrugglingblack@gmail.com"
}

resource "aws_lambda_function_event_invoke_config" "tdp_lambda_event_invoke_config" {
  function_name = aws_lambda_function.tdp_model_lambda.function_name

  destination_config {
    on_success {
      destination = aws_sns_topic.tdp_lambda_success_topic.arn
    }
    on_failure {
      destination = aws_sns_topic.tdp_lambda_failure_topic.arn
    }
  }

  maximum_retry_attempts = 2
  maximum_event_age_in_seconds = 60
}