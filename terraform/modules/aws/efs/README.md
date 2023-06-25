## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.file_system](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.file_system_mount_target_az1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.file_system_mount_target_az2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.file_system_mount_target_az3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_security_group.efs_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_cidrs_to_access_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_security_groups_to_access_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs permitted to access EFS mounts | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | List of Security Group IDs permitted to access EFS mounts | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [application\_name](#input\_application\_name) | application name used with in resource names | `string` | n/a | yes |
| <a name="input_efs_kms_key_id"></a> [efs\_kms\_key\_id](#input\_efs\_kms\_key\_id) | ARN of KMS key to use for EFS encryption (leave null to create a key, set to `aws/backup` to use AWS default CMK) | `string` | `null` | no |
| <a name="input_environment"></a> [environment\_name](#input\_environment\_name) | Name of the environment | `string` | n/a | yes |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | Performance mode to run in (`generalPurpose` or `maxIO`). See https://aws.amazon.com/premiumsupport/knowledge-center/linux-efs-performance-modes/ for details. | `string` | `"generalPurpose"` | no |
| <a name="input_provisioned_throughput"></a> [provisioned\_throughput](#input\_provisioned\_throughput) | Provisioned throughput (in mbps) | `number` | `null` | no |
| <a name="input_subnet_az1"></a> [subnet\_az1](#input\_subnet\_az1) | Subnet ID in AZ1 | `string` | n/a | yes |
| <a name="input_subnet_az2"></a> [subnet\_az2](#input\_subnet\_az2) | Subnet ID in AZ2 | `string` | n/a | yes |
| <a name="input_subnet_az3"></a> [subnet\_az3](#input\_subnet\_az3) | Subnet ID in AZ3 | `string` | n/a | yes |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | EFS file system throughput mode (`provisioned` or `bursting`) | `string` | `"bursting"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs-server-arn"></a> [efs-server-arn](#output\_efs-server-arn) | n/a |
| <a name="output_efs-server-dns-endpoint"></a> [efs-server-dns-endpoint](#output\_efs-server-dns-endpoint) | n/a |
| <a name="output_efs-server-id"></a> [efs-server-id](#output\_efs-server-id) | n/a |
| <a name="output_efs_security_group_id"></a> [efs\_security\_group\_id](#output\_efs\_security\_group\_id) | n/a |

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs permitted to access EFS mounts | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | List of Security Group IDs permitted to access EFS mounts | `list(string)` | `[]` | no |
| <a name="input_efs_kms_key_id"></a> [efs\_kms\_key\_id](#input\_efs\_kms\_key\_id) | ARN of KMS key to use for EFS encryption (leave null to create a key, set to `aws/backup` to use AWS default CMK) | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment | `string` | n/a | yes |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | Performance mode to run in (`generalPurpose` or `maxIO`). See https://aws.amazon.com/premiumsupport/knowledge-center/linux-efs-performance-modes/ for details. | `string` | `"generalPurpose"` | no |
| <a name="input_provisioned_throughput"></a> [provisioned\_throughput](#input\_provisioned\_throughput) | Provisioned throughput (in mbps) | `number` | `null` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | application name used with in resource names | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | subnet ids | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | EFS file system throughput mode (`provisioned` or `bursting`) | `string` | `"bursting"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs-server-arn"></a> [efs-server-arn](#output\_efs-server-arn) | ARN of the EFS file system |
| <a name="output_efs-server-dns-endpoint"></a> [efs-server-dns-endpoint](#output\_efs-server-dns-endpoint) | DNS endpoint of the EFS file system |
| <a name="output_efs-server-id"></a> [efs-server-id](#output\_efs-server-id) | ID of the EFS file system |
| <a name="output_efs_security_group_id"></a> [efs\_security\_group\_id](#output\_efs\_security\_group\_id) | ID of the security group associated with the EFS file system |
<!-- END_TF_DOCS -->