# This file contains all the variables that are used in the Terraform configuration.

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

################################### VPC vars end ####################################

##################################### EC2 vars ######################################

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

variable "amis" {
  description = "Which AMI to spawn."

  # Debian 12 AMI
  default = "ami-064519b8c76274859"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "prod-web"
}


# key pair - Location to the SSH Key generate using openssl or ssh-keygen or AWS KeyPair
variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/aws/aws_key.pub"
}


# auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "2"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "1"
}

################################### EC2 vars end ####################################
