provider "helm" {
  kubernetes {
    host                   = "https://${module.aws_infrastructure.prod_eip_k3s_cluster_ip}:6443"
    client_certificate     = var.k3s_client_certificate
    client_key             = var.k3s_client_key
    cluster_ca_certificate = var.k3s_cluster_ca_certificate
  }
}

provider "kubernetes" {
  host                   = "https://${module.aws_infrastructure.prod_eip_k3s_cluster_ip}:6443"
  client_certificate     = var.k3s_client_certificate
  client_key             = var.k3s_client_key
  cluster_ca_certificate = var.k3s_cluster_ca_certificate
}

provider "aws" {
  region = var.aws_region
}
