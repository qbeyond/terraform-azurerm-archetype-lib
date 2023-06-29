# Test Disable Backup manually

Test if the Policy 

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Disable Backup of VM.

## Verify

Backup can't be disabled.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`