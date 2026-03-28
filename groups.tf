resource "aws_iam_group" "Education" {
    name = "Education"
    path = "/groups/"
}

resource "aws_iam_group" "Engineers" {
    name = "Engineers"
    path = "/groups/"
}

resource "aws_iam_group" "Managers" {
    name = "Managers"
    path = "/groups/"
}

resource "aws_iam_group_membership" "Eduction_members" {
    name = "Education-group-membership"
    group = aws_iam_group.Education.name
    users = [for user in aws_iam_users.user : user.name if user.tags.department == "Education"]
}

resource "aws_iam_group_membership" "Engineers_members" {
    name = "Engineers-group-membership"
    group = aws_iam_group.Engineers.name
    users = [for user in aws_iam_users.user :user.name if user.tags.department == "Engineers"]
}

resource "aws_iam_group_membership" "Managers_members" {
    name = "Managers-group-membership"
    group = aws_iam_group.Managers.name
    users = [for user in aws_iam_users.user :user.name if user.tags.department == "Managers"]
}