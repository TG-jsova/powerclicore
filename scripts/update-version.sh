#!/bin/bash

# Update version script
set -e

# Load configuration
source scripts/config.sh

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <new-version>"
    echo "Example: $0 1.1.0"
    exit 1
fi

NEW_VERSION=$1

# Validate version format (simple check)
if [[ ! $NEW_VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in format MAJOR.MINOR.PATCH (e.g., 1.0.0)"
    exit 1
fi

echo "Updating version from $VERSION to $NEW_VERSION"

# Update VERSION file
echo "$NEW_VERSION" > VERSION

# Update CHANGELOG.md
sed -i.bak "s/## \[Unreleased\]/## [Unreleased]\n\n## [$NEW_VERSION] - $(date +%Y-%m-%d)/" CHANGELOG.md
rm CHANGELOG.md.bak

echo "Version updated successfully!"
echo "Current version: $NEW_VERSION"
echo "Don't forget to:"
echo "1. Commit these changes"
echo "2. Run ./scripts/release.sh when ready to release" 