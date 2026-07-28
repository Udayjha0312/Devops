# ☸️ Kubernetes Fundamentals

![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.33-blue?logo=kubernetes)
![Docker](https://img.shields.io/badge/Container-Docker-blue?logo=docker)
![Linux](https://img.shields.io/badge/Platform-Linux-yellow?logo=linux)
![Status](https://img.shields.io/badge/Module-Completed-success)

> Understanding the complete Kubernetes architecture from the API Server to running containers.

---

# 📚 Table of Contents

- Project Overview
- Learning Objectives
- Architecture Overview
- Kubernetes Request Lifecycle
- Components Covered
- Project Structure
- Production Concepts
- Skills Acquired
- Real-World Use Cases
- Module Summary
- What's Next

---

# 📖 Project Overview

This module focuses on understanding the internal architecture of Kubernetes and how different components work together to deploy, schedule, monitor, and maintain containerized applications.

Instead of memorizing definitions, this module explains the complete lifecycle of a deployment—from running `kubectl apply` to a production-ready application serving user traffic.

The concepts in this module form the foundation for all advanced Kubernetes topics such as Pods, Deployments, Services, Ingress, Autoscaling, Helm, GitOps, and Amazon EKS.

---

# 🎯 Learning Objectives

After completing this module, I can:

- Explain why Kubernetes exists.
- Describe the architecture of a Kubernetes cluster.
- Explain the role of every Control Plane component.
- Explain the role of every Worker Node component.
- Describe how Kubernetes achieves self-healing.
- Explain Desired State and Current State.
- Explain how scheduling works.
- Explain the complete deployment lifecycle.
- Explain how networking reaches Pods.
- Explain Kubernetes architecture in an interview without diagrams.

---

# 🏗 Kubernetes Architecture

```text
                 Developer
                      │
               kubectl apply
                      │
                      ▼
               Kubernetes API Server
                      │
                      ▼
                    etcd
          (Desired State Storage)
                      ▲
                      │
          Controller Manager
      (Maintains Desired State)
                      │
                      ▼
                Scheduler
          (Chooses Worker Node)
                      │
──────────────────────────────────────────

               Worker Node

                  kubelet
                     │
                     ▼
            Container Runtime
                     │
                     ▼
             Running Container

                  kube-proxy
                     │
                     ▼
                  Service
                     │
                     ▼
                 User Traffic
```

---

# 🔄 Kubernetes Request Lifecycle

When a developer executes:

```bash
kubectl apply -f deployment.yaml
```

The following steps occur:

1. kubectl sends the request to the API Server.
2. API Server authenticates, authorizes, and validates the request.
3. Desired state is stored inside etcd.
4. Controller Manager detects missing resources.
5. Scheduler assigns Pods to Worker Nodes.
6. kubelet receives Pod assignments.
7. Container Runtime pulls images and starts containers.
8. kube-proxy configures networking rules.
9. User traffic reaches the application through a Kubernetes Service.

---

# 🧩 Components Covered

## Control Plane

- API Server
- etcd
- Scheduler
- Controller Manager
- Cloud Controller Manager

## Worker Node

- kubelet
- kube-proxy
- Container Runtime

---

# 📂 Repository Structure

```text
module-01-kubernetes-fundamentals/

├── README.md
├── REVISION.md
├── MINI_PROJECT.md
├── COMMANDS.md
├── interview-cheatsheet.md
├── troubleshooting.md
├── INTERVIEW_STORIES.md
└── assets/
```

---

# 🏭 Production Concepts Learned

This module covers several production-level Kubernetes concepts, including:

- Desired State Management
- Self-Healing
- Reconciliation Loop
- Distributed Scheduling
- Cluster Architecture
- Node Health Monitoring
- Container Lifecycle
- Service Networking
- High Availability
- Fault Recovery

---

# 🛠 Technologies Used

- Kubernetes
- Docker
- containerd
- Linux
- YAML
- kubectl

---

# 💡 Skills Acquired

After completing this module, I can confidently explain:

- Kubernetes Architecture
- API Server Workflow
- etcd Internals
- Scheduling Process
- Worker Node Components
- Container Runtime Responsibilities
- Service Networking
- Self-Healing Workflow
- Complete Deployment Lifecycle

---

# 🌍 Real-World Use Cases

These concepts are used in production environments to:

- Deploy microservices
- Maintain high availability
- Automatically recover failed applications
- Scale workloads efficiently
- Route traffic to healthy services
- Manage large Kubernetes clusters

---

# 📝 Module Summary

This module establishes the foundation of Kubernetes by introducing its architecture and core components.

Understanding these concepts is essential before working with Pods, Deployments, Services, Storage, Security, Autoscaling, Helm, GitOps, and managed Kubernetes platforms such as Amazon EKS.

---

# 📚 Related Files

- 📖 REVISION.md → Quick revision notes and interview preparation.
- 🚀 MINI_PROJECT.md → Production deployment simulation.
- 💻 COMMANDS.md → Important Kubernetes commands.
- 🎯 interview-cheatsheet.md → Last-minute interview revision.
- 🔧 troubleshooting.md → Production troubleshooting scenarios.
- 💼 INTERVIEW_STORIES.md → Practical scenarios for behavioral and technical interviews.

---

# 🚀 What's Next

In the next module, we'll dive into the smallest deployable unit in Kubernetes:

- Pods
- Multi-Container Pods
- Init Containers
- Sidecar Pattern
- Pod Lifecycle
- Restart Policies

These concepts build directly on the architecture learned in this module.