#!/bin/bash

# Release script for Docker container
set -e

# Load configuration
source scripts/config.sh

echo "Creating release for version: $VERSION"

# Check if working directory is clean
if [[ -n $(git status --porcelain) ]]; then
    echo "Error: Working directory is not clean"
    echo "Please commit or stash your changes before creating a release"
    exit 1
fi

# Check if tag already exists
if git tag -l | grep -q "^v$VERSION$"; then
    echo "Error: Tag v$VERSION already exists"
    exit 1
fi

# Build the container
echo "Building container..."
./scripts/build.sh

# Test the container
echo "Testing container..."
./scripts/test.sh

# Create Git tag
echo "Creating Git tag: v$VERSION"
git tag -a "v$VERSION" -m "Release version $VERSION"

# Push tag to remote
echo "Pushing tag to remote..."
git push origin "v$VERSION"

# Push to Docker Hub
echo "Pushing to Docker Hub..."
./scripts/push.sh

echo "Release v$VERSION completed successfully!"
echo "Next steps:"
echo "1. Update VERSION file for next development cycle"
echo "2. Update CHANGELOG.md with new features" 