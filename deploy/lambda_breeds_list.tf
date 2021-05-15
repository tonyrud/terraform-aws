locals {
  breeds_get_function_name = "${local.prefix}-${var.api_resources.breeds}-list"
}

resource "aws_lambda_function" "BreedsList" {
  function_name = local.breeds_get_function_name

  # TODO: build step for S3
  # s3_bucket = "326347646211-terraform-serverless-example"
  # s3_key    = "v1.0.0/example.zip"
  filename = "../../BreedsList.zip"

  handler = "src/BreedsList/index.handler"
  runtime = var.lambda_runtime

  role = aws_iam_role.lambda_exec.arn

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.BreedsList,
  ]

  tags = local.common_tags

  environment {
    variables = local.lambda_env_vars
  }
}

resource "aws_cloudwatch_log_group" "BreedsList" {
  name              = "/aws/lambda/${local.breeds_get_function_name}"
  retention_in_days = 14
}


resource "aws_lambda_permission" "APIGW-BreedsList" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.BreedsList.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*/*"
}

