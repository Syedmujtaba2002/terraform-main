# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          = "arn:aws:iam::664418968609:role/lambda-access"
  handler       = "test.lambda_handler"
  runtime       = "python3.12"
  timeout       = 900
  memory_size   = 128

  filename         = "test.zip"  # Ensure this file exists
  source_code_hash = filebase64sha256("test.zip")
}