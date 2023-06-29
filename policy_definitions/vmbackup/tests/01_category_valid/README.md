# Test Category valid

Test if the Policy configures Backup for a VM.

## Setup

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Deploy a VM with tag `Backup=QbyDefault` without configured backup to the in *Setup* created resource group. 

## Verify

The VM backup should be configured to backup policy `QbyDefault`.

# Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`