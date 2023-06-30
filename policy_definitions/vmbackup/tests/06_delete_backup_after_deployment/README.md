# Test Delete Backup Test after deployment

It shouldn't be possible to delete the tag `backup` of a VM.

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group
- VM with tag `backup=QbyDefault` deployed to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Delete tag `Backup`.

## Verify

Tag can't be deleted.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`