

resource "azurerm_firewall_policy_rule_collection_group" "fwrulecollection" {
  firewall_policy_id = var.fw_policy_id
  name               = var.name
  priority           = var.priority

  dynamic "application_rule_collection" {
    for_each = var.application_rule_collection
    content {
      action   = application_rule_collection.value["action"]
      name     = application_rule_collection.value["name"]
      priority = application_rule_collection.value["priority"]
      dynamic "rule" {
        for_each = application_rule_collection.value.rule
        content {
          destination_fqdn_tags = rule.value["destination_fqdn_tags"]
          destination_fqdns     = rule.value["destination_fqdns"]
          name                  = rule.value["name"]
          source_addresses      = rule.value["source_addresses"]
          source_ip_groups      = rule.value["source_ip_groups"]
          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              port = protocols.value["port"]
              type = protocols.value["type"]
            }
          }
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = var.nat_rule_collection
    content {
      action   = nat_rule_collection.value["action"]
      name     = nat_rule_collection.value["name"]
      priority = nat_rule_collection.value["priority"]
      dynamic "rule" {
        for_each = nat_rule_collection.value.rule
        content {
          destination_address = rule.value["destination_address"]
          destination_ports   = rule.value["destination_ports"]
          name                = rule.value["name"]
          protocols           = rule.value["protocols"]
          source_addresses    = rule.value["source_addresses"]
          source_ip_groups    = rule.value["source_ip_groups"]
          translated_address  = rule.value["translated_address"]
          translated_port     = rule.value["translated_port"]
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collection
    content {
      action   = network_rule_collection.value["action"]
      name     = network_rule_collection.value["name"]
      priority = network_rule_collection.value["priority"]
      dynamic "rule" {
        for_each = network_rule_collection.value.rule
        content {
          destination_addresses = rule.value["destination_addresses"]
          destination_fqdns     = rule.value["destination_fqdns"]
          destination_ip_groups = rule.value["destination_ip_groups"]
          destination_ports     = rule.value["destination_ports"]
          name                  = rule.value["name"]
          protocols             = rule.value["protocols"]
          source_addresses      = rule.value["source_addresses"]
          source_ip_groups      = rule.value["source_ip_groups"]
        }
      }
    }
  }
}