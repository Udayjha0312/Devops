# 🛠️ Argo CD Troubleshooting Guide

## Module 14 – GitOps with Argo CD

This guide covers common production issues encountered while using **Argo CD** in Kubernetes environments and the troubleshooting approach expected in DevOps and Platform Engineering interviews.

---

# 1. Application is OutOfSync

## Symptoms

```text
Application Status

OutOfSync
```

## Investigation

Check:

* Recent Git commits
* Manual Kubernetes changes
* Failed synchronization

Commands

```bash
kubectl get application -A
```

## Resolution

* Perform Sync.
* Enable Self-Heal if appropriate.
* Remove manual changes.

---

# 2. Sync Failed

## Symptoms

```text
Sync Failed
```

## Investigation

Check

* Invalid YAML
* Helm rendering errors
* Missing resources
* Kubernetes API errors

Commands

```bash
kubectl describe application <app-name>
```

## Resolution

Correct the manifest or Helm chart and re-sync.

---

# 3. Repository Connection Failed

## Symptoms

```text
Unable to access repository
```

## Investigation

Check

* Git repository URL
* SSH keys
* Personal Access Token (PAT)
* Repository permissions
* Network connectivity

## Resolution

Fix repository credentials or access permissions.

---

# 4. Application Stuck in Progressing

## Investigation

```bash
kubectl get pods -A
```

Check

* Pending Pods
* CrashLoopBackOff
* ImagePullBackOff
* Readiness Probe failures

## Resolution

Resolve the underlying Kubernetes workload issue.

---

# 5. Self-Heal Not Working

## Investigation

Verify

* Auto Sync enabled
* Self-Heal enabled
* Application configuration

## Resolution

Enable automated synchronization with Self-Heal.

---

# 6. Prune Not Removing Resources

## Investigation

Check

Application Sync Policy.

## Resolution

Enable:

```text
Prune
```

Then perform another synchronization.

---

# 7. Rollback Failed

## Investigation

Check

* Revision history
* Git commit history
* Kubernetes events

## Resolution

Rollback to a valid application revision or Git commit.

---

# 8. Application Controller Not Running

## Symptoms

Applications stop synchronizing.

## Investigation

```bash
kubectl get pods -n argocd
```

Check

```text
argocd-application-controller
```

## Resolution

Restart or recover the controller Pod.

---

# 9. Repository Server Failure

## Symptoms

Git cannot be read.

## Investigation

```bash
kubectl get pods -n argocd
```

Verify

```text
argocd-repo-server
```

## Resolution

Restart the Repository Server and verify repository access.

---

# 10. API Server Unavailable

## Symptoms

Cannot access:

* Argo CD UI
* Argo CD CLI

## Investigation

Check

```text
argocd-server
```

Service

Ingress

Load Balancer

## Resolution

Recover the API Server or networking configuration.

---

# 11. Redis Failure

## Symptoms

Slow UI

Unexpected behavior

## Investigation

Check

```text
argocd-redis
```

## Resolution

Restart Redis and verify persistent storage if configured.

---

# 12. Git Changes Not Detected

## Investigation

Verify

* Repository connection
* Webhook (if configured)
* Repository polling
* Branch configuration

## Resolution

Ensure Argo CD is monitoring the correct repository and branch.

---

# 13. Incorrect Branch Deployed

## Investigation

Check

Application Source configuration.

Verify

* Repository
* Branch
* Revision

## Resolution

Update the Application to track the intended Git branch or revision.

---

# 14. Wrong Namespace

## Symptoms

Resources deployed into the wrong namespace.

## Investigation

Check

Application Destination configuration.

## Resolution

Correct the destination namespace and synchronize again.

---

# 15. Wrong Cluster

## Symptoms

Deployment appears in the wrong Kubernetes cluster.

## Investigation

Check

Destination Cluster.

## Resolution

Update the Application destination and re-sync.

---

# 16. Helm Chart Deployment Failure

## Investigation

Verify

* values.yaml
* Templates
* Chart version

## Resolution

Correct the Helm chart configuration before synchronizing.

---

# 17. Kubernetes Resource Already Exists

## Symptoms

Sync fails due to duplicate resources.

## Investigation

Check

```bash
kubectl get all -A
```

Determine whether the resource is managed by another Application or created manually.

## Resolution

Remove the conflicting resource or adopt a consistent ownership strategy.

---

# 18. ApplicationSet Not Creating Applications

## Investigation

Verify

* Generator configuration
* Template
* Repository
* Cluster registration

## Resolution

Correct the generator or template definition.

---

# 19. Drift Keeps Returning

## Symptoms

Application repeatedly becomes:

```text
OutOfSync
```

## Investigation

Check

* Manual kubectl changes
* Other automation tools
* Controllers modifying resources

## Resolution

Identify and eliminate competing sources of changes.

Git should remain the single source of truth.

---

# 20. Continuous Sync Loop

## Symptoms

Application continuously synchronizes.

## Investigation

Check

* Generated resources
* Controllers modifying labels or annotations
* Mutable fields

## Resolution

Ignore expected differences where appropriate or correct the application configuration.

---

# Useful Commands

```bash
kubectl get applications -A

kubectl describe application <application-name>

kubectl get pods -n argocd

kubectl logs deployment/argocd-application-controller -n argocd

kubectl logs deployment/argocd-repo-server -n argocd

kubectl get events -A
```

---

# Components to Verify

* API Server
* Repository Server
* Application Controller
* Redis
* Kubernetes API
* Git Repository

---

# Production Troubleshooting Flow

```text
Git Commit
      │
      ▼
Repository Accessible?
      │
      ▼
Application Healthy?
      │
      ▼
OutOfSync?
      │
      ▼
Sync Successful?
      │
      ▼
Pods Running?
      │
      ▼
Application Healthy?
      │
      ▼
Production Verified
```

---

# Common Root Causes

* Invalid YAML
* Incorrect Helm values
* Git authentication failure
* Repository unavailable
* Wrong branch
* Wrong namespace
* Kubernetes resource conflicts
* Missing permissions
* Controller failure
* Manual configuration drift

---

# Interview Strategy

If asked:

> "Argo CD isn't deploying my application."

Follow this order:

1. Check Application Health.
2. Check Sync Status.
3. Verify Git repository access.
4. Check Repository Server.
5. Check Application Controller.
6. Review Kubernetes events.
7. Verify Pods and Deployments.
8. Review logs.
9. Fix the root cause.
10. Synchronize again.

---

# ⭐ Production Tip

Always troubleshoot **from Git toward Kubernetes**, not the other way around.

```text
Git Repository
      ↓
Application
      ↓
Repository Server
      ↓
Application Controller
      ↓
Kubernetes API
      ↓
Deployment
      ↓
Pods
      ↓
Application
```

Since **Git is the source of truth**, begin by confirming that the desired state in Git is correct, then verify each step of the synchronization pipeline until you identify where the process is failing.
