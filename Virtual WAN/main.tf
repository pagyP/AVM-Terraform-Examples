

# resource azurerm_resource_group "vwan-rg" {
#     name     = "pp-vwan-rg"
#     location = "Switzerland North"
#   }
 
module "vwan_with_vhub" {
  source                         = "Azure/avm-ptn-virtualwan/azurerm"
  version = "0.4.0"
  resource_group_name            = "pp-vwan-rg"
  create_resource_group = true
  location                       = "Switzerland North"
  virtual_wan_name               = "pp-vwan-01"
  disable_vpn_encryption         = false
  allow_branch_to_branch_traffic = true
  //bgp_community                  = "12076:51010"
  type                           = "Standard"
  virtual_wan_tags = {
    environment = "dev"
    deployment  = "terraform"
  }
  virtual_hubs = {
    swin-vhub = {
      name           = "swin_vhub"
      location       = "Switzerland North"
      resource_group = "pp-vwan-rg"
      hub_routing_preference = "ASPath"
      address_prefix = "10.100.10.0/24"
      
      tags = {
        "location" = "SWIN"
      }
    }
  }
  # vpn_gateways = {
  #   "swin-vhub-vpn-gw" = {
  #     name            = "swin-vhub-vpn-gw"
  #     virtual_hub_key = "swin-vhub"
  #   }
  # }
  # vpn_sites = {
  #   "swin-vhub-vpn-site" = {
  #     name            = "swin-vhub-vpn-site"
  #     virtual_hub_key = "swin-vhub"
  #     links = [{
  #       name          = "link1"
  #       provider_name = "Cisco"
  #       bgp = {
  #         asn             = 65001
  #         peering_address = "172.16.1.254"
  #       }
  #       ip_address    = "20.28.182.157"
  #       speed_in_mbps = "20"
  #     }]
  #   }
  # }
  # vpn_site_connections = {
  #   "onprem1" = {
  #     name                = "swin-vhub-vpn-conn01"
  #     vpn_gateway_key     = "swin-vhub-vpn-gw"
  #     remote_vpn_site_key = "swin-vhub-vpn-site"

  #     vpn_links = [{
  #       name                                  = "link1"
  #       bandwidth_mbps                        = 10
  #       bgp_enabled                           = true
  #       local_azure_ip_address_enabled        = false
  #       policy_based_traffic_selector_enabled = false
  #       ratelimit_enabled                     = false
  #       route_weight                          = 1
  #       shared_key                            = random_password.vpnpsk.result
  #       vpn_site_link_number                  = 0
  #     }]
  #   }
  # }

  

  firewalls = {
  "swin-vhub-firewall" = {
    name            = "swin-vhub-firewall"
    virtual_hub_key = "swin-vhub"
    location        = "Switzerland North"
    resource_group  = "pp-vwan-rg"
    sku_name             = "AZFW_Hub"
    sku_tier        = "Standard"
    firewall_policy_id = module.fwpolicy.fw_policy_id
    tags = {
      "location" = "SWIN"
    }
  }
}

routing_intents = {
    "swin-vhub-routing-intent" = {
      name            = "swin-routing-intent"
      virtual_hub_key = "swin-vhub"
      routing_policies = [
        {
        name                  = "swin-vhub-routing-policy-private"
        destinations          = ["Internet"]
        next_hop_firewall_key = "swin-vhub-firewall"
        },
        {
        name                  = "swin-vhub-routing-policy-internet"
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = "swin-vhub-firewall"
        }
      ]
     
    }
  }

  
}
