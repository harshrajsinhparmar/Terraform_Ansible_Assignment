# TravelMemory – Terraform and Ansible on AWS

This repository deploys the TravelMemory MERN application on AWS.

## Architecture

- VPC: `10.0.0.0/16`
- Public subnet: web server and NAT Gateway
- Private subnet: MongoDB server
- Web server: Nginx, React production build, Express API
- DB server: MongoDB with authentication enabled
- Ansible reaches the DB through the web server using SSH ProxyCommand

## Prerequisites

- AWS CLI v2
- Terraform >= 1.6
- Ansible Core
- Git
- SSH key pair
- AWS IAM permissions to create VPC, EC2, IAM, S3, and related resources

## Deployment

1. Configure AWS CLI:

   ```bash
   aws configure
   aws sts get-caller-identity

Create an SSH key:

ssh-keygen -t ed25519 -f ~/.ssh/travelmemory -C "travelmemory-aws"
chmod 600 ~/.ssh/travelmemory

Create the S3 backend bucket using:

cd terraform
chmod +x bootstrap-state.sh
./bootstrap-state.sh YOUR-UNIQUE-STATE-BUCKET-NAME ap-south-1

Create Terraform configuration files:
cp backend.hcl.example backend.hcl
cp terraform.tfvars.example terraform.tfvars
Update backend.hcl and terraform.tfvars.

Provision infrastructure:

terraform init -backend-config=backend.hcl
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
Configure Ansible secrets:


cd ../ansible
cp group_vars/all/vault.yml.example group_vars/all/vault.yml
cp .vault_pass.example .vault_pass
chmod 600 .vault_pass
Edit vault.yml, then encrypt it:


ansible-vault encrypt group_vars/all/vault.yml

Install the required Ansible collection and deploy:
ansible-galaxy collection install -r requirements.yml
ansible all -m ping
ansible-playbook site.yml

Open the URL printed by Terraform:
cd ../terraform
terraform output -raw app_url
Cleanup

After screenshots and testing:
cd terraform
terraform destroy