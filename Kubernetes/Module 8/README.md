# ☸️ Kubernetes Module 8 — Advanced Scheduling & Cluster Operations

> Master Kubernetes scheduling strategies used in production environments, including Node Affinity, Pod Affinity, Taints & Tolerations, Pod Disruption Budgets, and Cluster Maintenance.

---

## 📚 Topics Covered

### 1. Node Affinity
- Why Node Selector is limited
- Required vs Preferred Scheduling
- Match Expressions
- Operators (In, NotIn, Exists, DoesNotExist, Gt, Lt)
- Production use cases
- YAML examples
- Troubleshooting
- Interview Questions

---

### 2. Pod Affinity
- Co-locating Pods
- Required & Preferred Affinity
- topologyKey
- Same Node vs Same Zone
- Production examples
- YAML examples
- Troubleshooting
- Interview Questions

---

### 3. Pod Anti-Affinity
- High Availability
- Replica Distribution
- Avoid Single Point of Failure
- Required & Preferred Rules
- YAML examples
- Production use cases
- Troubleshooting
- Interview Questions

---

### 4. Taints
- Why Taints are used
- Taint Effects
  - NoSchedule
  - PreferNoSchedule
  - NoExecute
- Built-in Node Taints
- GPU Node Scheduling
- Dedicated Nodes
- Commands
- Troubleshooting
- Interview Questions

---

### 5. Tolerations
- Allow Pods onto Tainted Nodes
- Equal Operator
- Exists Operator
- tolerationSeconds
- Production examples
- YAML examples
- Troubleshooting
- Interview Questions

---

### 6. Taints vs Node Affinity
- Scheduling Comparison
- Production Decision Making
- Best Practices
- GPU Workloads
- Dedicated Infrastructure

---

### 7. Pod Disruption Budget (PDB)
- Voluntary vs Involuntary Disruptions
- minAvailable
- maxUnavailable
- Node Drain Protection
- High Availability
- Production examples
- YAML examples

---

### 8. Cluster Maintenance
- cordon
- drain
- uncordon
- Maintenance Workflow
- Rolling Maintenance
- Interaction with PDB
- Troubleshooting

---

### 9. Scheduling Best Practices
- Production Scheduling Strategy
- Labeling Standards
- Replica Distribution
- Dedicated Nodes
- Resource Optimization
- High Availability
- Production Checklist

---

# 🛠️ Commands Practiced

```bash
kubectl describe node

kubectl taint nodes

kubectl cordon

kubectl drain

kubectl uncordon

kubectl get pdb

kubectl describe pdb

kubectl get nodes --show-labels
```

---

# 🎯 Production Concepts Learned

- Intelligent Pod Scheduling
- Dedicated GPU Nodes
- High Availability Scheduling
- Multi-Zone Scheduling
- Fault Tolerance
- Cluster Maintenance
- Safe Node Upgrades
- Production Scheduling Strategies
- Workload Isolation
- Resource Placement

---

# 💼 Real Production Scenarios

- Deploy AI workloads only on GPU nodes
- Keep Backend and Redis on the same node
- Spread replicas across different nodes
- Prevent downtime during node maintenance
- Reserve infrastructure for critical workloads
- Perform rolling cluster upgrades safely
- Protect production applications using Pod Disruption Budgets

---

# 📂 Skills Gained

- Kubernetes Scheduling
- Cluster Operations
- Node Management
- High Availability
- Production Maintenance
- Workload Isolation
- Scheduling Policies
- Production Troubleshooting

---

# 🧠 Interview Topics Covered

- Node Affinity
- Pod Affinity
- Pod Anti-Affinity
- Taints
- Tolerations
- NoSchedule vs NoExecute
- PDB
- Cluster Maintenance
- Cordon vs Drain vs Uncordon
- Scheduling Best Practices
- Production Scenarios
- Troubleshooting

---

# 🚀 Learning Outcome

After completing this module, I can:

- Design production-grade scheduling strategies
- Isolate workloads using Taints and Tolerations
- Deploy highly available applications using Affinity rules
- Perform safe Kubernetes cluster maintenance
- Protect applications from voluntary disruptions using PDBs
- Troubleshoot scheduling-related issues
- Answer production-focused Kubernetes interview questions confidently

---

## 📌 Tech Stack

- Kubernetes
- kubectl
- YAML
- Linux
- Container Orchestration

---

