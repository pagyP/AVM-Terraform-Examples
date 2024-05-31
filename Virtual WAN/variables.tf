variable "priority" {
  description = "The priority of the rule collection group"
  default = 200

}

variable "rule_collection_group_name" {
  description = "The name of the rule collection group"
  default     = "lab-rule-collection-group"
  type        = string
}


variable "application_rule_collection" {
  description = "nested block: NestingSet, min items: 0, max items: 0"
  type = set(object(
    {
      action   = string
      name     = string
      priority = number
      rule = set(object(
        {
          destination_fqdn_tags = set(string)
          destination_fqdns     = set(string)
          name                  = string
          protocols = set(object(
            {
              port = number
              type = string
            }
          ))
          source_addresses = set(string)
          source_ip_groups = set(string)
        }
      ))
    }
  ))
  default = []
}

variable "nat_rule_collection" {
  description = "nested block: NestingSet, min items: 0, max items: 0"
  type = set(object(
    {
      action   = string
      name     = string
      priority = number
      rule = set(object(
        {
          destination_address = string
          destination_ports   = set(string)
          name                = string
          protocols           = set(string)
          source_addresses    = set(string)
          source_ip_groups    = set(string)
          translated_address  = string
          translated_port     = number
        }
      ))
    }
  ))
  default = []
}

variable "network_rule_collection" {
  description = "nested block: NestingSet, min items: 0, max items: 0"
  type = set(object(
    {
      action   = string
      name     = string
      priority = number
      rule = set(object(
        {
          destination_addresses = set(string)
          destination_fqdns     = set(string)
          destination_ip_groups = set(string)
          destination_ports     = set(string)
          name                  = string
          protocols             = set(string)
          source_addresses      = set(string)
          source_ip_groups      = set(string)
        }
      ))
    }
  ))
  default = []
}

# variable "fw_policy_tags" {
#   type = map(any)
# }

variable "threat_intelligence_allowlist" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      fqdns        = set(string)
      ip_addresses = set(string)
    }
  ))
  default = []
}