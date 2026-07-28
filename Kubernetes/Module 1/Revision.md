# 📘 Kubernetes Fundamentals - Revision Guide

> Last Updated: July 2026

This document contains concise revision notes, interview questions, memory tricks, and production troubleshooting for Kubernetes Fundamentals.

---

# 📑 Table of Contents

- Quick Revision
- Important Definitions
- Component Summary
- Complete Request Flow
- Memory Tricks
- Common Interview Questions
- Scenario Based Interview Questions
- Troubleshooting
- Common Mistakes
- Revision Checklist

---

# ⚡ Quick Revision

| Component | One Line |
|------------|----------|
| Kubernetes | Container orchestration platform |
| API Server | Entry point of Kubernetes |
| etcd | Source of Truth |
| Controller Manager | Maintains Desired State |
| Scheduler | Chooses Worker Node |
| kubelet | Node Agent |
| kube-proxy | Manages Service networking |
| Container Runtime | Runs containers |

---

# 📖 Important Definitions

## Kubernetes

An orchestration platform used to deploy, scale and manage containerized applications.

---

## Desired State

The configuration stored inside etcd that represents how the cluster should look.

---

## Current State

The actual condition of resources running inside the cluster.

---

## Reconciliation Loop

A continuous process where Kubernetes compares Desired State with Current State and takes corrective action.

---

## API Server

The central management component that receives every Kubernetes request.

Responsibilities

- Authentication
- Authorization
- Validation
- Communication with etcd

---

## etcd

A distributed key-value database used to store Kubernetes cluster state.

Stores

- Deployments
- Pods
- Services
- ConfigMaps
- Secrets
- Nodes

---

## Scheduler

Chooses the most suitable Worker Node based on available resources and scheduling constraints.

Does NOT

- Start Pods
- Create Pods

---

## Controller Manager

Responsible for ensuring Current State matches Desired State.

Examples

- Deployment Controller
- ReplicaSet Controller
- Node Controller
- Job Controller

---

## kubelet

Runs on every Worker Node.

Responsibilities

- Watches API Server
- Starts Pods (through the Container Runtime)
- Reports Node Health
- Executes Health Probes

---

## kube-proxy

Maintains networking rules that allow Services to route traffic to healthy Pods.

---

## Container Runtime

Responsible for

- Pulling Images
- Creating Containers
- Starting Containers
- Stopping Containers
- Reporting Container Status

Common Runtime

- containerd

---

# 🔄 Kubernetes Request Flow

```text
Developer

↓

kubectl

↓

API Server

↓

etcd

↓

Controller Manager

↓

Scheduler

↓

Worker Node

↓

kubelet

↓

Container Runtime

↓

Running Pod

↓

Service

↓

kube-proxy

↓

User
```

---

# 🧠 Memory Tricks

| Component | Trick |
|------------|-------|
| API Server | Front Door |
| etcd | Cluster Memory |
| Scheduler | Chooses Home |
| kubelet | Node Executor |
| kube-proxy | Traffic Police |
| Runtime | Engine |
| Controller Manager | Self Healing Brain |

---

# 🎯 Common Interview Questions

## Kubernetes Basics

- What is Kubernetes?
- Why do we need Kubernetes?
- Difference between Docker and Kubernetes?
- Explain Container Orchestration.

---

## Architecture

- Explain Kubernetes Architecture.
- Explain Control Plane.
- Explain Worker Node.
- Difference between Master and Worker Node.
- Explain kubectl apply flow.

---

## API Server

- What is API Server?
- Why is API Server important?
- Which component talks directly to etcd?

---

## etcd

- What is etcd?
- Why is etcd called Source of Truth?
- What information is stored inside etcd?

---

## Controller Manager

- What is Desired State?
- Explain Self Healing.
- Explain Reconciliation Loop.
- Which component creates missing Pods?

---

## Scheduler

- How does Scheduler select Worker Nodes?
- Can Scheduler start Pods?
- What happens if no node has enough resources?

---

## kubelet

- What is kubelet?
- Does kubelet create containers?
- How does kubelet communicate with API Server?

---

## kube-proxy

- What is kube-proxy?
- Why don't users connect directly to Pod IPs?
- How does Service networking work?

---

## Container Runtime

- What is containerd?
- Difference between Docker and containerd?
- What is CRI?
- Is Docker required by Kubernetes?

---

# 🏭 Scenario Based Interview Questions

### Scenario 1

A Pod crashed.

Explain what happens internally.

---

### Scenario 2

A Worker Node suddenly becomes NotReady.

What components are involved?

---

### Scenario 3

Developer executes

kubectl apply

Explain every component involved until the application starts.

---

### Scenario 4

A Service is not routing traffic.

Which components will you investigate?

---

### Scenario 5

Pods remain Pending forever.

What could be the possible reasons?

---

# 🔧 Troubleshooting

---

## Pods Pending

Symptoms

- Pod never starts

Possible Causes

- No CPU
- No Memory
- Taints
- Node Selector mismatch

Commands

```bash
kubectl get pods

kubectl describe pod <pod-name>

kubectl get nodes
```

Resolution

- Increase resources
- Remove scheduling restrictions
- Add Worker Nodes

---

## Node NotReady

Commands

```bash
kubectl get nodes

kubectl describe node

kubectl get events
```

Possible Causes

- kubelet stopped
- Network issue
- Disk pressure
- Memory pressure

Resolution

- Restart kubelet
- Fix network
- Free disk space
- Resolve resource pressure

---

## ImagePullBackOff

Possible Causes

- Wrong image
- Private registry
- Authentication issue
- Network issue

Commands

```bash
kubectl describe pod

kubectl get events
```

---

## CrashLoopBackOff

Possible Causes

- Application crash
- Wrong environment variables
- Missing ConfigMap
- Missing Secret

Commands

```bash
kubectl logs

kubectl describe pod
```

---

# ❌ Common Mistakes

❌ Scheduler starts Pods

✔ kubelet starts Pods through the Container Runtime.

---

❌ etcd creates Pods

✔ etcd only stores cluster state.

---

❌ kube-proxy is a reverse proxy

✔ kube-proxy manages Service networking rules.

---

❌ Kubernetes runs containers

✔ Container Runtime runs containers.

---

# ✅ Revision Checklist

Before moving to Module 2, ensure you can explain:

- [ ] Kubernetes Architecture
- [ ] Desired State
- [ ] Current State
- [ ] Reconciliation Loop
- [ ] API Server
- [ ] etcd
- [ ] Scheduler
- [ ] Controller Manager
- [ ] Cloud Controller Manager
- [ ] kubelet
- [ ] kube-proxy
- [ ] Container Runtime
- [ ] Complete Request Lifecycle
- [ ] Self Healing
- [ ] Service Networking

---

# 🏁 Final Interview Challenge

Without looking at any notes, explain the complete lifecycle of the following command:

```bash
kubectl apply -f deployment.yaml
```

If you can confidently explain every component involved from the API Server to a running Pod serving user traffic, you have mastered the fundamentals of Kubernetes.