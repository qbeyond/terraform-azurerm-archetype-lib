# Test Spelling Error while Changing BackupPolicy after deployment via Tag

It shouldn't be possible to change the value of tag `backup` to an invalid value.

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group
- VM with tag `backup=QbyDefault` deployed to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change value of tag `Backup` to `NotEnhancedPolicy`.

## Verify

Tag can't be changed.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`