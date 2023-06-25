<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | ../../modules/aws/ec2-asg | n/a |
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ../../modules/aws/elb | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../modules/aws/vpc | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/aws/efs | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Autoscaling group maximum size | `number` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Autoscaling group minimum size | `number` | `1` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | environment name | `string` | n/a | yes |
| <a name="input_instance_port"></a> [instance\_port](#input\_instance\_port) | Instance port | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance type | `string` | `"t3.medium"` | no |
| <a name="input_load_balancer_port"></a> [load\_balancer\_port](#input\_load\_balancer\_port) | Load balancer frontend port | `number` | n/a | yes |
| <a name="input_private_subnet1_cidr"></a> [private\_subnet1\_cidr](#input\_private\_subnet1\_cidr) | The IPv4 CIDR block for the private subnet1. | `string` | n/a | yes |
| <a name="input_public_subnet1_cidr"></a> [public\_subnet1\_cidr](#input\_public\_subnet1\_cidr) | The IPv4 CIDR block for the public subnet1. | `string` | n/a | yes |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | Identify and differentiate resource stacks | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The IPv4 CIDR block for the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_url"></a> [jenkins\_url](#output\_jenkins\_url) | Jenkins URL |
<!-- END_TF_DOCS -->