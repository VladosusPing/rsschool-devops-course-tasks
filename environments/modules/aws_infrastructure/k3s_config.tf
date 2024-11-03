/*resource "null_resource" "wait_for_instance" {
  depends_on = [aws_ssm_parameter.k3s_config, aws_instance.prod-ec2-bastion, aws_instance.prod-ec2-k3s-cluster-allinone]
  provisioner "local-exec" {
    command = "sleep 60" # Adjust the duration as needed
  }
}

resource "null_resource" "put_k3s_config_scp" {
  depends_on = [aws_ssm_parameter.k3s_config, aws_instance.prod-ec2-bastion, aws_instance.prod-ec2-k3s-cluster-allinone, null_resource.wait_for_instance, random_string.k3s_token]
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
      "mv /etc/rancher/k3s/k3s.yaml /etc/rancher/k3s/k3s.yaml.old",
      "echo '${aws_ssm_parameter.k3s_config.value}' | sudo tee /etc/rancher/k3s/k3s.yaml",
      "sudo systemctl restart k3s.service"
    ]

  }
  triggers = {
    k3s_config_hash = sha256(aws_ssm_parameter.k3s_config.value)
  }
}
*/

resource "aws_ssm_parameter" "k3s_config" {
  depends_on = [random_string.k3s_token, aws_eip.k3s_cluster_eip]
  name       = "/k3s/cluster/config"
  type       = "SecureString"
  value      = <<EOF
    # /etc/rancher/k3s/config.yaml
    tls-san:
      - ${aws_eip.k3s_cluster_eip.public_ip}
    node-ip: ${aws_eip.k3s_cluster_eip.public_ip}
    # Node Configuration
    node-name: "k3s-addinone-node"         # Custom name for this node
    token: "${local.k3s_token}"
    apiVersion: v1
    clusters:
    - cluster:
        server: https://${aws_eip.k3s_cluster_eip.public_ip}:6443
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

resource "random_string" "k3s_token" {
  length  = 32
  special = false
  upper   = false
}

resource "aws_ssm_parameter" "k3s_token" {
  depends_on  = [random_string.k3s_token, local.k3s_token]
  name        = "/k3s/cluster/token"
  type        = "SecureString"
  value       = local.k3s_token
  description = "K3s cluster authentication token"
}

# Use a local value to determine the token to use
locals {
  k3s_token = var.k3s_token != null ? var.k3s_token : random_string.k3s_token.result
}
