Terraform Script for knowledgecity AWS infrastructure

This Terraform script sets up the environment in the following regions:

Primary Region: us-east-1
Secondary Region: us-west-1
Reason for Region Selection
Since Saudi Arabia and Dubai regions are unavailable in my AWS account, us-east-1 and us-west-1 were chosen for testing purposes. This ensures the Terraform script can be validated using terraform plan.

Database Credentials Management
To securely store the database password, AWS Secrets Manager is used. Instructions on creating a secret are provided in the terraform.tfvars file, along with comments for additional guidance.

Instructions to Run the Script
Create a secret in AWS Secrets Manager with the database password, as outlined in terraform.tfvars.
Run the following commands:

terraform init  
terraform plan  
terraform apply  

Ensure all prerequisites are met, including configuring AWS credentials and creating the necessary secret in AWS Secrets Manager, before running the script.

