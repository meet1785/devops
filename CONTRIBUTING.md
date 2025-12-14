# Contributing to DevOps Starter Repository

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn

## How to Contribute

### Reporting Issues

1. Check if the issue already exists
2. Use the issue template
3. Provide detailed information:
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Environment details

### Suggesting Enhancements

1. Open an issue with the "enhancement" label
2. Describe the feature and use case
3. Provide examples if possible

### Pull Requests

1. Fork the repository
2. Create a feature branch:
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Make your changes
4. Test your changes
5. Commit with clear messages:
   ```bash
   git commit -m "Add amazing feature"
   ```
6. Push to your fork:
   ```bash
   git push origin feature/amazing-feature
   ```
7. Open a Pull Request

## Development Setup

### Prerequisites
- Docker and Docker Compose
- Python 3.11+
- Git

### Local Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/devops.git
cd devops

# Install dependencies
make install-deps

# Run application
make run

# Run tests
make test
```

## Coding Standards

### Python
- Follow PEP 8
- Use meaningful variable names
- Add docstrings to functions
- Keep functions focused and small

### Docker
- Use multi-stage builds
- Minimize layers
- Don't run as root
- Add health checks

### Kubernetes
- Use resource limits
- Add labels
- Include health probes
- Use ConfigMaps for configuration

### Documentation
- Update README for significant changes
- Add comments for complex logic
- Update relevant guides in docs/

## Testing

Before submitting:

```bash
# Run tests
make test

# Lint code
make lint

# Test Docker build
make build

# Test full deployment
make deploy
```

## Commit Messages

Use clear, descriptive commit messages:

```
Add feature for X

- Implement Y
- Update Z
- Fix W

Resolves #123
```

## Review Process

1. Automated checks must pass
2. At least one maintainer review required
3. Address review comments
4. Keep PR scope focused
5. Squash commits if requested

## Getting Help

- Open an issue with the "question" label
- Check existing documentation
- Review closed issues and PRs

## Areas for Contribution

- Documentation improvements
- Bug fixes
- New examples
- CI/CD enhancements
- Security improvements
- Performance optimizations
- New DevOps tools integration

## Recognition

Contributors will be:
- Listed in README
- Credited in release notes
- Thanked in the community

Thank you for contributing! 🎉
