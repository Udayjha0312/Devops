# 🛠️ Kubernetes Module 7 – Troubleshooting Guide

> **Configuration & Security Troubleshooting**

---

# Troubleshooting Methodology

Whenever a Pod fails, follow this order:

```text
Pod Status
     │
     ▼
kubectl describe pod
     │
     ▼
Events
     │
     ▼
Logs
     │
     ▼
Configuration
     │
     ▼
Fix
```

Useful commands:

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get events --sort-by=.lastTimestamp
```

---

# Scenario 1 – ConfigMap Not Found

## Symptoms

```
CreateContainerConfigError
```

or

```
configmap "app-config" not found
```

## Investigation

```bash
kubectl get configmaps
kubectl describe pod <pod-name>
```

## Possible Causes

* ConfigMap doesn't exist.
* Wrong ConfigMap name.
* Wrong namespace.
* Typo in Deployment YAML.

## Solution

* Create the ConfigMap.
* Correct the name.
* Deploy it in the correct namespace.
* Restart the Pod if environment variables are used.

---

# Scenario 2 – ConfigMap Changes Not Visible

## Symptoms

Application still uses old configuration.

## Investigation

```bash
kubectl describe configmap app-config
```

## Cause

Environment variables are loaded only when the container starts.

## Solution

Restart the Deployment.

```bash
kubectl rollout restart deployment <deployment-name>
```

> Mounted ConfigMap files update automatically after a short delay, but many applications still need to reload or restart to use the new values.

---

# Scenario 3 – Secret Not Found

## Symptoms

```
CreateContainerConfigError
```

or

```
secret "db-secret" not found
```

## Investigation

```bash
kubectl get secrets
kubectl describe pod <pod-name>
```

## Solution

* Verify Secret exists.
* Check Secret name.
* Check namespace.
* Recreate if necessary.

---

# Scenario 4 – Wrong Secret Values

## Symptoms

Application starts but cannot connect.

Examples:

```
Database authentication failed
```

```
Invalid API Key
```

## Investigation

```bash
kubectl logs <pod-name>
kubectl describe secret db-secret
```

## Possible Causes

* Wrong username.
* Wrong password.
* Incorrect key names.
* Application expecting different environment variable names.

## Solution

Correct the Secret and restart the workload if necessary.

---

# Scenario 5 – 403 Forbidden

## Symptoms

```
403 Forbidden
```

```
User "system:serviceaccount:..." cannot get pods
```

## Investigation

```bash
kubectl describe pod <pod-name>

kubectl get serviceaccounts

kubectl get roles

kubectl get rolebindings
```

## Possible Causes

* Wrong Service Account.
* Missing Role.
* Missing RoleBinding.
* Incorrect permissions.

## Solution

Grant only the permissions required using RBAC.

---

# Scenario 6 – Unauthorized (401)

## Symptoms

```
401 Unauthorized
```

## Difference

| Error | Meaning               |
| ----- | --------------------- |
| 401   | Authentication failed |
| 403   | Authorization failed  |

## Investigation

Verify:

* Service Account
* Authentication token
* API Server access

---

# Scenario 7 – OOMKilled

## Symptoms

```
OOMKilled
```

Pod repeatedly restarts.

## Investigation

```bash
kubectl describe pod <pod-name>

kubectl top pod <pod-name>
```

## Cause

Memory usage exceeded the configured limit.

## Solution

* Increase memory limit if appropriate.
* Investigate memory leaks.
* Optimize the application.

---

# Scenario 8 – CPU Throttling

## Symptoms

Application is slow during high load.

No restart occurs.

## Investigation

```bash
kubectl top pod <pod-name>
```

Compare CPU usage with configured limits.

## Cause

CPU limit reached.

## Solution

* Increase CPU limit if justified.
* Optimize the application.
* Scale horizontally.

---

# Scenario 9 – Pod Stuck in Pending

## Symptoms

```
Pending
```

## Investigation

```bash
kubectl describe pod <pod-name>
```

Possible Events

```
Insufficient cpu
```

or

```
Insufficient memory
```

## Cause

Scheduler cannot satisfy the Pod's resource requests.

## Solution

* Reduce requests if appropriate.
* Add cluster capacity.
* Schedule onto a suitable node.

---

# Scenario 10 – Read-only File System

## Symptoms

```
Read-only file system
```

Application cannot create or modify files.

## Investigation

Check:

```yaml
securityContext:
  readOnlyRootFilesystem: true
