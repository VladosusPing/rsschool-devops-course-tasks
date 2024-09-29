### AWS Account Configuration task report
1. **MFA User configured (10 points)**

   - Provide a screenshot of the non-root account secured by MFA (ensure sensitive information is not shared).

2. **Bucket and GithubActionsRole IAM role configured (30 points)**

   - Terraform code is created and includes:
     - A bucket for Terraform states
     - IAM role with correct Identity-based and Trust policies

3. **Github Actions workflow is created (30 points)**

   - Workflow includes all jobs

4. **Code Organization (10 points)**

   - Variables are defined in a separate variables file.
   - Resources are separated into different files for better organization.

5. **Verification (10 points)**

   - Terraform plan is executed successfully for `GithubActionsRole`
   - Terraform plan is executed successfully for a terraform state bucket

6. **Additional Tasks (10 points)**
   - **Documentation (5 points)**
     - Document the infrastructure setup and usage in a README file.
   - **Submission (5 points)**
   - A GitHub Actions (GHA) pipeline is passing
