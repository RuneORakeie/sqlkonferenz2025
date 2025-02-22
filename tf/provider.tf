#############################################
#          Azure Resource Manager           #
#############################################
provider "azurerm" {
  features {}
  client_id                       = var.client_id
  use_oidc                        = true
  resource_provider_registrations = "none"
}
#############################################
#          Azure Active Directory           #
#############################################
provider "azuread" {
  client_id = var.client_id
  use_oidc  = true
}
#############################################
#           Microsoft Fabric                #
#############################################
provider "fabric" {
  preview = true
  # use_oidc = true
}
# provider "fabric" {
#   use_cli = true
#   alias   = "user_auth"
#   /*
# az config set core.login_experience_v2=off
# az login --allow-no-subscriptions --tenant 938b3811-af5f-4479-b767-8a7d85f5755d --scope api://fabric_terraform_provider/.default
# */
# }
# data "external" "fabric_auth" {
#   program = ["bash", "-c", <<-EOT
#     # Disable new login experience
#     az config set core.login_experience_v2=off > /dev/null

#     # Handle Windows WAM if needed
#     if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win"* ]]; then
#       az config set core.enable_broker_on_windows=false > /dev/null
#     fi

#     # Perform login
#     az login --allow-no-subscriptions \
#       --tenant "${var.tenant_id}" \
#       --scope "api://fabric_terraform_provider/.default" > /dev/null

#     # External data source requires JSON output
#     echo '{"authenticated": "true"}'
#   EOT
#   ]
# }
#############################################
#       Microsoft Fabric REST API           #
#############################################
# locals {
#   is_github_actions = fileexists("/github/workspace")
#   gha_oidc_token    = local.is_github_actions ? coalesce(nonsensitive(sensitive(coalesce(getenv("ACTIONS_ID_TOKEN_REQUEST_TOKEN"), ""))), "") : ""
# }

# # For local development, get token using workload identity
# data "external" "azure_cli_token" {
#   count   = local.is_github_actions ? 0 : 1
#   program = ["sh", "-c", "az account get-access-token --resource-type oidc --scope https://api.fabric.microsoft.com/.default | jq -r '{token: .accessToken}'"]
# }

# provider "restapi" {
#   uri                  = "https://api.fabric.microsoft.com/v1"
#   write_returns_object = true

#   headers = {
#     Authorization = "Bearer ${jsondecode(data.http.azure_token.response_body).access_token}"
#   }
# }
# data "http" "azure_token" {
#   # The token endpoint URL with variable interpolation
#   url = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"

#   # Specify POST method for token request
#   method = "POST"

#   # Set required headers for token request
#   request_headers = {
#     "Content-Type" = "application/x-www-form-urlencoded"
#   }

#   # Form-encoded body with OAuth2 parameters
#   #request_body = "grant_type=client_credentials&client_id=${var.client_id}&client_secret=${var.client_secret}&scope=https://api.fabric.microsoft.com/.default"
#   request_body = local.is_github_actions ? (
#     "grant_type=client_assertion&client_id=${var.client_id}&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&client_assertion=${local.gha_oidc_token}&scope=https://api.fabric.microsoft.com/.default"
#     ) : (
#     "grant_type=client_assertion&client_id=${var.local_dev_client_id}&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer&client_assertion=${data.external.azure_cli_token[0].result.token}&scope=https://api.fabric.microsoft.com/.default"
#   )
# }

# output "token" {
#   value = data.external.azure_token.result.access_token

# }
provider "restapi" {
  uri                  = "https://api.fabric.microsoft.com/v1"
  write_returns_object = true

  headers = {
    Authorization = "Bearer ${jsondecode(data.http.azure_token.response_body).access_token}"
  }
}
data "http" "azure_token" {
  # The token endpoint URL with variable interpolation
  url = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"
  # Specify POST method for token request
  method = "POST"
  # Set required headers for token request
  request_headers = {
    "Content-Type" = "application/x-www-form-urlencoded"
  }
  # Form-encoded body with OAuth2 parameters
  request_body = "grant_type=client_credentials&client_id=${var.client_id}&client_secret=${var.client_secret}&scope=https://api.fabric.microsoft.com/.default"
}
