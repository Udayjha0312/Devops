# 🛠️ Kubernetes Module 5 — Storage Troubleshooting Guide

> **Goal:** Learn the production troubleshooting workflow for Kubernetes storage issues.

---

# 📌 Troubleshooting Workflow

When an application that uses persistent storage is not working, follow this order:

```text id="4p9q2m"
Application Issue
        │
        ▼
Check Pod
        │
        ▼
Check PVC
        │
        ▼
Check PV
        │
        ▼
Check StorageClass
        │
        ▼
Check CSI Driver
        │
        ▼
Check Events
        │
        ▼
Root Cause Found
```

---

# 🔴 Scenario 1: Pod Stuck in Pending

## Symptoms

* Pod never starts.
* Status remains `Pending`.

### Step 1: Check Pod Status

```bash
kubectl get pods
```

Expected Output

```text
NAME         READY   STATUS
postgres     0/1     Pending
```

---

### Step 2: Describe the Pod

```bash
kubectl describe pod postgres
```

Look for:

* FailedScheduling
* Volume mount errors
* PVC not found
* Unbound PersistentVolumeClaims

---

### Step 3: Check PVC

```bash
kubectl get pvc
```

Example

```text
NAME            STATUS
postgres-pvc    Pending
```

If PVC is **Pending**, continue.

---

### Step 4: Describe PVC

```bash
kubectl describe pvc postgres-pvc
```

Possible Errors

```text
No matching PersistentVolume found
```

or

```text
waiting for first consumer
```

or

```text
storageclass.storage.k8s.io "gp3" not found
```

---

### Step 5: Check PV

```bash
kubectl get pv
```

Things to verify:

* PV exists
* Capacity matches
* Access Mode matches
* Status is Available or Bound

---

### Step 6: Check StorageClass

```bash
kubectl get storageclass
```

Verify:

* Requested StorageClass exists.
* Correct StorageClass name is used.

---

### Step 7: Check CSI Driver

```bash
kubectl get csidrivers
```

Ensure required CSI Driver is installed.

---

### Step 8: Check Events

```bash
kubectl get events --sort-by=.lastTimestamp
```

Events often contain the exact reason for failure.

---

# 🔴 Scenario 2: PVC Stuck in Pending

## Symptoms

```text
kubectl get pvc

STATUS

Pending
```

## Possible Causes

* No StorageClass
* Wrong StorageClass
* CSI Driver missing
* No matching PV
* Storage quota exceeded

## Commands

```bash
kubectl describe pvc <pvc-name>

kubectl get pv

kubectl get storageclass

kubectl get csidrivers
```

---

# 🔴 Scenario 3: Volume Mount Failed

## Symptoms

Pod enters:

```text
ContainerCreating
```

or

```text
CrashLoopBackOff
```

### Commands

```bash
kubectl describe pod <pod-name>
```

Look for:

```text
MountVolume.SetUp failed
```

or

```text
Unable to attach volume
```

---

### Next Steps

```bash
kubectl describe pvc <pvc-name>

kubectl describe pv <pv-name>
```

---

# 🔴 Scenario 4: StorageClass Not Found

## Symptoms

```text
storageclass.storage.k8s.io "gp3" not found
```

### Verify

```bash
kubectl get storageclass
```

### Solution

* Correct the StorageClass name.
* Create the missing StorageClass if required.

---

# 🔴 Scenario 5: CSI Driver Missing

## Symptoms

PVC never gets provisioned.

### Verify

```bash
kubectl get csidrivers
```

If expected CSI Driver is absent:

* Install the correct CSI Driver.
* Verify the StorageClass references the correct provisioner.

---

# 🔴 Scenario 6: Access Mode Mismatch

Example

PVC requests:

```text
ReadWriteMany
```

PV supports:

```text
ReadWriteOnce
```

Result

PVC remains Pending.

### Verify

```bash
kubectl describe pv <pv-name>

kubectl describe pvc <pvc-name>
```

---

# 🔴 Scenario 7: Insufficient Capacity

Example

PVC requests:

```text
100Gi
```

Available PV:

```text
20Gi
```

Result

PVC cannot bind.

### Verify

```bash
kubectl describe pvc <pvc-name>

kubectl get pv
```

---

# 🔴 Scenario 8: Pod Restarted but Data Still Exists

This is **expected behavior**.

Because:

```text
Pod
 │
 ▼
PVC
 │
 ▼
PV
 │
 ▼
Cloud Storage
```

The Pod is recreated, but the same PV is mounted again.

---

# 🔴 Scenario 9: Data Lost After Pod Deletion

Possible Cause

Application used:

```text
emptyDir
```

instead of

```text
Persistent Volume
```

Always use:

```text
PVC
 ↓
PV
```

for databases.

---

# 🔴 Scenario 10: Database Won't Start

Follow this order:

```text
kubectl get pods
        │
        ▼
kubectl describe pod
        │
        ▼
kubectl get pvc
        │
        ▼
kubectl describe pvc
        │
        ▼
kubectl get pv
        │
        ▼
kubectl describe pv
        │
        ▼
kubectl get storageclass
        │
        ▼
kubectl get csidrivers
        │
        ▼
kubectl get events
```

---

# 📋 Production Troubleshooting Checklist

| Check                | Command                                       |
| -------------------- | --------------------------------------------- |
| Pod Status           | `kubectl get pods`                            |
| Pod Details          | `kubectl describe pod <pod>`                  |
| PVC Status           | `kubectl get pvc`                             |
| PVC Details          | `kubectl describe pvc <pvc>`                  |
| PV Status            | `kubectl get pv`                              |
| PV Details           | `kubectl describe pv <pv>`                    |
| StorageClass         | `kubectl get storageclass`                    |
| StorageClass Details | `kubectl describe storageclass <name>`        |
| CSI Drivers          | `kubectl get csidrivers`                      |
| Cluster Events       | `kubectl get events --sort-by=.lastTimestamp` |

---

# 🎯 Interview Scenarios

### Q1. Pod is Pending. What will you check?

**Answer**

1. `kubectl get pods`
2. `kubectl describe pod`
3. `kubectl get pvc`
4. `kubectl describe pvc`
5. `kubectl get pv`
6. `kubectl get storageclass`
7. `kubectl get csidrivers`
8. `kubectl get events`

---

### Q2. PVC is Pending. Possible reasons?

* No matching PV
* Wrong StorageClass
* Missing CSI Driver
* Capacity mismatch
* Access mode mismatch
* Storage quota exceeded

---

### Q3. Why does data survive after Pod restart?

Because the data is stored on a **Persistent Volume**, not inside the Pod.

---

### Q4. Why was data lost?

Because temporary storage (`emptyDir`) was used instead of persistent storage (`PVC` + `PV`).

---

# 🧠 60-Second Troubleshooting Revision

```text
Pod Pending
     │
Describe Pod
     │
Check PVC
     │
Describe PVC
     │
Check PV
     │
Describe PV
     │
Check StorageClass
     │
Check CSI Driver
     │
Check Events
     │
Fix Root Cause
```

---

# ⭐ Production Rule

**Never guess the problem. Always troubleshoot layer by layer.**

```
Application
    ↓
Pod
    ↓
PVC
    ↓
PV
    ↓
StorageClass
    ↓
CSI Driver
    ↓
Cloud Storage
```

Checking each layer systematically is the fastest and most reliable way to identify storage issues in Kubernetes.
