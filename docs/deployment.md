# Deployment Documentation

## Kubernetes deployment
Files:
- `k8s/deployment.yaml`
- `k8s/service.yaml`

### Deployment details
- `deployment.yaml` creates a Deployment with 2 replicas.
- It uses image `YOUR_DOCKERHUB_USERNAME/devops-app:latest`.
- Container port: `5000`.

### Service details
- `service.yaml` exposes the app as a `NodePort` service.
- External port: `80`.
- Target container port: `5000`.
- Node port: `32000`.

### Usage
1. Build and push the Docker image to Docker Hub.
2. Update `k8s/deployment.yaml` with the correct Docker Hub image.
3. Apply manifests:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   ```

## Terraform provisioning
File:
- `terraform/main.tf`

### Resources
- `aws_security_group.devops_sg` opens SSH and HTTP.
- `aws_instance.devops_server` launches an EC2 instance in `us-east-1`.

### Notes
- The AMI is set to Ubuntu 22.04 LTS for `us-east-1`.
- Security group currently allows all SSH traffic; tighten this for production.
- Terraform outputs the public IP address of the instance.

### Usage
1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```
2. Preview the plan:
   ```bash
   terraform plan
   ```
3. Apply the plan:
   ```bash
   terraform apply
   ```
