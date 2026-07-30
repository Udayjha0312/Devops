# 🛠️ Helm Troubleshooting Guide

## Module 11 – Helm Package Manager

This guide contains common **production Helm issues**, investigation steps, commands, and resolutions frequently asked in DevOps and SRE interviews.

---

# 1. Helm Installation Fails

### Error

```text
INSTALLATION FAILED
```

### Investigation

Check:

* Chart syntax
* Chart structure
* Repository connectivity
* Kubernetes cluster status

Commands

```bash
helm lint ./chart

helm template my-app ./chart

kubectl get nodes
```

### Resolution

* Fix template/YAML errors.
* Ensure the Kubernetes cluster is healthy.
* Verify repository configuration.

---

# 2. Chart Not Found

### Error

```text
Error: chart "nginx" not found
```

### Investigation

```bash
helm repo list

helm repo update

helm search repo nginx
```

### Resolution

* Add the correct repository.
* Update the repository index.
* Verify the chart name.

---

# 3. Repository Cannot Be Reached

### Possible Causes

* Incorrect repository URL
* DNS issue
* Internet connectivity
* Repository outage

### Investigation

```bash
helm repo list

helm repo update
```

### Resolution

* Correct the repository URL.
* Check network connectivity.
* Retry after repository availability is restored.

---

# 4. Template Rendering Fails

### Error

```text
template: nil pointer evaluating...
```

### Investigation

Render locally:

```bash
helm template my-app ./chart
```

Check:

* Missing `.Values`
* Incorrect key names
* Wrong indentation
* Invalid Go template syntax

### Resolution

Correct the template or provide default values using:

```yaml
default
```

---

# 5. values.yaml Not Applied

### Symptoms

Deployment ignores configured values.

### Investigation

Check:

```bash
helm get values my-app
```

Verify:

* `values.yaml`
* Custom values files
* `--set` overrides

Remember precedence:

```text
--set
   ↓
-f values.yaml
   ↓
values.yaml
```

### Resolution

Use the correct values file and verify key names match the templates.

---

# 6. Wrong Image Version Deployed

### Investigation

```yaml
image:
  tag:
```

Check:

```bash
helm get values my-app
```

Also verify:

* `values-prod.yaml`
* `--set image.tag=...`

### Resolution

Use versioned image tags instead of `latest`.

---

# 7. Helm Upgrade Fails

### Symptoms

Upgrade stops midway.

### Investigation

```bash
helm status my-app

helm history my-app
```

Check Kubernetes Events:

```bash
kubectl get events

kubectl describe pod <pod>
```

### Resolution

Resolve the underlying Kubernetes issue or rollback to the previous revision.

---

# 8. Failed Upgrade Requires Rollback

### Investigation

View revision history:

```bash
helm history my-app
```

Rollback:

```bash
helm rollback my-app <revision>
```

Verify:

```bash
helm status my-app
```

---

# 9. Rollback Does Not Fix the Problem

### Possible Causes

* Database migration already executed
* External API failure
* Storage issue
* Incorrect Secrets
* Image removed from registry

### Investigation

Check:

```bash
kubectl logs

kubectl describe pod

kubectl get events
```

### Resolution

Remember:

Helm restores Kubernetes resources only.

Database schema changes require a separate rollback strategy.

---

# 10. Dependency Download Fails

### Investigation

```bash
helm dependency update
```

Verify:

* Repository exists
* Internet connectivity
* Dependency versions

Check:

```yaml
dependencies:
```

inside `Chart.yaml`.

### Resolution

Correct repository URL or dependency version.

---

# 11. Dependency Isn't Installed

### Investigation

Verify:

```text
charts/
```

contains downloaded dependencies.

Run:

```bash
helm dependency update
```

### Resolution

Download dependencies before installation.

---

# 12. Release Not Found

### Error

```text
Error: release not found
```

### Investigation

```bash
helm list

helm list --all-namespaces
```

### Resolution

The Release may exist in another namespace.

---

# 13. Resources Are Not Created

### Investigation

Render templates:

```bash
helm template my-app ./chart
```

Check:

