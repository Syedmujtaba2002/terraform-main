resource "aws_iam_role" "lambda-admin" {
  name = "lambda-access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda-admin" {
    role = aws_iam_role.lambda-admin.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  
}