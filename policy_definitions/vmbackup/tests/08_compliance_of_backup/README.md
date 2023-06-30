# Test Compliance of Backups

VMs that have no backup configured should be marked non compliant.

## Setup

The test requires:

- Resource group
- Policy set definition deployed
- VM with tag `backup=QbyDefault` deployed to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Assign Policy(Initiative).

## Verify

VM marked as non compliant.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`