```

## Solution

Mount a writable volume for application data instead of making the root filesystem writable.

---

# Scenario 11 – Container Won't Start with runAsNonRoot

## Symptoms

```
container has runAsNonRoot and image will run as root
```

## Cause

The container image only supports running as root.

## Solution

* Use a non-root compatible image.
* Rebuild the image with a non-root user.
* Configure `runAsUser` correctly.

---

# Scenario 12 – Privileged Container Security Risk

## Symptoms

Security review flags:

```yaml
privileged: true
```

## Cause

Container has excessive privileges.

## Solution

* Remove privileged mode.
* Use Linux capabilities instead.
* Grant only required permissions.

---

# Scenario 13 – Application Using Default Service Account

## Symptoms

```
serviceAccountName: default
```

## Risk

Multiple workloads share the same identity.

## Solution

Create a dedicated Service Account.

Example:

```
frontend-sa
backend-sa
monitoring-sa
```

---

# Scenario 14 – Password Stored in ConfigMap

## Symptoms

Sensitive data appears inside:

```yaml
kind: ConfigMap
```

## Risk

Credentials are treated as ordinary configuration.

## Solution

Move sensitive values into a Secret.

---

# Scenario 15 – Resource Requests Too High

## Symptoms

Pods remain Pending despite low application load.

## Investigation

```bash
kubectl describe pod <pod-name>
```

## Cause

Requests are larger than available node resources.

Example:

```
Request

8 CPU

Node

4 CPU
```

## Solution

Set realistic requests based on observed usage.

---

# Production Troubleshooting Checklist

```
Pod Not Starting
│
├── Describe Pod
├── Events
├── Logs
├── ConfigMap
├── Secret
├── Service Account
├── RBAC
├── Requests & Limits
├── Security Context
└── Namespace
```

---

# Essential Commands

```bash
kubectl get pods

kubectl describe pod <pod-name>

kubectl logs <pod-name>

kubectl get configmaps

kubectl get secrets

kubectl get serviceaccounts

kubectl get roles

kubectl get rolebindings

kubectl get clusterroles

kubectl get clusterrolebindings

kubectl top pods

kubectl top nodes

kubectl rollout restart deployment <deployment-name>
```

---

# Interview Scenarios

### 1. Pod shows `CreateContainerConfigError`.

Check:

* ConfigMap
* Secret
* Namespace
* Resource names

---

### 2. Pod shows `OOMKilled`.

Check:

* Memory limit
* Memory usage
* Memory leak
* Requests & Limits

---

### 3. Application receives `403 Forbidden`.

Check:

* Service Account
* Role
* RoleBinding
* ClusterRole
* ClusterRoleBinding

---

### 4. Application cannot write files.

Check:

* Security Context
* Read-only filesystem
* Mounted writable volume

---

### 5. Pod remains Pending.

Check:

* Resource requests
* Node capacity
* Scheduling events

---

# Golden Rule

Whenever a Kubernetes workload fails, investigate in this order:

```
Pod
 │
 ▼
Describe
 │
 ▼
Events
 │
 ▼
Logs
 │
 ▼
Configuration
 │
 ├── ConfigMap
 ├── Secret
 ├── Service Account
 ├── RBAC
 ├── Requests
 ├── Limits
 └── Security Context
 │
 ▼
Apply Fix
```

Following this sequence will solve the majority of configuration and security issues you'll encounter in Module 7 and forms a strong foundation for troubleshooting production Kubernetes clusters.
