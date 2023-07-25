# Configure virtual hub connections from virtual networks to virtual wan hub

This policy deploys a vNet connection to a vHub. If the vHub is in another subscriptions, the vNets will never be compliant, but the vNet connections are nevertheless created.

If the virtual Hub is not in the same subscription as the policy is assigned, make sure that the managed identity of the policy assignment got `Microsoft.Resources/deployments/*` (eg. *Network Contributor*) at the resource group of the virtual hub.

The policy works as expected when assigned in the following scenarios. For other scenarios view the known bugs.

- vNets in the same resource group as vHub 

## Known Bugs

### vNets not compliant although connected

Virtual networks will only marked as compliant when a vNet connection exists in the same Subscription. As vNet Subscriptions are part of the vHub this is only possible if the vNet is in the same subscription as the vHub and vWAN. This is due to the limitation of Azure Policy, that you can only check for existing resources in the same subscription. Remediating these vNets is not a problem (see [Connection deployed although already exist](#connection-deployed-although-already-exist))

### Connection deployed although already exist

The policy may deploy a vNet connection although it already exists. As the connection is deployed through the template in the first place, it has the same properties, as the new deployment. Therefore subsequent deployments aren't changing the resource. 

**If the resource is changed, the changes are overwritten. This may introduce a connection downtime.** 

**Policy to prevent changes is not implemented yet!**