resource "aws_iam_policy" "ec2_readonly" {
  name = "ec2_readonly"
  provider = aws.mt-lab-master

  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:Describe*",
            "Resource": "*"
        }
    ]
}
  )
}


resource "aws_iam_role" "ec2_readonly_role" {
  name = "ec2_readonly_role"
  provider = aws.mt-lab-master
  managed_policy_arns = [aws_iam_policy.ec2_readonly.arn]
  assume_role_policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "AWS": "76739xxxxxx3" #Dev account id
            },
            "Condition": {}
        }
    ]
}
  )

}
