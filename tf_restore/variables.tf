
variable "name" {
  description = "Name of the solution"
  type        = string
  default     = "sqlkonferenz2025"
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "WestEurope"
}

variable "fabric_capacity_sku" {
  description = "Fabric Capacity SKU name"
  type        = string
  default     = "F2"
}

# Authentication variables fro the RESTAPI provider
variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  # Will read from TF_VAR_tenant_id environment variable
}
variable "client_id" {
  description = "Azure client ID"
  type        = string
  # Will read from TF_VAR_client_id environment variable
}
variable "client_secret" {
  description = "Azure client secret"
  type        = string
  # Will read from TF_VAR_client_secret environment variable
}
# variable "local_dev_client_id" {
#   description = "Azure client ID"
#   type        = string
# }
variable "admin_user" {
  description = "MS Fabric admin user"
  type        = string
  # Will read from TF_VAR_admin_user environment variable
}
variable "admin_user2" {
  description = "MS Fabric admin user"
  type        = string
  # Will read from TF_VAR_admin_user2 environment variable
}
variable "solution_name" {
  description = "Name of the solution"
  type        = string
  default     = "sqlkonferenz2025"
}



# Get role assignments
# data "http" "connection_assignments" {
#   url = "https://api.fabric.microsoft.com/v1/connections/${restapi_object.fabric_connection.id}/roleAssignments"

#   request_headers = {
#     Authorization = "Bearer ${data.external.azure_token.result.access_token}"
#     Content-Type  = "application/json"
#   }
# }

# # Parse and output the assignments
# output "connection_assignments" {
#   description = "List of all role assignments for the connection"
#   value       = jsondecode(data.http.connection_assignments.response_body).value
# }
