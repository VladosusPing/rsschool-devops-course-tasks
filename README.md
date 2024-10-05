# DevOpsSchool

## Description
This is repo for RS school tasks and reports

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Clone the Repository](#clone-the-repository)
  - [Setup AWS Credentials](#setup-aws-credentials)
  - [Initialize Terraform](#initialize-terraform)
  - [Plan and Apply Changes](#plan-and-apply-changes)
- [Configuration](#configuration)
- [Variables](#variables)
  - [List and describe the input variables](#list-and-describe-the-input-variables)
  - [How to add new variable](#how-to-add-new-variable)
- [Contributing](#contributing)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS account with appropriate permissions.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured.
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) installed on your local machine.

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/VladosusPing/rsschool-devops-course-tasks.git
cd rsschool-devops-course-tasks
```

### Setup AWS Credentials

Make sure your AWS credentials are configured. You can set them up using the AWS CLI:

```bash
aws configure
```

### Initialize Terraform

 Navigate to the directory containing the Terraform configuration files and run:

 ```bash
cd environments/prod/
terraform init
```

### Plan and Apply Changes

To see the changes Terraform will make, run:

 ```bash
terraform plan
```

If everything looks good, apply the changes:

 ```bash
terraform apply
```

## Configuration 

- __main.tf__. Main configuration contains in main.tf file: main.tf contains required providers and terraform backend configs.
- __keypair.tf__. Manages the creation and configuration of key pairs for secure access.
- __iam.tf__. Defines IAM roles, policies, and user permissions.
- __network.tf__. Configures the network infrastructure, such as VPCs, subnets, and routing tables.
- __outputs.tf__. Specifies the output values to be displayed after applying the Terraform configuration.
- __prod.tfvars__. Holds variable values specific to the production environment. 
- __securitygroups.tf__. Defines security groups and rules for network traffic control.
- __variables.tf__. Declares variables used throughout the Terraform configuration.

## Variables

### List and describe the input variables

VPC vars:
- vpc_cidr
- private_us-east-1a_subnet_cidr
- private_us-east-1b_subnet_cidr
- public_us-east-1a_subnet_cidr
- public_us-east-1b_subnet_cidr

EC2 vars:
- health_check_path
- amis
- instance_type
- ec2_instance_name
- ssh_pubkey_file
- autoscale_min
- autoscale_max
- autoscale_desired

### How to add new variable

 ```hcl
variable "variable_name" {
  description = "Description of the variable"
  type        = string
  default     = "default_value"
}
```

If you whant to override any variable on specific environment you should use <env>.tfvars file. Syntax example:

 ```hcl
var_name  = <value>
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes. For major changes, please open an issue first to discuss what you would like to change.
