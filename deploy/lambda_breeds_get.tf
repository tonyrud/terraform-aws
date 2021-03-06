locals {
  breeds_list_function_name = "${local.prefix}-${var.api_resources.breeds}-get"
}

resource "aws_lambda_function" "BreedsGet" {
  function_name = local.breeds_list_function_name

  layers = [aws_lambda_layer_version.lambda_utils.arn]

  filename = "build/BreedsGet.zip"

  handler = "src/BreedsGet/index.handler"
  runtime = var.lambda_runtime

  role = aws_iam_role.lambda_exec.arn

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.BreedsGet,
  ]

  tags = local.common_tags

  environment {
    variables = merge(
      local.lambda_env_vars,
      { "QUERY_FILE" = "${var.api_resources.breeds}.csv" }
    )
  }
}

resource "aws_cloudwatch_log_group" "BreedsGet" {
  name              = "/aws/lambda/${local.breeds_list_function_name}"
  retention_in_days = 14
}

resource "aws_lambda_permission" "APIGW-BreedsGet" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.BreedsGet.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*/*"
}