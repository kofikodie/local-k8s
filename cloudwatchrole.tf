resource "aws_iam_role" "grafana_cloudwatch_role" {
  name = "grafana-cloudwatch-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "grafana.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_logs_readonly" {
  name        = "CloudWatchLogsReadOnly"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_readonly_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_logs_readonly.arn
  role       = aws_iam_role.grafana_cloudwatch_role.name
}
