# terraform {
#   experiments = [module_variable_optional_attrs]
# }

# resource "azurerm_firewall_policy" "fwpol" {
#   name                     = var.firewall_policy_config.name
#   resource_group_name      = var.resource_group_name
#   location                 = var.location
#   sku                      = var.firewall_policy_config.sku
#   threat_intelligence_mode = var.firewall_policy_config.threat_intelligence_mode
#   private_ip_ranges        = var.firewall_policy_config.private_ip_ranges
#   dns {
#     proxy_enabled = var.firewall_policy_config.dns_proxy_enabled
#     servers       = var.firewall_policy_config.dns_servers
#   }
#   threat_intelligence_allowlist {
#     fqdns        =  var.firewall_policy_config.threat_intelligence_allowlist_fqdns 
#     ip_addresses =  var.firewall_policy_config.threat_intelligence_allowlist_ip_addresses
#   }
#   intrusion_detection {
#     mode = var.firewall_policy_config.intrusion_detection_mode
#   }
#   tags = var.tags


# }

resource "azurerm_firewall_policy" "fwpol" {
  # base_policy_id - (optional) is a type of string
  base_policy_id = var.base_policy_id
  # location - (required) is a type of string
  location = var.location
  # name - (required) is a type of string
  name = var.name
  # resource_group_name - (required) is a type of string
  resource_group_name = var.resource_group_name
  # sku - (optional) is a type of string
  sku = var.sku
  # tags - (optional) is a type of map of string
  tags = var.tags
  # threat_intelligence_mode - (optional) is a type of string
  threat_intelligence_mode = var.threat_intelligence_mode

  dynamic "dns" {
    for_each = var.dns
    content {
      # network_rule_fqdn_enabled - (optional) is a type of bool
      #network_rule_fqdn_enabled = dns.value["network_rule_fqdn_enabled"]
      # proxy_enabled - (optional) is a type of bool
      proxy_enabled = dns.value["proxy_enabled"]
      # servers - (optional) is a type of set of string
      servers = dns.value["servers"]
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = var.threat_intelligence_allowlist
    content {
      # fqdns - (optional) is a type of set of string
      fqdns = threat_intelligence_allowlist.value["fqdns"]
      # ip_addresses - (optional) is a type of set of string
      ip_addresses = threat_intelligence_allowlist.value["ip_addresses"]
    }
  }

  # dynamic "timeouts" {
  #   for_each = var.timeouts
  #   content {
  #     # create - (optional) is a type of string
  #     create = timeouts.value["create"]
  #     # delete - (optional) is a type of string
  #     delete = timeouts.value["delete"]
  #     # read - (optional) is a type of string
  #     read = timeouts.value["read"]
  #     # update - (optional) is a type of string
  #     update = timeouts.value["update"]
  #   }
  # }

}