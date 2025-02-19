resource "aws_iam_role" "ec2-admin" {
  name = "admin-access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2-admin" {
    role = aws_iam_role.ec2-admin.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  
}