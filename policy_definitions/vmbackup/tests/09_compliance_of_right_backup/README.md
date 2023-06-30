# Test Compliance of right Backup

VMs that are configured with a different backup policy then the tag value of `backup` should be non-compliant.

## Setup

The test requires:

- Policy set definition deployed
- Resource Group named `<TODO: name from Policy>`
  - Recovery Services Vault named `<TODO>`
    - Backup policy named `EnhancedDefault`
- Resource group
  - VM with tag `backup=QbyDefault` deployed to resource group
    - VM configured with backup policy `EnhancedDefault`

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Assign Policy(Initiative).

## Verify

VM marked as non compliant.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`