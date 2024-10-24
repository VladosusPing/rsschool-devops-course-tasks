provider "helm" {
  kubernetes {
    host                   = aws_instance.prod-ec2-k3s-cluster-allinone.public_ip
    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}