# Codebuild IAM
resource "aws_iam_role" "codebuild-iam-role" {
  name               = "${var.app_name}-codebuild-iam-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_role_policy.json
  tags = {
    Name = "${var.app_name}-${var.env}-codebuild-iam-role"
  }
}
# Attach policy
resource "aws_iam_role_policy" "codebuild" {
  role   = aws_iam_role.codebuild-iam-role.name
  policy = data.aws_iam_policy_document.codebuild_role_policy_assume.json
}

# Policy for Codebuild
data "aws_iam_policy_document" "codebuild_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com", "codepipeline.amazonaws.com", "s3.amazonaws.com"]
    }
  }
}
# Policy for Codebuild
# 1. S3 (Bucket with remote state, bucket with archive)
# 2. Logs for CodeBuild
# 3. CodeBuild Policy
# 4. CloudWatch Policy
# 5. SNS Policy
# 6. ECR Policy
# 7. ECS Policy
# 8. EC2 Policy (ALB, VPC, SG)
# 9. IAM policy

data "aws_iam_policy_document" "codebuild_role_policy_assume" {
  statement {
    sid    = "AllowS3"
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:Delete*",
      "s3:List*",
      "s3:Put*",
      "s3:Get*"
    ]
    resources = [
      "${var.s3_arn_codebuild}",
      "${var.s3_arn_codebuild}/*",
      "arn:aws:s3:::${var.app_name}-${var.env}-terraform-state",
      "arn:aws:s3:::${var.app_name}-${var.env}-terraform-state/*"
    ]
  }

  statement {
    sid    = "AllowCodeBuild"
    effect = "Allow"

    actions = [
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages",
      "codebuild:BatchGet*",
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:DescribeTestCases",
      "codebuild:DescribeCodeCoverages",
      "codebuild:GetResourcePolicy",
      "codebuild:List*",
      "codebuild:RetryBuild",
      "codebuild:RetryBuildBatch",
      "codebuild:StartBuild",
      "codebuild:StopBuild",
      "codebuild:StartBuildBatch",
      "codebuild:StopBuildBatch",
      "codebuild:UpdateReport",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:ListBranches",
      "cloudwatch:GetMetricStatistics",
      "events:DescribeRule",
      "events:ListTargetsByRule",
      "events:ListRuleNamesByTarget"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "AllowIAM"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:PassRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRolePolicies"
    ]
    resources = ["arn:aws:iam::*:role/*"]
  }

  statement {
    sid    = "AllowLog"
    effect = "Allow"
    actions = [
      "logs:GetLogGroupFields",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
      "logs:PutMetricFilter",
      "logs:PutSubscriptionFilter"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/codebuild/",
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/codebuild/*"
    ]
  }

  statement {
    sid    = "AllowSNS"
    effect = "Allow"
    actions = [
      "sns:ListTopics",
      "sns:GetTopicAttributes",
      "sns:Publish"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudWatch"
    effect = "Allow"
    actions = [
      "cloudwatch:Disable*",
      "cloudwatch:Describe*",
      "cloudwatch:Delete*",
      "cloudwatch:Set*",
      "cloudwatch:Get*",
      "cloudwatch:Put*",
      "cloudwatch:Stop*",
      "cloudwatch:Enable*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowECSandECRDeploy"
    effect = "Allow"
    actions = [
      "ecr:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "ec2:AttachNetworkInterface",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:Describe*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowSSM"
    effect = "Allow"
    actions = [
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:Update*"
    ]
    resources = ["*"]
  }

  statement {
    sid       = "AllowPassRole"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["iam:PassRole"]
    condition {
      test     = "StringLike"
      values   = ["ecs-tasks.amazonaws.com"]
      variable = "iam:PassedToService"
    }
  }
}
