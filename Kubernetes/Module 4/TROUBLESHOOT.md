# 🛠️ Kubernetes Module 4 — Networking Troubleshooting Guide

> **Goal:** Learn the production troubleshooting workflow for Kubernetes networking issues.

---

# 📌 Troubleshooting Strategy

When an application is **not reachable**, always troubleshoot layer by layer.

```text
User
 │
 ▼
DNS
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
Endpoints
 │
 ▼
Pods
 │
 ▼
Application
```

**Golden Rule:** Never assume the problem. Verify each layer.

---

# 🔴 Scenario 1: Pod Cannot Reach Another Pod

## Symptoms

* API calls fail.
* Connection timeout.
* Service-to-service communication broken.

### Step 1: Verify Pods

```bash
kubectl get pods -o wide
```

Check:

* Pod is Running
* Pod IP exists
* Correct node assignment

---

### Step 2: Describe the Pod

```bash
kubectl describe pod <pod-name>
```

Look for:

* Restart count
* Scheduling issues
* Events
* Network errors

---

### Step 3: Test Connectivity

```bash
kubectl exec -it <pod-name> -- sh
```

Inside the Pod:

```bash
ping <pod-ip>
```

or

```bash
curl http://<service-name>
```

---

# 🔴 Scenario 2: Service Not Working

## Symptoms

* Service IP doesn't respond.
* Requests timeout.
* Backend application unreachable.

### Step 1

```bash
kubectl get svc
```

Verify:

* Service exists
* Correct ClusterIP
* Correct port

---

### Step 2

```bash
kubectl describe svc <service-name>
```

Check:

* Selector
* Target Port
* Endpoints

---

### Step 3

```bash
kubectl get endpoints
```

Example

```text
NAME          ENDPOINTS
backend       10.244.0.12:8080
```

If ENDPOINTS is empty:

The Service is not selecting any Pods.

---

### Common Causes

* Wrong labels
* Wrong selector
* Pod not Running

---

# 🔴 Scenario 3: Service Has No Endpoints

## Symptoms

```text
ENDPOINTS

<none>
```

### Verify Labels

```bash
kubectl get pods --show-labels
```

---

### Verify Service Selector

```bash
kubectl describe svc <service-name>
```

Example

Wrong

```yaml
selector:
  app: frontend
```

Pod Label

```yaml
app: backend
```

No Pods match.

---

# 🔴 Scenario 4: Ingress Not Working

## Symptoms

* Browser shows 404
* Browser shows 502
* Browser shows 503
* Domain unreachable

### Step 1

```bash
kubectl get ingress
```

Verify:

* Host
* Address
* Rules

---

### Step 2

```bash
kubectl describe ingress <ingress-name>
```

Check:

* Backend Service
* Host
* Paths
* Events

---

### Step 3

```bash
kubectl get svc
```

Ensure backend Service exists.

---

### Step 4

```bash
kubectl get endpoints
```

Verify backend Pods are available.

---

# 🔴 Scenario 5: Ingress Controller Missing

## Symptoms

Ingress exists but never works.

### Verify

```bash
kubectl get pods -A
```

Look for:

* NGINX Ingress Controller
* Traefik
* HAProxy
* Other installed controllers

If no controller is running,

Ingress rules will never be applied.

---

# 🔴 Scenario 6: DNS Resolution Fails

## Symptoms

Application cannot resolve:

```text
database.default.svc.cluster.local
```

### Step 1

```bash
kubectl get pods -n kube-system
```

Verify:

CoreDNS Pods are Running.

---

### Step 2

From another Pod:

```bash
kubectl exec -it <pod-name> -- sh
```

Run:

```bash
nslookup database.default.svc.cluster.local
```

If lookup fails,

CoreDNS may be unhealthy or the Service name is incorrect.

---

# 🔴 Scenario 7: Network Policy Blocking Traffic

## Symptoms

Pods can communicate before policy creation.

After policy:

Connection refused or timeout.

### Verify Policies

```bash
kubectl get networkpolicy
```

---

### Inspect Policy

```bash
kubectl describe networkpolicy <policy-name>
```

Check:

* Pod selectors
* Namespace selectors
* Allowed ports
* Ingress rules
* Egress rules

---

# 🔴 Scenario 8: NodePort Not Reachable

## Symptoms

Cannot access:

```text
NodeIP:30080
```

### Verify

```bash
kubectl get svc
```

Ensure Service type is:

```text
NodePort
```

Check:

* NodePort number
* Node IP
* Firewall/security group rules

---

# 🔴 Scenario 9: LoadBalancer External IP Pending

## Symptoms

```text
EXTERNAL-IP

<pending>
```

Usually occurs when:

* No cloud provider integration
* Local cluster (Minikube, Kind)
* Cloud controller not configured

### Verify

```bash
kubectl get svc
```

---

# 🔴 Scenario 10: Pod Running But Application Unreachable

### Step 1

```bash
kubectl logs <pod-name>
```

Look for:

* Port mismatch
* Startup failures
* Exceptions

---

### Step 2

```bash
kubectl describe pod <pod-name>
```

Check:

* Container port
* Readiness probe
* Liveness probe

---

### Step 3

```bash
kubectl describe svc <service-name>
```

Verify:

TargetPort matches the application's listening port.

---

# 📋 Production Troubleshooting Checklist

| Check            | Command                                       |
| ---------------- | --------------------------------------------- |
| Pod Status       | `kubectl get pods -o wide`                    |
| Pod Details      | `kubectl describe pod <pod>`                  |
| Pod Logs         | `kubectl logs <pod>`                          |
| Service Status   | `kubectl get svc`                             |
| Service Details  | `kubectl describe svc <service>`              |
| Endpoints        | `kubectl get endpoints`                       |
| Ingress          | `kubectl get ingress`                         |
| Ingress Details  | `kubectl describe ingress <ingress>`          |
| Network Policies | `kubectl get networkpolicy`                   |
| Policy Details   | `kubectl describe networkpolicy <policy>`     |
| Events           | `kubectl get events --sort-by=.lastTimestamp` |

---

# 🎯 Interview Scenarios

## Q1. Service is not working. What will you check?

**Answer**

1. `kubectl get svc`
2. `kubectl describe svc`
3. `kubectl get endpoints`
4. `kubectl get pods --show-labels`
5. `kubectl describe pod`
6. `kubectl logs`

---

## Q2. Ingress returns 404 or 503. What will you check?

**Answer**

1. `kubectl get ingress`
2. `kubectl describe ingress`
3. Backend Service
4. Endpoints
5. Ingress Controller
6. Pod logs

---

## Q3. DNS resolution is failing. What will you verify?

* CoreDNS Pods
* Service name
* `nslookup`
* Cluster DNS configuration

---

## Q4. Why are Endpoints empty?

Possible reasons:

* Wrong Service selector
* Pod labels don't match
* Pods not Ready
* Pods not Running

---

## Q5. Why can't Pods communicate?

Possible reasons:

* Network Policy
* Pod not Running
* Wrong Service
* Wrong DNS name
* Application not listening on expected port

---

# 🧠 60-Second Networking Troubleshooting Flow

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
Check CoreDNS
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

# ⭐ Production Rule

Always troubleshoot from the **outside toward the application**.

```text
User
 │
 ▼
DNS
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
Endpoints
 │
 ▼
Pods
 │
 ▼
Application
```

By verifying each layer in order, you'll isolate networking issues quickly and use the same approach followed by DevOps and SRE teams in production environments.
