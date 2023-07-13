# Tests Virtual Hub Connections

Tests are following the four phase model Setup, Exercise, Verify, Cleanup. A test may be manual, automated or a mix of both. In any case the README.md in each test folder contains a textual description of any phase and a general overview, what the test verifies.

## Test ARM template

The ARM template used in the Deploy if not Exist policy should deploy a VNet connection between an existing VNet and existing virtual Hub.

### Setup

The test requires:

- Resource group
- virtual WAN
- virtual Hub
- virtual network

The test is automatically setup in *Exercise*.

### Exercise

Deploy ARM template to resource group. 

To set up and exercise the test run `terraform apply` in (`./ARM`)[./ARM]

### Verify

ARM template deployed successfully and connection created.

## Cleanup

- run `terraform destroy` or just delete the Resource Group created in *Setup*

## Test connection creation in same Resource Group

The policy should deploy a VNet connection to the virtual hub, if a new VNet is deployed.

### Setup

The test requires:

- Resource group
- virtual WAN
- virtual Hub
- Policy definition deployed and assigned to resource group

To set up the test environment run `terraform apply` in subfolder [`setup`](./setup/) with `assign_policy=true` and `deploy_virtual_network=false`.

Wait a bit, until you are sure the policy is successfully assigned.

### Exercise

Deploy a VNet to the in *Setup* created resource group. 

You can deploy the VNet by run `terraform apply` in subfolder [`setup`](./setup/) with `assign_policy=true` and `deploy_virtual_network=true`.

### Verify

A VNet connection should be created between the VNet and virtual Hub.

## Cleanup

- run `terraform destroy`