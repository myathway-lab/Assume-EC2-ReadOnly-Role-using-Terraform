
Master account assumes “EC2 Readonly role” to Dev account.

We have two AWS accounts for assume role testing.

```yaml
Master account id	582xxxxx195
Dev account id	767xxxxx3373
```

<aside>
💡 **let’s demonstrate to create the IAM role which has EC2 read only access in Master account. Then assume this role to Dev account.**

</aside>

- version.tf
    
    ```yaml
    terraform {
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "5.35.0"
        }
      }
    }
    
    provider "aws" {
      shared_config_files      = ["/home/vagrant/.aws/config"]
      shared_credentials_files = ["/home/vagrant/.aws/credentials"]
      profile                  = "mt-lab-master-mgmt"
      alias                    = "mt-lab-master"
    }
    ```
    
- main.tf
    
    ```yaml
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
                    "AWS": "767xxxxx3373"
                },
                "Condition": {}
            }
        ]
    }
      )
    
    }
    ```
    

Apply the Terraform. 

Now Login to Dev env using IAM account. 

Then switch to another aws account using “ec2_readonly_role”.

![image](https://github.com/myathway-lab/Create-AWD-Assume-Role-using-Terraform/assets/157335804/f9815f70-8bc0-48a9-9191-999d9ce093b1)


Verify if the role can access the Master with read permissions. 
![image](https://github.com/myathway-lab/Create-AWD-Assume-Role-using-Terraform/assets/157335804/fa59862f-860e-4644-a5f4-dbd55b78dd69)

