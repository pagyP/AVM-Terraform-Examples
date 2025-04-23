resource "azurerm_resource_group" "franc-vnets-rg" {
  name     = "france-central-vnets-rg"
  location = "France Central"

}

module "franc-vnet-001" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.2.3"
  resource_group_name = azurerm_resource_group.franc-vnets-rg.name
  location            = azurerm_resource_group.franc-vnets-rg.location
  name                = "vnet-franc-001"
  address_space       = ["172.16.150.0/24"]
  subnets = {
    subnet0 = {
      name             = "${module.naming.subnet.name_unique}0"
      address_prefixes = ["172.16.150.0/27"]
    }
  }
}