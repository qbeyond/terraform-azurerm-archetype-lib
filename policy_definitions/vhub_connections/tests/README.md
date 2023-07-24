# Tests Virtual Hub Connections

Tests are following the four phase model Setup, Exercise, Verify, Cleanup. A test may be manual, automated or a mix of both. In any case the README.md in each test folder contains a textual description of any phase and a general overview, what the test verifies.

## 1 Test ARM template

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

To set up and exercise the test run `terraform apply` in (`./1_ARM`)[./1_ARM]

### Verify

ARM template deployed successfully and connection status is `Connected`. This is automatically checked by terraform if `exercise=true`.

## Cleanup

- run `terraform destroy` or just delete the Resource Group created in *Setup*

## 2 Test connection creation in Resource Group

The policy should deploy a VNet connection to the virtual hub, if a new VNet is deployed.

### Setup

The test requires:

- Resource group
  - virtual WAN
  - virtual Hub
  - Policy definition deployed and assigned to resource group

To set up the test environment run `terraform apply -target module.setup_hub.azurerm_resource_group.this` first (Due to a poorly implemented module used to assign the policy) in subfolder [`./2_resource_group`](./2_resource_group) with `exercise=false`. Afterwards run `terraform apply` with same inputs.

Wait a bit, until you are sure the policy is successfully assigned by running the outputted command.

### Exercise

Deploy a VNet to the in *Setup* created resource group. 

You can deploy the VNet by run `terraform apply` in subfolder [`./2_resource_group`](./2_resource_group) with `exercise=true`.

### Verify

A VNet connection should be created between the VNet and virtual Hub and connection status is `Connected`. This is automatically checked by terraform if `exercise=true`.

The vNet is `compliant`.

## Cleanup

- run `terraform destroy`

## 3 Test connection creation in Subscription

The policy should deploy a VNet connection to the virtual hub in another resource group, if a new VNet is deployed.

### Setup

The test requires:

- Resource group 1
  - virtual WAN
  - virtual Hub
- Resource group 2
- Policy definition deployed and assigned to subscription

To set up the test environment run `terraform apply -target module.setup_hub.azurerm_resource_group.this` first (Due to a poorly implemented module used to assign the policy) in subfolder [`./3_subscription`](./3_subscription) with `exercise=false`. Afterwards run `terraform apply` with same inputs.

Wait a bit, until you are sure the policy is successfully assigned by running the outputted command.

### Exercise

Deploy a VNet to the in *Setup* created resource group. 

You can deploy the VNet by run `terraform apply` in subfolder [`./3_subscription`](./3_subscription) with `exercise=true`.

### Verify

A VNet connection should be created between the VNet and virtual Hub and connection status is `Connected`. This is automatically checked by terraform if `exercise=true`.

The vNet is `compliant`.

## Cleanup

- run `terraform destroy`

## 3 Test connection creation in different subscription

The policy should deploy a VNet connection to the virtual hub in another subscription, when a new VNet is deployed.

### Setup

The test requires:

- Resource group in Subscription A
  - virtual WAN
  - virtual Hub
- Resource group in Subscription B
  - Policy definition deployed and assigned to resource group
  - Managed Identity with role `Network Contributor` in ResourceGroup of Subscription A

To set up the test environment run `terraform apply` in subfolder [`3_different_subscriptions`](./3_different_subscriptions/) with `exercise=false` and `subscription_id_hub` to another subscription id then shown in `az account show`.

Wait a bit, until you are sure the policy is successfully assigned by running the outputted command.

### Exercise

Deploy a VNet to the in *Setup* created resource group. 

You can deploy the VNet by run `terraform apply` in subfolder [`3_different_subscriptions`](./3_different_subscriptions/) with `exercise=false` and `subscription_id_hub` same as in Setup.

### Verify

A VNet connection should be created between the VNet and virtual Hub and connection status is `Connected`. This is automatically checked by terraform if `exercise=true`.

The vNet is `compliant`.

### Cleanup

- run `terraform destroy`

## 4 Connection creation in different subscription under same assignment to management group

The policy should deploy a VNet connection to the virtual hub in another subscription under the same management group where the policy is assigned, when a new VNet is deployed.

### Setup

The test requires:

- Resource group in Subscription A
  - virtual WAN
  - virtual Hub
- Resource group in Subscription B
- Management Group
  - Subscription A & B as a child
  - Policy definition deployed and assigned to management group
  - Managed Identity with role `Network Contributor` in at management group

To set up the test environment run `terraform apply -target azurerm_management_group.this` in subfolder [`4_management_group`](./4_management_group/) with `exercise=false` and `subscription_id_hub` to another subscription id then shown in `az account show`. Afterwards run again without `target`.

Wait a bit, until you are sure the policy is successfully assigned by running the outputted command.

### Exercise

Deploy a VNet to the in *Setup* created resource group. 

You can deploy the VNet by run `terraform apply` in subfolder [`3_different_subscriptions`](./3_different_subscriptions/) with `exercise=false` and `subscription_id_hub` same as in Setup.

### Verify

A VNet connection should be created between the VNet and virtual Hub and connection status is `Connected`. This is automatically checked by terraform if `exercise=true`.

The vNet is `compliant`.