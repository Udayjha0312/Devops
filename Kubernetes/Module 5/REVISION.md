# 📖 Kubernetes Module 5 — Storage (Revision)

> **Goal:** Quickly revise Kubernetes Storage before interviews or hands-on practice.

---

# 📌 Storage Hierarchy

```text
Application
      │
      ▼
Pod
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
Cloud Storage (AWS EBS / Azure Disk / GCE PD)
      │
      ▼
Persistent Volume (PV)
```

---

# 🔑 Key Concepts

## Volume

* Storage attached to a Pod.
* Used for sharing files and storing application data.

---

## emptyDir

* Created when Pod starts.
* Deleted when Pod is deleted.
* Survives container restarts.
* Used for temporary data.

❌ Not for databases.

---

## hostPath

* Mounts a directory from the worker node.
* Useful for logs, monitoring agents, and node-level access.

❌ Not recommended for persistent application data.

---

## Persistent Volume (PV)

* Cluster-managed storage.
* Independent of Pod lifecycle.
* Represents actual storage (AWS EBS, Azure Disk, NFS, Ceph, etc.).

---

## Persistent Volume Claim (PVC)

* Request for storage made by an application.
* Pod uses the PVC, **not the PV directly**.

Flow:

```text
Pod
 ↓
PVC
 ↓
PV
```

---

## StorageClass

Defines **how storage should be created**.

Provides:

* Dynamic provisioning
* Storage type
* Provisioner
* Reclaim policy
* Volume expansion

---

## CSI (Container Storage Interface)

Acts as the bridge between Kubernetes and storage providers.

Examples:

* AWS EBS CSI
* Azure Disk CSI
* GCE PD CSI
* Ceph CSI
* NFS CSI

Responsibilities:

* Create Volume
* Attach Volume
* Mount Volume
* Expand Volume
* Delete Volume

---

# ⭐ Static vs Dynamic Provisioning

| Static Provisioning       | Dynamic Provisioning                  |
| ------------------------- | ------------------------------------- |
| Admin creates PV manually | StorageClass creates PV automatically |
| Less scalable             | Highly scalable                       |
| Rare in production        | Standard production approach          |

---

# 📌 Important Commands

## Storage Resources

```bash
kubectl get pv
kubectl get pvc
kubectl get storageclass
kubectl get csidrivers
```

---

## Describe Resources

```bash
kubectl describe pv <pv-name>
kubectl describe pvc <pvc-name>
kubectl describe storageclass <storageclass-name>
```

---

## Troubleshooting

```bash
kubectl describe pod <pod-name>

kubectl get events --sort-by=.lastTimestamp
```

---

# 🛠 Storage Troubleshooting Flow

```text
Pod Pending
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
kubectl describe storageclass
      │
      ▼
kubectl get csidrivers
      │
      ▼
kubectl get events
```

---

# 💼 Production Flow

```text
Developer
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

# ❌ Common Interview Mistakes

* Pod directly uses PV.
* PVC stores data.
* CSI stores data.
* StorageClass stores data.
* `emptyDir` is suitable for databases.
* Persistent storage eliminates the need for backups.

---

# 🎯 Interview Questions

### What is a PV?

Persistent storage resource managed by Kubernetes.

---

### What is a PVC?

A request for storage made by an application.

---

### What is a StorageClass?

A blueprint that defines how Kubernetes dynamically provisions storage.

---

### What is CSI?

A standard interface that allows Kubernetes to communicate with storage providers using storage drivers.

---

### Explain Kubernetes Storage Flow.

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

# ⚡ 30-Second Revision

* **Volume** → Storage attached to a Pod.
* **emptyDir** → Temporary storage.
* **hostPath** → Node directory mount.
* **PV** → Actual persistent storage.
* **PVC** → Request for storage.
* **StorageClass** → Defines dynamic provisioning.
* **CSI** → Connects Kubernetes to storage providers.
* **Production** → Pod → PVC → StorageClass → CSI → Cloud Storage → PV.

---

# ✅ Module 5 Checklist

* [x] Volumes
* [x] emptyDir
* [x] hostPath
* [x] Persistent Volume (PV)
* [x] Persistent Volume Claim (PVC)
* [x] StorageClass
* [x] CSI
* [x] Production Storage
* [x] Troubleshooting
* [x] Interview Preparation

---

# 🧠 Memory Trick

```text
Pod
 ↓
PVC
 ↓
StorageClass
 ↓
CSI
 ↓
Cloud Storage
 ↓
PV
```

Remember it as:

**"Pod Requests → StorageClass Plans → CSI Creates → PV Represents."**
