# ☸️ Kubernetes Advanced Scheduling — Revision Notes

> Quick revision notes for interviews and production.

---

# 1. Node Selector

### Definition

Simplest way to schedule Pods on specific nodes using labels.

```yaml
nodeSelector:
  disktype: ssd
```

### Limitation

* Exact match only
* No AND/OR logic
* No preference rules

---

# 2. Node Affinity

### Definition

Schedules Pods to nodes based on advanced label rules.

### Types

### Required

Pod **must** run on matching node.

```yaml
requiredDuringSchedulingIgnoredDuringExecution
```

### Preferred

Scheduler tries to place the Pod there.

```yaml
preferredDuringSchedulingIgnoredDuringExecution
```

### Operators

* In
* NotIn
* Exists
* DoesNotExist
* Gt
* Lt

### Production Uses

* GPU nodes
* SSD nodes
* High-memory nodes
* Dedicated workloads

---

# 3. Pod Affinity

### Definition

Schedules Pods close to other Pods.

Example:

```
Backend
↓

Redis
```

Backend prefers running with Redis.

### Production Uses

* Backend + Redis
* API + Cache
* Microservices with heavy communication

---

# 4. Pod Anti-Affinity

### Definition

Ensures Pods do NOT run together.

Example

```
Replica 1 → Node A

Replica 2 → Node B

Replica 3 → Node C
```

### Production Uses

* High Availability
* Fault Tolerance

---

# 5. Taints

### Definition

Prevent Pods from being scheduled onto a node unless tolerated.

Syntax

```
key=value:effect
```

### Effects

### NoSchedule

New Pods cannot be scheduled.

### PreferNoSchedule

Soft restriction.

### NoExecute

Existing Pods are evicted unless tolerated.

### Production Uses

* GPU nodes
* Dedicated nodes
* Critical workloads

---

# 6. Tolerations

### Definition

Allow Pods to run on tainted nodes.

> **Important:** Toleration does **not** force scheduling; it only permits it.

---

# 7. Node Affinity vs Taints

| Node Affinity      | Taints            |
| ------------------ | ----------------- |
| Pod chooses node   | Node rejects Pods |
| Pod-side rule      | Node-side rule    |
| Flexible placement | Access control    |

---

# 8. Pod Affinity vs Anti-Affinity

| Affinity           | Anti-Affinity         |
| ------------------ | --------------------- |
| Keep Pods together | Keep Pods apart       |
| Reduce latency     | Increase availability |

---

# 9. Pod Disruption Budget (PDB)

### Purpose

Protect applications during **voluntary disruptions**.

### Options

```
minAvailable
```

or

```
maxUnavailable
```

### Example

```
Replicas = 5

minAvailable = 4
```

Only one Pod can be unavailable during maintenance.

---

# 10. Cluster Maintenance

### Commands

```bash
kubectl cordon <node>

kubectl drain <node>

kubectl uncordon <node>
```

### Workflow

```
cordon
↓

drain
↓

maintenance
↓

uncordon
```

---

# 11. Scheduling Best Practices

* Label nodes consistently
* Use Node Affinity instead of Node Selector for flexibility
* Spread replicas using Anti-Affinity
* Reserve special nodes with Taints
* Use PDB before draining nodes
* Avoid overly strict affinity rules
* Test scheduling in staging before production

---

# Important kubectl Commands

```bash
kubectl get nodes --show-labels

kubectl describe node

kubectl taint nodes

kubectl get pdb

kubectl describe pdb

kubectl cordon

kubectl drain

kubectl uncordon
```

---

# Production Scenarios

✅ GPU workloads

✅ Database isolation

✅ Dedicated production nodes

✅ Multi-zone scheduling

✅ High Availability

✅ Rolling cluster upgrades

✅ Zero-downtime maintenance

---

# Interview One-Liners

**Node Selector** → Simple label matching.

**Node Affinity** → Advanced node scheduling.

**Pod Affinity** → Keep related Pods together.

**Pod Anti-Affinity** → Spread replicas apart.

**Taints** → Reject Pods.

**Tolerations** → Allow Pods onto tainted nodes.

**PDB** → Protect against voluntary disruptions.

**Cordon** → Mark node unschedulable.

**Drain** → Evict workloads safely.

**Uncordon** → Return node to service.

---

# Quick Memory Map

```
Node Selector
        │
        ▼
Node Affinity
        │
        ▼
Pod Affinity
        │
        ▼
Pod Anti-Affinity
        │
        ▼
Taints
        │
        ▼
Tolerations
        │
        ▼
Pod Disruption Budget
        │
        ▼
Cluster Maintenance
        │
        ▼
Scheduling Best Practices
```
