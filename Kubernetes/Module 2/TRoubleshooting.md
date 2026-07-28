# 🔧 Module 02 — TROUBLESHOOTING.md

> **Purpose:** This guide contains the most common Pod-related production issues, how to investigate them, and how to resolve them. These are the same types of scenarios you'll encounter in DevOps/SRE interviews and real Kubernetes clusters.

---

# 🚨 Troubleshooting Workflow

Whenever a Pod has an issue, follow this order:

```text
Application Down

↓

kubectl get pods

↓

kubectl describe pod

↓

kubectl logs

↓

kubectl exec

↓

Investigate Node / Events / Resources
```

Never randomly guess the problem.

---

# 📋 Quick Troubleshooting Commands

| Command | Purpose |
|----------|----------|
| `kubectl get pods` | Check Pod status |
| `kubectl describe pod <pod>` | View events and Pod details |
| `kubectl logs <pod>` | View application logs |
| `kubectl logs <pod> --previous` | View logs from the previous crashed container |
| `kubectl exec -it <pod> -- sh` | Open a shell inside the container |
| `kubectl get events --sort-by=.metadata.creationTimestamp` | View cluster events |
| `kubectl top pod` | View CPU & Memory usage (requires Metrics Server) |
| `kubectl get nodes` | Check node health |
| `kubectl describe node <node>` | Inspect node resources |

---

# Scenario 1 — Pod Stuck in Pending

## Symptoms

```text
NAME          READY   STATUS
fastapi       0/1     Pending
```

---

## Possible Causes

- No available Worker Node
- CPU request too high
- Memory request too high
- PVC not bound
- Taints and tolerations mismatch
- Node selector mismatch
- Scheduler cannot place the Pod

---

## Investigation

```bash
kubectl describe pod fastapi
```

Look for events like:

```text
0/3 nodes are available:
Insufficient memory
```

---

## Fix

- Reduce resource requests
- Add more worker nodes
- Free cluster resources
- Fix node selectors or taints
- Ensure PersistentVolume is available

---

# Scenario 2 — ImagePullBackOff

## Symptoms

```text
STATUS

ImagePullBackOff
```

---

## Possible Causes

- Wrong image name
- Wrong image tag
- Private image without credentials
- Registry unavailable
- Network issue

---

## Investigation

```bash
kubectl describe pod fastapi
```

Typical event:

```text
Failed to pull image
```

---

## Fix

Verify:

```yaml
image:
```

Check:

- Image exists
- Tag exists
- Registry credentials
- Internet connectivity

---

# Scenario 3 — ErrImagePull

Usually appears before:

```text
ImagePullBackOff
```

Meaning:

Kubernetes failed to pull the image.

---

## Investigation

```bash
kubectl describe pod
```

---

## Fix

Usually identical to ImagePullBackOff.

---

# Scenario 4 — CrashLoopBackOff

## Symptoms

```text
CrashLoopBackOff
```

---

## Meaning

The application starts...

Crashes...

Restarts...

Crashes again...

Kubernetes waits longer between each restart.

---

## Common Causes

- Application bug
- Wrong command
- Missing environment variable
- Missing Secret
- Missing ConfigMap
- Database unavailable
- Port conflict

---

## Investigation

```bash
kubectl logs fastapi
```

If container already restarted:

```bash
kubectl logs fastapi --previous
```

Also inspect:

```bash
kubectl describe pod fastapi
```

---

## Fix

Fix the application or configuration causing the crash.

---

# Scenario 5 — OOMKilled

## Symptoms

```text
Reason:

OOMKilled
```

---

## Meaning

The application exceeded its memory limit.

---

## Investigation

```bash
kubectl describe pod fastapi
```

or

```bash
kubectl top pod
```

---

## Fix

Increase:

```yaml
limits:
  memory:
```

or optimize memory usage.

---

# Scenario 6 — ContainerCreating

## Symptoms

```text
STATUS

ContainerCreating
```

---

## Possible Causes

- Pulling image
- Mounting volume
- Creating network
- Waiting for Secret
- Waiting for ConfigMap

---

## Investigation

```bash
kubectl describe pod
```

Look at Events.

---

## Fix

Depends on the event message.

Examples:

- Fix volume
- Wait for image download
- Create missing Secret

---

# Scenario 7 — Readiness Probe Failed

## Symptoms

```text
READY

0/1
```

Pod is Running.

