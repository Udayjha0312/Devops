# ☸️ Module 6 – Kubernetes Workloads

## 📌 Overview

This module focuses on **Kubernetes Workloads**, the resources responsible for running applications and tasks inside a Kubernetes cluster.

By the end of this module, you'll understand how Kubernetes manages **stateless applications, stateful applications, node-level services, one-time tasks, and scheduled jobs** in production environments.

---

# 📚 Topics Covered

* StatefulSets
* StatefulSet Features
* Headless Services
* DaemonSets
* Jobs
* CronJobs
* Production Workload Selection

---

# 🎯 Learning Outcomes

After completing this module, you will be able to:

* Differentiate between Deployment and StatefulSet.
* Understand stable Pod identity and persistent storage.
* Explain why StatefulSets use Headless Services.
* Deploy node-level applications using DaemonSets.
* Execute one-time tasks using Jobs.
* Schedule recurring tasks using CronJobs.
* Select the correct Kubernetes workload for production use cases.
* Troubleshoot common workload-related issues.

---

# 🏗️ Kubernetes Workloads Overview

```text
                           Kubernetes Workloads
                                   │
          ┌───────────────┬─────────┴─────────┬──────────────┐
          │               │                   │              │
          ▼               ▼                   ▼              ▼
     Deployment      StatefulSet        DaemonSet         Job
          │               │                   │              │
          │               │                   │              ▼
          │               │                   │         One-Time Task
          │               │                   │
          │               │                   ▼
          │         Stateful Apps      One Pod Per Node
          │
          ▼
 Stateless Apps

                  CronJob
                      │
                      ▼
             Scheduled Jobs
```

---

# 📖 Key Concepts

## 1. Deployment

**Purpose**

Run stateless applications continuously.

**Examples**

* FastAPI
* Node.js
* React
* NGINX
* Spring Boot

**Features**

* Stateless
* Rolling Updates
* Self-Healing
* Horizontal Scaling

---

## 2. StatefulSet

**Purpose**

Run applications requiring persistent identity and storage.

**Examples**

* PostgreSQL
* MongoDB
* Kafka
* Cassandra
* MySQL
* ZooKeeper

**Features**

* Stable Pod Names
* Stable DNS
* Stable Storage
* Ordered Deployment
* Ordered Scaling
* Ordered Updates

---

## 3. Headless Service

**Purpose**

Provide direct DNS-based access to individual StatefulSet Pods.

**Features**

* No ClusterIP
* No Load Balancing
* Returns Pod IPs
* Stable DNS Names

---

## 4. DaemonSet

**Purpose**

Run exactly one Pod on every eligible node.

**Production Examples**

* Fluent Bit
* Fluentd
* Node Exporter
* Calico
* Cilium
* Falco
* CSI Node Plugins

---

## 5. Job

**Purpose**

Run a task once until completion.

**Production Examples**

* Database Migration
* Data Import
* Batch Processing
* Verification Scripts

---

## 6. CronJob

**Purpose**

Schedule Jobs automatically.

**Production Examples**

* Nightly Database Backup
* Log Cleanup
* Weekly Reports
* Cache Cleanup
* Scheduled Maintenance

---

# ⚖️ Workload Comparison

| Workload    | Best For        | Runs Continuously | Stable Identity | Scheduled | One Pod Per Node |
| ----------- | --------------- | ----------------- | --------------- | --------- | ---------------- |
| Deployment  | Stateless Apps  | ✅                 | ❌               | ❌         | ❌                |
| StatefulSet | Databases       | ✅                 | ✅               | ❌         | ❌                |
| DaemonSet   | Node Agents     | ✅                 | ❌               | ❌         | ✅                |
| Job         | One-Time Tasks  | ❌                 | ❌               | ❌         | ❌                |
| CronJob     | Scheduled Tasks | ❌                 | ❌               | ✅         | ❌                |

---

# 🏢 Production Architecture

