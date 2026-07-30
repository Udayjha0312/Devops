# 📘 Helm Revision Notes

## Module 11 – Helm Package Manager

---

# 🚀 Helm Overview

* Helm is the **Package Manager for Kubernetes**.
* Helm packages Kubernetes applications into **Charts**.
* It simplifies installation, upgrades, rollbacks, and configuration management.

---

# 📦 Chart

A **Chart** is a reusable package containing Kubernetes manifests and templates.

### Components

* `Chart.yaml` → Metadata
* `values.yaml` → Default configuration
* `templates/` → Kubernetes templates
* `charts/` → Dependencies
* `crds/` → Custom Resource Definitions
* `.helmignore` → Ignore files during packaging

---

# 🚀 Release

A **Release** is a deployed instance of a Helm Chart.

```
Chart
   │
   ├── dev-release
   ├── stage-release
   └── prod-release
```

One Chart can create multiple Releases.

---

# ⚙️ values.yaml

Stores configurable values used by templates.

Example:

```yaml
replicaCount: 3

image:
  repository: nginx
  tag: "1.28"
```

Access in templates:

```yaml
{{ .Values.replicaCount }}

{{ .Values.image.repository }}
```

---

# 📑 Value Precedence

```
--set
   ↓
Custom Values File (-f)
   ↓
values.yaml
```

Highest priority:

```
--set
```

---

# 📄 Templates

Templates are Kubernetes YAML files with Go template syntax.

Common template functions:

* `.Values`
* `if`
* `range`
* `default`
* `include`

Render locally:

```bash
helm template my-app ./chart
```

---

# 📚 Helm Repository

Stores Helm Charts.

Similar to Docker Hub.

Popular repositories:

* Bitnami
* Prometheus Community
* Grafana
* ingress-nginx
* Jetstack
* Argo

Commands:

```bash
helm repo add

helm repo update

helm repo list

helm search repo
```

---

# 📦 Dependencies

Defined in:

```
Chart.yaml
```

Downloaded using:

```bash
helm dependency update
```

Stored in:

```
charts/
```

Used to bundle applications like:

* Redis
* PostgreSQL
* RabbitMQ

with your application.

---

# 🔄 Upgrade

Update an existing Release.

```bash
helm upgrade my-app ./chart
```

Install if missing:

```bash
helm upgrade --install my-app ./chart
```

---

# ⏪ Rollback

Restore a previous Release Revision.

View history:

```bash
helm history my-app
```

Rollback:

```bash
helm rollback my-app 2
```

---

# 📜 Release History

Every successful upgrade creates a new Revision.

```
Revision 1

↓

Revision 2

↓

Revision 3
```

Rollback restores an older revision.

---

# 🔍 Validation

Validate Chart:

```bash
helm lint ./chart
```

Render manifests:

```bash
helm template my-app ./chart
```

View deployed manifests:

```bash
helm get manifest my-app
```

View deployed values:

```bash
helm get values my-app
```

---

# ⭐ Production Best Practices

* Separate `values-dev.yaml`, `values-stage.yaml`, and `values-prod.yaml`
* Never use `latest` image tags
* Don't modify community Charts directly
* Store secrets outside `values.yaml`
* Use `helm lint` before deployment
* Review manifests using `helm template`
* Use `--wait`
* Use `--atomic`
* Pin dependency versions
* Integrate Helm into CI/CD

---

# 🛠️ Common Commands

```bash
helm version

helm repo add

helm repo update

helm repo list

helm search repo

helm create

helm install

helm upgrade

helm upgrade --install

helm list

helm status

helm history

helm rollback

helm template

helm lint

helm get values

helm get manifest

helm dependency update

helm dependency build

helm uninstall
```

---

# 🎯 Frequently Asked Interview Points

* Helm = Package Manager
* Chart = Blueprint
* Release = Running Installation
* Repository = Stores Charts
* values.yaml = Configuration
* Templates = Dynamic YAML
* Dependencies = Child Charts
* Revision = Release Version
* Rollback = Restore Previous Version
* `helm lint` = Validate Chart
* `helm template` = Render YAML
* `helm upgrade --install` = Install if absent, upgrade if present
* `--wait` = Wait for resources to become Ready
* `--atomic` = Automatically rollback if deployment fails

---

# 🏭 Production Deployment Flow

```
Developer
      │
      ▼
Git Push
      │
      ▼
CI/CD Pipeline
      │
      ├── helm lint
      ├── helm template
      ├── Security Scan
      ▼
helm upgrade --install \
--wait \
--atomic
      │
      ▼
Kubernetes Cluster
```

---

# 🧠 Memory Map

```
Helm
│
├── Chart
│      ├── Chart.yaml
│      ├── values.yaml
│      ├── templates/
│      └── charts/
│
├── Repository
│
├── Release
│      ├── Install
│      ├── Upgrade
│      ├── History
│      └── Rollback
│
├── Dependencies
│
└── Production
       ├── lint
       ├── template
       ├── wait
       ├── atomic
       ├── values files
       └── CI/CD
```
