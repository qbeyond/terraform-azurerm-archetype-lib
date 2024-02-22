# Test Update Management Policies

## Policy Deploy Maintenance configuration & assignment

To create the test environment run `terraform apply`. This will deploy two resource groups, policy definition & assignment and a VM. The VM will be deployed before the policy, so the VM should be `notCompliant`. This is verified by the code. 

After the initial deployment, create a remediation task to make the VM compliant.