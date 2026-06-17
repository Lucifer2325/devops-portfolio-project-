#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")" && pwd)"
cd "$root"

usage() {
  cat <<'EOF'
Usage: ./run.sh <command>
Commands:
  init          Create a Python virtual environment and install dependencies
  test          Run unit tests
  build-image   Build the Docker image locally
  deploy-k8s    Apply Kubernetes manifests
  terraform     Run Terraform commands from the terraform directory
  help          Show this help message
EOF
}

command="${1:-help}"
shift || true

case "$command" in
  init)
    python -m venv .venv
    source .venv/bin/activate
    python -m pip install --upgrade pip
    pip install -r app/requirements.txt
    echo "Local environment ready. Activate with: source .venv/bin/activate"
    ;;
  test)
    if [ -f .venv/bin/activate ]; then
      source .venv/bin/activate
    fi
    python -m unittest discover -s app -p "test_*.py"
    ;;
  build-image)
    docker build -t devops-app:local app
    ;;
  deploy-k8s)
    kubectl apply -f k8s/deployment.yaml
    kubectl apply -f k8s/service.yaml
    ;;
  terraform)
    if [ $# -eq 0 ]; then
      echo "Usage: ./run.sh terraform <command> [args...]"
      exit 1
    fi
    cd terraform
    terraform "$@"
    ;;
  help|*)
    usage
    exit 1
    ;;
esac
