Uses the AVM pattern module Azure Virtual WAN https://registry.terraform.io/modules/Azure/avm-ptn-virtualwan/azurerm/latest
- At the moment I'm using sub-modules to create a firewall policy and rules within the policy, the above module does not support doing that at this time
- At the time of writing this (22nd April 24) the above module does not support the association of firewall policy to the Virtual WAN hub - a PR has been submitted to the module to add this functionality https://github.com/Azure/terraform-azurerm-avm-ptn-virtualwan/pull/53 
- TODO:
    - Add diagram of what this deploys
    - Uage instructions