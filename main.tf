resource "aws_iam_user" "users" {
    for_each = { for user in local.users : user.first_name  => user }

    name = upper("${substr(each.value.first_name,0,1)}${each.value.last_name}")
    path = "/users/"
    tags = {
        "Display_name" = "${each.value.first_name} ${each.value.last_name}"
        "Department"   = each.value.department
        "Job_title"    = each.value.job_title
    }
    }


resource "aws_iam_user_login_profile" "users" {
  for_each =  aws_iam_user.users
  user = each.value.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [password_reset_required, password_length] 
  }
}

resource "aws_iam_policy" "enforce_mfa" {
  name        = "EnforceMFA"
  description = "Deny all actions if MFA is not present"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # Allow users to manage their own MFA
      {
        Effect = "Allow"
        Action = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice"
        ]
        Resource = "*"
      },

      # Deny everything if MFA is NOT present
      {
        Effect = "Deny"
        NotAction = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice",
          "iam:GetUser"
        ]
        Resource = "*"
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}



resource "aws_iam_group_policy_attachment" "mfa_attach" {
  for_each = aws_iam_group.department_groups

  group      = each.value.name
  policy_arn = aws_iam_policy.enforce_mfa.arn
}