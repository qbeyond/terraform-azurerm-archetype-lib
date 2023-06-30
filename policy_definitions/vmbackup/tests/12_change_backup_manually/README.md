# Test Change Backup manually

It shouldn't be possible to change the configured backup policy of a VM manually (not via tags).

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group
- VM with tag `backup=QbyDefault` deployed to resource group
  - VM configured with backup policy `QbyDefault`

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change BackupPolicy of VM to `EnhancedPolicy`.

## Verify

BackupPolicy can't be changed.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`