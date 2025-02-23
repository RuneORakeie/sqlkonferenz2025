#######################
### FABRIC CAPACITY ###
#######################
data "fabric_capacity" "capacity" {
  display_name = "fc${var.solution_name}"
}
#######################
### Entra ID Group  ###
#######################
data "azuread_group" "fabric_ws_contributors" {
  display_name = "Terraform Demo - Workspace Contributors"
}
#######################
###  Entra ID User  ###
#######################
data "azuread_user" "admin" {
  user_principal_name = var.admin_user
}
data "azuread_user" "admin2" {
  user_principal_name = var.admin_user2
}
