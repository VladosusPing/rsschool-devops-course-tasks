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

