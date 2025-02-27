module "ws_conn_eventhub" {
  source          = "github.com/RuneORakeie/terraform-modules-fabric//fabric-connection?ref=beta-v0.1.2"
  connection_name = "SQLKonf-Events SQLClause"
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
# terraform import module.ws_conn_eventhub.restapi_object.fabric_connection /connections/f29bed7c-a452-4329-b967-2c5a333a5bc9
# terraform import 'module.ws_conn_eventhub.restapi_object.connection_role_assignment["0"]' /connections/f29bed7c-a452-4329-b967-2c5a333a5bc9/roleAssignments/65dc42b4-71be-4e0a-b1c2-11f961077e1d
# terraform import 'module.ws_conn_eventhub.restapi_object.connection_role_assignment["1"]' /connections/f29bed7c-a452-4329-b967-2c5a333a5bc9/roleAssignments/5b2864ad-58d8-4442-a3e9-1c3d1a5cdca6
# terraform import 'module.ws_conn_eventhub.restapi_object.connection_role_assignment["2"]' /connections/f29bed7c-a452-4329-b967-2c5a333a5bc9/roleAssignments/aa5edc36-080b-4b9c-bcee-3b95cabd902d
/*
{
    "value": [
        {
            "id": "65dc42b4-71be-4e0a-b1c2-11f961077e1d",
            "principal": {
                "id": "65dc42b4-71be-4e0a-b1c2-11f961077e1d",
                "type": "User"
            },
            "role": "Owner"
        },
        {
            "id": "5b2864ad-58d8-4442-a3e9-1c3d1a5cdca6",
            "principal": {
                "id": "5b2864ad-58d8-4442-a3e9-1c3d1a5cdca6",
                "type": "User"
            },
            "role": "User"
        },
        {
            "id": "aa5edc36-080b-4b9c-bcee-3b95cabd902d",
            "principal": {
                "id": "aa5edc36-080b-4b9c-bcee-3b95cabd902d",
                "type": "User"
            },
            "role": "User"
        }
    ]
}
*/
