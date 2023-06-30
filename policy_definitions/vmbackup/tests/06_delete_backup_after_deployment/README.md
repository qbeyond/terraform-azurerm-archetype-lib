# Test Delete Backup Test after deployment

Test if the Policy has a tag that can't be deleted.

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Delete tag `Backup`.

## Verify

Tag can't be deleted.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`