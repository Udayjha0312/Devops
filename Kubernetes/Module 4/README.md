# 🌐 Kubernetes Module 4 — Networking

> **Goal:** Understand how Pods communicate inside and outside the Kubernetes cluster and how production traffic reaches applications.

---

# 📚 Topics Covered

* Pod Networking
* Services
* Service Types
* CoreDNS
* Ingress
* Network Policies
* Production Networking Architecture

---

# 🎯 Learning Outcomes

After completing this module, I can:

* Explain Kubernetes networking fundamentals.
* Understand how Pods communicate with each other.
* Explain why Services are required.
* Differentiate between all Service types.
* Understand Kubernetes DNS and CoreDNS.
* Explain Ingress and Ingress Controllers.
* Secure applications using Network Policies.
* Understand the complete production traffic flow.
* Troubleshoot common Kubernetes networking issues.

---

# 🧠 Key Concepts

## 1. Pod Networking

Every Pod gets its own unique IP address.

Features:

* Every Pod has its own IP.
* Pods communicate directly.
* No NAT required between Pods.
* Kubernetes follows a flat networking model.

Example:

```text
Pod A (10.244.1.5)
        │
        ▼
Pod B (10.244.2.8)
```

---

## 2. Services

Pods are temporary and their IP addresses change.

A **Service** provides a stable IP address and DNS name for accessing Pods.

Flow:

```text
Client
   │
   ▼
Service
   │
   ▼
Pods
```

Benefits:

* Stable endpoint
* Load balancing
* Service discovery

---

## 3. Service Types

### ClusterIP

* Default Service type
* Accessible only inside the cluster

Use Cases:

* Database
* Backend APIs
* Internal microservices

---

### NodePort

* Exposes application on a port of every worker node.

Flow:

```text
Client
    │
    ▼
NodeIP:30080
    │
    ▼
Service
    │
    ▼
Pods
```

---

### LoadBalancer

* Creates a cloud load balancer.
* Used in AWS, Azure, and GCP.

Flow:

```text
Internet
     │
     ▼
Cloud Load Balancer
     │
     ▼
Service
     │
     ▼
Pods
```

---

### ExternalName

Maps a Kubernetes Service to an external DNS name.

Example:

```text
api.company.com
        │
        ▼
database.company.com
```

---

## 4. CoreDNS

CoreDNS provides DNS inside Kubernetes.

Instead of remembering Pod IPs:

```text
postgres.default.svc.cluster.local
```

CoreDNS resolves the Service name to the correct IP.

Flow:

```text
Pod
 │
 ▼
CoreDNS
 │
 ▼
Service IP
 │
 ▼
Destination Pod
```

---

## 5. Ingress

Ingress manages external HTTP/HTTPS traffic using one entry point.

Flow:

```text
Internet
     │
     ▼
Load Balancer
     │
     ▼
Ingress Controller
     │
     ▼
Ingress Rules
     │
     ▼
Services
     │
     ▼
Pods
```

Features:

* Host-based routing
* Path-based routing
* TLS termination
* Single external entry point

---

## 6. Network Policies

Network Policies act as a firewall for Pods.

They control:

* Ingress traffic
* Egress traffic

Example:

```text
Frontend Pod
      │
      ▼
Backend Pod

Database Pod

❌ Cannot be accessed directly
```

---

## 7. Production Networking

Complete production traffic flow:

```text
User
 │
 ▼
DNS
 │
 ▼
Cloud Load Balancer
 │
 ▼
Ingress Controller
 │
 ▼
Ingress
 │
 ▼
Service
 │
 ▼
Pods
 │
 ▼
Database
```

---

# 📌 Kubernetes Commands

## View Networking Resources

```bash
kubectl get svc
```

Lists all Services.

---

```bash
kubectl get ingress
```

Lists all Ingress resources.

---

```bash
kubectl get endpoints
```

Shows which Pods a Service routes traffic to.

