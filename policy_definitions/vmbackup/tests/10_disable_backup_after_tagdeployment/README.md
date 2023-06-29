# Test Disable BackUp after deployment via tag

Test if the Policy 

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change value of Tag `Backup` to `Disabled`. 

## Verify (TBD)

VM is not backed up (This needs to be verified). 

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`