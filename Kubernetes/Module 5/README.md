# 📦 Kubernetes Module 5 — Storage

> **Goal:** Learn how Kubernetes stores application data reliably, even when Pods or Nodes fail.

---

# 📚 Topics Covered

* Volumes
* Persistent Volumes (PV)
* Persistent Volume Claims (PVC)
* StorageClass
* Container Storage Interface (CSI)
* Production Storage Architecture

---

# 🎯 Learning Outcomes

After completing this module, I can:

* Explain why Pods need persistent storage.
* Differentiate between ephemeral and persistent storage.
* Understand how Volumes work.
* Explain the purpose of Persistent Volumes (PV).
* Explain how Persistent Volume Claims (PVC) request storage.
* Understand dynamic provisioning using StorageClasses.
* Explain the role of CSI (Container Storage Interface).
* Design production-ready storage architecture for stateful applications.
* Troubleshoot common Kubernetes storage problems.

---

# 🧠 Key Concepts

## 1. Volume

A Volume provides storage to containers inside a Pod.

Used for:

* Sharing files between containers
* Temporary storage
* Persistent storage (depending on volume type)

---

## 2. emptyDir

* Created when Pod starts
* Deleted when Pod is deleted
* Survives container restarts
* Ideal for temporary files

**Not suitable for databases.**

---

## 3. hostPath

Mounts a directory from the worker node.

Common uses:

* Monitoring agents
* System logs
* Docker/container runtime socket

**Not recommended for production application data.**

---

## 4. Persistent Volume (PV)

A Persistent Volume is storage managed by the Kubernetes cluster.

Characteristics:

* Independent of Pods
* Represents real storage
* Can survive Pod deletion
* Used for stateful applications

Examples:

* AWS EBS
* Azure Disk
* Google Persistent Disk
* NFS
* Ceph

---

## 5. Persistent Volume Claim (PVC)

A PVC is an application's request for storage.

The application never directly uses a PV.

Flow:

```text
Pod
 ↓
PVC
 ↓
PV
```

---

## 6. StorageClass

StorageClass enables **dynamic provisioning**.

Instead of manually creating PVs:

```text
PVC
 ↓
StorageClass
 ↓
Automatic PV Creation
```

Benefits:

* Automatic storage provisioning
* Cloud-native
* Production standard

---

## 7. CSI (Container Storage Interface)

CSI connects Kubernetes with storage providers.

Examples:

* AWS EBS CSI Driver
* Azure Disk CSI Driver
* GCE PD CSI Driver
* Ceph CSI
* NFS CSI

CSI performs:

* Create Volume
* Attach Volume
* Mount Volume
* Expand Volume
* Delete Volume

---

## 8. Production Storage Flow

```text
Application
      │
      ▼
Pod
      │
      ▼
PVC
      │
      ▼
StorageClass
      │
      ▼
CSI Driver
      │
      ▼
Cloud Storage
      │
      ▼
Persistent Volume
```

---

# 📌 Kubernetes Commands

## View Storage Resources

```bash
kubectl get pv
```

Lists all Persistent Volumes.

---

```bash
kubectl get pvc
```

Lists all Persistent Volume Claims.

---

```bash
kubectl get storageclass
```

Lists available StorageClasses.

---

```bash
kubectl get csidrivers
```

Lists installed CSI Drivers.

---

## Inspect Resources

```bash
kubectl describe pv <pv-name>
```

Shows:

* Capacity
* Access Modes
* Status
* Reclaim Policy
* Backend details

---

```bash
kubectl describe pvc <pvc-name>
```

Shows:

* Bound/Pending status
* Events
* StorageClass
* Capacity

---

```bash
kubectl describe storageclass <storageclass-name>
```

Shows:

* Provisioner
* Reclaim Policy
* Volume Expansion
* Parameters

---

## Troubleshooting

```bash
kubectl get events --sort-by=.lastTimestamp
```

Shows the latest storage-related events.

---

```bash
kubectl describe pod <pod-name>
```

Checks for:

* Mount failures
* Volume errors
* Scheduling issues

---

# 🛠 Common Production Troubleshooting Flow

If a database Pod is stuck in **Pending**:

```text
kubectl get pods
        ↓
kubectl describe pod
        ↓
kubectl get pvc
        ↓
kubectl describe pvc
        ↓
kubectl get pv
        ↓
kubectl describe pv
        ↓
kubectl get storageclass
        ↓
kubectl describe storageclass
        ↓
kubectl get csidrivers
        ↓
kubectl get events --sort-by=.lastTimestamp
```

---

# 💼 Production Use Cases

* PostgreSQL
* MySQL
* MongoDB
* Jenkins
* SonarQube
* Elasticsearch
* Redis (with persistence)

These applications require persistent storage because their data must survive Pod restarts.

---

# ⚠️ Common Mistakes

❌ Using `emptyDir` for databases

❌ Thinking PVC stores data

❌ Thinking CSI stores data

❌ Believing Pods use PVs directly

❌ Manually creating PVs in every production environment

---

# 📝 Interview Questions

### 1. What is a Volume?

A storage mechanism attached to a Pod that allows containers to read and write data.

---

### 2. What is the difference between a PV and a PVC?

* **PV:** The actual storage resource.
* **PVC:** The application's request for storage.

---

### 3. What is a StorageClass?

A blueprint that defines how Kubernetes dynamically provisions storage.

---

### 4. What is CSI?

A standard interface that allows Kubernetes to communicate with different storage providers through storage drivers.

---

### 5. Explain the complete Kubernetes storage flow.

```text
Pod
 ↓
PVC
 ↓
StorageClass
 ↓
CSI Driver
 ↓
Cloud Storage
 ↓
Persistent Volume
```

---

# 📖 Quick Revision

```text
Volume
      │
      ▼
Persistent Volume (PV)
      │
      ▼
Persistent Volume Claim (PVC)
      │
      ▼
StorageClass
      │
      ▼
CSI Driver
      │
      ▼
Cloud Storage
```

---

# ✅ Module Completion Checklist

* [x] Understand Volumes
* [x] Learn emptyDir
* [x] Learn hostPath
* [x] Learn Persistent Volumes (PV)
* [x] Learn Persistent Volume Claims (PVC)
* [x] Learn StorageClass
* [x] Learn CSI
* [x] Understand Production Storage Architecture
* [x] Learn job-oriented Kubernetes storage commands
* [x] Practice production troubleshooting flow

---

# 🚀 Next Module

**Module 6 — Kubernetes Workloads**

Topics include:

* StatefulSets
* DaemonSets
* Jobs
* CronJobs
* Production workload patterns
