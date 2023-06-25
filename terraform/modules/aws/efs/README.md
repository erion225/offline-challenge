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