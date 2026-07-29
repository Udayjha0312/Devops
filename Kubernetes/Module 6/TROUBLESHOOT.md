# 🛠️ Module 6 – Kubernetes Workloads Troubleshooting Guide

> **Goal:** Learn how to troubleshoot StatefulSets, DaemonSets, Jobs, and CronJobs in production environments.

---

# 🚑 Kubernetes Workload Troubleshooting Flow

When an application or task is not behaving as expected, first identify **which workload type** is managing it.

```text
Application Problem
        │
        ▼
Identify Workload
        │
        ├────────► Deployment
        ├────────► StatefulSet
        ├────────► DaemonSet
        ├────────► Job
        └────────► CronJob
                │
                ▼
        Inspect Resource
                │
                ▼
        Inspect Pods
                │
                ▼
        Check Events
                │
                ▼
        Check Logs
                │
                ▼
        Root Cause
```

---

# 🔴 Scenario 1 – StatefulSet Pod Stuck in Pending

## Symptoms

```text
postgres-0   Running
postgres-1   Pending
postgres-2   Not Created
```

Since StatefulSets create Pods **sequentially**, `postgres-2` will not be created until `postgres-1` becomes Ready.

### Step 1

```bash
kubectl get statefulsets
```

Verify:

* Desired replicas
* Ready replicas

---

### Step 2

```bash
kubectl describe statefulset postgres
```

Look for:

* Scheduling failures
* Storage errors
* Events

---

### Step 3

```bash
kubectl describe pod postgres-1
```

Check:

* Failed scheduling
* Image pull errors
* Readiness probe failures
* Volume mount issues

---

### Step 4

```bash
kubectl get pvc
kubectl describe pvc
```

Verify:

* PVC exists
* PVC is Bound
* StorageClass is available

---

# 🔴 Scenario 2 – StatefulSet Lost Storage

## Symptoms

Database starts with empty data.

### Verify

```bash
kubectl get pvc
kubectl describe pvc
kubectl get pv
kubectl describe pv
```

Check:

* PVC bound correctly
* Correct Persistent Volume attached
* StorageClass
* Reclaim Policy

---

# 🔴 Scenario 3 – StatefulSet DNS Not Working

Application cannot resolve:

```text
postgres-0.database.default.svc.cluster.local
```

### Step 1

```bash
kubectl get svc
```

Verify:

```text
ClusterIP: None
```

---

### Step 2

```bash
kubectl describe svc database
```

Ensure:

* Headless Service
* Correct selector

---

### Step 3

```bash
kubectl get endpoints database
```

Confirm Pod IPs are present.

---

# 🔴 Scenario 4 – DaemonSet Missing on One Node

## Symptoms

Cluster:

```text
5 Nodes
```

DaemonSet:

```text
4 Pods
```

One node has no monitoring/logging agent.

---

### Step 1

```bash
kubectl get nodes
```

Verify node status.

---

### Step 2

```bash
kubectl get daemonsets
```

Compare:

* Desired
* Current
* Ready

---

### Step 3

```bash
kubectl get pods -o wide
```

Find the missing node.

---

### Step 4

```bash
kubectl describe daemonset fluent-bit
```

Look for:

* Node selector mismatch
* Taints
* Tolerations
* Image pull failures

---

# 🔴 Scenario 5 – New Node Has No DaemonSet Pod

A new worker node joined the cluster.

Expected:

```text
Node-4

↓

Fluent Bit
```

If missing:

Verify:

```bash
kubectl get nodes
kubectl get daemonsets
kubectl describe daemonset fluent-bit
```

Check:

* Node Ready state
* Node labels
* Node affinity
* Taints

---

# 🔴 Scenario 6 – Job Never Completes

## Symptoms

```text
STATUS

Running
```

for a long time.

### Step 1

```bash
kubectl get jobs
```

---

### Step 2

```bash
kubectl describe job migration-job
```

Check:

* Active Pods
* Completions
* Retry count

---

### Step 3

```bash
kubectl get pods
kubectl logs <pod-name>
```

Look for:

* SQL errors
* Connection refused
* Authentication failure
* Missing files

---

# 🔴 Scenario 7 – Job Keeps Failing

## Symptoms

```text
BackoffLimitExceeded
```

### Verify

