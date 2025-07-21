#!/bin/bash

# Build script for Docker container
set -e

# Load configuration
source scripts/config.sh

echo "Building Docker container..."
echo "Version: $VERSION"
echo "Image: $DOCKER_IMAGE"

# Build the Docker image (AMD64 - works on both Intel and Apple Silicon)
docker build -t "$DOCKER_IMAGE:$VERSION" -t "$DOCKER_IMAGE:latest" .

echo "Build completed successfully!"
echo "Images created:"
echo "  - $DOCKER_IMAGE:$VERSION"
echo "  - $DOCKER_IMAGE:latest" 