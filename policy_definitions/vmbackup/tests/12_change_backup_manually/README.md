# Test Change Backup manually

Test if the Policy 

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change BackupPolicy of VM to `EnhancedPolicy`.

## Verify

BackupPolicy can't be changed.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`