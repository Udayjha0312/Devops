# ☸️ Module 3 Troubleshooting
# ReplicaSets & Deployments

> **Goal:** Learn how to investigate and fix ReplicaSet and Deployment issues in production.

---

# Troubleshooting Workflow

Whenever an application is not working, follow this order:

```
Application Down

↓

Deployment

↓

ReplicaSet

↓

Pods

↓

Events

↓

Logs

↓

Node

↓

Container
```

Never jump directly to container logs.

---

# Scenario 1: Deployment Not Creating Pods

## Symptoms

```
kubectl get deployment

READY 0/3
```

## Investigation

```bash
kubectl describe deployment nginx
```

Check Events.

Then:

```bash
kubectl get rs
```

If ReplicaSet exists:

```bash
kubectl describe rs
```

## Possible Causes

- Wrong image
- Wrong selector
- Invalid YAML
- Admission policy failure
- Resource quota exceeded

## Fix

Correct the Deployment YAML and re-apply.

---

# Scenario 2: ReplicaSet Not Creating Pods

## Symptoms

ReplicaSet exists.

Pods = 0

## Investigation

```bash
kubectl describe rs nginx-rs
```

Check Events.

## Possible Causes

- Selector mismatch
- Invalid Pod Template
- Image doesn't exist
- Namespace quota exceeded

## Fix

Verify:

```yaml
selector:

  matchLabels:

    app: nginx
```

matches

```yaml
template:

  metadata:

    labels:

      app: nginx
```

---

# Scenario 3: Selector Mismatch

## Symptoms

ReplicaSet keeps trying to create Pods.

Pods never become managed.

## Investigation

```bash
kubectl get pods --show-labels
```

Compare with:

```bash
kubectl get rs -o yaml
```

## Root Cause

Selector

```
app=nginx
```

Template

```
app=apache
```

## Fix

Make both identical.

---

# Scenario 4: Pods Stuck in Pending

## Symptoms

```
STATUS

Pending
```

## Investigation

```bash
kubectl describe pod POD_NAME
```

Check Events.

## Possible Causes

- No worker node available
- CPU shortage
- Memory shortage
- Taints
- PVC Pending

## Fix

Free cluster resources or add worker nodes.

---

# Scenario 5: ImagePullBackOff

## Symptoms

```
STATUS

ImagePullBackOff
```

## Investigation

```bash
kubectl describe pod POD_NAME
```

## Possible Causes

- Wrong image
- Private registry
- Authentication failure
- Network issue

## Fix

Verify image name.

Example

Wrong

```
ngnix
```

Correct

```
nginx
```

---

# Scenario 6: CrashLoopBackOff

## Symptoms

Container continuously restarts.

## Investigation

```bash
kubectl logs POD_NAME
```

```bash
kubectl describe pod POD_NAME
```

## Possible Causes

- Application crash
- Missing environment variables
- Wrong command
- Port already in use

## Fix

Read logs and correct application.

---

# Scenario 7: Rollout Stuck

## Symptoms

```bash
kubectl rollout status deployment nginx
```

Never completes.

## Investigation

```bash
kubectl describe deployment nginx
```

Check Pods.

## Possible Causes

- Readiness Probe failure
- CrashLoopBackOff
- ImagePullBackOff

## Fix

Resolve Pod issue.

Deployment continues automatically.

---

# Scenario 8: Rollback Required

## Symptoms

New deployment causing failures.

## Investigation

```bash
kubectl rollout history deployment nginx
```

## Fix

```bash
kubectl rollout undo deployment nginx
```

---

# Scenario 9: Wrong Replica Count

## Symptoms

Expected

```
5 Pods
```

Actual

```
3 Pods
```

## Investigation

```bash
kubectl get deployment

kubectl get rs

kubectl get pods
```

## Possible Causes

- Pending Pods
- Node Failure
- Scheduling Failure

---

# Scenario 10: Node Failure

## Symptoms

Many Pods disappear.

## Investigation

```bash
kubectl get nodes
```

```bash
kubectl describe node NODE_NAME
```

## Fix

ReplicaSet automatically recreates Pods on healthy nodes.

---

# Scenario 11: Deployment Not Updating

## Symptoms

New image applied.

Old Pods still running.

## Investigation

```bash
kubectl rollout status deployment nginx
```

```bash
kubectl describe deployment nginx
```

## Possible Causes

- Image unchanged
- Rollout paused
- Readiness failure

---

# Scenario 12: Too Many Pods

## Symptoms

Expected

```
3
```

Current

```
5
```

## Investigation

```bash
kubectl get rs
```

Possible during Rolling Update.

## Explanation

Deployment temporarily creates extra Pods because of

```
maxSurge
```

This is normal.

---

# Scenario 13: Pods Deleted Automatically

## Symptoms

Pods disappear after manual deletion.

## Investigation

```bash
kubectl get rs
```

## Explanation

ReplicaSet detected:

Desired != Current

Creates replacement Pods.

This is expected behavior.

---

# Scenario 14: Wrong Version Running

## Investigation

```bash
kubectl get rs
```

```bash
kubectl rollout history deployment nginx
```

Check image.

---

# Scenario 15: Deployment Uses Old Image

## Investigation

```bash
kubectl describe deployment nginx
```

Verify image.

Sometimes

```
imagePullPolicy
```

or an unchanged image tag (like `latest`) can lead to unexpected behavior.

---

# Production Debugging Commands

```bash
kubectl get deployment

kubectl describe deployment

kubectl rollout status deployment

kubectl rollout history deployment

kubectl rollout undo deployment

kubectl get rs

kubectl describe rs

kubectl get pods

kubectl describe pod POD_NAME

kubectl logs POD_NAME

kubectl get events --sort-by=.metadata.creationTimestamp

kubectl get nodes

kubectl describe node NODE_NAME
```

---

# Interview Scenarios

## Scenario 1

Deployment exists.

ReplicaSet exists.

Pods = 0.

How will you debug?

---

## Scenario 2

Pods Running.

Application inaccessible.

Where do you investigate first?

---

## Scenario 3

Rolling Update stuck at 60%.

How do you troubleshoot?

---

## Scenario 4

Image updated.

Old Pods still serving traffic.

Explain why.

---

## Scenario 5

Pods continuously recreated.

Possible reasons?

---

# Golden Troubleshooting Order

```
Deployment

↓

ReplicaSet

↓

Pods

↓

Events

↓

Logs

↓

Node

↓

Container
```

Never skip directly to logs.

Always identify **which layer** of Kubernetes is failing first.

---

# Production Tips

✅ Use `kubectl describe` before `kubectl logs`.

✅ Check Events first—they often reveal scheduling, image, or probe issues.

✅ Don't delete Pods manually to "fix" problems; understand **why** they're failing.

✅ Avoid using the `latest` image tag in production.

✅ Verify selectors and labels before suspecting Kubernetes itself.

---

# Remember

**Deployment Problem?**

→ Check Deployment → ReplicaSet → Pods.

**Pod Problem?**

→ Check Events → Logs.

**Scheduling Problem?**

→ Check Node resources and Scheduler events.

**Application Problem?**

→ Check container logs and readiness/liveness probes.