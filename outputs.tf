output "public_ip" {
  description = "Public IP address of the load balancer used to access services"
  value       = openstack_networking_floatingip_v2.loadbalancer_fip.address
}
