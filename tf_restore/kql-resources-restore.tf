variable "solution_name_restored" {
  description = "Name of the solution"
  type        = string
  default     = "sqlkonferenz2025-restored"
}


########################
###  KQL EVENTHOUSE  ###
########################
resource "fabric_eventhouse" "kql_demo_restore" {
  display_name = "eh-${var.solution_name_restored}"
  workspace_id = module.demo_ws_prod_restore.id
}

########################
###   KQL DATABASE   ###
########################
resource "fabric_kql_database" "kql_demo_db_1_restore" {
  display_name = "kql-db-01-${var.solution_name_restored}"
  workspace_id = module.demo_ws_prod_restore.id
  format       = "Default"
  definition = {
    "DatabaseProperties.json" = {
      source = "../item-templates/DatabaseProperties_01.json.tmpl"
      tokens = {
        "KqlEhId" = fabric_eventhouse.kql_demo_restore.id
      }
    }
    "DatabaseSchema.kql" = {
      source = "../item-templates/DatabaseSchema_01.kql"
    }
  }
  depends_on = [fabric_eventhouse.kql_demo_restore]

}
resource "fabric_kql_database" "kql_demo_db_2_restore" {
  display_name = "kql-db-02-${var.solution_name_restored}"
  workspace_id = module.demo_ws_prod_restore.id
  format       = "Default"
  definition = {
    "DatabaseProperties.json" = {
      source = "../item-templates/DatabaseProperties_01.json.tmpl"
      tokens = {
        "KqlEhId" = fabric_eventhouse.kql_demo_restore.id
      }
    }
    "DatabaseSchema.kql" = {
      source = "../item-templates/DatabaseSchema_02.kql"
    }
  }
  depends_on = [fabric_kql_database.kql_demo_db_1_restore]
}

########################
### KQL EVENTSTREAM  ###
########################
resource "fabric_eventstream" "kql_demo_es_restore" {
  display_name = "kql-es-${var.solution_name_restored}"
  workspace_id = module.demo_ws_prod_restore.id
  format       = "Default"
  definition = {
    "eventstream.json" = {
      source = "../item-templates/eventstream.json.tmpl"
      tokens = {
        "ConnId"    = module.ws_conn_eventhub.id
        "KqlDbName" = fabric_kql_database.kql_demo_db_1_restore.display_name
        "KqlDbId"   = fabric_kql_database.kql_demo_db_1_restore.id
        "WsId"      = module.demo_ws_prod_restore.id
      }
    }
  }
  depends_on = [module.ws_conn_eventhub, fabric_kql_database.kql_demo_db_1_restore]
}

########################
###   KQL DASHBOARD  ###
########################
resource "fabric_kql_dashboard" "kql_demo_dash_restore" {
  display_name = "kql-dash-${var.solution_name_restored}"
  workspace_id = module.demo_ws_prod_restore.id
  format       = "Default"
  definition = {
    "RealTimeDashboard.json" = {
      source = "../item-templates/RealTimeDashboard_downloaded.json"
      tokens = {
        "QuerySvcUri" = fabric_kql_database.kql_demo_db_1_restore.properties.query_service_uri
        "KqlDbId"     = fabric_kql_database.kql_demo_db_1_restore.id
        "WsId"        = module.demo_ws_prod_restore.id
      }
    }
  }
  depends_on = [fabric_kql_database.kql_demo_db_1_restore]
}