Application receives no traffic.

---

## Meaning

The application is alive but not ready.

---

## Investigation

```bash
kubectl describe pod
```

Look for:

```text
Readiness probe failed
```

---

## Common Causes

- Database unavailable
- Wrong endpoint
- Wrong port
- Slow startup
- Application initialization incomplete

---

## Fix

Verify:

- Probe endpoint
- Port
- Dependencies
- Application startup

---

# Scenario 8 — Liveness Probe Failed

## Symptoms

Container restarts repeatedly.

---

## Investigation

```bash
kubectl describe pod
```

Look for:

```text
Liveness probe failed
```

---

## Common Causes

- Infinite loop
- Deadlock
- Wrong probe endpoint
- Slow application

---

## Fix

Fix application health or adjust probe timing.

---

# Scenario 9 — Startup Probe Failed

## Symptoms

Application never finishes startup.

Container restarts repeatedly.

---

## Common Causes

- Startup takes longer than expected
- Wrong endpoint
- Missing dependency

---

## Fix

Increase:

```yaml
failureThreshold
```

or

```yaml
initialDelaySeconds
```

---

# Scenario 10 — Pod Running But Website Doesn't Open

## Symptoms

```text
STATUS

Running
```

Browser:

```text
Connection Refused
```

---

## Investigation

Check:

```bash
kubectl logs
```

Verify:

```bash
kubectl describe pod
```

Verify application port.

---

## Common Causes

- Wrong container port
- Application listening only on localhost inside the container
- No port-forward or Service configured

---

## Fix

For FastAPI:

```bash
uvicorn app:app --host 0.0.0.0 --port 8000
```

Not:

```bash
127.0.0.1
```

---

# Scenario 11 — Pod Deleted Unexpectedly

## Investigation

Was it created by:

- Deployment
- ReplicaSet
- Job
- DaemonSet

Check:

```bash
kubectl get deployments
```

---

## Explanation

Controllers recreate Pods automatically.

Standalone Pods do not.

---

# Scenario 12 — High Restart Count

```text
RESTARTS

48
```

---

## Meaning

Application repeatedly crashes.

---

## Investigation

```bash
kubectl logs --previous
```

Check:

```bash
kubectl describe pod
```

---

## Fix

Fix the root cause.

Never ignore restart count.

---

# Common Interview Questions

## Why is my Pod Pending?

Possible answers:

- CPU request too high
- Memory request too high
- Scheduler unable to find a node
- PVC unavailable
- Taints
- Node selectors

---

## Pod Running But Not Ready

Usually:

Readiness Probe failure.

---

## Difference

ImagePullBackOff

vs

CrashLoopBackOff

| ImagePullBackOff | CrashLoopBackOff |
|------------------|------------------|
| Image cannot be downloaded | Application keeps crashing |

---

## Difference

OOMKilled

vs

CrashLoopBackOff

| OOMKilled | CrashLoopBackOff |
|------------|------------------|
| Memory exceeded | Application exits repeatedly for any reason |

---

# Production Troubleshooting Flow

```text
Pod Problem

↓

kubectl get pods

↓

Check STATUS

↓

describe

↓

logs

↓

events

↓

exec

↓

Node Resources

↓

Fix

↓

Redeploy
```

---

# Golden Rules

✅ Always check `kubectl describe pod` first.

✅ Read Events before making changes.

✅ Check logs before entering the container.

✅ Use `kubectl logs --previous` after a crash.

✅ Don't assume "Running" means healthy.

✅ Check probe failures.

✅ Monitor restart count.

---

# Interview Checklist

If asked:

> "A Pod isn't working."

Your response should be:

1. Check Pod status

```bash
kubectl get pods
```

2. Inspect Pod

```bash
kubectl describe pod <pod>
```

3. Check logs

```bash
kubectl logs <pod>
```

4. Check previous logs (if restarting)

```bash
kubectl logs <pod> --previous
```

5. Enter the container if necessary

```bash
kubectl exec -it <pod> -- sh
```

6. Check resources and node health

```bash
kubectl top pod

kubectl get nodes
```

---

# 🎯 Final Takeaway

A good Kubernetes engineer doesn't memorize error messages—they follow a **systematic troubleshooting process**:

**Observe → Gather Evidence → Identify Root Cause → Fix → Verify**

Following the same sequence every time helps you diagnose Pod issues quickly in both interviews and production environments.