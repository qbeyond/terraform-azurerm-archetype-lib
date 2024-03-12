# Tests

Tests in this repository are automated using terraform test feature when possible. If not possible (or reasonable) tests are written as text.

## Policy Deploy Maintenance configuration & assignment

To test this policy, we should validate, that existing Vms are not compliant and new Vms are automatically onboarded to Update management. We validate this first in a single subscription to avoid the need for two subscriptions/managementgroup. This is only the minumum test, please validate, that the policy also works when assigned to a management group and deploying the maintenance configurations to another subscription

1. Define two Severity Groups (eg. `01-first-monday-1000-csu-reboot` & `02-second-friday-2000-csu-reboot`)
2. Create resource group (`rg-TestUpdateManagementPolicyManagement-dev-01`) to contain the maintenance configurations
3. Validate, that no maintenance configurations or configuration assignments for the chosen Severity groups exist
4. Create resource group (`rg-TestUpdateManagementPolicy-dev-01`) to contain the test VMs
5. Create VM in new resource group with tag `Severity Group Monthly=01-first-monday-1000-csu-reboot`
6. Assign the policy Subscription
7. validate, that the VM is not compliant
8. Create VM in new resource group with tag `Severity Group Monthly=02-second-friday-2000-csu-reboot`
9. Validate that the VM is compliant
10. Validate that maintenance configuration `02-second-friday-2000-csu-reboot` exists in management resource group
11. Validate that configuration assignment `02-second-friday-2000-csu-reboot` exists at subscription level
12. CHange tag of the VM to `02-second-friday-2000-csu-reboot`
13. validate that it is assigned to the correct maintenance configuration
14. optionally: remediate first Vm & validate compliance and new resources

~~The first 7 steps are automated by running `terraform test`.~~ Test currently unsuccessful.
