# Test Spelling Error while Changing BackupPolicy after deployment via Tag

Test if the Policy 

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change value of tag `Backup` to `NotEnhancedPolicy`.

## Verify

Tag can't be changed.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`