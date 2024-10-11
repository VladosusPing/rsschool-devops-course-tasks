# Task 2: Basic Infrastructure Configuration
1. **Terraform Code Implementation (50 points)**

   - Terraform code is created to configure the following:
     - VPC
     - 2 public subnets in different AZs
     - 2 private subnets in different AZs
     - Internet Gateway
     - Routing configuration:
       - Instances in all subnets can reach each other
       - Instances in public subnets can reach addresses outside VPC and vice-versa
      
### __You can find all configuration in environments/prod folder__



2. **Code Organization (10 points)**

   - Variables are defined in a separate variables file.
   - Resources are separated into different files for better organization.

### __You can find all configuration in environments/prod folder. Variables are defined in variables.tf file and overrided(if needed) in prod.tfvars. Additional information you can find in README.md file__




3. **Verification (10 points)**

   - Terraform plan is executed successfully.
   - A resource map screenshot is provided (VPC -> Your VPCs -> your_VPC_name -> Resource map).

```
root@DESKTOP-L69GVV5:~/rsschool-devops-course-tasks/environments/prod# terraform plan
Acquiring state lock. This may take a few moments...
aws_vpc.main: Refreshing state... [id=vpc-01f7ae07adddd2af8]
aws_iam_role.github_actions_role: Refreshing state... [id=github-actions-role]
aws_iam_role_policy_attachment.attach_sqs_full_access: Refreshing state... [id=github-actions-role-20241005122440497400000006]
aws_iam_role_policy_attachment.attach_vpc_full_access: Refreshing state... [id=github-actions-role-20241005122440505700000007]
aws_iam_role_policy_attachment.attach_ec2_full_access: Refreshing state... [id=github-actions-role-20241005122440284300000002]
aws_iam_role_policy_attachment.attach_eventbridge_full_access: Refreshing state... [id=github-actions-role-20241005122440473500000005]
aws_iam_role_policy_attachment.attach_s3_full_access: Refreshing state... [id=github-actions-role-20241005122440463600000004]
aws_iam_role_policy_attachment.attach_route53_full_access: Refreshing state... [id=github-actions-role-20241005122440050300000001]
aws_iam_role_policy_attachment.attach_iam_full_access: Refreshing state... [id=github-actions-role-20241005122440460200000003]
aws_subnet.prod-private-subnet-us-east-1a: Refreshing state... [id=subnet-0cbf395d893045b7e]
aws_route_table.public-route-table: Refreshing state... [id=rtb-0b69fd979a24d1ce2]
aws_subnet.prod-public-subnet-us-east-1b: Refreshing state... [id=subnet-02caa4c9737391bd6]
aws_internet_gateway.prod-igw: Refreshing state... [id=igw-02441a0fedd02b5b0]
aws_subnet.prod-private-subnet-us-east-1b: Refreshing state... [id=subnet-028e145ccda348c9c]
aws_security_group.prod-ec2-sg: Refreshing state... [id=sg-0e1080d1ddd7aae72]
aws_route_table.private-route-table: Refreshing state... [id=rtb-0beba051ecd0c2683]
aws_security_group.prod-load-balancer-sg: Refreshing state... [id=sg-04f6fa113ba04afdb]
aws_subnet.prod-public-subnet-us-east-1a: Refreshing state... [id=subnet-06fb95022fcc2c34a]
aws_route.public-internet-igw-route: Refreshing state... [id=r-rtb-0b69fd979a24d1ce21080289494]
aws_eip.prod-nat-gw-eip: Refreshing state... [id=eipalloc-05e0a68a25dd3e22c]
aws_route_table_association.prod-public-subnet-us-east-1b-association: Refreshing state... [id=rtbassoc-0da1aa99c006903c1]
aws_route_table_association.prod-private-subnet-us-east-1b-association: Refreshing state... [id=rtbassoc-0f85074f2cc07bbcf]
aws_route_table_association.prod-private-subnet-us-east-1a-association: Refreshing state... [id=rtbassoc-0a661f098b573957a]
aws_route_table_association.prod-public-subnet-us-east-1a-association: Refreshing state... [id=rtbassoc-077200cebc566dddf]
aws_nat_gateway.prod-nat-gw: Refreshing state... [id=nat-0b94996c8cf49dd84]
aws_route.nat-ngw-route: Refreshing state... [id=r-rtb-0beba051ecd0c26831080289494]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```

![image](https://github.com/user-attachments/assets/356f6938-5236-40bf-83c5-57cc7525d75e)


4. **Additional Tasks (30 points)**
   - **Security Groups and Network ACLs (5 points)**
     - Implement security groups and network ACLs for the VPC and subnets.


### __Configured in securitygroups.tf file__



   - **NAT is implemented for private subnets (10 points)**
     - Orginize NAT for private subnets with simpler or cheaper way
     - Instances in private subnets should be able to reach addresses outside VPC
    


### __Configured in network.tf file__

    
   - **Documentation (5 points)**
     - Document the infrastructure setup and usage in a README file.
    
### __Check README.md file__

   - **Submission (5 points)**
   - A GitHub Actions (GHA) pipeline is set up for the Terraform code.

### __Check https://github.com/VladosusPing/rsschool-devops-course-tasks/actions/runs/11296107030 . Also you can find success exec on https://github.com/VladosusPing/rsschool-devops-course-tasks/actions__
