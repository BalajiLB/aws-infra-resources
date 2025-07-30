# aws-infra-resources

This repository provides a modular and reusable way to provision AWS infrastructure using Terraform. It supports environment-based deployments (`dev`, `stg`, `prod`) and uses GitHub Actions for CI/CD automation.

---

## 📁 Project Structure

aws-infra-resources/
├── .github/
│ └── workflows/
│ ├── terraform-deploy.yml # Reusable Terraform workflow
│ ├── mulitenv-deploy.yml 
│ ├── terraform-destroy 
│ └── manual-destroy.yml # Choice to select & destroy the env
├── environments/
│ ├── dev/
│ ├── stg/
│ └── prod/
├── provider.tf
├── README.md
└── .gitignore


---

## 🚀 Features

- Environment-based infrastructure deployments
- GitHub Actions integrated CI/CD pipeline
- Reusable Terraform modules with version pinning
- Support for Terraform plan, apply, and destroy
- Checkov security scanning integration (coming soon)

---

## 🔧 Usage

### Clone this repo

```bash
git clone https://github.com/<your-username>/aws-infra-resources.git


⚙️ Setup Guide (What I did)
Created repo & directory structure

environments/dev, environments/stg, environments/prod

Each environment has its own main.tf, backend.tf, terraform.tfvars

Configured provider

Defined provider.tf at root level

Uses AWS_REGION as variable input

Linked remote Terraform modules

Modules are fetched using Git URLs with version pinning (e.g., ?ref=v1.0.0-vpc)

Implemented GitHub Actions

Added reusable workflow: .github/workflows/terraform-deploy.yml

Environment-specific workflows (e.g., mulitenv-deploy.yml) call the reusable workflow

Setup Checkov integration

Added Checkov scan as part of CI (scan runs after plan)

Output is uploaded as SARIF (Code Scanning Alerts – WIP due to GitHub token permissions)

Branching strategy

Created feature branches (e.g., feature/checkov-added)

Merged changes to main via PRs



Trigger CI/CD
Push changes to a feature branch and raise a PR to main. The GitHub Actions pipeline will:

Run terraform plan

Optionally run terraform apply

(Coming soon) Run checkov scan and upload results


🔐 Notes
Ensure GitHub Actions has access to necessary secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

For Checkov scanning via GitHub Advanced Security:

Set permissions: security-events: write in workflow

Must be on same repo (not a fork)

📌 Roadmap
✅ Environment-specific automation

✅ Reusable Terraform modules

✅ Multi-environment CI/CD workflows