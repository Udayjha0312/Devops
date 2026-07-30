# 🛠️ Kubernetes Advanced Scheduling — Troubleshooting Guide

> Common production issues related to scheduling, affinity, taints, tolerations, and cluster maintenance.

---

# Scenario 1: Pod is stuck in Pending

## Symptoms

```bash
kubectl get pods
```

```
STATUS: Pending
```

## Investigation

Describe the Pod:

```bash
kubectl describe pod <pod-name>
```

Check the **Events** section.

Common messages:

* `0/3 nodes are available`
* `Insufficient cpu`
* `Insufficient memory`
* `Node didn't match Pod affinity`
* `Node(s) had taints`

## Possible Causes

* Node Affinity mismatch
* Node Selector mismatch
* Missing Toleration
* Insufficient CPU
* Insufficient Memory
* PVC not available

## Resolution

* Verify node labels
* Verify affinity rules
* Check taints
* Add tolerations if required
* Scale the cluster if resources are exhausted

---

# Scenario 2: Node Affinity Not Working

## Symptoms

Pod never schedules.

## Investigation

Check node labels.

```bash
kubectl get nodes --show-labels
```

Check affinity rules.

```bash
kubectl describe pod <pod-name>
```

## Common Causes

* Incorrect label name
* Wrong operator
* Wrong value
* Required affinity too restrictive

## Resolution

Correct labels or affinity rules.

Example:

```yaml
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
```

---

# Scenario 3: Pod Affinity Failure

## Symptoms

Pods remain Pending.

## Investigation

Check Events.

```bash
kubectl describe pod
```

Verify:

* Required Pod exists
* Labels match
* topologyKey is correct

## Resolution

* Fix labels
* Deploy dependent Pods
* Relax Required → Preferred if appropriate

---

# Scenario 4: Pod Anti-Affinity Prevents Scheduling

## Symptoms

Replicas cannot start.

Example:

Cluster has

```
2 Nodes
```

Application

```
3 Replicas
```

Required Anti-Affinity means one replica has nowhere to go.

## Resolution

* Add more nodes
* Change Required → Preferred
* Reduce replica count

---

# Scenario 5: Pod Cannot Run on Tainted Node

## Symptoms

```
Pending
```

Events:

```
node had taint
```

## Investigation

Check taints.

```bash
kubectl describe node <node-name>
```

or

```bash
kubectl get nodes -o wide
```

## Resolution

Option 1

Add Toleration.

Option 2

Remove Taint.

```bash
kubectl taint nodes node1 dedicated-
```

---

# Scenario 6: Pod Evicted Unexpectedly

## Symptoms

Pod disappears.

## Investigation

Describe Pod.

Look for:

```
NoExecute
```

Check node.

```bash
kubectl describe node
```

## Common Cause

Node has

```
NoExecute
```

taint.

## Resolution

* Add Toleration
* Configure tolerationSeconds if temporary eviction is acceptable

---

# Scenario 7: Node Drain Stuck

## Symptoms

```bash
kubectl drain node1
```

never completes.

## Investigation

Check:

```bash
kubectl get pdb
```

Describe PDB.

```bash
kubectl describe pdb
```

## Common Cause

Pod Disruption Budget blocks eviction.

## Resolution

* Increase replicas
* Modify PDB
* Retry drain after ensuring availability

---

# Scenario 8: Node Remains Unschedulable

## Symptoms

No new Pods land on the node.

## Investigation

```bash
kubectl get nodes
```

Node shows:

```
SchedulingDisabled
```

## Resolution

```bash
kubectl uncordon <node>
```

---

# Scenario 9: Workloads Running on Wrong Node

## Symptoms

GPU workload runs on CPU node.

## Investigation

Check labels.

```bash
kubectl get nodes --show-labels
```

Check affinity.

```bash
kubectl describe pod
```

## Resolution

* Apply correct labels
* Configure Node Affinity
* Use Taints for dedicated nodes

---

# Scenario 10: Too Many Pods on One Node

## Symptoms

One node overloaded.

Others mostly idle.

## Investigation

Review scheduling rules.

Check:

* Pod Anti-Affinity
* Topology Spread Constraints (if used)

## Resolution

* Add Pod Anti-Affinity
* Review scheduling strategy
* Balance workloads across nodes

---

# Scenario 11: Cluster Upgrade Causes Downtime

## Symptoms

Users experience downtime during maintenance.

## Investigation

Check:

```bash
kubectl get pdb
```

Review replica count.

## Resolution

* Configure Pod Disruption Budget
* Increase replicas
* Drain nodes one at a time

---

# Scenario 12: Affinity Rules Too Restrictive

## Symptoms

Pods remain Pending despite available nodes.

## Investigation

Review:

```yaml
requiredDuringSchedulingIgnoredDuringExecution
```

## Resolution

If strict placement isn't necessary, use:

```yaml
preferredDuringSchedulingIgnoredDuringExecution
```

This gives the scheduler flexibility.

---

# Useful Commands

```bash
kubectl get pods

kubectl describe pod <pod>

kubectl get nodes

kubectl get nodes --show-labels

kubectl describe node <node>

kubectl get events

kubectl get pdb

kubectl describe pdb

kubectl cordon <node>

kubectl drain <node>

kubectl uncordon <node>

kubectl taint nodes

kubectl top nodes

kubectl top pods
```

---

# Production Troubleshooting Checklist

✅ Check Pod Events

✅ Verify node labels

✅ Verify Node Affinity

✅ Verify Pod Affinity

✅ Check Taints

✅ Check Tolerations

✅ Check Pod Disruption Budget

✅ Verify cluster resources

✅ Confirm node status

✅ Review scheduler events

---

# Interview Tips

When a Pod is **Pending**, follow this order:

1. Check Pod Events (`kubectl describe pod`)
2. Verify available node resources
3. Verify Node Selector / Node Affinity
4. Verify Pod Affinity / Anti-Affinity
5. Check node Taints and Pod Tolerations
6. Confirm PVC and other dependencies
7. Review scheduler logs if the issue persists

This structured approach demonstrates a production-ready troubleshooting mindset in interviews.
