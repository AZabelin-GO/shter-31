## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.15.0)

## Providers

The following providers are used by this module:

- <a name="provider_yandex"></a> [yandex](#provider\_yandex)

## Modules

No modules.

## Resources

The following resources are used by this module:

- yandex_vpc_network.this (resource)
- yandex_vpc_subnet.this (resource)

## Required Inputs

The following input variables are required:

### <a name="input_env_name"></a> [env\_name](#input\_env\_name)

Description: Name of the environment (will be used as prefix for resources names)

Type: `string`

### <a name="input_subnet_v4_cidr_blocks"></a> [subnet\_v4\_cidr\_blocks](#input\_subnet\_v4\_cidr\_blocks)

Description: CIDR blocks for subnet

Type: `list(string)`

### <a name="input_zone"></a> [zone](#input\_zone)

Description: Availability zone

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_network"></a> [network](#output\_network)

Description: Network resource

### <a name="output_subnet"></a> [subnet](#output\_subnet)

Description: Subnet resource
