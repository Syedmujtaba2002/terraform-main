# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "syedsmhh112"
  acl           = "private"

  tags = {
    Name = "syedhussssaini"
  }
}

# Upload Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "dev.zip"
  source = "dev.zip" # Path to your zip file containing the Lambda code
  etag   = filemd5("dev.zip")
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  runtime          = "python3.9"
  role             = "arn:aws:iam::664418968609:role/lambda-access"
  handler          = "dev.lambda_handler" # Replace with your function handler
  s3_bucket        = aws_s3_bucket.lambda_bucket.id # calling code from s3 bucket 
  s3_key           = aws_s3_object.lambda_code.key # inside this folder
  timeout          = 900
  memory_size      = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE" # Example environment variable
    }
  }

  tags = {
    Name = "MyLambdaFunction"
  }
}