```bash
kubectl get all
```

Verify:

* Conditional templates (`if`)
* Disabled resources
* Incorrect values

### Resolution

Fix template conditions or configuration.

---

# 14. Pods Are Pending After Installation

### Investigation

```bash
kubectl describe pod

kubectl get events
```

Possible causes:

* Insufficient resources
* PVC issues
* Node scheduling problems
* Image pull failures

### Resolution

Resolve the Kubernetes scheduling issue.

Helm is only the deployment tool.

---

# 15. Pods Crash After Deployment

### Investigation

```bash
kubectl logs

kubectl describe pod
```

Check:

* Environment variables
* Secrets
* ConfigMaps
* Database connectivity

### Resolution

Fix the application configuration or rollback.

---

# 16. Ingress Not Created

### Investigation

Verify:

```yaml
ingress:
  enabled: true
```

Render:

```bash
helm template my-app ./chart
```

### Resolution

Enable Ingress in the values file.

---

# 17. Secrets Missing

### Investigation

```bash
kubectl get secrets
```

Verify:

* Secret name
* Namespace
* Mount path

### Resolution

Create the Secret or integrate a secret management solution.

---

# 18. Helm Lint Reports Errors

### Investigation

```bash
helm lint ./chart
```

Common issues:

* YAML indentation
* Missing values
* Invalid templates
* Missing required fields

### Resolution

Correct the reported issues before deployment.

---

# 19. Deployment Never Completes

### Investigation

If using:

```bash
--wait
```

Check:

```bash
kubectl get pods

kubectl get events
```

### Resolution

Find the resource preventing readiness.

---

# 20. Automatic Rollback Triggered

Using:

```bash
helm upgrade --atomic
```

### Investigation

Review:

```bash
helm history my-app

helm status my-app
```

Check Kubernetes Events.

### Resolution

Fix the deployment issue before attempting another upgrade.

---

# Common Debugging Commands

```bash
helm version

helm repo list

helm repo update

helm search repo

helm lint ./chart

helm template my-app ./chart

helm install

helm upgrade

helm status

helm history

helm rollback

helm get values

helm get manifest

helm dependency update

kubectl get pods

kubectl get all

kubectl describe pod

kubectl logs

kubectl get events
```

---

# Production Troubleshooting Flow

```text
Application Issue
        │
        ▼
helm status
        │
        ▼
helm history
        │
        ▼
helm get values
        │
        ▼
helm get manifest
        │
        ▼
kubectl get pods
        │
        ▼
kubectl describe pod
        │
        ▼
kubectl logs
        │
        ▼
kubectl get events
        │
        ▼
Identify Root Cause
        │
        ├── Configuration Issue
        ├── Template Issue
        ├── Dependency Issue
        ├── Kubernetes Issue
        └── Application Issue
        │
        ▼
Fix or Rollback
```

---

# Interview Troubleshooting Strategy

When asked to troubleshoot a Helm deployment, follow this order:

1. Check the Release status (`helm status`).
2. Review Release history (`helm history`).
3. Inspect deployed values (`helm get values`).
4. Inspect rendered manifests (`helm get manifest`).
5. Validate the Chart (`helm lint`).
6. Render templates locally (`helm template`).
7. Check Kubernetes resources (`kubectl get all`).
8. Inspect Pods (`kubectl describe pod`).
9. Review application logs (`kubectl logs`).
10. Review cluster events (`kubectl get events`).
11. If the latest deployment is faulty and the previous revision is healthy, perform a `helm rollback`.

---

# ⭐ Production Tip

A common misconception is that **Helm is the source of every deployment failure**.

In practice, Helm often **successfully deploys the manifests**, while the actual issue lies in Kubernetes or the application itself—for example:

* Invalid image
* CrashLoopBackOff
* Missing Secret
* PVC not bound
* Resource limits too low
* Database unavailable

Always distinguish between **Helm problems** (Chart, templates, values, repositories, releases) and **Kubernetes/application problems** (Pods, scheduling, networking, storage, runtime errors). This structured approach is exactly what interviewers look for during production troubleshooting discussions.
