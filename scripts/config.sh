#!/bin/bash

# Configuration for Docker container
# Update these values for your specific container

# Docker Hub username
DOCKER_USERNAME="jsova1978"

# Container name (without username)
CONTAINER_NAME="powerclicore"

# Full Docker image name
DOCKER_IMAGE="$DOCKER_USERNAME/$CONTAINER_NAME"

# Read version from VERSION file
VERSION=$(cat VERSION)

# Build arguments (customize as needed)
BUILD_ARGS=""

# Export variables for use in other scripts
export DOCKER_USERNAME
export CONTAINER_NAME
export DOCKER_IMAGE
export VERSION
export BUILD_ARGS 