#######################
### FABRIC CAPACITY ###
#######################
data "fabric_capacity" "capacity" {
  display_name = azurerm_fabric_capacity.kql_demo.name
}
#######################
### Entra ID Group  ###
#######################
data "azuread_group" "fabric_ws_contributors" {
  display_name = "Terraform Demo - Workspace Contributors"
}
