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
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID | `string` | n/a | yes |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Autoscaling group maximum size | `number` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Autoscaling group minimum size | `number` | `1` | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | Specify volumes to attach to the instance besides the volumes specified by the AMI | <pre>list(object({<br>    device_name  = string<br>    no_device    = bool<br>    virtual_name = string<br>    ebs = object({<br>      delete_on_termination = bool<br>      encrypted             = bool<br>      iops                  = number<br>      kms_key_id            = string<br>      snapshot_id           = string<br>      volume_size           = number<br>      volume_type           = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Autoscaling group desired capacity | `number` | `"1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | application name used with in resource names | `string` | n/a | yes |
| <a name="input_extra_iam_policies"></a> [extra\_iam\_policies](#input\_extra\_iam\_policies) | List of additional IAM policies to grant access to EC2 instance | `list(string)` | `[]` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | CIDRs to allow ingress | `list(string)` | `[]` | no |
| <a name="input_ingress_ports"></a> [ingress\_ports](#input\_ingress\_ports) | TCP Ports to allow access | `list(string)` | `[]` | no |
| <a name="input_ingress_security_groups"></a> [ingress\_security\_groups](#input\_ingress\_security\_groups) | List of Security Groups that are allowed to access the application | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance type | `string` | n/a | yes |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | Name of the environment | `string` | n/a | yes |
| <a name="input_subnets_tags_filter"></a> [subnets\_tags\_filter](#input\_subnets\_tags\_filter) | filter to fetch subnet ids | `map(string)` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data for launch template configuration | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | Autoscaling group ID |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group ID |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Autoscaling group ID |
<!-- END_TF_DOCS -->