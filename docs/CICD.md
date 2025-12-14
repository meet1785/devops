# CI/CD Guide

## Overview
Continuous Integration and Continuous Deployment (CI/CD) automate the software delivery process from code commit to production deployment.

## CI/CD Pipeline

Our project uses GitHub Actions for CI/CD automation.

### Pipeline Stages

1. **Test**: Run linting and tests
2. **Security**: Scan for vulnerabilities
3. **Build**: Build Docker image
4. **Deploy**: Deploy to environments

## GitHub Actions Workflows

### Main CI/CD Workflow
`.github/workflows/ci-cd.yml`

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main`

**Jobs:**
1. **test**: Lint and run tests
2. **security**: Security scanning with Trivy
3. **build**: Build and test Docker image
4. **deploy-staging**: Deploy to staging (main branch only)
5. **deploy-production**: Deploy to production (requires approval)

### Docker Publish Workflow
`.github/workflows/docker-publish.yml`

**Triggers:**
- Tags matching `v*` (e.g., v1.0.0)

**Purpose:**
- Build multi-platform Docker images
- Push to Docker Hub

## Workflow Examples

### Running Tests

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    - name: Install dependencies
      run: |
        pip install -r app/requirements.txt
        pip install pytest flake8
    - name: Run tests
      run: pytest app/
```

### Building Docker Images

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v3
    - name: Build image
      uses: docker/build-push-action@v5
      with:
        context: .
        push: false
        tags: devops-demo-app:latest
```

### Deploying to Kubernetes

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Configure kubectl
      uses: azure/setup-kubectl@v3
    - name: Deploy
      run: |
        kubectl apply -f kubernetes/
```

## Secrets Management

Store sensitive data in GitHub Secrets:

1. Go to repository Settings > Secrets and variables > Actions
2. Add secrets:
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`
   - `KUBECONFIG`
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

Use in workflows:
```yaml
- name: Login to Docker Hub
  uses: docker/login-action@v3
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
```

## Environments

GitHub Environments provide deployment controls:

- **staging**: Auto-deploy on main branch
- **production**: Requires manual approval

Configure in Settings > Environments:
1. Create environment
2. Add protection rules
3. Set required reviewers
4. Configure secrets

## Best Practices

### 1. Fast Feedback
- Run tests early in pipeline
- Fail fast on errors
- Parallel jobs when possible

### 2. Security
- Scan for vulnerabilities
- Never commit secrets
- Use secrets management
- Minimal permissions for tokens

### 3. Reproducibility
- Pin action versions
- Use Docker for consistent environments
- Version all dependencies

### 4. Efficiency
- Use caching for dependencies
- Optimize Docker builds
- Skip unnecessary steps

### 5. Reliability
- Retry failed steps
- Use health checks
- Automated rollback on failure

## Local Testing

Test workflows locally with [act](https://github.com/nektos/act):

```bash
# Install act
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Run workflow
act -W .github/workflows/ci-cd.yml

# Run specific job
act -j test
```

## Deployment Strategies

### 1. Continuous Deployment
Every commit to main automatically deploys to production.

### 2. Continuous Delivery
Manual approval required for production.

### 3. Feature Branches
Deploy feature branches to temporary environments.

## Monitoring CI/CD

### View Workflow Runs
```bash
gh run list
gh run view <run-id>
gh run watch
```

### Debug Failed Runs
```bash
gh run view <run-id> --log-failed
```

### Re-run Failed Jobs
```bash
gh run rerun <run-id>
```

## Advanced Topics

### Matrix Builds
Test multiple versions:

```yaml
jobs:
  test:
    strategy:
      matrix:
        python-version: [3.9, 3.10, 3.11]
    steps:
    - uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
```

### Conditional Execution

```yaml
- name: Deploy
  if: github.ref == 'refs/heads/main'
  run: ./deploy.sh
```

### Artifacts

```yaml
- name: Upload artifact
  uses: actions/upload-artifact@v3
  with:
    name: test-results
    path: test-results/
```

## Troubleshooting

### Workflow not triggering
- Check branch names in workflow
- Verify file paths
- Check workflow permissions

### Job failing
- Check job logs
- Verify environment variables
- Test commands locally

### Permission errors
- Update workflow permissions
- Check token scopes
- Verify secrets

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [Awesome Actions](https://github.com/sdras/awesome-actions)
