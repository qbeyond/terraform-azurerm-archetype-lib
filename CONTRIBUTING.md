# Contribute

Thank you for contributing!

Please read this document and follow it to adhere to our standards.

## Testing

When you contribute to this repository, make sure that you check the [Tests](tests\README.md). Create or change tests as needed.

## Writing Policies

When writing policies, include an `Effect` parameter to allow the user to choose the effect as needed without the need for another policy definition.

```json
//...
"parameters": {
    "effect": {
        "type": "string",
        "defaultValue": "Deny", //or DeployIfNotExists
        "allowedValues": [
            "Audit", // or AuditIfNotExists
            "Deny", // or DeployIfNotExists
            "Disabled"
        ],
        "metadata": {
            "displayName": "Effect",
            "description": "The effect determines what happens when the policy rule is evaluated to match"
        }
    }
},
//...
"policyRule": {
    //...
    "then": {
        "effect": "[parameters('effect')]"
    }
}
```

### Policies for VMs

A Policy applying to VMs should also target Scale Sets and Arc machines, if similar enough. 

A policy applying to VMs, Scale Sets or Arc machines should target Linux & Windows machine in the same policy, if it is similar enough. Then there should be the following parameters to filter specific OS and/or types:

```json
"parameters": {
         "osTypeArc": {
             "type": "String",
             "metadata": {
                 "displayName": "OS type Arc machines included",
                 "description": "Filter Arc machines by osType. None excludes arc machines. All includes any Arc machine."
             },
             "defaultValue": "All",
             "allowedValues": [
               "All",
               "Windows",
               "Linux",
               "None"
           ]
         },
         "osOffers": {
             "type": "Array",
             "metadata": {
                "displayName": "OS offers included",
                 "description": "Include only offers of Azure VMs and Scale sets like specified strings. Can contain * as wildcard. ['*'] includes any offer. Use an empty array [] to exclude Azure VMs and scale sets."
             },
             "defaultValue": [
               "*"
             ]
         },
        "osSKUs": {
            "type": "Array",
            "metadata": {
               "displayName": "OS SKUs included",
               "description": "Include only OS SKUs of Azure VMs and Scale sets like specified strings. Can contain * as wildcard. ['*'] includes any SKU. Use an empty array [] to exclude Azure VMs and scale sets."
            },
            "defaultValue": [
               "*"
            ]
         }
     }
```

You can use the following filter as a basic implementation:

```json
"if": {
"anyOf": [
    {
        "allOf": [
            {
            "field": "type",
            "equals": "Microsoft.HybridCompute/machines"
            },
            {
            "anyOf": [
                {
                    "field": "Microsoft.HybridCompute/machines/osType",
                    "like": "[parameters('osTypeArc')]"
                },
                {
                    "value": "[parameters('osTypeArc')]",
                    "equals": "All"
                }
            ]
            }
        ]
    },
    {
        "allOf": [
            {
            "anyOf": [
                {
                    "field": "type",
                    "equals": "Microsoft.Compute/virtualMachines"
                },
                {
                    "field": "type",
                    "equals": "Microsoft.Compute/virtualMachineScaleSets"
                }
            ]
            },
            {
            "count": {
                "name": "offerPattern",
                "value": "[parameters('osOffers')]",
                "where": {
                    "field": "Microsoft.Compute/ImageOffer",
                    "like": "[current('offerPattern')]"
                }
            },
            "greater": 0
            },
            {
            "count": {
                "name": "skuPattern",
                "value": "[parameters('osSKUs')]",
                "where": {
                    "field": "Microsoft.Compute/ImageSKU",
                    "like": "[current('skuPattern')]"
                }
            },
            "greater": 0
            }
        ]
    }
]
}
```

Using such a filter might result in a deployment that wants to target different resource types. Consider a policy that will either deploy a `Microsoft.Compute/virtualMachines/extensions` or `Microsoft.Compute/virtualMachineScaleSets/extensions`. This requires setting the `effect.details.type` so that it matches the evaluated resource. Sadly it's not possible to simply use `[concat(field('type'), '/extensions')` to decide the needed resource type as you will get the error `InvalidPolicyRuleIfNotExistsDetails`. This is because Azure will consider every possible resource type (including invalid ones) when validating the assignment. To avoid this, filter your allowed types like such:
```
"type": "[if(contains(createArray('Microsoft.Compute/virtualMachines', 'Microsoft.Compute/virtualMachineScaleSets'), field('type')), field('type'), 'Microsoft.Resources/resourceGroups')]"
```
The type `Microsoft.Resources/resourceGroups` is used here to represent an invalid state. This should never happen if your policy rule is written correctly and will cause the deployment to fail resulting in a non-compliant resource.

Do not filter by `Microsoft.Compute/virtualMachines/storageProfile.osDisk.osType`, as it is an [autogenerated property](https://github.com/Azure/azure-policy#optional-or-auto-generated-resource-property-that-bypasses-policy-evaluation) and bypasses policy evaluation on creation.