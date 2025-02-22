# Create a Fabric Capacity.
resource "azurerm_fabric_capacity" "kql_demo" {
  name                = "fc${var.name}"
  resource_group_name = data.azurerm_resource_group.fc_cap_rg.name
  location            = var.location

  administration_members = [
    data.azuread_user.admin.user_principal_name,
  "aa5edc36-080b-4b9c-bcee-3b95cabd902d"]
  sku {
    name = var.fabric_capacity_sku
    tier = "Fabric"
  }
}

