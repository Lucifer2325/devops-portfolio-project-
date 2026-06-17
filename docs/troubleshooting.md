# Troubleshooting Guide

## CI build log
- CI writes `build.log` at the start of the GitHub Actions run.
- The log includes pipeline metadata, dependency install output, and test output.
- The artifact is uploaded as `ci-logs` and retained for 7 days.

## Common issues
- `ModuleNotFoundError`: ensure the virtual environment is activated and `pip install -r app/requirements.txt` passes.
- `403 Unauthorized` on Docker login: verify Docker Hub secrets in repository settings.
- `Container image not found`: confirm the image tag in `k8s/deployment.yaml` matches the pushed Docker Hub image.

## Local reproduction
1. Run dependency install locally.
2. Run unit tests with:
   ```bash
   python -m unittest discover -s app -p "test_*.py"
   ```
3. Build the Docker image locally for validation:
   ```bash
   docker build -t devops-app:local app
   ```
