# DevOps Portfolio Project

## Overview
This sample project demonstrates a simple DevOps portfolio app with:
- Flask web application
- Docker container packaging
- GitHub Actions CI/CD workflow
- Kubernetes deployment manifests
- Terraform AWS provisioning template

## Project structure
- `.github/workflows/deploy.yml` - CI pipeline for tests, build, and Docker push
- `app/` - Flask application and Docker build context
- `k8s/` - Kubernetes manifests for deployment and service
- `terraform/` - AWS EC2 instance provisioning

## CI/CD workflow steps
1. Check out repository code
2. Set up Python 3.11
3. Prepare `build.log` for troubleshooting
4. Install Python dependencies from `app/requirements.txt`
5. Run unit tests located in `app/test_app.py`
6. Build and push Docker image to Docker Hub
7. Upload `build.log` as a GitHub Actions artifact for later troubleshooting

## Local setup
1. Clone repository
2. Build and test locally:
   ```bash
   cd app
   python -m venv .venv
   source .venv/bin/activate   # Linux/macOS
   .\.venv\Scripts\Activate  # Windows PowerShell
   pip install -r requirements.txt
   python -m unittest discover -s . -p "test_*.py"
   ```
3. Build Docker image locally:
   ```bash
   docker build -t devops-app:local .
   ```

## Deployment
- Kubernetes manifests are under `k8s/`
- Terraform config is under `terraform/main.tf`

## Local automation scripts
- `run.sh` — Bash entrypoint for Linux/macOS automation
- `run.ps1` — PowerShell entrypoint for Windows automation

### Usage examples
- Initialize and install dependencies:
  ```bash
  ./run.sh init
  . .venv/bin/activate
  ```
- Run tests:
  ```bash
  ./run.sh test
  ```
- Build Docker image:
  ```bash
  ./run.sh build-image
  ```
- Deploy Kubernetes manifests:
  ```bash
  ./run.sh deploy-k8s
  ```
- Run Terraform commands:
  ```bash
  ./run.sh terraform init
  ./run.sh terraform apply
  ```

## Troubleshooting
- Use the GitHub Actions artifact `ci-logs` to inspect failure output.
- Verify Docker Hub secrets `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` in repo settings.
- Confirm branch is `main` for pipeline execution.

## Git and GitHub setup
1. Initialize the repository if needed:
   ```bash
git init
   ```
2. Add files and commit changes:
   ```bash
git add .
git commit -m "Initial DevOps portfolio project setup with CI/CD docs and tests"
   ```
3. Add a GitHub remote and push:
   ```bash
git remote add origin https://github.com/<your-username>/<repo-name>.git
git branch -M main
git push -u origin main
   ```
4. Configure GitHub Secrets:
   - `DOCKERHUB_USERNAME`
   - `DOCKERHUB_TOKEN`
