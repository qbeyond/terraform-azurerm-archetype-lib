# Upgrades

This document includes guidelines what to do to upgrade to a new major version. If not mentioned otherwise, upgrade guides refer to the previous version.

## [Unreleased]

### MMA to AMA

This version moves away from the Microsoft Monitoring Agent to the Azure Monitoring Agent. Therefore you need to check everything related to Monitoring eg.:

- Names of used tables
- Collected Metrics & Logs using new DCRs

To upgrade the Module itself you need to add `linuxDCRs` & `windowsDCRs` to `template_file_variables` of the CAF module call. It should include the DCRs to assign to VMs. If you don't need that, just set it to `[]`.

### Update Management

The Update Management Initiative requires to set at least the `managementSubscriptionId` of the assignment. For any management group using the archetype `qby_msp` add it like this:

```terraform
    "msp" = {
        // ...
      archetype_config = {
        archetype_id   = "qby_msp"
        parameters     = {
          QBY-Deploy-Update-Mgmt = {
            managementSubscriptionId = "1234-12321432-12312432-123234"
          }
        }
      }
    }
```
