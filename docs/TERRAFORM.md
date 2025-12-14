# Terraform Guide

## Overview
Terraform is an Infrastructure as Code (IaC) tool that allows you to define and provision infrastructure using declarative configuration files.

## Key Concepts

### 1. Infrastructure as Code
Define infrastructure in code that can be versioned, shared, and reused.

### 2. Declarative Configuration
Describe the desired end state, Terraform handles the how.

### 3. Providers
Plugins that interact with cloud providers (AWS, Azure, GCP, etc.).

### 4. Resources
Infrastructure components (VMs, networks, databases, etc.).

### 5. State
Terraform tracks the current state of your infrastructure.

## Project Structure

```
terraform/
└── aws/
    ├── main.tf        # Main configuration
    ├── variables.tf   # Variable definitions
    └── outputs.tf     # Output values
```

## Basic Workflow

### 1. Initialize
Download providers and prepare working directory:

```bash
cd terraform/aws
terraform init
```

### 2. Plan
Preview changes before applying:

```bash
terraform plan
```

### 3. Apply
Create or update infrastructure:

```bash
terraform apply
```

### 4. Destroy
Remove all infrastructure:

```bash
terraform destroy
```

## Common Commands

### Workspace Management
```bash
# List workspaces
terraform workspace list

# Create workspace
terraform workspace new production

# Switch workspace
terraform workspace select production
```

### State Management
```bash
# Show current state
terraform show

# List resources in state
terraform state list

# Show specific resource
terraform state show aws_instance.app

# Remove resource from state
terraform state rm aws_instance.app

# Pull remote state
terraform state pull
```

### Validation and Formatting
```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Format recursively
terraform fmt -recursive
```

### Import Existing Resources
```bash
terraform import aws_instance.app i-1234567890abcdef0
```

## Configuration Examples

### Variables

**variables.tf**
```hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

**Usage**
```hcl
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  # ...
}
```

### Outputs

**outputs.tf**
```hcl
output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_eip.app.public_ip
}
```

**Usage**
```bash
terraform output instance_public_ip
```

### Data Sources

Query existing infrastructure:

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "app" {
  ami = data.aws_ami.ubuntu.id
  # ...
}
```

### Locals

Define local values:

```hcl
locals {
  common_tags = {
    Environment = var.environment
    Project     = "DevOps Demo"
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "app" {
  tags = merge(
    local.common_tags,
    {
      Name = "app-server"
    }
  )
}
```

## AWS Infrastructure Setup

Our configuration creates:
- VPC with public subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance
- Elastic IP

### Customize Variables

Create `terraform.tfvars`:

```hcl
aws_region         = "us-west-2"
environment        = "production"
instance_type      = "t3.medium"
key_name           = "my-keypair"
allowed_ssh_cidrs  = ["1.2.3.4/32"]
```

### Deploy Infrastructure

```bash
cd terraform/aws

# Initialize
terraform init

# Plan with variables
terraform plan -var-file="terraform.tfvars"

# Apply
terraform apply -var-file="terraform.tfvars"

# Get outputs
terraform output
```

## State Management

### Local State
Default, stores state in `terraform.tfstate` file.

### Remote State (S3)
Store state remotely for team collaboration:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

**Setup**:
1. Create S3 bucket
2. Create DynamoDB table for locking
3. Configure backend
4. Run `terraform init -migrate-state`

## Best Practices

### 1. Version Control
- Commit `.tf` files
- Ignore `.tfstate` files
- Use `.gitignore`

### 2. Use Variables
- Don't hardcode values
- Use `variables.tf`
- Provide defaults

### 3. Organize Code
- Separate environments
- Use modules
- Keep it DRY

### 4. State Management
- Use remote state for teams
- Enable state locking
- Never edit state manually

### 5. Security
- Don't commit secrets
- Use AWS Secrets Manager
- Encrypt state files
- Use IAM roles

### 6. Documentation
- Comment complex logic
- Maintain README
- Document variables

### 7. Testing
- Use `terraform plan`
- Test in dev environment
- Use `terraform validate`

## Modules

Create reusable components:

**modules/vpc/main.tf**
```hcl
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  # ...
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  # ...
}
```

**Use module**:
```hcl
module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
}
```

## Provisioners

Execute scripts during resource creation:

```hcl
resource "aws_instance" "app" {
  # ...

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
```

## Multi-Environment Setup

### Using Workspaces
```bash
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

terraform workspace select dev
terraform apply
```

### Using Directories
```
terraform/
├── dev/
├── staging/
└── prod/
```

## Troubleshooting

### Error: Resource already exists
```bash
terraform import <resource_type>.<name> <id>
```

### State is locked
```bash
terraform force-unlock <lock-id>
```

### Refresh state
```bash
terraform refresh
```

### Debug mode
```bash
export TF_LOG=DEBUG
terraform apply
```

## Advanced Topics

### Dynamic Blocks
```hcl
dynamic "ingress" {
  for_each = var.ingress_rules
  content {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_blocks
  }
}
```

### Count and For Each
```hcl
resource "aws_instance" "app" {
  count         = 3
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "app-server-${count.index}"
  }
}
```

### Conditional Resources
```hcl
resource "aws_eip" "app" {
  count    = var.create_eip ? 1 : 0
  instance = aws_instance.app.id
}
```

## Cost Estimation

Use Terraform Cloud or Infracost:

```bash
# Install Infracost
brew install infracost

# Get cost estimate
infracost breakdown --path .
```

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [Best Practices](https://www.terraform-best-practices.com/)
- [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
