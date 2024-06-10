output "ansible_inventory" {
  value = templatefile("${path.module}/templates/inventory.tpl", {
    master_nodes = yandex_compute_instance_group.master_nodes_group.instances.*.network_interface.0.nat_ip_address
    worker_nodes = yandex_compute_instance_group.worker_nodes_group.instances.*.network_interface.0.nat_ip_address
  })
}