# Test Change BackupPolicy after deployment via Tag

If the `backup` tag value is changed to a valid value, the backup should be configured to the new backup policy.

## Setup

The test requires:

- Policy set definition deployed
- Resource Group named `<TODO: name from Policy>`
  - Recovery Services Vault named `<TODO>`
    - Backup policy named `QbyDefault`
- Resource group
  - VM with tag `backup=QbyDefault` deployed to resource group
    - VM configured with backup policy `QbyDefault`

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/).

## Exercise

Change value of tag `Backup` to `EnhancedPolicy`.


## Verify (TBD)

VM is assigned Backup Policy `EnhancedPolicy`.

## Cleanup

- Delete Resource Group created in *Setup*
- Delete Resource Group `TODO: Add name here` created by Policy
- Run `terraform destroy` in `./setup`