# Update Management Policies

The policies for Update Management supporting the following feature currently:

- New VMs
  - Patch settings updated if needed
  - Maintenance configuration created if needed
  - Configuration Assignment created
  - Compliance correctly evaluated
- Remediating existing VMs
  - Patch settings updated if needed
  - Maintenance configuration created if needed
  - Configuration Assignment created or updated if needed
  - Compliance correctly evaluated
- ~~Updating Tags~~
  - Compliance correctly evaluated
  - ~~Patch settings updated if needed~~
  - ~~Maintenance configuration created if needed~~
  - ~~Configuration Assignment created or updated if needed~~

## Decisions

As the List API for COnfiguration Assignments on Subscription Level is not implemented, we decided to use direct assignments instead. Furthermore the Reporting is probably easier. As the direct Configuration Assignment requires the correct patch settings, this is part of the policy definition itself. To Audit for wrongly configured VMs there is still a Policy Defition for the Patch Settings set to Audit mode.

## Tests

Tests are described in a [separate file](../../tests/README.md).
