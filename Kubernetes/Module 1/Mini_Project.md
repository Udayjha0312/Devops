# 🚀 Production Deployment Simulation Using Kubernetes

> A production-style simulation demonstrating how Kubernetes deploys, schedules, manages, and recovers a containerized FastAPI application.

---

# 📑 Table of Contents

- Project Overview
- Business Problem
- Solution Architecture
- Project Objectives
- Technologies Used
- System Architecture
- Deployment Workflow
- Internal Kubernetes Workflow
- Failure Simulation
- Production Considerations
- Validation Checklist
- Key Learnings
- Future Improvements

---

# 📖 Project Overview

This project simulates how Kubernetes deploys and manages a production-ready FastAPI application.

Rather than focusing only on YAML manifests, the objective is to understand what happens internally after a deployment request is submitted.

The project follows the complete request lifecycle from:

```
kubectl apply
```

to

```
Running Containers Serving User Requests
```

while explaining the responsibility of every Kubernetes component involved.

---

# 💼 Business Problem

A backend development team has created a FastAPI application.

Requirements:

- Deploy the application reliably.
- Run multiple replicas.
- Automatically recover from failures.
- Distribute traffic between healthy instances.
- Support future scaling.

Manual deployment across multiple servers is difficult and error-prone.

A container orchestration platform is required.

---

# ✅ Solution

Deploy the application using Kubernetes.

Kubernetes will:

- Maintain the desired number of replicas.
- Automatically recover failed Pods.
- Schedule workloads efficiently.
- Route traffic to healthy containers.
- Simplify future scaling.

---

# 🎯 Project Objectives

- Understand Kubernetes architecture.
- Simulate a production deployment.
- Learn the responsibility of every Control Plane component.
- Learn the responsibility of every Worker Node component.
- Understand self-healing.
- Understand request routing.
- Understand scheduling.
- Understand container lifecycle.

---

# 🛠 Technologies Used

| Technology | Purpose |
|------------|---------|
| Kubernetes | Container orchestration |
| Docker | Container image |
| FastAPI | Backend application |
| containerd | Container runtime |
| kubectl | Kubernetes CLI |
| Linux | Operating system |
| YAML | Kubernetes manifests |

---

# 🏗 System Architecture

```
                 Developer
                      │
               kubectl apply
                      │
                      ▼
               API Server
                      │
                      ▼
                    etcd
                      ▲
                      │
          Controller Manager
                      │
                      ▼
                Scheduler
                      │
──────────────────────────────────

            Worker Node

               kubelet

                  │

        Container Runtime

                  │

          FastAPI Container

──────────────────────────────────

            kube-proxy

                  │

              Service

                  │

             User Requests
```

---

# 🔄 Deployment Workflow

## Step 1

Developer submits

```bash
kubectl apply -f deployment.yaml
```

---

## Step 2

API Server

- Authenticates request
- Authorizes user
- Validates YAML

---

## Step 3

Desired State stored inside etcd.

Example:

```
Deployment

Replicas = 3

Image = fastapi:v1
```

---

## Step 4

Controller Manager detects:

Desired Pods = 3

Current Pods = 0

Creates three Pod objects.

---

## Step 5

Scheduler selects Worker Nodes.

Example

```
Pod 1 → Node A

Pod 2 → Node B

Pod 3 → Node C
```

---

## Step 6

Each kubelet receives its assigned Pod.

---

## Step 7

Container Runtime

- Pulls image
- Creates container
- Starts FastAPI application

---

## Step 8

kubelet reports Pod status back to the API Server.

---

## Step 9

kube-proxy configures Service networking.

Users can now access the application.

---

# 🔬 Internal Kubernetes Workflow

```
Developer

↓

kubectl

↓

API Server

↓

etcd

↓

Controller Manager

↓

Scheduler

↓

Worker Node

↓

kubelet

↓

Container Runtime

↓

Running Pod

↓

Service

↓

kube-proxy

↓

User
```

---

# 🧪 Failure Simulation

## Scenario 1 – Pod Crash

A FastAPI Pod terminates unexpectedly.

### Kubernetes Response

```
Current Pods = 2

↓

Controller Manager

↓

Create Replacement Pod

↓

Scheduler

↓

Healthy Worker Node

↓

kubelet

↓

Container Runtime

↓

New Pod Running
```

Result

Application availability is maintained.

---

## Scenario 2 – Worker Node Failure

A Worker Node becomes unavailable.

### Kubernetes Response

- Node stops reporting health.
- Controller detects node failure.
- Missing Pods are recreated.
- Scheduler selects healthy nodes.
- kubelet starts replacement Pods.

Result

Application continues running with minimal disruption.

---

## 🌐 Production Considerations

In production environments, this architecture enables:

- High Availability
- Automatic Recovery
- Efficient Scheduling
- Service Discovery
- Horizontal Scaling
- Fault Tolerance
- Simplified Operations

---

# ✅ Validation Checklist

After deployment, verify:

```bash
kubectl get nodes

kubectl get pods

kubectl get deployments

kubectl get svc
```

Inspect resources:

```bash
kubectl describe pod <pod-name>

kubectl logs <pod-name>
```

---

# 📚 Key Learnings

Through this project I learned:

- Kubernetes architecture.
- Control Plane responsibilities.
- Worker Node responsibilities.
- Self-healing mechanism.
- Scheduling process.
- Networking workflow.
- Complete deployment lifecycle.
- Container runtime responsibilities.
- Service routing.

---

# 📈 Future Improvements

Future modules will extend this project with:

- Deployments
- ReplicaSets
- Services
- Ingress
- ConfigMaps
- Secrets
- Persistent Volumes
- Horizontal Pod Autoscaler
- Helm
- Amazon EKS
- GitOps
- Monitoring
- CI/CD

---

# 🏁 Conclusion

This project demonstrates the complete lifecycle of deploying a containerized application using Kubernetes.

By understanding how every core component interacts—from the API Server to the Container Runtime—I established the architectural foundation required for building, troubleshooting, and operating production Kubernetes workloads.