# 📘 KEDA Revision Notes

## Module 12 – Kubernetes Event-Driven Autoscaling (KEDA)

---

# 🚀 What is KEDA?

* **KEDA (Kubernetes Event-Driven Autoscaling)** is an open-source autoscaler for Kubernetes.
* It scales workloads based on **external event sources** instead of only CPU or memory.
* Supports **Scale to Zero**.

---

# Why KEDA?

Problem with HPA:

```text
Queue = 10,000 Messages

CPU = 5%
```

HPA sees only CPU and may not scale.

KEDA monitors:

* RabbitMQ
* Kafka
* Redis
* AWS SQS
* Prometheus
* Databases
* Cron schedules

and scales accordingly.

---

# HPA vs KEDA

| HPA                          | KEDA                      |
| ---------------------------- | ------------------------- |
| CPU / Memory                 | External Events           |
| Resource-based               | Event-driven              |
| Usually minimum replicas ≥ 1 | Can scale to 0            |
| Best for APIs                | Best for workers & queues |

---

# KEDA Architecture

```text
External Event Source
        │
        ▼
 KEDA Operator
        │
        ▼
 Metrics Adapter
        │
        ▼
 Horizontal Pod Autoscaler
        │
        ▼
 Deployment
        │
        ▼
 Pods
```

---

# KEDA Components

### KEDA Operator

* Watches ScaledObjects
* Creates HPAs
* Reconciles desired state

---

### Metrics Adapter

* Converts external metrics
* Exposes metrics to HPA

---

### ScaledObject

Defines:

* Target workload
* Trigger
* Polling interval
* Cooldown
* Min replicas
* Max replicas

---

### ScaledJob

Used for:

* Kubernetes Jobs
* Batch workloads
* Event-driven jobs

---

### TriggerAuthentication

Namespace-scoped authentication.

---

### ClusterTriggerAuthentication

Cluster-wide authentication.

---

# ScaledObject

Important fields:

```yaml
scaleTargetRef

pollingInterval

cooldownPeriod

minReplicaCount

maxReplicaCount

triggers
```

---

# Polling Interval

Default:

```text
30 seconds
```

Lower:

* Faster scaling
* Higher API usage

Higher:

* Slower scaling
* Lower overhead

---

# Cooldown Period

Default:

```text
300 seconds
```

Purpose:

Avoid scaling thrashing.

---

# Replica Limits

Example:

```yaml
minReplicaCount: 0

maxReplicaCount: 20
```

Allows:

Scale between **0–20 Pods**.

---

# Trigger Types

Common production triggers:

* RabbitMQ
* Kafka
* Redis
* AWS SQS
* Azure Queue
* Prometheus
* Cron
* PostgreSQL
* MySQL

---

# Authentication

Authentication options:

* Kubernetes Secret
* TriggerAuthentication
* ClusterTriggerAuthentication
* AWS IAM
* Azure Managed Identity
* Google Workload Identity
* HashiCorp Vault

Never hardcode credentials.

---

# Scale to Zero

Workflow:

```text
No Events

↓

0 Pods

↓

New Event

↓

KEDA Detects Event

↓

Pods Start

↓

Process Work

↓

Cooldown

↓

0 Pods
```

---

# Cold Start

When scaling from 0 Pods:

```text
Event

↓

Pod Creation

↓

Container Start

↓

Application Ready

↓

Processing
```

Cold start = Startup delay.

---

# Production Best Practices

* Choose the correct trigger
* Tune polling interval
* Tune cooldown period
* Configure min/max replicas
* Monitor KEDA Operator
* Secure authentication
* Optimize container startup
* Test autoscaling
* Monitor downstream services
* Integrate with CI/CD

---

# Common Troubleshooting

Pods not scaling:

```bash
kubectl get scaledobjects

kubectl describe scaledobject
```

Check HPA:

```bash
kubectl get hpa
```

Check KEDA:

```bash
kubectl get pods -n keda
```

Check logs:

```bash
kubectl logs deployment/keda-operator -n keda
```

---

# Troubleshooting Flow

```text
Event Source

↓

Trigger

↓

Authentication

↓

ScaledObject

↓

KEDA Operator

↓

Metrics Adapter

↓

HPA

↓

Pods

↓

Application
```

---

# Common Commands

```bash
kubectl get scaledobjects

kubectl describe scaledobject

kubectl get hpa

kubectl describe hpa

kubectl get pods -n keda

kubectl logs deployment/keda-operator -n keda

kubectl logs deployment/keda-metrics-apiserver -n keda

kubectl get events
```

---

# Interview Quick Revision

### What is KEDA?

Event-driven autoscaler for Kubernetes.

---

### Biggest advantage?

Scale to Zero.

---

### What does ScaledObject define?

How a workload should scale.

---

### What does the Operator do?

Creates and manages HPA.

---

### What does the Metrics Adapter do?

Exposes external metrics to HPA.

---

### Difference between ScaledObject and ScaledJob?

* ScaledObject → Deployments/StatefulSets
* ScaledJob → Kubernetes Jobs

---

### Difference between TriggerAuthentication and ClusterTriggerAuthentication?

* TriggerAuthentication → Namespace-scoped
* ClusterTriggerAuthentication → Cluster-wide

---

### What is Polling Interval?

How often KEDA checks the event source.

---

### What is Cooldown Period?

How long KEDA waits before scaling down.

---

### What is Cold Start?

Delay while creating Pods from zero replicas.

---

### Most common triggers?

* RabbitMQ
* Kafka
* Redis
* AWS SQS
* Prometheus
* Cron

---

# 🧠 Memory Map

```text
KEDA
│
├── Operator
├── Metrics Adapter
├── ScaledObject
├── ScaledJob
├── Authentication
│
├── Triggers
│      ├── RabbitMQ
│      ├── Kafka
│      ├── Redis
│      ├── AWS SQS
│      ├── Prometheus
│      └── Cron
│
├── Scale to Zero
│
├── Production
│      ├── Polling
│      ├── Cooldown
│      ├── Min/Max Replicas
│      └── Monitoring
│
└── Troubleshooting
       ├── Trigger
       ├── Authentication
       ├── Operator
       ├── HPA
       └── Pods
```
