locals {
  services = ["80", "443", "6443"]
}

terraform {
  required_version = ">= 1.1.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47.0"
    }
  }
}

provider "openstack" {
  use_octavia = true
}

resource "openstack_lb_loadbalancer_v2" "loadbalancer" {
  name               = "${var.cluster_name}-lb"
  description        = "Loadbalancer for the ${var.cluster_name} control plane"
  vip_subnet_id      = var.subnet_id
  security_group_ids = var.security_group_id
}

resource "openstack_lb_listener_v2" "loadbalancer_listener" {
  name            = format("listener_%s", element(local.services, count.index))
  count           = length(local.services)
  protocol        = "TCP"
  protocol_port   = element(local.services, count.index)
  loadbalancer_id = openstack_lb_loadbalancer_v2.loadbalancer.id
}

resource "openstack_lb_pool_v2" "loadbalancer_pool" {
  name        = format("pool_%s", element(local.services, count.index))
  count       = length(local.services)
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.loadbalancer_listener[count.index].id
}

resource "openstack_lb_member_v2" "loadbalancer_members" {
  count         = length(local.services) * var.num_nodes
  pool_id       = openstack_lb_pool_v2.loadbalancer_pool[floor(count.index / var.num_nodes)].id
  protocol_port = local.services[floor(count.index / var.num_nodes)]
  subnet_id     = var.subnet_id
  address       = var.node_ip_addresses[count.index % var.num_nodes]
}

resource "openstack_networking_floatingip_v2" "loadbalancer_fip" {
  pool    = var.floating_ip_pool
  port_id = openstack_lb_loadbalancer_v2.loadbalancer.vip_port_id
}
