# Test Disabled Backup

Test if the Policy 

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Deploy a VM with tag `Backup` and value `Disabled`. 

## Verify

The VM gets deployed and is not assigned to a backup policy.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`