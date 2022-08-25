/**
  * Outputs
  */
# output "kubernetes_master_public_ip" {
#   value = join(",", aws_spot_instance_request.master.*.public_ip)
# }
# output "kubernetes_workers_public_ip" {
#   value = join(",", aws_spot_instance_request.worker.*.public_ip)
# }
# output "master_ssh_command" {
#   value = format("ssh -i %s/%s ubuntu@%s", var.ssh_key_path, var.ssh_key_name, aws_spot_instance_request.master.0.public_ip)
# }

/**
  * Provision Ansible Inventory
  */
resource "null_resource" "tc_instances" {
  provisioner "local-exec" {
    command = <<EOD
    cat <<EOF > kube_hosts
[kubemaster]
master ansible_host="${aws_instance.master[0].public_ip}" ansible_user=ubuntu ansible_ssh_private_key_file=../terraform/key
[kubeworkers]
worker1 ansible_host="${aws_instance.worker[0].public_ip}" ansible_user=ubuntu ansible_ssh_private_key_file=../terraform/key
EOF
EOD
  }
}
