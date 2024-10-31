resource "null_resource" "wait_for_instance" {
  depends_on = [aws_ssm_parameter.k3s_config, aws_instance.prod-ec2-bastion, aws_instance.prod-ec2-k3s-cluster-allinone]
  provisioner "local-exec" {
    command = "sleep 60" # Adjust the duration as needed
  }
}

resource "null_resource" "put_k3s_config_scp" {
  depends_on = [aws_ssm_parameter.k3s_config, aws_instance.prod-ec2-bastion, aws_instance.prod-ec2-k3s-cluster-allinone, null_resource.wait_for_instance]
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.prod-ec2-k3s-cluster-allinone.private_ip
      user        = "admin"
      private_key = var.ssh_privkey_file

      bastion_host        = aws_instance.prod-ec2-bastion.public_ip
      bastion_user        = "admin"
      bastion_private_key = var.ssh_privkey_file
    }

    inline = [
      "echo '${aws_ssm_parameter.k3s_config.value}' | sudo tee /etc/rancher/k3s/k3s.yaml",
      "sudo systemctl restart k3s.service"
    ]

  }


}

resource "aws_ssm_parameter" "k3s_config" {
  depends_on = [aws_instance.prod-ec2-bastion, aws_instance.prod-ec2-k3s-cluster-allinone]
  name       = "/k3s/cluster/config"
  type       = "SecureString"
  value      = <<EOF
    # /etc/rancher/k3s/config.yaml
    tls-san:
      - ${aws_instance.prod-ec2-k3s-cluster-allinone.public_ip}
    node-ip: ${aws_instance.prod-ec2-k3s-cluster-allinone.public_ip}
    # Node Configuration
    node-name: "k3s-addinone-node"         # Custom name for this node
    apiVersion: v1
    clusters:
    - cluster:
        server: https://${aws_instance.prod-ec2-k3s-cluster-allinone.public_ip}:6443
        certificate-authority-data: ${var.k3s_cluster_ca_certificate}
      name: k3s
    contexts:
    - context:
        cluster: k3s
        user: k3s-admin
      name: k3s-context
    current-context: k3s-context
    kind: Config
    preferences: {}
    users:
    - name: k3s-admin
    user:
      client-certificate-data: ${var.k3s_client_certificate}
      client-key-data: ${var.k3s_client_key}
  EOF
}

