# ☸️ Module 7 – Kubernetes Configuration & Security

## 📌 Overview

This module covers how Kubernetes manages **application configuration, sensitive data, identities, permissions, resource management, and container security**.

By the end of this module, you'll understand how to securely configure applications, implement the Principle of Least Privilege, manage workload identities, and apply production-grade security practices in Kubernetes clusters.

---

# 📚 Topics Covered

* ConfigMaps
* Creating & Using ConfigMaps
* Secrets
* ConfigMaps vs Secrets
* Service Accounts
* RBAC (Role-Based Access Control)
* Resource Requests & Limits
* Security Contexts
* Production Security Best Practices

---

# 🎯 Learning Outcomes

After completing this module, you will be able to:

* Store application configuration using ConfigMaps.
* Store sensitive information securely using Secrets.
* Differentiate between ConfigMaps and Secrets.
* Understand Kubernetes Service Accounts.
* Implement Role-Based Access Control (RBAC).
* Configure CPU and Memory Requests & Limits.
* Secure containers using Security Contexts.
* Apply Kubernetes production security best practices.
* Troubleshoot common configuration and security issues.

---

# 🏗️ Module Architecture

```text
                     Kubernetes Security

                             │

     ┌──────────────┬─────────┴──────────────┬───────────────┐
     │              │                        │               │
     ▼              ▼                        ▼               ▼
 ConfigMaps      Secrets            Service Accounts      RBAC
     │              │                        │               │
     └──────────────┴──────────────┬─────────┘               │
                                   ▼                         ▼
                            Application Identity      Permissions
                                   │
                                   ▼
                           Security Context
                                   │
                                   ▼
                      Requests & Limits
                                   │
                                   ▼
                          Production Security
```

---

# 📖 Key Concepts

## 1. ConfigMaps

### Purpose

Store **non-sensitive** application configuration.

### Examples

* Database Host
* Application Port
* API URL
* Feature Flags
* Log Level
* Timeout Values

### Benefits

* No image rebuilds for configuration changes
* Environment-specific configuration
* Centralized configuration management

---

## 2. Secrets

### Purpose

Store **sensitive** application data.

### Examples

* Database Passwords
* API Keys
* JWT Secrets
* OAuth Tokens
* TLS Certificates
* SSH Keys

### Notes

* Stored as Base64-encoded values.
* Base64 is **encoding**, **not encryption**.
* Protect Secrets using RBAC and encryption at rest where available.

---

## 3. ConfigMaps vs Secrets

| ConfigMap                   | Secret                |
| --------------------------- | --------------------- |
| Non-sensitive configuration | Sensitive information |
| Database Host               | Database Password     |
| Log Level                   | API Key               |
| Application Port            | JWT Secret            |
| Feature Flags               | TLS Certificate       |

---

## 4. Service Accounts

### Purpose

Provide an identity for Pods when communicating with the Kubernetes API Server.

### Production Best Practice

Create dedicated Service Accounts.

Examples:

* frontend-sa
* backend-sa
* monitoring-sa
* backup-sa

Avoid relying on the default Service Account for production workloads.

---

## 5. RBAC (Role-Based Access Control)

### Purpose

Control what authenticated users and Service Accounts are allowed to do.

### Components

```text
RBAC

├── Role
├── ClusterRole
├── RoleBinding
└── ClusterRoleBinding
```

### Principle

Apply the **Principle of Least Privilege**.

---

## 6. Resource Requests & Limits

### Requests

Guaranteed minimum resources.

Used by the Scheduler.

### Limits

Maximum resources a container may consume.

### Important Difference

| Resource | Exceeds Limit |
| -------- | ------------- |
| CPU      | Throttled     |
| Memory   | OOMKilled     |

---

## 7. Security Contexts

### Purpose

Control how containers run securely.

### Features

* Run as Non-Root
* Read-Only Root Filesystem
* Linux Capabilities
* Privileged Mode
* User and Group IDs

### Best Practices

* Run containers as non-root.
* Avoid privileged containers.
* Use read-only root filesystems whenever possible.

---

## 8. Production Security

Layered security includes:

* Trusted Images
* ConfigMaps
* Secrets
* Service Accounts
* RBAC
* Security Contexts
* Resource Requests & Limits

---

# 🔐 Kubernetes Security Flow

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
Kubernetes API Server
      │
      ▼
RBAC Authorization
      │
      ▼
ConfigMaps / Secrets
```

---

# 📊 Authentication vs Authorization

```text
Authentication

Who are you?

↓

Service Account

↓

API Server

----------------------------

Authorization

What are you allowed to do?

↓

RBAC

↓

