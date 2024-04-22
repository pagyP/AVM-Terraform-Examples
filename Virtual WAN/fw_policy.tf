resource "azurerm_resource_group" "fw-pol-rg" {
  name     = "fw-policy-rg"
  location = "switzerland north"
}

# This is the module call
# module "firewall_policy" {
#  source  = "Azure/avm-res-network-firewallpolicy/azurerm"
#   version = "0.1.1"
#   enable_telemetry    = false
#   name                = module.naming.firewall_policy.name_unique
#   location            = azurerm_resource_group.fw-pol-rg.location
#   resource_group_name = azurerm_resource_group.fw-pol-rg.name
  
# }

module "fwpolicy" {
  source                   = "./modules/azfirewallpolicy"
  name                     = "uks-firewall-policy"
  resource_group_name      = azurerm_resource_group.fw-pol-rg.name
  location                 = azurerm_resource_group.fw-pol-rg.location
  base_policy_id           = null
  sku                      = "Standard"
  threat_intelligence_mode = "Alert"
  // Below line only needed when a dns server is defined
  //dns                           = var.dns
  tags                          = var.fw_policy_tags
  threat_intelligence_allowlist = var.threat_intelligence_allowlist
}


module "fwrules" {
  source                      = "./modules/azfirewallrulecollectiongroup"
  name                        = var.rule_collection_group_name
  priority                    = var.priority
  fw_policy_id                = module.fwpolicy.fw_policy_id
  application_rule_collection = var.application_rule_collection
  network_rule_collection     = var.network_rule_collection
  #Line below only needed when a nat rule collection is defined
  #nat_rule_collection = var.nat_rule_collection
}


# module "rule_collection_group" {
#   //source = "../../modules/rule_collection_groups"
#   source = "Azure/avm-res-network-firewallpolicy/azurerm//modules/rule_collection_groups"
#   firewall_policy_rule_collection_group_firewall_policy_id = module.firewall_policy.id
#   firewall_policy_rule_collection_group_name               = "rcg-001"
#   firewall_policy_rule_collection_group_priority           = 200
#   firewall_policy_rule_collection_group_network_rule_collection = [
#     {
#       action   = "Allow"
#       name     = "netrule-collection-allow"
#       priority = 200
#       rule = [
#         {
#           name              = "allow-msft"
#           description       = "Allow all traffic to Microsoft"
#           source_addresses  = ["*"]
#           destination_ports = ["*"]
#           protocols         = ["TCP", "UDP"]
#           destination_fqdns = ["microsoft.com"]
#         }
#       ]
#     },
#     {
#       action   = "Deny"
#       name     = "netrule-collection-deny"
#       priority = 300
#       rule = [
#         {
#           name              = "deny-google"
#           description       = "Deny all traffic to Google"
#           source_addresses  = ["*"]
#           destination_ports = ["*"]
#           protocols         = ["TCP", "UDP"]
#           destination_fqdns = ["google.com"]
#         }
#       ]
#     }
#   ]
# }

# module "fwrules2" {
#   source       = "../modules/azfirewallrulecollectiongroup"
#   name         = var.rule_collection_group_name2
#   priority     = var.priority
#   fw_policy_id = module.fwpolicy.fw_policy_id
#   #application_rule_collection = var.application_rule_collection
#   network_rule_collection = var.network_rule_collection2
#   #Line below only needed when a nat rule collection is defined
#   #nat_rule_collection = var.nat_rule_collection
# }