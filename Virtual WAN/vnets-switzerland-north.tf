


resource "azurerm_resource_group" "switzerland-vnets-rg" {
  name     = "switzerland-north-vnets-rg"
  location = "switzerland north"

}

module "swin-vnet-001" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.2.3"
  resource_group_name = azurerm_resource_group.switzerland-vnets-rg.name
  location            = azurerm_resource_group.switzerland-vnets-rg.location
  name                = "vnet-swin-001"
  address_space       = ["172.16.100.0/24"]
  subnets = {
    subnet0 = {
      name             = "${module.naming.subnet.name_unique}0"
      address_prefixes = ["172.16.100.0/27"]
    }
  }
}

