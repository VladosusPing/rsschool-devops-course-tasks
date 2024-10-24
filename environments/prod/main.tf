# This is main file for terraform on prod env
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.0"
    }
  }

  backend "s3" {
    bucket         = "components-terraform-state"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "components-terraform-lockid"
  }

}

module "aws_infrastructure" {
  source = "../modules/aws_infrastructure"

  k3s_installation_script = var.k3s_installation_script
  ssh_pubkey_file         = var.ssh_pubkey_file
  tag_env                 = var.tag_env
}

