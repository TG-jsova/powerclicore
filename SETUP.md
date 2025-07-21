# Setup Guide for Docker Container Maintenance

This guide will help you set up your forked Docker container for ongoing maintenance and releases.

## Prerequisites

- Docker installed and running
- Git installed
- Docker Hub account
- GitHub account (for CI/CD)

## Step 1: Clone Your Forked Repository

```bash
git clone <your-forked-repo-url>
cd <repo-name>
```

## Step 2: Configure Your Container

1. **Update `scripts/config.sh`:**
   ```bash
   # Edit the file and update these values:
   DOCKER_USERNAME="your-dockerhub-username"
   CONTAINER_NAME="your-container-name"
   ```

2. **Add your Dockerfile:**
   - Copy your original Dockerfile to the root directory
   - Or create a new one based on your needs

## Step 3: Set Up Docker Hub Authentication

1. **Login to Docker Hub:**
   ```bash
   docker login
   ```

2. **For GitHub Actions (optional):**
   - Go to your GitHub repository settings
   - Add secrets:
     - `DOCKER_USERNAME`: Your Docker Hub username
     - `DOCKER_PASSWORD`: Your Docker Hub password/token

## Step 4: Test Your Setup

1. **Build the container:**
   ```bash
   ./scripts/build.sh
   ```

2. **Test the container:**
   ```bash
   ./scripts/test.sh
   ```

3. **Push to Docker Hub:**
   ```bash
   ./scripts/push.sh
   ```

## Step 5: Initial Git Setup

```bash
# Add all files
git add .

# Initial commit
git commit -m "feat: initial setup for container maintenance"

# Push to your repository
git push origin main
```

## Step 6: Create Your First Release

```bash
# Update version if needed
./scripts/update-version.sh 1.0.0

# Create and push release
./scripts/release.sh
```

## Ongoing Maintenance Workflow

### Making Changes

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/new-feature
   ```

2. **Make your changes:**
   - Update Dockerfile
   - Modify application code
   - Update documentation

3. **Test locally:**
   ```bash
   ./scripts/build.sh
   ./scripts/test.sh
   ```

4. **Commit and push:**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   git push origin feature/new-feature
   ```

5. **Create pull request and merge to main**

### Creating Releases

1. **Update version:**
   ```bash
   ./scripts/update-version.sh 1.1.0
   ```

2. **Update CHANGELOG.md** with your changes

3. **Commit version changes:**
   ```bash
   git add VERSION CHANGELOG.md
   git commit -m "chore: bump version to 1.1.0"
   git push origin main
   ```

4. **Create release:**
   ```bash
   ./scripts/release.sh
   ```

## Troubleshooting

### Common Issues

1. **Docker not logged in:**
   ```bash
   docker login
   ```

2. **Permission denied on scripts:**
   ```bash
   chmod +x scripts/*.sh
   ```

3. **Git tag already exists:**
   - Update version in `VERSION` file
   - Run `./scripts/update-version.sh <new-version>`

### Getting Help

- Check the logs in GitHub Actions
- Verify Docker Hub credentials
- Ensure all scripts are executable
- Check that your Dockerfile is valid

## Best Practices

1. **Always test locally before pushing**
2. **Use semantic versioning**
3. **Keep CHANGELOG.md updated**
4. **Use meaningful commit messages**
5. **Tag all releases**
6. **Monitor GitHub Actions for build status** 