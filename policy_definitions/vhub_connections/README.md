# Configure virtual hub connections from virtual networks to virtual wan hub

This policy deploys a vnet connection to a vhub. Tested in the same subscription. Will probably not work and show VNets as non-compliant if vHub is in another subscription.

If the virtual Hub is not in the same subscription as the policy is assigned, make sure that the managed identity of the policy assignment got `Microsoft.Resources/deployments/*` at the resource group of the virtual hub.