Allow / Deny
```

---

# 📊 ConfigMap vs Secret

| Feature                     | ConfigMap | Secret |
| --------------------------- | --------- | ------ |
| Non-sensitive Configuration | ✅         | ❌      |
| Sensitive Data              | ❌         | ✅      |
| Environment Variables       | ✅         | ✅      |
| Mounted Files               | ✅         | ✅      |
| Base64 Encoded              | ❌         | ✅      |

---

# 📊 Role vs ClusterRole

| Feature          | Role        | ClusterRole        |
| ---------------- | ----------- | ------------------ |
| Namespace Scoped | ✅           | ❌                  |
| Cluster Wide     | ❌           | ✅                  |
| Access Nodes     | ❌           | ✅                  |
| Used With        | RoleBinding | ClusterRoleBinding |

---

# 📊 Requests vs Limits

| Requests              | Limits                  |
| --------------------- | ----------------------- |
| Scheduler Uses Them   | Runtime Uses Them       |
| Minimum Guaranteed    | Maximum Allowed         |
| Determines Scheduling | Prevents Resource Abuse |

---

# 📊 CPU vs Memory

| Resource | Exceeds Limit | Result         |
| -------- | ------------- | -------------- |
| CPU      | Yes           | CPU Throttling |
| Memory   | Yes           | OOMKilled      |

---

# 🏢 Production Architecture

```text
                   Internet
                       │
                       ▼
                   Ingress
                       │
       ┌───────────────┴───────────────┐
       ▼                               ▼
Frontend Deployment            Backend Deployment
frontend-sa                    backend-sa
Security Context               Security Context
Requests/Limits                Requests/Limits
       │                               │
       └───────────────┬───────────────┘
                       ▼
                PostgreSQL StatefulSet
                       │
                    Secret
```

---

# 🛠️ Important Commands

## ConfigMaps

```bash
kubectl get configmaps
kubectl describe configmap <name>
kubectl create configmap <name> --from-literal=key=value
kubectl apply -f configmap.yaml
```

---

## Secrets

```bash
kubectl get secrets
kubectl describe secret <name>
kubectl create secret generic <name>
kubectl apply -f secret.yaml
```

---

## Service Accounts

```bash
kubectl get serviceaccounts
kubectl describe serviceaccount <name>
kubectl create serviceaccount <name>
```

---

## RBAC

```bash
kubectl get roles
kubectl get rolebindings
kubectl get clusterroles
kubectl get clusterrolebindings
kubectl describe role <name>
```

---

## Resources

```bash
kubectl top pods
kubectl top nodes
kubectl describe pod <name>
```

---

# 🚑 Troubleshooting Checklist

## ConfigMap Issues

```bash
kubectl get configmaps
kubectl describe configmap <name>
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

---

## Secret Issues

```bash
kubectl get secrets
kubectl describe secret <name>
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

---

## RBAC Issues

Symptoms:

```text
403 Forbidden
```

Check:

```bash
kubectl describe role <name>
kubectl describe rolebinding <name>
kubectl get serviceaccounts
```

---

## Resource Issues

Symptoms:

```text
OOMKilled
```

Check:

```bash
kubectl describe pod <pod-name>
kubectl top pod <pod-name>
```

---

## Pending Pods

Check:

```bash
kubectl describe pod <pod-name>
```

Look for:

* Insufficient CPU
* Insufficient Memory
* Scheduling failures

---

# 💼 Production Best Practices

* Use ConfigMaps for non-sensitive configuration.
* Use Secrets for passwords and API keys.
* Create dedicated Service Accounts.
* Apply RBAC using the Principle of Least Privilege.
* Configure Requests and Limits.
* Run containers as non-root.
* Use read-only root filesystems whenever possible.
* Avoid privileged containers.
* Use trusted, version-pinned container images.

---

# 🎯 Interview Questions

1. What is a ConfigMap?
2. What is a Secret?
3. Why shouldn't passwords be stored in ConfigMaps?
4. What is a Service Account?
5. Explain Authentication vs Authorization.
6. What is RBAC?
7. Difference between Role and ClusterRole?
8. Difference between RoleBinding and ClusterRoleBinding?
9. Difference between Requests and Limits?
10. Why does CPU throttle but Memory becomes OOMKilled?
11. What is a Security Context?
12. Why should containers run as non-root?
13. What is the Principle of Least Privilege?
14. Name five Kubernetes production security best practices.

---

# 🧠 Quick Revision

```text
ConfigMap
│
└── Non-sensitive Configuration

Secret
│
└── Sensitive Information

Service Account
│
└── Identity

RBAC
│
└── Permissions

Requests
│
└── Scheduler

Limits
│
├── CPU → Throttling
└── Memory → OOMKilled

Security Context
│
├── Non-root User
├── Read-only Root Filesystem
└── Minimal Privileges
```

---

# ✅ Module Checklist

* [x] ConfigMaps
* [x] Creating & Using ConfigMaps
* [x] Secrets
* [x] ConfigMaps vs Secrets
* [x] Service Accounts
* [x] RBAC
* [x] Resource Requests & Limits
* [x] Security Contexts
* [x] Production Security
* [x] Production Troubleshooting
* [x] Interview Preparation

---

# 🚀 Next Module

**Module 8 – Advanced Scheduling & Cluster Operations**

Topics include:

* Node Selectors
* Node Affinity
* Pod Affinity
* Pod Anti-Affinity
* Taints
* Tolerations
* Taints vs Node Affinity
* Pod Disruption Budgets
* Production Scheduling Strategies
* Cluster Maintenance
