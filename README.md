# Docker Container Maintenance Workflow

This repository contains a forked Docker container that we maintain and update regularly.

## Quick Start

1. **Clone your forked repository:**
   ```bash
   git clone <your-forked-repo-url>
   cd <repo-name>
   ```

2. **Set up Docker Hub credentials:**
   ```bash
   docker login
   ```

3. **Build and test the container:**
   ```bash
   ./scripts/build.sh
   ```
   *(AMD64 build - works on both Intel and Apple Silicon via Rosetta 2)*

4. **Push to Docker Hub:**
   ```bash
   ./scripts/push.sh
   ```

## Development Workflow

### 1. Making Changes
- Make your code changes
- Update version in `VERSION` file
- Update `CHANGELOG.md` with your changes
- Test locally with `./scripts/test.sh`

### 2. Committing Changes
```bash
git add .
git commit -m "feat: add new feature"
git push origin main
```

### 3. Creating a Release
```bash
./scripts/release.sh
```

## File Structure

- `Dockerfile` - Main container definition
- `scripts/` - Build and deployment scripts
- `VERSION` - Current version number
- `CHANGELOG.md` - Release notes
- `.github/workflows/` - GitHub Actions for CI/CD

## Version Management

We use semantic versioning (MAJOR.MINOR.PATCH):
- Update `VERSION` file before each release
- Tag releases in Git
- Push corresponding Docker tags

## Docker Hub Integration

- Automated builds on push to main branch
- Manual releases with `./scripts/release.sh`
- Multiple tag support (latest, version-specific) 