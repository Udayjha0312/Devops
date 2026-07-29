# 📘 Module 6 – Kubernetes Workloads (Revision)

> **Goal:** Quickly revise Kubernetes workload types, production use cases, important commands, and interview concepts.

---

# 🏗️ Kubernetes Workloads Overview

```text
                         Kubernetes Workloads
                                 │
      ┌───────────────┬──────────┴──────────┬──────────────┐
      │               │                     │              │
      ▼               ▼                     ▼              ▼
 Deployment      StatefulSet          DaemonSet         Job
      │               │                     │              │
      │               │                     │              ▼
      │               │                     │        One-Time Task
      │               │                     │
      │               │                     ▼
      │         Stateful Apps       One Pod Per Node
      │
      ▼
 Stateless Apps

              CronJob
                  │
                  ▼
          Scheduled Jobs
```

---

# 1️⃣ Deployment

### Used For

* FastAPI
* Node.js
* React
* Spring Boot
* NGINX

### Features

* Stateless
* Rolling Updates
* Self-Healing
* Horizontal Scaling

### Remember

Deployment → ReplicaSet → Pods

---

# 2️⃣ StatefulSet

### Used For

* PostgreSQL
* MySQL
* MongoDB
* Kafka
* Cassandra
* ZooKeeper

### Features

* Stable Pod Name
* Stable DNS
* Stable Storage
* Ordered Deployment
* Ordered Scaling
* Ordered Updates

### Remember

```text
StatefulSet

↓

postgres-0

↓

PVC

↓

PV
```

---

# 3️⃣ Headless Service

### Purpose

Allows clients to communicate with **individual Pods** instead of a single Service IP.

### Key Points

* `clusterIP: None`
* No Load Balancing
* Returns Pod IPs
* Required for StatefulSet DNS discovery

Example DNS

```text
postgres-0.database.default.svc.cluster.local
```

---

# 4️⃣ DaemonSet

### Used For

* Fluent Bit
* Fluentd
* Node Exporter
* Calico
* Cilium
* Falco
* CSI Node Plugins

### Features

* One Pod per eligible Node
* Automatically runs on new Nodes
* Automatically removed when a Node leaves

Architecture

```text
DaemonSet

↓

Node-1 → Agent

↓

Node-2 → Agent

↓

Node-3 → Agent
```

---

# 5️⃣ Job

### Used For

* Database Migration
* Batch Processing
* Data Import
* Verification Scripts

### Features

* Executes once
* Stops after completion
* Retries on failure
* Supports Parallelism and Completions

Flow

```text
Job

↓

Pod

↓

Task

↓

Completed
```

---

# 6️⃣ CronJob

### Used For

* Nightly Database Backup
* Log Cleanup
* Weekly Reports
* Scheduled Maintenance

### Features

* Runs Jobs on a schedule
* Uses cron expressions
* Supports concurrency policies

Flow

```text
CronJob

↓

Job

↓

Pod

↓

Completed
```

---

# 📊 Workload Comparison

| Workload    | Best For        | Runs Continuously | Stable Identity | One Pod Per Node | Scheduled |
| ----------- | --------------- | ----------------- | --------------- | ---------------- | --------- |
| Deployment  | APIs, Frontends | ✅                 | ❌               | ❌                | ❌         |
| StatefulSet | Databases       | ✅                 | ✅               | ❌                | ❌         |
| DaemonSet   | Node Agents     | ✅                 | ❌               | ✅                | ❌         |
| Job         | One-Time Tasks  | ❌                 | ❌               | ❌                | ❌         |
| CronJob     | Scheduled Tasks | ❌                 | ❌               | ❌                | ✅         |

---

# 🏢 Production Mapping

| Application        | Workload    |
| ------------------ | ----------- |
| FastAPI            | Deployment  |
| React              | Deployment  |
| PostgreSQL         | StatefulSet |
| MongoDB            | StatefulSet |
| Kafka              | StatefulSet |
| Fluent Bit         | DaemonSet   |
| Node Exporter      | DaemonSet   |
| Database Migration | Job         |
| Nightly Backup     | CronJob     |

---

# 🛠️ Important Commands

## Deployment

```bash
kubectl get deployments
kubectl describe deployment <name>
kubectl rollout status deployment <name>
```

---

## StatefulSet

```bash
kubectl get statefulsets
kubectl describe statefulset <name>
kubectl get pvc
```

---

## DaemonSet

```bash
kubectl get daemonsets
kubectl describe daemonset <name>
kubectl get pods -o wide
```

---

## Job

```bash
kubectl get jobs
kubectl describe job <name>
kubectl logs <pod-name>
kubectl delete job <name>
```

---

## CronJob

```bash
kubectl get cronjobs
kubectl describe cronjob <name>
kubectl get jobs
```

---

# 🚑 Troubleshooting Flow

## Deployment

```text
Deployment
     │
     ▼
ReplicaSet
     │
     ▼
Pods
     │
     ▼
Logs
```

---

## StatefulSet

```text
StatefulSet
     │
     ▼
Pods
     │
     ▼
PVC
     │
     ▼
PV
```

---

## DaemonSet

```text
DaemonSet
     │
     ▼
Nodes
     │
     ▼
Daemon Pods
```

---

## Job

```text
Job
     │
     ▼
Pod
     │
     ▼
Logs
```

---

## CronJob

```text
CronJob
     │
     ▼
Job
     │
     ▼
Pod
     │
     ▼
Logs
```

---

# 🎯 Interview Questions

### What is a StatefulSet?

A workload for stateful applications requiring stable identities, persistent storage, and ordered lifecycle management.

---

### Why use a Headless Service?

To expose individual StatefulSet Pods through DNS instead of a single load-balanced Service IP.

---

### What is a DaemonSet?

A workload that ensures one Pod runs on every eligible node.

---

### What is the difference between a Job and a CronJob?

* **Job:** Runs once.
* **CronJob:** Creates Jobs automatically according to a schedule.

---

### Which workload should you use?

| Scenario           | Answer      |
| ------------------ | ----------- |
| FastAPI API        | Deployment  |
| PostgreSQL         | StatefulSet |
| Fluent Bit         | DaemonSet   |
| Database Migration | Job         |
| Nightly Backup     | CronJob     |

---

# 🧠 30-Second Revision

```text
Deployment
│
├── Stateless Apps
├── Rolling Updates
└── ReplicaSet

StatefulSet
│
├── Stable Identity
├── Stable Storage
├── Stable DNS
└── Ordered Lifecycle

DaemonSet
│
├── One Pod Per Node
├── Logging
├── Monitoring
└── Networking

Job
│
├── One-Time Task
└── Stops After Completion

CronJob
│
├── Scheduled Task
└── Creates Jobs
```

---

# ✅ Module 6 Checklist

* [x] Deployment vs StatefulSet
* [x] StatefulSet Features
* [x] Headless Service
* [x] DaemonSet
* [x] Job
* [x] CronJob
* [x] Workload Comparison
* [x] Production Use Cases
* [x] Important Commands
* [x] Interview Questions

---

# 🚀 Next Module

**Module 7 – Kubernetes Configuration & Security**

* ConfigMaps
* Secrets
* Environment Variables
* Service Accounts
* RBAC
* Security Contexts
* Resource Requests & Limits
* Production Security Best Practices
