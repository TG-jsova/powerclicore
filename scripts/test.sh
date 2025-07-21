#!/bin/bash

# Test script for Docker container
set -e

# Load configuration
source scripts/config.sh

echo "Testing Docker container..."
echo "Version: $VERSION"
echo "Image: $DOCKER_IMAGE"

# Check if image exists locally, if not try to pull it
if ! docker image inspect "$DOCKER_IMAGE:$VERSION" >/dev/null 2>&1; then
    echo "Image not found locally, attempting to pull from Docker Hub..."
    if ! docker pull "$DOCKER_IMAGE:$VERSION" >/dev/null 2>&1; then
        echo "Error: Image not found locally or on Docker Hub"
        echo "Please build the image first with: ./scripts/build.sh"
        exit 1
    fi
fi

# Run the container in test mode
echo "Running container test..."
docker run --rm "$DOCKER_IMAGE:$VERSION" --help

echo "Test completed successfully!" 