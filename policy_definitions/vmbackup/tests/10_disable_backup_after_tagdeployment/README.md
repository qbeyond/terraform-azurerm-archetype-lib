# Test Disable BackUp after deployment via tag

It should be possible to disable the backup of a VM after the deployment via tag.

## Setup

The test requires:

- Policy set definition deployed
- Resource Group named `<TODO: name from Policy>`
  - Recovery Services Vault named `<TODO>`
    - Backup policy named `EnhancedDefault`
- Resource group
  - Policy set definition assigned to resource group
  - VM with tag `backup=QbyDefault` deployed to resource group
    - VM configured with backup policy `QbyDefault`

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change value of Tag `Backup` to `Disabled`. 

## Verify (TBD)

VM is not backed up (This needs to be verified). 

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`