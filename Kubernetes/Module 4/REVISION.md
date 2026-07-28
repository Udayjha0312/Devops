# 📖 Kubernetes Module 4 — Networking (Revision)

> **Goal:** Revise Kubernetes Networking in **10–15 minutes** before interviews or hands-on practice.

---

# 🌐 Networking Flow

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
Application
```

---

# 🔑 Key Concepts

## Pod Networking

* Every Pod gets its own unique IP.
* Pods communicate directly using Pod IPs.
* Pod IPs are **temporary**.
* Kubernetes follows a **flat networking model**.

---

## Services

A Service provides a **stable endpoint** for Pods.

Purpose:

* Stable IP
* Load balancing
* Service discovery

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

---

## Service Types

### ClusterIP

* Default Service type
* Internal communication only

Use Cases:

* Backend APIs
* Databases
* Internal microservices

---

### NodePort

* Exposes application on every worker node.
* Uses ports in the **30000–32767** range by default.

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
* Used in AWS, Azure, GCP.

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

---

## CoreDNS

CoreDNS provides DNS inside Kubernetes.

Instead of using Pod IPs:

```text
postgres.default.svc.cluster.local
```

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

## Ingress

Ingress manages **HTTP/HTTPS** traffic entering the cluster.

Features:

* Host-based routing
* Path-based routing
* TLS termination
* Single external entry point

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
Ingress
 │
 ▼
Service
 │
 ▼
Pods
```

---

## Ingress vs Ingress Controller

| Ingress               | Ingress Controller                        |
| --------------------- | ----------------------------------------- |
| Defines routing rules | Implements the routing rules              |
| Kubernetes resource   | Running controller (NGINX, Traefik, etc.) |

---

## Network Policies

Act as a firewall for Pods.

Controls:

* Ingress traffic
* Egress traffic

Without Network Policies:

```text
Every Pod
      │
      ▼
Can communicate with every other Pod
```

With Network Policies:

```text
Frontend
     │
     ▼
Backend

Database

❌ Direct access blocked
```

---

# ⭐ Service Comparison

| Service Type | Internal     | External     | Production Use         |
| ------------ | ------------ | ------------ | ---------------------- |
| ClusterIP    | ✅            | ❌            | Internal services      |
| NodePort     | ✅            | ✅            | Testing / Small setups |
| LoadBalancer | ✅            | ✅            | Production             |
| ExternalName | External DNS | External DNS | Third-party services   |

---

# 📌 Important Commands

## Services

```bash
kubectl get svc

kubectl describe svc <service-name>
```

---

## Ingress

```bash
kubectl get ingress

kubectl describe ingress <ingress-name>
```

---

## Network Policies

```bash
kubectl get networkpolicy

kubectl describe networkpolicy <policy-name>
```

---

## Debugging

```bash
kubectl get pods -o wide

kubectl describe pod <pod-name>

kubectl logs <pod-name>

kubectl exec -it <pod-name> -- sh

kubectl port-forward svc/<service-name> 8080:80

kubectl get endpoints

kubectl get events --sort-by=.lastTimestamp
```

---

# 🛠 Networking Troubleshooting Flow

```text
Application Not Reachable
          │
          ▼
Check Pod
          │
          ▼
Check Service
          │
          ▼
Check Endpoints
          │
          ▼
Check Ingress
          │
          ▼
Check Network Policy
          │
          ▼
Check Events
          │
          ▼
Root Cause
```

---

# 💼 Production Networking Flow

```text
Internet
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

# ❌ Common Interview Mistakes

* Accessing Pods directly instead of using Services.
* Assuming Pod IPs never change.
* Confusing Ingress with an Ingress Controller.
* Thinking Ingress works without an Ingress Controller.
* Assuming Network Policies are enabled on every cluster.
* Using NodePort instead of LoadBalancer in cloud production environments without understanding the trade-offs.

---

# 🎯 Interview Questions

### What is a Service?

A stable endpoint that provides load balancing and service discovery for Pods.

---

### What is the default Service type?

**ClusterIP**

---

### Difference between ClusterIP and NodePort?

* **ClusterIP:** Internal only.
* **NodePort:** Exposes the application on every node.

---

### Difference between NodePort and LoadBalancer?

* **NodePort:** Uses a node's IP and port.
* **LoadBalancer:** Uses a cloud provider's load balancer with an external IP.

---

### What is CoreDNS?

The DNS server that provides service discovery inside Kubernetes.

---

### What is Ingress?

A Kubernetes resource that defines HTTP/HTTPS routing rules.

---

### What is an Ingress Controller?

A controller that watches Ingress resources and implements those routing rules.

---

### What are Network Policies?

Firewall rules that control Pod-to-Pod communication.

---

### Explain Kubernetes Networking Flow.

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

# ⚡ 30-Second Revision

* **Pod** → Gets its own IP.
* **Service** → Stable endpoint for Pods.
* **ClusterIP** → Internal communication.
* **NodePort** → Exposes app on every node.
* **LoadBalancer** → Cloud external access.
* **ExternalName** → Maps to external DNS.
* **CoreDNS** → Internal DNS resolution.
* **Ingress** → HTTP/HTTPS routing.
* **Ingress Controller** → Implements Ingress rules.
* **Network Policy** → Pod firewall.

---

# ✅ Module 4 Checklist

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

# 🧠 Memory Trick

```text
Internet
   │
   ▼
LoadBalancer
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

Remember it as:

**"Traffic Enters → Ingress Routes → Service Balances → Pods Serve."**
