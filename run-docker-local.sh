#!/bin/bash

# DevOps Portfolio Project - Docker Local Build & Run Script
# This script builds and runs the Docker image locally

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$SCRIPT_DIR/app"
IMAGE_NAME="devops-app"
IMAGE_TAG="local"
CONTAINER_NAME="devops-app-container"
PORT="5000"

print_status() {
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}► $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
}

print_error() {
    echo -e "${RED}✗ ERROR: $1${NC}"
    exit 1
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# ============================================
# STEP 0: Check Docker Installation
# ============================================
print_status "Step 0: Checking Docker Installation"

if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker to use this script."
fi

print_success "Docker found: $(docker --version)"

# ============================================
# STEP 1: Build Docker Image
# ============================================
print_status "Step 1: Building Docker Image"

print_info "Building image: ${IMAGE_NAME}:${IMAGE_TAG}"
print_info "Dockerfile location: ${APP_DIR}/Dockerfile"

docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" "${APP_DIR}"

if [ $? -eq 0 ]; then
    print_success "Docker image built successfully"
    
    # Show image info
    echo -e "\n${YELLOW}Image Details:${NC}"
    docker images "${IMAGE_NAME}:${IMAGE_TAG}" --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"
else
    print_error "Docker build failed"
fi

# ============================================
# STEP 2: Check for Running Container
# ============================================
print_status "Step 2: Checking for Running Container"

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    print_info "Container '${CONTAINER_NAME}' already exists"
    
    if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        print_info "Container is currently running. Stopping it..."
        docker stop "${CONTAINER_NAME}"
        print_success "Container stopped"
    fi
    
    read -p "Do you want to remove the existing container? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker rm "${CONTAINER_NAME}"
        print_success "Container removed"
    fi
fi

# ============================================
# STEP 3: Run Docker Container
# ============================================
print_status "Step 3: Running Docker Container"

print_info "Starting container: ${CONTAINER_NAME}"
print_info "Port mapping: localhost:${PORT} -> container:5000"

docker run \
    --name "${CONTAINER_NAME}" \
    -p "${PORT}:5000" \
    --rm \
    -it \
    "${IMAGE_NAME}:${IMAGE_TAG}"

print_status "Container Stopped"
print_success "Done!"
