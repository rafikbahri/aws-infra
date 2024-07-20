AWS Infra
=========

Overview
--------

This repo contains custom Terraform modules to build AWS infrastructure (EC2, subnet,...)

TODOs
-----

Finish CI:

- set access keys using aws profiles
- test


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2-internal-cluster"></a> [ec2-internal-cluster](#module\_ec2-internal-cluster) | ./modules/aws-node | n/a |
| <a name="module_github-actions-user"></a> [github-actions-user](#module\_github-actions-user) | ./modules/aws-user | n/a |
| <a name="module_internal-subnet"></a> [internal-subnet](#module\_internal-subnet) | ./modules/aws-subnet | n/a |
| <a name="module_main-vpc"></a> [main-vpc](#module\_main-vpc) | ./modules/aws-vpc | n/a |
| <a name="module_sg-admin"></a> [sg-admin](#module\_sg-admin) | ./modules/aws-sg | n/a |
| <a name="module_test"></a> [test](#module\_test) | ./modules/aws-group | n/a |

## Resources

| Name | Type |
|------|------|
| [local_sensitive_file.github-actions-credentials](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for the EC2 instance | `string` | `"ami-0546127e0cf2c6498"` | no |
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Whether to create a key pair or not | `bool` | `true` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name tag for the EC2 instance | `string` | `"ec2-default"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key pair name | `string` | `"key-pair"` | no |
| <a name="input_server_count"></a> [server\_count](#input\_server\_count) | Number of nodes to be created | `number` | `1` | no |
| <a name="input_server_prefix"></a> [server\_prefix](#input\_server\_prefix) | Instance name prefix | `string` | `"ec2"` | no |
| <a name="input_ssh_enabled"></a> [ssh\_enabled](#input\_ssh\_enabled) | Whether SSH access to the instance is enabled or not | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the created EC2 instance |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP of the created EC2 instance |
| <a name="output_secret_access_key"></a> [secret\_access\_key](#output\_secret\_access\_key) | n/a |
<!-- END_TF_DOCS -->