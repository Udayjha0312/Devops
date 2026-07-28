# 📚 Module 02 — REVISION.md

> **Purpose:** This file is designed for **5–10 minute revision** before interviews, certifications, or real-world troubleshooting.

---

# 🎯 One-Line Revision

> **A Pod is the smallest deployable unit in Kubernetes that encapsulates one or more tightly coupled containers sharing the same network, storage, and lifecycle.**

---

# 🧠 Memory Tricks

### Pod

> **One Application = One Pod**

---

### Multi-Container Pod

> **One Workload + Many Helpers**

---

### Init Container

> **Prepare → Exit → Application Starts**

---

### Sidecar

> **Runs Beside the Application**

---

### Restart Policies

```
Always

↓

OnFailure

↓

Never
```

Remember:

**AON**

---

### Pod Lifecycle

```
Pending

↓

Running

↓

Succeeded / Failed / Unknown
```

Remember:

**PRSFU**

---

### Requests vs Limits

```
Requests

↓

Reservation
```

```
Limits

↓

Restriction
```

---

### CPU vs Memory

```
CPU

↓

Throttled
```

```
Memory

↓

OOMKilled
```

---

### Probes

```
Startup

↓

Readiness

↓

Liveness
```

Remember:

**Start → Ready → Live**

---

# 📦 Pod Quick Revision

A Pod is:

- Smallest deployable object
- Scheduled by Kubernetes
- Contains one or more containers
- Shares networking
- Shares storage
- Shares lifecycle

---

# 🏗 Pod Architecture

```
Pod

├── Pause Container
├── Application Container(s)
├── Shared Network
├── Shared Volumes
└── Metadata
```

Pause Container creates the shared namespaces.

---

# 📌 Single vs Multi-Container Pods

| Single Container | Multi-Container |
|------------------|-----------------|
| Most common | Less common |
| One application | One application + helper containers |
| Easier scaling | Used for logging, monitoring, proxies |

---

# 🚀 Init Container

Runs:

```
Before Application
```

Purpose:

- Wait for database
- Download configuration
- Run migrations
- Prepare storage

Flow:

```
Init

↓

Exit

↓

Application
```

---

# 🚀 Sidecar

Runs:

```
Alongside Application
```

Typical examples:

- Fluent Bit
- Envoy
- Monitoring Agent

Shares:

- localhost
- Volumes
- Lifecycle

---

# 🔄 Pod Lifecycle

```
Pending

↓

Running

↓

Succeeded

or

Failed

or

Unknown
```

Meaning:

| Phase | Meaning |
|---------|----------|
| Pending | Waiting for scheduling/resources |
| Running | Application running |
| Succeeded | Finished successfully |
| Failed | Finished with error |
| Unknown | Node status unavailable |

---

# 🔁 Restart Policies

| Policy | Usage |
|---------|-------|
| Always | APIs, Web Servers |
| OnFailure | Jobs |
| Never | Debugging |

Remember:

Restart Policy restarts

**Containers**

NOT

**Pods**

---

# 🌐 Pod Networking

Rules:

✅ Every Pod gets one IP

✅ Containers share that IP

✅ Containers communicate using localhost

✅ Pods communicate across Worker Nodes

❌ Never depend on Pod IPs

Use:

```
Service
```

instead.

---

# 🌍 CNI

CNI =

```
Container Network Interface
```

Responsibilities:

- Assign Pod IP
- Connect Pods
- Cross-node networking

Popular CNIs:

- Calico
- Flannel
- Cilium

---

# ⚙ Resource Requests & Limits

Requests:

```
Minimum Guaranteed
```

Limits:

```
Maximum Allowed
```

Scheduler uses:

```
Requests
```

NOT

```
Limits
```

---

### CPU

Above limit:

```
Throttled
```

---

### Memory

Above limit:

```
OOMKilled
```

---

# ❤️ Kubernetes Probes

| Probe | Purpose |
|---------|----------|
| Startup | Application finished starting |
| Readiness | Ready for traffic |
| Liveness | Restart unhealthy application |

Probe Types:

- HTTP
- TCP
- Exec

---

# ⚡ Most Important kubectl Commands

```bash
kubectl get pods
```

List Pods.

---

```bash
kubectl describe pod <pod-name>
```

View detailed Pod information.

---

```bash
kubectl logs <pod-name>
```

View application logs.

---

```bash
kubectl exec -it <pod-name> -- sh
```

Enter a container.

---

```bash
kubectl delete pod <pod-name>
```

Delete a Pod.

---

```bash
kubectl get pod <pod-name> -o yaml
```

View complete Pod YAML.

---

# 🎯 Interview Cheat Sheet

### What is a Pod?

Smallest deployable unit in Kubernetes.

---

### Why Pods instead of Containers?

- Shared networking
- Shared storage
- Shared lifecycle
- Better scheduling

---

### Difference between Init Container and Sidecar?

| Init | Sidecar |
|------|----------|
| Runs before app | Runs with app |
| Temporary | Long-running |

---

### Difference between Readiness and Liveness?

| Readiness | Liveness |
|------------|-----------|
| Controls traffic | Restarts container |

---

### Difference between Requests and Limits?

| Requests | Limits |
|----------|---------|
| Scheduling | Runtime enforcement |

---

### CPU vs Memory Limits?

CPU

↓

Throttled

Memory

↓

OOMKilled

---

### Does every container get an IP?

No.

Every **Pod** gets one IP.

Containers share it.

---

### What is localhost used for?

Communication between containers inside the same Pod.

---

### Does Restart Policy recreate Pods?

No.

Deployments recreate Pods.

Restart Policies restart containers.

---

### Is CrashLoopBackOff a Pod Phase?

No.

It is a **container status**.

---

# 🚨 Common Mistakes

❌ Pod = Container

---

❌ Every container gets an IP

---

❌ Pod IPs are permanent

---

❌ CrashLoopBackOff is a Pod phase

---

❌ CPU limit kills containers

---

❌ Scheduler uses Limits

---

❌ Readiness restarts Pods

---

❌ Sidecars replace applications

---

# 📋 Production Best Practices

✅ One application per Pod

✅ Configure resource requests

✅ Configure realistic limits

✅ Configure probes

✅ Keep Pods stateless

✅ Use Services instead of Pod IPs

✅ Monitor restart count

✅ Use Sidecars only when necessary

---

# 🧪 Rapid Fire Questions

1. What is a Pod?
2. Why does Kubernetes use Pods?
3. What is the Pause Container?
4. What is a Sidecar?
5. What is an Init Container?
6. Name the Pod lifecycle phases.
7. Name the restart policies.
8. Difference between Requests and Limits?
9. What happens when CPU exceeds its limit?
10. What happens when memory exceeds its limit?
11. What are the three probes?
12. Difference between Readiness and Liveness?
13. What is CNI?
14. Can Pods communicate across nodes?
15. Why shouldn't applications use Pod IPs directly?
16. Does Restart Policy recreate Pods?
17. Is CrashLoopBackOff a Pod phase?
18. How do you view Pod logs?
19. How do you enter a running container?
20. Which command gives the most troubleshooting information?

---

# 🏁 Final Takeaway

If you remember only five things from this module, remember these:

1. **Pods are the smallest deployable unit in Kubernetes.**
2. **Containers inside a Pod share networking and storage.**
3. **The Scheduler uses resource requests, not limits.**
4. **Readiness controls traffic; Liveness enables self-healing.**
5. **Use Services for stable communication—never rely on Pod IP addresses.**