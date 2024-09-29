### AWS Account Configuration task report
1. **MFA User configured (10 points)**

   - Provide a screenshot of the non-root account secured by MFA (ensure sensitive information is not shared).
  
    <img width="1920" alt="image" src="https://github.com/user-attachments/assets/20a34654-941a-4a9c-99c1-2fdd704065aa">


2. **Bucket and GithubActionsRole IAM role configured (30 points)**

   - Terraform code is created and includes:
     - A bucket for Terraform states
    <img width="1920" alt="image" src="https://github.com/user-attachments/assets/a761c640-8885-4b16-b1b9-cc97f9956eee">
    <img width="1917" alt="image" src="https://github.com/user-attachments/assets/170ee379-790c-4e67-884c-dce7d29e6b5d">


     - IAM role with correct Identity-based and Trust policies
    check iam.tf

3. **Github Actions workflow is created (30 points)**

   - Workflow includes all jobs
  check .github/workflows/blank.yml
     

4. **Code Organization (10 points)**

   - Variables are defined in a separate variables file.
   - Resources are separated into different files for better organization.

5. **Verification (10 points)**

   - Terraform plan is executed successfully for `GithubActionsRole`
   - Terraform plan is executed successfully for a terraform state bucket
     <img width="1362" alt="image" src="https://github.com/user-attachments/assets/57e3d6c1-842c-4fc2-8f86-17e577f909db">
  

6. **Additional Tasks (10 points)**
   - **Documentation (5 points)**
     - Document the infrastructure setup and usage in a README file.
   - **Submission (5 points)**
   - A GitHub Actions (GHA) pipeline is passing
