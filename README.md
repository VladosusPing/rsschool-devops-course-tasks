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
- [EC2 instances](#ec2-instances)
  - [prod-ec2-bastion](#prod-ec2-bastion)
  - [prod-ec2-k3s-cluster-allinone](#prod-ec2-k3s-cluster-allinone)
- [Deployment process](#deployment-process)
  - [GitHub Actions workflow](#github-actions-workflow)
  - [K3S deployment](#k3s-deployment)
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
## EC2 instances

There are 2 ec2 instances:
- prod-ec2-bastion
- prod-ec2-k3s-cluster-allinone

### prod-ec2-bastion

A bastion host acts as a fortified entryway to a secure internal network, ensuring that remote access is tightly controlled and monitored. By using a bastion host, we add an extra layer of defense against unauthorized access, making our cloud infrastructure more secure.
Bastion host configuration is in `ec2.tf` file. Bastion host have inbound access rule from anywhere to 22 ssh port.

### prod-ec2-k3s-cluster-allinone

A prod-ec2-k3s-cluster-allinone refers to a lightweight, consolidated Kubernetes cluster deployment in a production environment, hosted on Amazon EC2 using K3s with all components on a single node. It aims for simplicity, rapid deployment, and lower resource use, but comes with trade-offs like limited scalability and being a single point of failure. This kind of setup is great for low-resource applications, small-scale production deployments, or environments where high availability is not a critical requirement. K3S cluster host configuration is in ``ec2.tf`` file. K3S cluster host have inbound access rule from anywhere to 80 http port and from local network to 22 ssh port.

## Deployment process

### GitHub Actions workflow

The deployment is automated using a GitHub Actions workflow `blank.yml`. This workflow file defines the CI/CD process that runs Terraform commands to manage AWS infrastructure. This GitHub Actions workflow automates the deployment process using Terraform. It consists of several stages: checking Terraform format, planning changes, and applying changes. The workflow is triggered by pushes and pull requests to the main branch that affect files in the environments/prod directory.

#### Key Steps in the Workflow:

##### 1. Trigger

Conditions: The workflow is triggered on any pull request or push to the main branch. This ensures that any changes to the infrastructure are validated and applied only after review.
The workflow is activated by two types of events:

- Push Events: When code is pushed to the main branch, affecting files within the environments/prod/** directory.
- Pull Requests: When a pull request targets the main branch, affecting files within the environments/prod/** directory.

```
on:
  push:
    branches:
      - main
    paths:
      - 'environments/prod/**'
  pull_request:
    branches:
      - main
    paths:
      - 'environments/prod/**'
```

##### 2. Permissions

This workflow needs various GitHub permissions to interact with resources securely:

```
permissions:
  id-token: write # Required for AWS OpenID Connect authentication.
  contents: read # Required to use the actions/checkout action to access the repository contents.
  pull-requests: write # Allows GitHub bot to comment on pull requests.
```

##### 3. Jobs

###### 3.1. terraform-check
    Purpose: Validate Terraform formatting.
    Steps: Checkout code, set up Terraform, run terraform fmt -check.
###### 3.2. terraform-plan
    Purpose: Generate execution plan for infrastructure changes.
    Steps: Checkout code, set up Terraform, configure AWS, initialize (terraform init), run terraform plan.
###### 3.3. terraform-apply
    Purpose: Apply infrastructure changes (only on main branch).
    Steps: Checkout code, set up Terraform, configure AWS, initialize, apply changes (terraform apply -auto-approve).
    This ensures formatting validation, planning, and controlled application of changes.

### K3S deployment

Deployment of k3s cluster realized with k3s_install.sh file, this is bash script with k3s installation. This script sends to ec2 instance with using ec2 userdata.

```hcl
user_data = file(var.k3s_installation_script)
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes. For major changes, please open an issue first to discuss what you would like to change.
