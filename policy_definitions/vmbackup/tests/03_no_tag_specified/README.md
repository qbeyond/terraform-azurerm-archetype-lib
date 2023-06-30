# Test No Tag Specified

VMs without a tag `backup` should be assigned to the backup policy `QbyDefault`.

## Setup

The test requires:

- Resource group
- Policy set definition deployed and assigned to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Deploy a VM without tag `Backup` without configured backup to the in *Setup* created resource group. 

## Verify

The VM backup should be configured to backup policy `QbyDefault`.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`