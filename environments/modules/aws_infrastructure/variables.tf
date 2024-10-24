# This file contains all the variables that are used in the Terraform configuration.

##################################### Tags vars #####################################

variable "tag_env" {
  description = "Enviroment tag"
  type        = string
  default     = "prod"
}

variable "tag_owner" {
  description = "Owner name tag"
  type        = string
  default     = "Vladislav"
}

variable "tag_project" {
  description = "Project name tag"
  type        = string
  default     = "devops-learning"
}


##################################### VPC vars #####################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_us-east-1a_subnet_cidr" {
  description = "CIDR block for the private us-east-1a subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_us-east-1b_subnet_cidr" {
  description = "CIDR block for the private us-east-1b subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_us-east-1a_subnet_cidr" {
  description = "CIDR block for the public us-east-1a subnet"
  type        = string
  default     = "10.0.11.0/24"
}

variable "public_us-east-1b_subnet_cidr" {
  description = "CIDR block for the public us-east-1b subnet"
  type        = string
  default     = "10.0.12.0/24"
}

##################################### EC2 vars ######################################


variable "health_check_path" {
  type        = string
  description = "Health check path for the default target group"
  default     = "/"
}

variable "amis" {
  type        = string
  description = "Which AMI to spawn."

  # Debian 12 AMI
  default = "ami-064519b8c76274859"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "prod-web"
}


# key pair - Location to the SSH Key generate using openssl or ssh-keygen or AWS KeyPair
variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  type        = string
}


variable "volume_type" {
  description = "Volume type on project"
  type        = string
  default     = "gp2"
}

variable "k3s_installation_script" {
  description = "Path to an SSH public key"
  type        = string
}


##################################### AWS vars ######################################


variable "aws_region" {
  type    = string
  default = "us-east-1"
}