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

resource "aws_iam_policy" "cloudwatch_logs_metrics_policy" {
  name = "cloudwatch-logs-metrics-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowReadingMetricsFromCloudWatch"
        Effect = "Allow"
        Action = [
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetInsightRuleReport",
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowReadingLogsFromCloudWatch"
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups",
          "logs:GetLogGroupFields",
          "logs:StartQuery",
          "logs:StopQuery",
          "logs:GetQueryResults",
          "logs:GetLogEvents",
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowReadingTagsInstancesRegionsFromEC2"
        Effect = "Allow"
        Action = [
          "ec2:DescribeTags",
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
        ]
        Resource = "*"
      },
      {
        Sid      = "AllowReadingResourcesForTags"
        Effect   = "Allow"
        Action   = "tag:GetResources"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "cloudwatch_logs_readonly_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_logs_metrics_policy.arn
  role       = aws_iam_role.grafana_cloudwatch_role.name
}
