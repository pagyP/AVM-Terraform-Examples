# variable "name" {
#   description = "The name of the Firewall connection"

# }

# variable "location" {
#   description = "The location/region where the firewall and pip will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"

# }

# variable "resource_group_name" {
#   description = "Default resource group name that the firewall and pip will be created in."
#   default     = "myapp-rg"
# }

# variable "tags" {
#   description = "Tags to be applied to the firewall and pip"
#   type        = map
# }


# variable "firewall_policy_config" {
#   description = "Manages an Azure Firewall configuration"
#   type = object({
#     name                                       = string
#     threat_intelligence_mode                   = optional(string)
#     private_ip_ranges                          = optional(list(string))
#     dns_proxy_enabled                          = optional(bool)
#     dns_servers                                = optional(list(string))
#     threat_intelligence_allowlist_fqdns        = optional(list(string))
#     threat_intelligence_allowlist_ip_addresses = optional(list(string))
#     intrusion_detection_mode                   = optional(string)
#     sku                                        = optional(string)
#   })
# }

# variable "premium" {
#   description = "Premium tier"
#   default     = false
#   type        = bool

# }

variable "base_policy_id" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "location" {
  description = "(required)"
  type        = string
}

variable "name" {
  description = "(required)"
  type        = string
}

variable "resource_group_name" {
  description = "(required)"
  type        = string
}

variable "sku" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "(optional)"
  type        = map(any)
  default     = null
}

variable "threat_intelligence_mode" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "dns" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = set(object(
    {
      #network_rule_fqdn_enabled = bool
      proxy_enabled = bool
      servers       = set(string)
    }
  ))
  default = []
}

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

variable "timeouts" {
  description = "nested block: NestingSingle, min items: 0, max items: 0"
  type = set(object(
    {
      create = string
      delete = string
      read   = string
      update = string
    }
  ))
  default = []
}