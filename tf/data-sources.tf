#######################
###  Executing USER ###
#######################
data "azuread_client_config" "current" {
}
#######################
### RESOURCE GROUPS ###
#######################
data "azurerm_resource_group" "fc_cap_rg" {
  name = "ClauseFabric"
}
#######################
### FABRIC CAPACITY ###
#######################
data "fabric_capacity" "capacity" {
  display_name = azurerm_fabric_capacity.kql_demo.name
}

data "azuread_user" "admin" {
  user_principal_name = var.admin_user
}
data "azuread_user" "admin2" {
  user_principal_name = var.admin_user2
}

