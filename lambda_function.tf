resource "aws_lambda_function" "PaymentGateway_IntelysisToken" {
    filename      = "PaymentGateway_IntelysisToken.zip"
    function_name = "PaymentGateway_IntelysisToken-AD"
    role          = aws_iam_role.iam_for_lambda.arn
    handler       = "payment.handler"
    runtime       = "nodejs12.x"
    
}