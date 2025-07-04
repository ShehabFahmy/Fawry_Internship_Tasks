resource "local_file" "ansible_inventory_file_creation" {
  content  = <<-EOT
    [all:vars]
    ansible_user = ubuntu

    [controlplanes]
    controlplane ansible_host=${module.compute.instances_public_ips[0]} private_ip=${module.compute.instances_private_ips[0]}

    [workers]
    %{for idx, ip in module.compute.instances_public_ips}
    %{if idx != 0}
    worker${idx} ansible_host=${ip}
    %{endif}
    %{endfor}
  EOT
  filename = "${path.module}/../Ansible/inventory.ini"
}

resource "local_file" "ansible_cfg_file_creation" {
  content  = <<-EOT
    [defaults]
    inventory = inventory.ini
    private_key_file = ${path.cwd}/${module.key-pair.key-name}.pem
    host_key_checking = False
    vault_password_file = ${path.module}/../Ansible/Secrets/vault_pass.txt
  EOT
  filename = "${path.module}/../Ansible/ansible.cfg"
}

output "worker_node_public_ip" {
  value = module.compute.instances_public_ips[1]
}
