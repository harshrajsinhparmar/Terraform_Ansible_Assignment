# TravelMemory Deployment Report

## 1. Objective and summary

Describe the goal:
- Deploy TravelMemory on AWS.
- Terraform provisions infrastructure.
- Ansible configures MongoDB and web tier.
- MongoDB stays in a private subnet.

## 2. Architecture

Include a diagram showing:

Browser
  -> Internet Gateway
  -> Web EC2 in public subnet
     -> Nginx
     -> React production build
     -> Express API
  -> MongoDB EC2 in private subnet

Mention:
- DB has no public IP.
- DB reaches package repositories through NAT Gateway.
- Web server reaches MongoDB on port 27017.
- DB server SSH is through the web server bastion.

## 3. Terraform implementation

Document:
- AWS CLI authentication.
- Terraform initialization.
- VPC and CIDR.
- Public and private subnet.
- Internet Gateway.
- NAT Gateway and Elastic IP.
- Route tables.
- Security groups.
- IAM role and instance profile.
- EC2 instances.
- Terraform output and generated Ansible inventory.

## 4. Ansible implementation

Document:
- Inventory and SSH jump host.
- Ansible Vault.
- Common role.
- Hardening role.
- MongoDB role.
- Webserver role.
- React frontend build.
- Express systemd service.
- Nginx reverse proxy.

## 5. Application component interaction

Explain:

1. Browser opens `http://WEB_PUBLIC_IP`.
2. Nginx serves React build.
3. React calls `/trip` and `/hello`.
4. Nginx proxies API calls to Express on port 3001.
5. Express reads `MONGO_URI`.
6. Express connects to MongoDB using private IP and app user.
7. MongoDB accepts port 27017 only from web server.

## 6. Security hardening

Include:
- SSH only from learner IP to web server.
- DB SSH only from web SG.
- MongoDB only from web SG.
- UFW default-deny incoming.
- SSH key-only login.
- Root and password login disabled.
- fail2ban enabled.
- MongoDB authentication enabled.
- Separate least-privilege database user.
- IMDSv2 required.
- Encrypted EBS volumes.
- Secrets in Ansible Vault.

## 7. Problems and solutions

Examples:
- React frontend stuck on Loading due to localhost backend URL.
- Private DB server cannot install packages when NAT route is missing.
- Ansible cannot reach private DB without ProxyCommand.
- React build consumes memory.
- MongoDB user creation after auth requires localhost exception.

## 8. Cost and cleanup

Mention:
- NAT Gateway incurs hourly charges.
- Public IPv4 addresses incur charges.
- Run `terraform destroy` after screenshots.

## 9. Screenshot checklist

- AWS CLI `sts get-caller-identity`
- `terraform init`, `fmt`, `validate`
- Terraform plan
- Terraform apply and public IP output
- VPC and subnets
- IGW, NAT Gateway and route tables
- EC2 instances
- Security group rules
- Ansible inventory and ping
- Ansible playbook run
- MongoDB service and authentication
- Backend systemd service
- Nginx validation
- Website in browser
- Add Experience form
- Trip visible in MongoDB
- Root/password SSH refusal
- UFW and fail2ban status
- Second Ansible run with `changed=0`
- `terraform destroy`