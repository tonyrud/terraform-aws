resource "aws_lambda_layer_version" "lambda_utils" {
  filename   = "build/utils.zip"
  layer_name = "utils"

  compatible_runtimes = [var.lambda_runtime]
}