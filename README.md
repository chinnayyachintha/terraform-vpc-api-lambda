# Import the REST API

terraform import aws_api_gateway_rest_api.payment_gateway_api 3drk5yfi26

# Import the Resource for "/v1"

terraform import aws_api_gateway_resource.token_resource 3drk5yfi26/<resource_id_for_v1>

# Import the Resource for "/v1/token"

terraform import aws_api_gateway_resource.token_subresource 3drk5yfi26/<resource_id_for_v1_token>

# Import the POST Method for "/v1/token"

terraform import aws_api_gateway_method.post_method 3drk5yfi26/<resource_id_for_v1_token>/POST

# Import the Integration for POST Method

terraform import aws_api_gateway_integration.post_integration 3drk5yfi26/<resource_id_for_v1_token>/POST

# Import the Deployment for the Dev stage

terraform import aws_api_gateway_deployment.dev_deployment 3drk5yfi26/<deployment_id>


### second http-api

# Import the HTTP API

terraform import aws_apigatewayv2_api.http_api mv0roh4dqj

# Import the Route for "/PaymentGateway_IntelysisToken"

terraform import aws_apigatewayv2_route.default_route mv0roh4dqj/<route_id>

# Import the Integration for the route

terraform import aws_apigatewayv2_integration.default_integration mv0roh4dqj/<integration_id>

# Import the Default Stage

terraform import aws_apigatewayv2_stage.default_stage mv0roh4dqj/$default
