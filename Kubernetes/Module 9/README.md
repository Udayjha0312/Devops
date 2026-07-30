# ☸️ Module 11 – Helm Package Manager

## 📌 Overview

This module covers **Helm**, the package manager for Kubernetes. It introduces Helm architecture, Charts, templates, values, repositories, releases, dependencies, rollbacks, and production best practices.

By the end of this module, you'll be able to package Kubernetes applications, deploy them consistently across environments, manage application lifecycles, and perform production-grade upgrades and rollbacks using Helm.

---

# 📚 Topics Covered

### 1. What is Helm?

* Introduction to Helm
* Why Helm is needed
* Helm vs `kubectl`
* Helm workflow
* Advantages and limitations
* Production use cases

---

### 2. Why Helm?

* Problems with managing raw Kubernetes YAML
* Reusability
* Environment-specific deployments
* Upgrade and rollback capabilities
* Configuration management

---

### 3. Helm Architecture

* Helm CLI
* Kubernetes API Server
* Chart
* Release
* Repository
* Helm 2 vs Helm 3 (Removal of Tiller)
* Template rendering workflow

---

### 4. Helm Charts

* What is a Chart?
* Chart lifecycle
* Chart components
* Chart versioning
* `Chart.yaml`
* `appVersion`
* Community Charts

---

### 5. Chart Directory Structure

Understanding the structure of a Helm Chart:

```text
my-chart/
├── Chart.yaml
├── values.yaml
├── charts/
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── _helpers.tpl
│   └── NOTES.txt
├── crds/
└── .helmignore
```

---

### 6. Helm Templates

* Go templating
* Variables
* `.Values`
* `if`
* `range`
* Default values
* Helper templates
* Template rendering

---

### 7. values.yaml

* Default configuration
* Environment-specific values
* Nested values
* Overriding values
* Value precedence
* Multiple values files

---

### 8. Helm Repositories

* Public repositories
* Private repositories
* Repository structure
* Searching Charts
* Installing Charts
* Downloading Charts
* Updating repository indexes

---

### 9. Helm Releases

* Chart vs Release
* Release lifecycle
* Release revisions
* Release status
* Release inspection
* Multiple releases from one Chart

---

### 10. Helm Dependencies

* Parent and child Charts
* Dependency management
* `Chart.yaml` dependencies
* `helm dependency update`
* `helm dependency build`
* Configuring dependencies
* Dependency versioning

---

### 11. Helm Rollbacks

* Release history
* Revision management
* Rollback workflow
* Rollback commands
* Production rollback strategies

---

### 12. Production Helm Best Practices

* Environment-specific values files
* Avoid modifying community Charts
* Versioned container images
* Secret management
* `helm lint`
* `helm template`
* `--atomic`
* `--wait`
* CI/CD integration
* Release naming conventions
* Dependency version pinning

---

# 🛠️ Common Helm Commands

```bash
# Check Helm version
helm version

# Add repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# List repositories
helm repo list

# Update repositories
helm repo update

# Search Charts
helm search repo nginx

# Download Chart
helm pull bitnami/nginx

# Create Chart
helm create my-chart

# Install Chart
helm install my-app ./my-chart

# Upgrade Release
helm upgrade my-app ./my-chart

# Upgrade or Install
helm upgrade --install my-app ./my-chart

# List Releases
helm list

# View Release Status
helm status my-app

# View Release History
helm history my-app

# Rollback Release
helm rollback my-app 2

# View Rendered YAML
helm get manifest my-app

# View Values
helm get values my-app

# Render Templates Locally
helm template my-app ./my-chart

# Validate Chart
helm lint ./my-chart

# Download Dependencies
helm dependency update

# Build Dependencies
helm dependency build

# Uninstall Release
helm uninstall my-app
```

---

# 🏭 Production Concepts Learned

* Package management for Kubernetes
* Reusable application deployment
* Environment-specific configuration
* Release lifecycle management
* Chart repositories
* Template rendering
* Configuration separation
* Revision history
* Safe upgrades
* Rollback strategies
* Dependency management
* CI/CD integration
* Production deployment practices

---

# 🎯 Production Scenarios Covered

* Deploying applications using community Helm Charts
* Managing Development, Staging, and Production environments
* Rolling back failed deployments
* Installing complete application stacks using dependencies
* Environment-specific configuration management
* CI/CD deployment automation
* Safe production upgrades using `--atomic`
* Secure secret handling
* Release history inspection
* Production deployment validation

---

# 💼 Interview Topics Covered

* What is Helm?
* Helm vs kubectl
* Helm Architecture
* Helm Charts
* Chart structure
* Templates
* values.yaml
* Value precedence
* Helm Repositories
* Chart vs Release
* Release revisions
* Helm Dependencies
* Rollbacks
* `helm lint`
* `helm template`
* `helm upgrade --install`
* `--wait`
* `--atomic`
* Production best practices
* Common troubleshooting scenarios

---

# 🚀 Skills Acquired

After completing this module, you will be able to:

* Understand Helm architecture
* Create and customize Helm Charts
* Use templates and `values.yaml`
* Install applications from Helm repositories
* Manage Helm Releases
* Configure Chart dependencies
* Perform upgrades and rollbacks
* Validate Charts before deployment
* Deploy applications across multiple environments
* Integrate Helm into CI/CD pipelines
* Apply production-ready deployment practices

---

# 📂 Suggested Repository Structure

```text
11-helm/
│
├── README.md
├── Revision.md
├── Troubleshooting.md
├── Charts/
├── Examples/
├── values-dev.yaml
├── values-stage.yaml
├── values-prod.yaml
└── Notes/
```

---

# 📖 Learning Outcome

Upon completing this module, you should be confident in using **Helm as the package manager for Kubernetes**, enabling you to package, configure, deploy, upgrade, and roll back applications efficiently. You'll also understand how Helm fits into modern DevOps workflows and CI/CD pipelines while following production-grade best practices used in enterprise Kubernetes environments.

---

## 🛠️ Tech Stack

* Kubernetes
* Helm
* YAML
* Go Templates
* Kubernetes API Server
* Docker
* Git
* CI/CD (Jenkins / GitHub Actions / GitLab CI)

---
