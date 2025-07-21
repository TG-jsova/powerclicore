#!/bin/bash

# Push script for Docker container
set -e

# Load configuration
source scripts/config.sh

echo "Pushing Docker container to Docker Hub..."
echo "Version: $VERSION"
echo "Image: $DOCKER_IMAGE"

# Check if user is logged in to Docker Hub
if ! docker info | grep -q "Username"; then
    echo "Error: Not logged in to Docker Hub"
    echo "Please run: docker login"
    exit 1
fi

# Push both version and latest tags
echo "Pushing version tag: $VERSION"
docker push "$DOCKER_IMAGE:$VERSION"

echo "Pushing latest tag"
docker push "$DOCKER_IMAGE:latest"

echo "Push completed successfully!"
echo "Images pushed:"
echo "  - $DOCKER_IMAGE:$VERSION"
echo "  - $DOCKER_IMAGE:latest" 