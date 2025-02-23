variable "solution_name_restored" {
  description = "Name of the solution"
  type        = string
  default     = "sqlkonferenz2025-restored"
}

# Authentication variables for the RESTAPI provider
variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
  # Will read from TF_VAR_tenant_id environment variable
}
variable "client_id" {
  description = "Azure client ID"
  type        = string
  sensitive   = true
  # Will read from TF_VAR_client_id environment variable
}
variable "client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
  # Will read from TF_VAR_client_secret environment variable
}
# variable "local_dev_client_id" {
#   description = "Azure client ID"
#   type        = string
# }
variable "admin_user" {
  description = "MS Fabric admin user"
  type        = string
  sensitive   = true
  # Will read from TF_VAR_admin_user environment variable
}
variable "admin_user2" {
  description = "MS Fabric admin user"
  type        = string
  sensitive   = true
  # Will read from TF_VAR_admin_user2 environment variable
}
variable "solution_name" {
  description = "Name of the solution"
  type        = string
  default     = "sqlkonferenz2025"
}
