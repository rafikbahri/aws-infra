<!-- BEGIN_TF_DOCS -->
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
| [aws_iam_access_key.access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices | `bool` | `false` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the user | `string` | `"/"` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of policy ARNs to attach to the user | `list(string)` | `[]` | no |
| <a name="input_username"></a> [username](#input\_username) | IAM user name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The access key ID |
| <a name="output_secret_access_key"></a> [secret\_access\_key](#output\_secret\_access\_key) | The secret access key. This will be written to the state file in plain-text |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | The ARN assigned by AWS for this user |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The name of the IAM user |
<!-- END_TF_DOCS -->