---

```bash
kubectl get networkpolicy
```

Lists all Network Policies.

---

## Inspect Resources

```bash
kubectl describe svc <service-name>
```

Displays:

* ClusterIP
* Ports
* Selectors
* Endpoints

---

```bash
kubectl describe ingress <ingress-name>
```

Displays:

* Rules
* Hosts
* Paths
* Backend Services

---

```bash
kubectl describe networkpolicy <policy-name>
```

Displays:

* Allowed traffic
* Pod selectors
* Ingress/Egress rules

---

## Debugging Commands

```bash
kubectl get pods -o wide
```

Shows Pod IP addresses.

---

```bash
kubectl describe pod <pod-name>
```

Checks networking events and Pod status.

---

```bash
kubectl logs <pod-name>
```

Views application logs.

---

```bash
kubectl exec -it <pod-name> -- sh
```

Access the container for network testing.

---

```bash
kubectl port-forward svc/<service-name> 8080:80
```

Temporarily access a Service from your local machine.

---

```bash
kubectl get events --sort-by=.lastTimestamp
```

View the latest networking-related events.

---

# 🛠 Production Troubleshooting Flow

If an application cannot be reached:

```text
User Request
      │
      ▼
Ingress
      │
      ▼
Service
      │
      ▼
Endpoints
      │
      ▼
Pods
      │
      ▼
Application Logs
      │
      ▼
Network Policy
      │
      ▼
Root Cause
```

---

# 💼 Production Use Cases

* Frontend applications
* Backend APIs
* Microservices
* Payment services
* Authentication services
* Internal databases
* Kubernetes Ingress for web applications

---

# ⚠️ Common Mistakes

❌ Accessing Pods directly instead of Services.

❌ Assuming Pod IPs are permanent.

❌ Confusing Ingress with an Ingress Controller.

❌ Forgetting that Ingress works mainly for HTTP/HTTPS traffic.

❌ Assuming Network Policies are enabled automatically on every cluster.

---

# 📝 Interview Questions

### 1. Why do we need a Service?

Because Pod IPs are temporary. A Service provides a stable endpoint and load balances traffic to Pods.

---

### 2. What is the default Service type?

**ClusterIP**

---

### 3. Difference between NodePort and LoadBalancer?

* **NodePort:** Exposes the application on a port of every node.
* **LoadBalancer:** Creates a cloud load balancer and provides an external IP.

---

### 4. What is CoreDNS?

CoreDNS provides DNS-based service discovery inside the Kubernetes cluster.

---

### 5. What is an Ingress?

An API resource that defines HTTP/HTTPS routing rules for external traffic.

---

### 6. What is an Ingress Controller?

A controller that watches Ingress resources and implements the routing rules (for example, NGINX Ingress Controller).

---

### 7. What are Network Policies?

Firewall rules that control which Pods can communicate with each other.

---

### 8. Explain the complete Kubernetes networking flow.

```text
Internet
     │
     ▼
Load Balancer
     │
     ▼
Ingress Controller
     │
     ▼
Ingress
     │
     ▼
Service
     │
     ▼
Pods
```

---

# 📖 Quick Revision

```text
Pod Networking
      │
      ▼
Service
      │
      ▼
CoreDNS
      │
      ▼
Ingress
      │
      ▼
Network Policies
      │
      ▼
Production Networking
```

---

# ✅ Module Completion Checklist

* [x] Pod Networking
* [x] Services
* [x] Service Types
* [x] CoreDNS
* [x] Ingress
* [x] Network Policies
* [x] Production Networking
* [x] Kubernetes Networking Commands
* [x] Troubleshooting
* [x] Interview Preparation

---

# 🚀 Next Module

**Module 5 — Storage**

Topics include:

* Volumes
* Persistent Volumes (PV)
* Persistent Volume Claims (PVC)
* StorageClass
* CSI (Container Storage Interface)
* Production Storage Architecture
