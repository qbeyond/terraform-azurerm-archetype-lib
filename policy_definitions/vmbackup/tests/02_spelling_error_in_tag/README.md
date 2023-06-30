# Test Spelling Error in Tag

Only VMs with a valid tag value (`Default`, `QbyDefault`, `EnhancedDefault`) for `backup` should be able to deploy, if one is provided.

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Deploy a VM with tag `Backup=NotQbyDefault` without configured backup to the in *Setup* created resource group. 

## Verify

The VM can't be deployed.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`