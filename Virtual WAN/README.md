

# Azure Virtual WAN
- TODO:
    - Add diagram of what this deploys
    - Uage instructions
    - Remove hard coded values and replace with variables/locals
    - Swap my modules for Azure Verified Modules
    - Add virtual machines in spoke vnets
    - Add shared vnet for DNS resolver
    - Add shared vnet for Azure Bastion
  

Uses the following modules from Azure Verified Modules https://aka.ms/avm:

- https://registry.terraform.io/modules/Azure/avm-ptn-virtualwan/azurerm/latest

- https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest

Uses modules that I have written myself:

Azure Firewall Policy 
Azure Firewall Rule Collection Group