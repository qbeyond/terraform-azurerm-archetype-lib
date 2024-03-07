# Upgrades

This document includes guidelines what to do to upgrade to a new major version. If not mentioned otherwise, upgrade guides refer to the previous version.

## [Unreleased]

### MMA to AMA

This version moves away from the Microsoft Monitoring Agent to the Azure Monitoring Agent. Therefore you need to check everything related to Monitoring eg.:

- Names of used tables
- Collected Metrics & Logs using new DCRs

To upgrade the Module itself you need to add `linuxDCRs` to `template_file_variables` of the CAF module call. It should include the DCRs to assign to Linux VMs. If you don't need that, just set it to `[]`.
