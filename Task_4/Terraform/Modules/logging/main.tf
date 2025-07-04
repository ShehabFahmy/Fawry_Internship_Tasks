resource "aws_s3_bucket" "flow_logs" {
  bucket = var.logs_bucket_name

  tags = {
    Name = var.logs_bucket_name
    Env  = var.env
  }
}

resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = 7

  tags = {
    Name = "poc-prod-logs"
    Env  = var.env
  }
}

resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "poc-prod-vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name = "poc-prod-vpc-flow-logs-policy"
  role = aws_iam_role.vpc_flow_logs_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.flow_logs.arn}/*"
      }
    ]
  })
}

resource "aws_flow_log" "vpc_logs" {
  log_destination      = aws_cloudwatch_log_group.flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
  iam_role_arn         = aws_iam_role.vpc_flow_logs_role.arn

  tags = {
    Name = "poc-prod-vpc-flow-log"
    Env  = var.env
  }
}