variable "name" {
  description = "The name of the rule collection group"

}


variable "fw_policy_id" {
  description = "The firewall policy ID to which the rule collection group belongs"

}

variable "priority" {
  description = "The priority of the rule collection group"

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