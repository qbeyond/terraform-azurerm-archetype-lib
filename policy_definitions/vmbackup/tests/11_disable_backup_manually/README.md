# Test Disable Backup manually

It shouldn't be possible to disable the backup of a VM manually (not using tag).

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group
- VM with tag `backup=QbyDefault` deployed to resource group
  - VM configured with backup policy `QbyDefault`

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Disable Backup of VM.

## Verify

Backup can't be disabled.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`