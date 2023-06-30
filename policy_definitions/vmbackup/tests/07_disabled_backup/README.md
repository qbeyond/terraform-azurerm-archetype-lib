# Test Disabled Backup

It should be possible to not configure backup by setting tag `backup` to `disabled`.

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Deploy a VM with tag `Backup` and value `Disabled`. 

## Verify

The VM gets deployed and is not assigned to a backup policy.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`