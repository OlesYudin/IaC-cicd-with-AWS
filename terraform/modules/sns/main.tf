# https://docs.aws.amazon.com/codebuild/latest/userguide/sample-build-notifications.html#sample-build-notifications-ref
# Create SNS topic
resource "aws_sns_topic" "sns_topic_codebuild" {
  name            = "${var.app_name}-${var.env}-sns-CodeBuild"
  display_name    = "Codebuild Result (${var.env})"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "numRetries": 10,
      "numNoDelayRetries": 0,
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numMinDelayRetries": 0,
      "numMaxDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
}
# Subscribe to SNS topic
resource "aws_sns_topic_subscription" "sns_subscribe_codebuild" {
  topic_arn = aws_sns_topic.sns_topic_codebuild.arn
  protocol  = "email"
  endpoint  = "oles.yudin.it@gmail.com"
}


# CloudWatch
resource "aws_cloudwatch_event_rule" "cloudwatch-rule-codebuild" {
  name        = "${var.app_name}-${var.env}-CloudWatch"
  description = "CloudWatch for CodeBuild in ${var.env} environment"

  # Push notification to email, if CodeBuild run with status: SUCCEEDED, FAILED or STOPPED
  event_pattern = <<EOF
{
  "source": ["aws.codebuild"],
  "detail-type": ["CodeBuild Build State Change"],
  "detail": {
    "build-status": ["STOPPED", "FAILED", "SUCCEEDED"],
    "project-name": ["${var.codebuild_project_name}"]
  }
}
EOF
}

# CloudWatch target
resource "aws_cloudwatch_event_target" "cloudwatch-event-target-codebuild" {
  rule = aws_cloudwatch_event_rule.cloudwatch-rule-codebuild.name
  arn  = aws_sns_topic.sns_topic_codebuild.arn

  # Configuration of CloutWatch
  # input_path - value of cloudwatch that can give to target (Email letter to target)
  # input_tamplate - template letter for target (email letter to target)
  input_transformer {
    input_paths = {
      "region"       = "$.region"
      "time"         = "$.time"
      "build-status" = "$.detail.build-status"
      "project-name" = "$.detail.project-name"
    }
    input_template = "\"Your project <project-name> in <region> region, at '<time>' was run with <build-status> status\""
  }
}
