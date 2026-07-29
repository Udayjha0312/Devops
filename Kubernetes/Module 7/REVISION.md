# 📚 Kubernetes Module 7 – Quick Revision

> **Configuration & Security**

---

# 1. ConfigMap

### Definition

Stores **non-sensitive configuration** separately from container images.

### Examples

* Database Host
* Port
* API URL
* Feature Flags
* Log Level
* Timeout

### Use Cases

* Environment variables
* Mounted files

### Commands

```bash
kubectl get configmaps
kubectl describe configmap <name>
kubectl create configmap <name> --from-literal=key=value
```

---

# 2. Secret

### Definition

Stores **sensitive data**.

### Examples

* Passwords
* API Keys
* JWT Secrets
* TLS Certificates

### Important

* Base64 = Encoding ❌ Encryption
* Protect using RBAC and encryption at rest.

### Commands

```bash
kubectl get secrets
kubectl describe secret <name>
kubectl create secret generic <name>
```

---

# 3. ConfigMap vs Secret

| ConfigMap     | Secret      |
| ------------- | ----------- |
| Non-sensitive | Sensitive   |
| DB Host       | DB Password |
| Log Level     | API Key     |
| Port          | JWT Secret  |

---

# 4. Service Account

### Definition

Identity used by Pods to communicate with the Kubernetes API Server.

### Production Best Practice

* One Service Account per application.
* Avoid using the default Service Account in production.

Example:

* frontend-sa
* backend-sa
* monitoring-sa

### Commands

```bash
kubectl get serviceaccounts
kubectl describe serviceaccount <name>
```

---

# 5. Authentication vs Authorization

### Authentication

**Who are you?**

Handled using:

* Service Account
* Token
* API Server

---

### Authorization

**What can you do?**

Handled using:

* RBAC

---

# 6. RBAC

### Definition

Controls what authenticated identities are allowed to do.

### Components

* Role
* ClusterRole
* RoleBinding
* ClusterRoleBinding

### Principle

**Least Privilege**

Grant only the permissions required.

---

# 7. Role vs ClusterRole

| Role        | ClusterRole        |
| ----------- | ------------------ |
| Namespace   | Cluster            |
| RoleBinding | ClusterRoleBinding |

---

# 8. Requests & Limits

### Requests

* Minimum guaranteed resources.
* Used by the Scheduler.

Example:

```yaml
requests:
  cpu: "500m"
  memory: "512Mi"
```

---

### Limits

* Maximum allowed resources.
* Enforced at runtime.

Example:

```yaml
limits:
  cpu: "1"
  memory: "1Gi"
```

---

# CPU vs Memory

| CPU       | Memory    |
| --------- | --------- |
| Throttled | OOMKilled |

---

# Scheduler Uses

✅ Requests

❌ Limits

---

# QoS Classes

### Guaranteed

Requests = Limits

Highest priority.

---

### Burstable

Requests ≠ Limits

Most common in production.

---

### BestEffort

No requests or limits.

Lowest priority.

---

# 9. Security Context

### Definition

Controls how a Pod or container runs securely.

### Features

* runAsNonRoot
* runAsUser
* readOnlyRootFilesystem
* Linux Capabilities
* privileged

### Best Practices

* Run as non-root.
* Read-only root filesystem.
* Avoid privileged containers.
* Grant only required capabilities.

---

# 10. Production Security Layers

```text
Application
      │
      ▼
Security Context
      │
      ▼
Service Account
      │
      ▼
Authentication
      │
      ▼
API Server
      │
      ▼
RBAC
      │
      ▼
ConfigMap / Secret
```

---

# Production Best Practices

* Trusted container images.
* Version-pinned images.
* ConfigMaps for configuration.
* Secrets for credentials.
* Dedicated Service Accounts.
* Least-Privilege RBAC.
* Resource Requests & Limits.
* Non-root containers.
* Read-only root filesystem.
* Avoid privileged containers.

---

# Common Problems

### OOMKilled

Cause:

Memory limit exceeded.

---

### CPU Throttling

Cause:

CPU limit exceeded.

---

### Pending Pod

Cause:

Insufficient requested resources.

Check:

```bash
kubectl describe pod <pod-name>
```

---

### 403 Forbidden

Cause:

RBAC or Service Account issue.

---

### Read-only File System

Cause:

`readOnlyRootFilesystem: true`

---

# Important Commands

```bash
kubectl get configmaps
kubectl get secrets
kubectl get serviceaccounts
kubectl get roles
kubectl get rolebindings
kubectl get clusterroles
kubectl get clusterrolebindings

kubectl describe pod <pod-name>

kubectl top pods
kubectl top nodes
```

---

# Interview One-Liners

### ConfigMap

Stores non-sensitive configuration.

---

### Secret

Stores sensitive data securely.

---

### Service Account

Identity used by Pods.

---

### RBAC

Controls permissions.

---

### Requests

Minimum guaranteed resources.

---

### Limits

Maximum allowed resources.

---

### CPU Limit

CPU is throttled.

---

### Memory Limit

Container is OOMKilled.

---

### Security Context

Controls container security settings.

---

### Principle of Least Privilege

Grant only the permissions required.

---

# 5-Minute Mind Map

```text
Module 7
│
├── ConfigMap
│     └── Non-sensitive Configuration
│
├── Secret
│     └── Sensitive Data
│
├── Service Account
│     └── Pod Identity
│
├── RBAC
│     ├── Role
│     ├── ClusterRole
│     ├── RoleBinding
│     └── ClusterRoleBinding
│
├── Requests
│     └── Scheduler
│
├── Limits
│     ├── CPU → Throttling
│     └── Memory → OOMKilled
│
├── Security Context
│     ├── Non-root
│     ├── Read-only FS
│     └── Minimal Privileges
│
└── Production Security
      ├── Trusted Images
      ├── Secrets
      ├── RBAC
      ├── Service Accounts
      └── Least Privilege
```
