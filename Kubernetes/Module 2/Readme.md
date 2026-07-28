# ☸️ Module 02 — Kubernetes Pods

> The Pod is the smallest deployable unit in Kubernetes. Every application running inside a Kubernetes cluster ultimately runs inside one or more Pods.

---

# 📖 Table of Contents

- Module Overview
- Learning Objectives
- What is a Pod?
- Why Kubernetes Uses Pods Instead of Containers
- Pod Architecture
- Single-Container Pods
- Multi-Container Pods
- Init Containers
- Sidecar Pattern
- Pod Lifecycle
- Restart Policies
- Pod Networking
- Resource Requests & Limits
- Health Checks (Probes)
- Best Practices
- Common Mistakes
- Production Summary
- Skills Acquired
- Related Files
- What's Next

---

# 🎯 Module Overview

Pods are the fundamental execution unit of Kubernetes.

Although Docker runs **containers**, Kubernetes schedules and manages **Pods**.

A Pod acts as a wrapper around one or more tightly coupled containers that share networking, storage, and lifecycle.

Understanding Pods is essential before learning ReplicaSets, Deployments, Services, or Ingress.

---

# 🎓 Learning Objectives

After completing this module, you will be able to:

- Explain why Kubernetes uses Pods instead of containers
- Understand Pod architecture
- Work with single and multi-container Pods
- Use Init Containers and Sidecars
- Explain the Pod lifecycle
- Configure restart policies
- Understand Kubernetes networking
- Configure resource requests and limits
- Implement health checks using probes
- Troubleshoot common Pod failures

---

# 📦 What is a Pod?

A **Pod** is the smallest deployable object in Kubernetes.

Instead of scheduling containers directly, Kubernetes schedules Pods.

A Pod may contain:

- One application container
- Multiple tightly coupled containers
- Shared storage
- Shared networking

Example:

```text
Pod

├── Pause Container
├── FastAPI Container
└── Fluent Bit Sidecar
```

---

# ❓ Why Kubernetes Uses Pods

Pods solve several problems that individual containers cannot solve efficiently.

## Shared Networking

Containers inside a Pod communicate using:

```text
localhost
```

instead of external networking.

---

## Shared Storage

Containers can mount the same volume.

Example:

```text
FastAPI

↓

shared volume

↓

Fluent Bit
```

---

## Shared Lifecycle

Containers that belong together:

- Start together
- Stop together
- Move together

---

## Scheduling

The Kubernetes Scheduler places the entire Pod onto a Worker Node instead of scheduling each container independently.

---

# 🏗 Pod Architecture

Every Pod contains:

```text
Pod

├── Pause Container
├── Application Container(s)
├── Shared Network Namespace
├── Shared Volumes
└── Metadata
```

## Pause Container

The Pause Container creates and owns the shared namespaces for the Pod.

Application containers join these namespaces.

---

## Shared Network

Every Pod receives:

- One IP Address

Every container inside the Pod shares it.

Communication happens using:

```text
localhost
```

---

## Shared Storage

Volumes can be mounted into multiple containers simultaneously.

---

# 📌 Single-Container Pods

Most production workloads follow:

```text
One Pod

↓

One Main Container
```

Examples:

- FastAPI
- Nginx
- Redis
- PostgreSQL

This model provides:

- Simpler scaling
- Easier deployment
- Better isolation

---

# 📌 Multi-Container Pods

Multiple containers should only be used when they are tightly coupled.

Example:

```text
Pod

├── FastAPI
└── Fluent Bit
```

Common sidecars:

- Logging
- Monitoring
- Service Mesh Proxy

---

# 🚀 Init Containers

Init Containers execute before application containers start.

Typical responsibilities:

- Wait for databases
- Run database migrations
- Download configuration
- Prepare shared volumes

Flow:

```text
Pause

↓

Init Container

↓

Application Container
```

---

# 🚀 Sidecar Pattern

A Sidecar is a helper container that runs alongside the main application.

Example:

```text
Pod

├── FastAPI
└── Fluent Bit
```

Common use cases:

- Logging
- Monitoring
- Security
- Service Mesh

---

# 🔄 Pod Lifecycle

Every Pod moves through lifecycle phases.

```text
Pending

↓

Running

↓

Succeeded

or

Failed
```

Possible phases:

- Pending
- Running
- Succeeded
- Failed
- Unknown

---

# 🔁 Restart Policies

Kubernetes supports three restart policies.

| Policy | Purpose |
|---------|----------|
| Always | Restart every failure |
| OnFailure | Restart only after failure |
| Never | Never restart |

Remember:

Restart Policies restart **containers**, not Pods.

---

# 🌐 Pod Networking

Networking rules:

- Every Pod gets one IP
- Containers share the Pod IP
- Pods communicate across Nodes
- Applications should not rely on Pod IPs

Example:

```text
Frontend Pod

↓

Product Pod

↓

Database Pod
```

Networking is implemented using a **CNI plugin**.

Popular CNIs:

- Calico
- Flannel
- Cilium

---

# ⚙ Resource Requests & Limits

Requests define minimum guaranteed resources.

Limits define maximum allowed resources.

Example:

```yaml
resources:
  requests:
    cpu: "500m"
    memory: "256Mi"

  limits:
    cpu: "1"
    memory: "512Mi"
```

Important behavior:

CPU exceeds limit

↓

Throttled

Memory exceeds limit

↓

OOMKilled

---

# ❤️ Health Checks

Kubernetes provides three probes.

| Probe | Purpose |
|---------|---------|
| Startup | Application finished starting |
| Readiness | Ready to receive traffic |
| Liveness | Application is healthy |

Probe methods:

- HTTP
- TCP
- Exec

---

# 🏢 Production Best Practices

- Prefer one application per Pod.
- Use Sidecars only when necessary.
- Always define resource requests.
- Configure realistic limits.
- Implement readiness and liveness probes.
- Never hardcode Pod IP addresses.
- Access applications through Services.
- Monitor restart counts.
- Keep Pods stateless whenever possible.

---

# ❌ Common Mistakes

- Assuming Pods are permanent
- Confusing Pods with containers
- Treating CrashLoopBackOff as a Pod phase
- Forgetting readiness probes
- Using Pod IPs directly
- Ignoring resource limits
- Running unrelated applications in one Pod

---

# 📈 Production Summary

Pods are the foundation of every Kubernetes workload.

Everything you deploy later—including Deployments, StatefulSets, DaemonSets, and Jobs—ultimately creates and manages Pods.

A solid understanding of Pods is critical for production Kubernetes environments.

---

# 🎯 Skills Acquired

After this module you can:

- Design Pod architectures
- Configure multi-container Pods
- Use Init Containers
- Implement Sidecars
- Understand Pod networking
- Configure requests and limits
- Configure probes
- Debug common Pod failures
- Deploy production-ready Pods

---

# 📂 Related Files

- **REVISION.md** — Quick revision and interview notes
- **TROUBLESHOOTING.md** — Production troubleshooting scenarios
- **MINI_PROJECT.md** — Deploying a production-style application using Pods
- **labs/** — YAML manifests and hands-on exercises

---

# 🚀 What's Next?

The next module introduces **ReplicaSets and Deployments**, where you'll learn how Kubernetes achieves:

- Self-healing
- Scaling
- Rolling updates
- Rollbacks
- High availability

Pods are powerful, but Deployments are what you'll use for almost every production application.