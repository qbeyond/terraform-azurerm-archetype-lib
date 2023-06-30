# Test Category valid

The policy initiative should configure the backup policy based on the value of tag backup of a VM if the tag value is valid.

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Deploy a VM with tag `Backup=QbyDefault` without configured backup to the in *Setup* created resource group. 

## Verify

The VM backup should be configured to backup policy `QbyDefault`.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`