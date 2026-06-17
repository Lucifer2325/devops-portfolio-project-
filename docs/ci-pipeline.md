# CI Pipeline Documentation

## Purpose
This document explains the GitHub Actions CI pipeline for the DevOps portfolio project and how the build log is preserved for troubleshooting.

## Workflow file
- File: `.github/workflows/deploy.yml`
- Trigger: `push` to `main`

## Pipeline steps
1. Check out repository code.
2. Set up Python 3.11.
3. Prepare `build.log` with pipeline metadata:
   - GitHub run ID
   - run number
   - repository
   - commit SHA
   - branch name
4. Install dependencies from `app/requirements.txt`.
5. Run unit tests from `app/test_app.py` using `unittest`.
6. Set up Docker Buildx.
7. Log in to Docker Hub using repo secrets.
8. Build and push the Docker image from `app/`.
9. Upload `build.log` as a GitHub Actions artifact.

## Troubleshooting
- If a pipeline step fails, download the `ci-logs` artifact from the workflow run.
- The `build.log` file includes both install and test output.
- Keep `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` configured in repository secrets.

## Local validation
Run these locally before pushing changes:
```bash
cd app
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
.\.venv\Scripts\Activate    # Windows PowerShell
pip install --upgrade pip
pip install -r requirements.txt
python -m unittest discover -s . -p "test_*.py"
```
