

resource "aws_iam_role" "lambda_role" {
  name = "lambda_ses_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}



resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_ses_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}



resource "aws_lambda_function" "notify" {
  filename      = "lambda/notify.zip"
  function_name = "terraform-state-notifier"
  role          = aws_iam_role.lambda_role.arn
  handler       = "notify.lambda_handler"
  runtime       = "python3.11"

  environment {
    variables = {
      FROM_EMAIL = "janna.wael.ali@gmail.com"
      TO_EMAIL   = "janna.wael.ali@gmail.com"
    }
  }

  tags = {
    Name = "terraform-state-notifier"
  }
}