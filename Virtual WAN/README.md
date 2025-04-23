

# Azure Virtual WAN
-
  

Uses the following modules from Azure Verified Modules https://aka.ms/avm:

- https://registry.terraform.io/modules/Azure/avm-ptn-virtualwan/azurerm/latest

- https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest
- 
- https://registry.terraform.io/modules/Azure/avm-res-network-firewallpolicy/azurerm/latest

Deploys the following resources:
- 1 x Virtual WAN
- 1 x Virtual Hub
- 1 x Virtual Network
- 1 x Firewall Policy
- 1 x Firewall
- 1 x Firewall Policy Association
- 1 x Firewall Policy Rule Collection Group
- 1 x Firewall Policy Rule Collection


- Can optionally deploy more than one 1 virtual wan hub and/or firewall.  Currently in the code but commented out, purely for cost reasons.  If you want to deploy more than one, uncomment the code.