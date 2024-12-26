# REST API
resource "aws_api_gateway_rest_api" "payment_gateway_api" {
  name = "intelisys_paymentgateway_api"
}

resource "aws_api_gateway_resource" "token_resource" {
  rest_api_id = aws_api_gateway_rest_api.payment_gateway_api.id
  parent_id   = aws_api_gateway_rest_api.payment_gateway_api.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "token_subresource" {
  rest_api_id = aws_api_gateway_rest_api.payment_gateway_api.id
  parent_id   = aws_api_gateway_resource.token_resource.id
  path_part   = "token"
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.payment_gateway_api.id
  resource_id   = aws_api_gateway_resource.token_subresource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.payment_gateway_api.id
  resource_id             = aws_api_gateway_resource.token_subresource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "MOCK" # Update this to a specific type like "AWS_PROXY" if integrating with Lambda or other services.
  uri                     = ""    # Add the URI if required.
}

resource "aws_api_gateway_deployment" "dev_deployment" {
  rest_api_id = aws_api_gateway_rest_api.payment_gateway_api.id
  stage_name  = "Dev"
  depends_on = [
    aws_api_gateway_integration.post_integration,
  ]
}

# HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "PaymentGateway_IntelysisToken-API"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /PaymentGateway_IntelysisToken"
}

resource "aws_apigatewayv2_integration" "default_integration" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "MOCK" # Update this to other types like AWS_PROXY if using a Lambda or service.
  integration_method = "ANY" # Use "ANY" for any method. Specify "POST", "GET", etc., if needed.
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "default"
  auto_deploy = true
}

resource "aws_apigatewayv2_route_settings" "route_settings" {
  api_id    = aws_apigatewayv2_api.http_api.id
  stage_name = aws_apigatewayv2_stage.default_stage.name
  route_key = aws_apigatewayv2_route.default_route.route_key

  throttling_burst_limit = 500
  throttling_rate_limit  = 1000
}
