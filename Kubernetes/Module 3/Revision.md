# ☸️ Module 3 Revision Notes
# ReplicaSets & Deployments

> **Interview Revision Time:** 15–20 Minutes

---

# Module Summary

This module covers:

- ReplicaSets
- Labels & Selectors
- Deployments
- Rolling Updates
- Rollbacks
- Scaling
- Deployment Strategies

---

# One-Line Definitions

## Pod

Smallest deployable unit in Kubernetes.

---

## ReplicaSet

Maintains the desired number of identical Pods.

---

## Deployment

Manages ReplicaSets and provides Rolling Updates, Rollbacks, Scaling, and Revision History.

---

## Label

Key-value pair attached to Kubernetes resources.

Example:

```yaml
app: nginx
```

---

## Selector

Finds Kubernetes objects using Labels.

---

## Reconciliation Loop

Continuously compares Desired State and Current State.

---

## Desired State

Configuration defined inside YAML.

---

## Current State

Actual cluster state.

---

# Responsibilities

| Component | Responsibility |
|-----------|----------------|
| Deployment | Manages ReplicaSets |
| Deployment Controller | Rolling Updates & Rollbacks |
| ReplicaSet | Maintains Pod Count |
| ReplicaSet Controller | Creates/Deletes Pods |
| Scheduler | Chooses Worker Node |
| kubelet | Starts Containers |
| API Server | Entry Point |
| etcd | Stores Desired State |

---

# Architecture

```
Deployment

↓

ReplicaSet

↓

Pods

↓

Containers
```

---

# Internal Workflow

```
kubectl apply

↓

API Server

↓

etcd

↓

Deployment Controller

↓

ReplicaSet

↓

ReplicaSet Controller

↓

Pods

↓

Scheduler

↓

Worker Node

↓

kubelet

↓

Running Containers
```

---

# ReplicaSet

Purpose

- Self-Healing
- Maintain Pod Count
- Horizontal Scaling

ReplicaSet DOES

✅ Create Pods

✅ Delete Pods

✅ Maintain Desired Replicas

ReplicaSet DOES NOT

❌ Rolling Updates

❌ Rollbacks

❌ Deployment History

---

# Deployment

Purpose

- Manage ReplicaSets

Provides

✅ Rolling Updates

✅ Rollbacks

✅ Revision History

✅ Scaling

---

# Labels

Example

```yaml
labels:
  app: nginx
```

Purpose

Identify Kubernetes resources.

---

# Selectors

Example

```yaml
selector:
  matchLabels:
    app: nginx
```

Purpose

Find matching Pods.

---

# Golden Rule

Selector

MUST

match

Template Labels

---

# YAML Structure

```
apiVersion

kind

metadata

spec

replicas

selector

template

containers

image
```

---

# Scaling

ReplicaSet

```bash
kubectl scale rs nginx-rs --replicas=5
```

Deployment

```bash
kubectl scale deployment nginx --replicas=5
```

---

# Rolling Update

Default Strategy

```
Old Pods

↓

New Pods

↓

Old Pods

↓

New Pods
```

No complete downtime.

---

# maxUnavailable

Maximum Pods allowed to be unavailable.

Example

```
replicas=4

maxUnavailable=1

Minimum Running = 3
```

---

# maxSurge

Maximum extra Pods created during update.

Example

```
Desired = 4

maxSurge = 1

Temporary = 5 Pods
```

---

# Rollback

Command

```bash
kubectl rollout undo deployment nginx
```

Purpose

Restore previous ReplicaSet.

---

# Deployment Strategies

## RollingUpdate

✅ Default

✅ Minimal Downtime

---

## Recreate

Delete Old Pods

↓

Create New Pods

Downtime occurs.

---

## Blue-Green

Two environments.

Switch traffic.

---

## Canary

Gradually send traffic.

5%

↓

20%

↓

50%

↓

100%

---

# Scaling vs Updating

Scaling

Changes

```
replicas
```

No New ReplicaSet.

Updating

Changes

```
spec.template
```

Creates New ReplicaSet.

---

# ReplicaSet vs Deployment

| ReplicaSet | Deployment |
|------------|------------|
| Maintains Pods | Manages ReplicaSets |
| Self-Healing | Rolling Updates |
| Scaling | Rollbacks |
| No Revision History | Revision History |
| No Deployment Strategies | Supports Strategies |

---

# Common kubectl Commands

```bash
kubectl get rs

kubectl describe rs

kubectl get deployment

kubectl describe deployment

kubectl apply -f file.yaml

kubectl delete -f file.yaml

kubectl scale deployment nginx --replicas=5

kubectl rollout status deployment nginx

kubectl rollout history deployment nginx

kubectl rollout undo deployment nginx
```

---

# Production Best Practices

- Use Deployments instead of ReplicaSets directly.
- Use meaningful Labels.
- Never use `latest` image tag in production.
- Configure Readiness & Liveness Probes.
- Monitor Rollout Status.
- Keep resource requests and limits.
- Test Rollbacks regularly.

---

# Common Mistakes

❌ Selector mismatch

❌ Wrong Labels

❌ Wrong Image Tag

❌ No Readiness Probe

❌ Assuming Deployment creates Pods

❌ Assuming Scaling creates ReplicaSet

❌ Using ReplicaSets directly in production

---

# Memory Tricks

ReplicaSet

↓

Quantity

Deployment

↓

Strategy

---

Template Changed

↓

New ReplicaSet

---

Replica Count Changed

↓

Same ReplicaSet

---

Deployment

↓

ReplicaSet

↓

Pods

↓

Containers

---

# Top Interview Questions

1. What is a ReplicaSet?
2. Why use Deployment instead of ReplicaSet?
3. What is the Reconciliation Loop?
4. What is Desired State?
5. Difference between Desired and Current State?
6. What are Labels?
7. What are Selectors?
8. Why must Selector and Template Labels match?
9. Which controller creates Pods?
10. Which controller performs Rolling Updates?
11. Which controller performs Rollbacks?
12. Does Deployment create Pods?
13. Does Scaling create a new ReplicaSet?
14. What creates a new ReplicaSet?
15. What is maxUnavailable?
16. What is maxSurge?
17. Difference between RollingUpdate and Recreate?
18. What is Blue-Green Deployment?
19. What is Canary Deployment?
20. How does Kubernetes perform self-healing?

---

# 30-Second Revision

- ReplicaSet → Maintains Pod Count
- Deployment → Manages ReplicaSets
- ReplicaSet Controller → Creates Pods
- Deployment Controller → Rolling Updates & Rollbacks
- Labels → Identify Resources
- Selectors → Find Resources
- Template Change → New ReplicaSet
- Replica Change → Same ReplicaSet
- RollingUpdate → Default Strategy
- Recreate → Downtime
- Blue-Green → Two Environments
- Canary → Gradual Traffic
- Desired State → YAML
- Current State → Cluster
- Kubernetes → Always Reconciles Desired vs Current