```text
                    Internet
                         │
                         ▼
                 Load Balancer
                         │
                         ▼
                     Ingress
                         │
         ┌───────────────┴───────────────┐
         ▼                               ▼
Frontend Deployment              Backend Deployment
         │                               │
         └───────────────┬───────────────┘
                         ▼
               PostgreSQL StatefulSet
                         │
                         ▼
                Persistent Volumes

Worker Nodes
├── Fluent Bit (DaemonSet)
├── Node Exporter (DaemonSet)
└── Application Pods

Nightly Backup
CronJob
   │
   ▼
 Job
   │
   ▼
 Pod
```

---

# 🛠️ Important Commands

## StatefulSets

```bash
kubectl get statefulsets
kubectl describe statefulset <name>
kubectl get pvc
```

---

## DaemonSets

```bash
kubectl get daemonsets
kubectl describe daemonset <name>
kubectl get pods -o wide
```

---

## Jobs

```bash
kubectl get jobs
kubectl describe job <name>
kubectl logs <pod-name>
kubectl delete job <name>
```

---

## CronJobs

```bash
kubectl get cronjobs
kubectl describe cronjob <name>
kubectl get jobs
```

---

# 🚑 Production Troubleshooting Checklist

## StatefulSet Issues

```bash
kubectl get statefulsets
kubectl describe statefulset <name>
kubectl get pods
kubectl get pvc
kubectl describe pvc
```

Check for:

* Pending Pods
* Missing PVCs
* Storage issues
* Failed rollouts

---

## DaemonSet Issues

```bash
kubectl get daemonsets
kubectl get nodes
kubectl get pods -o wide
kubectl describe daemonset <name>
```

Check for:

* Missing Pods on nodes
* Node selectors
* Taints and tolerations
* Scheduling failures

---

## Job Issues

```bash
kubectl get jobs
kubectl describe job <name>
kubectl get pods
kubectl logs <pod-name>
```

Check for:

* Retry count
* Exit code
* Script errors
* Database connection failures

---

## CronJob Issues

```bash
kubectl get cronjobs
kubectl describe cronjob <name>
kubectl get jobs
kubectl logs <pod-name>
```

Check for:

* Incorrect schedule
* Suspended CronJob
* Failed Jobs
* Script errors

---

# 💼 Real Production Use Cases

| Requirement        | Recommended Workload |
| ------------------ | -------------------- |
| REST API           | Deployment           |
| Frontend           | Deployment           |
| PostgreSQL         | StatefulSet          |
| MongoDB            | StatefulSet          |
| Kafka              | StatefulSet          |
| Fluent Bit         | DaemonSet            |
| Node Exporter      | DaemonSet            |
| Database Migration | Job                  |
| Nightly Backup     | CronJob              |
| Weekly Reports     | CronJob              |

---

# 🎯 Interview Questions

### 1. What is the difference between a Deployment and a StatefulSet?

### 2. Why do StatefulSets require Headless Services?

### 3. What is a DaemonSet, and where is it used?

### 4. When should you use a Job instead of a Deployment?

### 5. What is the difference between a Job and a CronJob?

### 6. What happens when a new node joins a cluster with a DaemonSet?

### 7. Explain the relationship between a CronJob, Job, and Pod.

### 8. Which workload would you choose for PostgreSQL, and why?

---

# 🧠 Quick Revision

```text
Deployment
│
├── Stateless Applications
├── Self-Healing
└── Rolling Updates

StatefulSet
│
├── Databases
├── Stable Identity
├── Stable Storage
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
└── Creates Jobs Automatically
```

---

# ✅ Module Checklist

* [x] Learned StatefulSets
* [x] Understood Stable Identity
* [x] Learned Headless Services
* [x] Learned DaemonSets
* [x] Learned Jobs
* [x] Learned CronJobs
* [x] Compared Kubernetes Workloads
* [x] Practiced Production Scenarios
* [x] Learned Troubleshooting Workflow
* [x] Reviewed Interview Questions

---

# 🚀 Next Module

**Module 7 – Kubernetes Configuration & Security**

Topics include:

* ConfigMaps
* Secrets
* Environment Variables
* Service Accounts
* RBAC
* Security Contexts
* Resource Requests & Limits
* Production Security Best Practices
