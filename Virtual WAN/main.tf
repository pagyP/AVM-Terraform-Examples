resource "random_pet" "vvan_name" {
  length    = 2
  separator = "-"
}

locals {
  aue_firewall_key        = "aue-vhub-fw"
  aue_firewall_name       = "fw-avm-vwan-${random_pet.vvan_name.id}"
  aue_location            = "australiaeast"
  resource_group_name = "rg-avm-vwan-${random_pet.vvan_name.id}"
  tags = {
    environment = "avm-vwan-testing"
    deployment  = "terraform"
  }
  aue_virtual_hub_key  = "aue-vhub"
  aue_virtual_hub_name = "vhub-avm-vwan-${random_pet.vvan_name.id}"
  virtual_wan_name = "vwan-avm-vwan-${random_pet.vvan_name.id}"
  vwan_location = "australiaeast"

  uks_firewall_key        = "uks-vhub-fw"
  uks_firewall_name       = "uks_fw-avm-vwan-${random_pet.vvan_name.id}"
  uks_location            = "uksouth"
  uks_virtual_hub_key  = "uks-vhub"
  uks_virtual_hub_name = "uks_vhub-avm-vwan-${random_pet.vvan_name.id}"

  vnet_connections = {
    vnet-aue-001 = {
      virtual_network_connection_name = "vnet-conn-vnet-aue-001-connection"
      name                            = "vnet-aue-001-connection"
      virtual_hub_key                 = "aue-vhub"
      remote_virtual_network_id       = module.vnet-aue-east.resource_id
      internet_security_enabled       = false
    }
}
}

module "vwan_with_vhub" {
  source                         = "Azure/avm-ptn-virtualwan/azurerm"
  create_resource_group          = true
  resource_group_name            = local.resource_group_name
  location                       = local.vwan_location
  virtual_wan_name               = local.virtual_wan_name
  disable_vpn_encryption         = false
  allow_branch_to_branch_traffic = true
  type                           = "Standard"
  virtual_wan_tags               = local.tags
  virtual_network_connections    = local.vnet_connections
  virtual_hubs = {
    (local.aue_virtual_hub_key) = {
      name           = local.aue_virtual_hub_name
      location       = local.aue_location
      resource_group = local.resource_group_name
      address_prefix = "10.0.0.0/24"
      hub_routing_preference = "ASPath"
      tags           = local.tags
    }
    # (local.uks_virtual_hub_key) = {
    #   name           = local.uks_virtual_hub_name
    #   location       = local.uks_location
    #   resource_group = local.resource_group_name
    #   address_prefix = "10.5.0.0/24"
    #   hub_routing_preference = "ASPath"
    #   tags           = local.tags
    # }
  }
  
  firewalls = {
    (local.aue_firewall_key) = {
      sku_name        = "AZFW_Hub"
      sku_tier        = "Standard"
      name            = local.aue_firewall_name
      virtual_hub_key = local.aue_virtual_hub_key
      firewall_policy_id = module.firewall_policy.resource.id
    }
    # (local.uks_firewall_key) = {
    #   sku_name        = "AZFW_Hub"
    #   sku_tier        = "Standard"
    #   name            = local.uks_firewall_name
    #   virtual_hub_key = local.uks_virtual_hub_key
    #   firewall_policy_id = module.firewall_policy.resource.id
    # }
  }

  routing_intents = {
    "aue-vhub-routing-intent" = {
      name            = "private-routing-intent"
      virtual_hub_key = local.aue_virtual_hub_key
      routing_policies = [{
        name                  = "aue-vhub-routing-policy-private"
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = local.aue_firewall_key
      },
      {
          name                  = "aue-vhub-routing-policy-public"
          destinations          = ["Internet"]
          next_hop_firewall_key = local.aue_firewall_key
        },
      ]
    }
    # "uks-vhub-routing-intent" = {
    #   name            = "private-routing-intent"
    #   virtual_hub_key = local.uks_virtual_hub_key
    #   routing_policies = [{
    #     name                  = "uks-vhub-routing-policy-private"
    #     destinations          = ["PrivateTraffic"]
    #     next_hop_firewall_key = local.uks_firewall_key
    #   },
    #   {
    #     name                  = "uks-vhub-routing-policy-public"
    #     destinations          = ["Internet"]
    #     next_hop_firewall_key = local.uks_firewall_key
    #   }]
    # }
  }

}