```bash
kubectl describe job migration-job
kubectl logs <pod-name>
```

Common causes:

* Incorrect credentials
* Invalid SQL
* Missing ConfigMap
* Missing Secret
* Network connectivity issues

---

# 🔴 Scenario 8 – CronJob Never Runs

Expected:

Every day at **2:00 AM**

Reality:

No Job created.

---

### Step 1

```bash
kubectl get cronjobs
```

Check:

* Schedule
* Suspend status
* Last schedule

---

### Step 2

```bash
kubectl describe cronjob database-backup
```

Verify:

* Events
* Schedule
* Concurrency policy

---

### Step 3

```bash
kubectl get jobs
```

If no Job exists,

CronJob configuration is likely incorrect.

---

# 🔴 Scenario 9 – CronJob Creates Job but Backup Fails

### Step 1

```bash
kubectl get jobs
kubectl describe job <job-name>
```

---

### Step 2

```bash
kubectl get pods
kubectl logs <backup-pod>
```

Look for:

* Authentication errors
* S3 upload failure
* Permission issues
* Database connection timeout

---

# 🔴 Scenario 10 – Wrong Workload Selected

Example:

Database deployed using Deployment.

Symptoms:

* Random Pod names
* Data inconsistency
* Replication failures

Solution:

Use:

```text
StatefulSet
```

instead of:

```text
Deployment
```

---

# 🔴 Scenario 11 – Pods Running but Workload Not Healthy

Always inspect the workload object first.

```bash
kubectl get deployments
kubectl get statefulsets
kubectl get daemonsets
kubectl get jobs
kubectl get cronjobs
```

Then inspect Pods:

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

---

# 📋 Production Troubleshooting Checklist

## StatefulSet

```bash
kubectl get statefulsets
kubectl describe statefulset <name>
kubectl get pods
kubectl get pvc
kubectl describe pvc
kubectl get pv
```

---

## DaemonSet

```bash
kubectl get daemonsets
kubectl describe daemonset <name>
kubectl get nodes
kubectl get pods -o wide
```

---

## Job

```bash
kubectl get jobs
kubectl describe job <name>
kubectl get pods
kubectl logs <pod-name>
```

---

## CronJob

```bash
kubectl get cronjobs
kubectl describe cronjob <name>
kubectl get jobs
kubectl logs <pod-name>
```

---

## Events

Always check cluster events.

```bash
kubectl get events --sort-by=.lastTimestamp
```

---

# 🎯 Interview Scenarios

## Q1. PostgreSQL StatefulSet has three replicas but only one Pod is running.

**Check:**

1. StatefulSet status
2. Pending Pod
3. PVC binding
4. StorageClass
5. Events

---

## Q2. One worker node is missing Fluent Bit.

**Check:**

1. DaemonSet status
2. Node Ready
3. Node selectors
4. Taints/Tolerations
5. Pod logs

---

## Q3. Database migration Job keeps restarting.

**Check:**

1. Job status
2. Backoff limit
3. Pod logs
4. Exit code
5. Database connectivity

---

## Q4. Nightly backup never starts.

**Check:**

1. CronJob schedule
2. Suspend flag
3. Job creation
4. Job logs
5. Backup script

---

## Q5. PostgreSQL starts with empty data after restart.

**Check:**

1. PVC
2. PV
3. StorageClass
4. Volume mounts
5. Reclaim policy

---

# 🧠 60-Second Workload Troubleshooting Flow

```text
Workload Problem
       │
       ▼
Identify Resource
       │
       ▼
Describe Resource
       │
       ▼
Inspect Pods
       │
       ▼
Inspect Storage (if StatefulSet)
       │
       ▼
Inspect Node (if DaemonSet)
       │
       ▼
Inspect Job/CronJob
       │
       ▼
Inspect Events
       │
       ▼
Inspect Logs
       │
       ▼
Root Cause
```

---

# ⭐ Production Rule

Always troubleshoot in this order:

```text
Workload
     │
     ▼
Pods
     │
     ▼
Storage / Nodes / Schedule
     │
     ▼
Events
     │
     ▼
Logs
     │
     ▼
Application
```

This structured approach prevents guesswork and is the same methodology commonly followed by Kubernetes administrators, DevOps engineers, and SRE teams in production environments.
