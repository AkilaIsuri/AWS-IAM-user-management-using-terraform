resource "aws_iam_group" "department_groups" {
    for_each = local.department
    name     = replace(each.value, " ", "_")
    path     = "/groups/"
  
}

resource "aws_iam_group_membership" "memberships" {
  for_each = aws_iam_group.department_groups
  name = "${each.key}-membership"
  group = each.value.name

  users = [
    for user_key, user in aws_iam_user.users:
    user.name if user.tags["Department"] == each.key
  ] 
}
