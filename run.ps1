param(
    [string]$Command = 'help',
    [string[]]$Args
)

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

function Show-Help {
    @'
Usage: .\run.ps1 <command> [args]
Commands:
  init          Create a Python virtual environment and install dependencies
  test          Run unit tests
  build-image   Build the Docker image locally
  deploy-k8s    Apply Kubernetes manifests
  terraform     Run Terraform commands from the terraform directory
  help          Show this help message
'@ | Write-Host
}

switch ($Command) {
    'init' {
        if (-Not (Test-Path .venv)) {
            python -m venv .venv
        }
        . .\venv\Scripts\Activate.ps1
        python -m pip install --upgrade pip
        pip install -r app\requirements.txt
        Write-Host 'Local environment ready. Activate with: .\.venv\Scripts\Activate.ps1'
        break
    }
    'test' {
        if (Test-Path .\venv\Scripts\Activate.ps1) {
            . .\venv\Scripts\Activate.ps1
        }
        python -m unittest discover -s app -p 'test_*.py'
        break
    }
    'build-image' {
        docker build -t devops-app:local app
        break
    }
    'deploy-k8s' {
        kubectl apply -f k8s\deployment.yaml
        kubectl apply -f k8s\service.yaml
        break
    }
    'terraform' {
        if ($Args.Length -eq 0) {
            Write-Host 'Usage: .\run.ps1 terraform <command> [args...]'
            exit 1
        }
        Set-Location terraform
        terraform @Args
        break
    }
    default {
        Show-Help
        exit 1
    }
}
