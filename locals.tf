locals {
    users = csvdecode(file("users.csv"))
}

locals {
  department = toset(
    [for user in local.users : user.department ]
  )
  
}