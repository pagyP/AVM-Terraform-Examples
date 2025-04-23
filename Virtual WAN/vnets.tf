resource "azurerm_resource_group" "vnetsrg" {
  name     = "vnets-rg"
  location = "australiaeast"
}

module "vnet-aue-east" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.8.1"
  resource_group_name = azurerm_resource_group.vnetsrg.name
  location            = azurerm_resource_group.vnetsrg.location
  name                = "vnet-001"
  address_space       = ["172.16.50.0/24"]
  subnets = {
    subnet0 = {
      name             = "vnet-001-subnet-0"
      address_prefixes = ["172.16.50.0/27"]
    }
  }
}
