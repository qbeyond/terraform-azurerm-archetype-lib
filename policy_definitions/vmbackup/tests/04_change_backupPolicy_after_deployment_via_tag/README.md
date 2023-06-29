# Test Change BackupPolicy after deployment via Tag



## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change value of tag `Backup` to `EnhancedPolicy`.


## Verify (TBD)

VM is assigned Backup Policy `EnhancedPolicy`.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`