# Breeds List
resource "aws_api_gateway_resource" "BreedsList" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = var.api_resources.breeds
}

resource "aws_api_gateway_method" "BreedsList" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.BreedsList.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "LambdaBreedsList" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = aws_api_gateway_method.BreedsList.resource_id
  http_method = aws_api_gateway_method.BreedsList.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.BreedsList.invoke_arn
}

# Breeds Get
resource "aws_api_gateway_resource" "BreedsGet" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_resource.BreedsList.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "BreedsGet" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.BreedsGet.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "LambdaBreedsGet" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = aws_api_gateway_method.BreedsGet.resource_id
  http_method = aws_api_gateway_method.BreedsGet.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.BreedsGet.invoke_arn
}