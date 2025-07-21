# Quick Reference

## Daily Commands

### Build and Test
```bash
./scripts/build.sh    # Build container (AMD64 - works everywhere)
./scripts/test.sh     # Test container
```

### Version Management
```bash
./scripts/update-version.sh 1.1.0  # Update version
cat VERSION                      # Check current version
```

### Git Operations
```bash
git add .                        # Stage all changes
git commit -m "feat: message"    # Commit changes
git push origin main             # Push to main
git tag -l                       # List tags
```

### Docker Operations
```bash
docker login                     # Login to Docker Hub
./scripts/push.sh               # Push to Docker Hub
docker images                    # List local images
docker rmi <image>              # Remove image
```

## Release Workflow

1. **Update version:**
   ```bash
   ./scripts/update-version.sh 1.1.0
   ```

2. **Update CHANGELOG.md**

3. **Commit changes:**
   ```bash
   git add VERSION CHANGELOG.md
   git commit -m "chore: bump version to 1.1.0"
   git push origin main
   ```

4. **Create release:**
   ```bash
   ./scripts/release.sh
   ```

## Configuration

Edit `scripts/config.sh` to update:
- Docker Hub username
- Container name
- Build arguments

## GitHub Actions

- **Automatic builds** on push to main
- **Automatic releases** on tag push
- **Pull request testing** enabled

## Troubleshooting

```bash
chmod +x scripts/*.sh           # Fix permissions
docker system prune             # Clean Docker cache
git status                      # Check git status
``` 