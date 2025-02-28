module "ws_conn_eventhub" {
  source          = "github.com/RuneORakeie/terraform-modules-fabric//fabric-connection?ref=beta-v0.1.2"
  connection_name = "SQLKonf-Events SQLClause-2"
  connection_type = "EventHub"

  connectivity_type = "ShareableCloud"
  privacy_level     = "None" # Optional, defaults to "Organizational"

  eventhub_parameters = {
    namespace = "clauseevents"
    name      = "clausehub"
  }

  eventhub_credentials = {
    shared_access_key_name = "Fabric"
    shared_access_key      = var.azeventhub_saskey
  }

  # Optional: Add role assignments
  connection_role_assignments = [
    {
      principal_id   = data.azuread_user.admin2.object_id
      principal_type = "User"
      role           = "Owner"
    },
    {
      principal_id   = data.azuread_user.admin.object_id
      principal_type = "User"
      role           = "User"
    },
    {
      principal_id   = "aa5edc36-080b-4b9c-bcee-3b95cabd902d" // Terraform sp object_id
      principal_type = "User"
      role           = "Owner"
    },

  ]
}
