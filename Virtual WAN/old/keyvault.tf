data "azurerm_client_config" "this" {}

# This allows us to randomize the region for the resource group.
# module "regions" {
#   source  = "Azure/regions/azurerm"
#   version = "0.4.0"
# }

# This allows us to randomize the region for the resource group.
# resource "random_integer" "region_index" {
#   max = length(module.regions.regions) - 1
#   min = 0
# }

data "http" "ip" {
  url = "https://api.ipify.org/"
  retry {
    attempts     = 5
    max_delay_ms = 1000
    min_delay_ms = 500
  }
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = "switzerland north"
  name     = "kv-rg"
}

# This is the module call
module "keyvault" {
  source                 = "Azure/avm-res-keyvault-vault/azurerm"
  version                = "0.5.3"
  name                   = module.naming.key_vault.name_unique
  enable_telemetry       = false
  location               = azurerm_resource_group.this.location
  resource_group_name    = azurerm_resource_group.this.name
  tenant_id              = data.azurerm_client_config.this.tenant_id
  enabled_for_deployment = true
  sku_name               = "standard"
  role_assignments = {
    deployment_user_kv_admin = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.this.object_id
    }
  }
  network_acls = {
    bypass   = "AzureServices"
    ip_rules = ["${data.http.ip.response_body}/32"]
  }
  secrets = {
    vpnpsk = {
      name = "vpnpsk"
    }
  }
  secrets_value = {
    vpnpsk = random_password.vpnpsk.result
  }
}

resource "random_password" "vpnpsk" {
  length  = 64
  special = false
}

