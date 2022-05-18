# terraform-module-lb

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| openstack | ~> 1.35.0 |

## Providers

| Name | Version |
|------|---------|
| openstack | ~> 1.35.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [openstack_lb_listener_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_listener_v2) |
| [openstack_lb_loadbalancer_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_loadbalancer_v2) |
| [openstack_lb_member_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_member_v2) |
| [openstack_lb_pool_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_pool_v2) |
| [openstack_networking_floatingip_v2](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_v2) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the cluster | `string` | `"cluster"` | no |
| floating\_ip\_pool | The pool from which floating IP addresses should be allocated | `string` | `""` | no |
| internal\_services | n/a | `list(string)` | <pre>[<br>  "80",<br>  "443",<br>  "6443"<br>]</pre> | no |
| network\_id | The network ID in which the loadbalancer should sit | `string` | `""` | no |
| node\_ip\_addresses | n/a | `list(string)` | `[]` | no |
| num\_nodes | n/a | `string` | `""` | no |
| security\_group\_id | The security groups (firewall rules) that will be applied to this loadbalancer | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| subnet\_id | The subnet ID in which lb members should reside | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| public\_ip | Public IP address of the load balancer used to access services |
