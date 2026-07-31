# 📘 Amazon EKS Revision Notes

## Module 13 – Elastic Kubernetes Service (EKS)

---

# 🚀 What is Amazon EKS?

Amazon EKS (Elastic Kubernetes Service) is a **fully managed Kubernetes service** provided by AWS.

AWS manages the **Kubernetes Control Plane**, while customers manage applications and worker nodes (unless using Fargate).

---

# Why EKS?

Instead of managing:

* API Server
* etcd
* Scheduler
* Controller Manager
* High Availability
* Upgrades

AWS manages them for you.

---

# EKS Architecture

```text id="eks1"
          AWS Managed
──────────────────────────
API Server
etcd
Scheduler
Controller Manager
──────────────────────────
          │
          ▼
Worker Nodes (EC2/Fargate)
          │
          ▼
Pods
```

---

# Control Plane

Managed by AWS.

Includes:

* API Server
* etcd
* Scheduler
* Controller Manager

Responsibilities:

* Cluster state
* Scheduling
* Kubernetes API
* Reconciliation

---

# Worker Nodes

Run:

* kubelet
* kube-proxy
* containerd
* Pods

Can be:

* EC2
* Fargate

---

# Cluster Creation

Methods:

* AWS Console
* AWS CLI
* eksctl
* Terraform ⭐⭐⭐⭐⭐

Production:

Infrastructure as Code (Terraform)

---

# Node Groups

A Node Group is a collection of EC2 worker nodes.

Types:

* Managed Node Groups ⭐⭐⭐⭐⭐
* Self-Managed Node Groups
* AWS Fargate

---

# Managed Node Groups

AWS manages:

* Upgrades
* Health
* Replacement
* Lifecycle

You manage:

* Instance Type
* Scaling
* Labels
* Taints

---

# Auto Scaling Groups

Managed Node Groups use EC2 Auto Scaling Groups.

If a node dies:

```text id="asg1"
Desired = 3

↓

Current = 2

↓

Launch New EC2
```

---

# Spot vs On-Demand

### On-Demand

* Stable
* Production workloads

### Spot

* Cheaper
* Interruptible
* Batch jobs
* Workers

---

# Service Accounts

Every Pod has a Kubernetes identity.

That identity is:

```text id="sa1"
Service Account
```

---

# OIDC

OpenID Connect

Purpose:

Allow AWS to verify Kubernetes identities.

---

# IRSA

IAM Roles for Service Accounts

Flow:

```text id="irsa1"
Pod

↓

Service Account

↓

OIDC

↓

IAM Role

↓

STS

↓

Temporary Credentials

↓

AWS
```

Benefits:

* No Access Keys
* Least Privilege
* Temporary Credentials

---

# STS

Security Token Service

Provides:

* Temporary Access Key
* Temporary Secret Key
* Session Token

---

# Networking

Flow:

```text id="net1"
Internet

↓

Route53

↓

ALB

↓

Ingress

↓

Service

↓

Pod
```

---

# VPC CNI

Amazon VPC CNI gives Pods:

Real VPC IP addresses.

Benefits:

* Native AWS networking
* Direct communication

---

# Services

Provide:

Stable endpoint for Pods.

Pods change.

Services remain constant.

---

# Ingress

Routes HTTP/HTTPS traffic.

Example:

```text id="ing1"
ALB

↓

Ingress

↓

Multiple Services
```

---

# AWS Load Balancer Controller

Automatically creates:

* ALB
* Target Groups
* Listener Rules

From Kubernetes Ingress resources.

---

# Security Groups

AWS Firewall.

Protect:

* EC2
* ENIs
* Load Balancers

---

# Network Policies

Kubernetes Firewall.

Protect:

Pod-to-Pod communication.

---

# Storage

Storage Chain:

```text id="storage1"
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

EBS / EFS
```

---

# Persistent Volume (PV)

Actual storage resource.

---

# Persistent Volume Claim (PVC)

Application's storage request.

---

# StorageClass

Defines:

* Storage Type
* Provisioner
* Performance

Supports Dynamic Provisioning.

---

# CSI Driver

Bridge between Kubernetes and AWS storage.

---

# Amazon EBS

* Block Storage
* One AZ
* High Performance
* Best for Databases

---

# Amazon EFS

* Shared File System
* Multi-AZ
* Multiple Pods

---

# StatefulSet

Use for:

* PostgreSQL
* MySQL
* MongoDB

Provides:

* Stable Identity
* Stable Storage

---

# Scaling

## HPA

Scales Pods.

---

## VPA

Scales CPU/Memory.

---

## Cluster Autoscaler

Scales EC2 Nodes.

---

## Karpenter

Modern Node Autoscaler.

Smarter than traditional Cluster Autoscaler.

---

## KEDA

Scales Pods based on:

* RabbitMQ
* Kafka
* Redis
* SQS

---

# Scaling Flow

```text id="scale1"
Traffic

↓

HPA

↓

More Pods

↓

No Capacity

↓

Karpenter

↓

More Nodes
```

---

# Monitoring (Overview)

Metrics:

* Prometheus

Visualization:

* Grafana

Logs:

* Loki

Log Collector:

* Fluent Bit

AWS Native:

* CloudWatch

---

# Production Best Practices

* Multi-AZ
* Private Worker Nodes
* Managed Node Groups
* IRSA
* Resource Requests
* Resource Limits
* Health Probes
* HTTPS
* Terraform
* CI/CD
* Monitoring
* Logging
* Backups

---

# Common Interview Questions

### What is Amazon EKS?

Managed Kubernetes by AWS.

---

### Who manages the Control Plane?

AWS.

---

### Who manages Worker Nodes?

Customer (unless using Fargate).

---

### What is IRSA?

Secure way for Pods to access AWS using IAM Roles.

---

### Why OIDC?

Allows AWS to trust Kubernetes identities.

---

### Difference between HPA and Cluster Autoscaler?

HPA → Pods

Cluster Autoscaler → EC2 Nodes

---

### Difference between PV and PVC?

PV → Storage

PVC → Storage Request

---

### Difference between EBS and EFS?

EBS → Block Storage

EFS → Shared File Storage

---

### Difference between Security Groups and Network Policies?

Security Groups → AWS Infrastructure

Network Policies → Kubernetes Pods

---

### Difference between Managed and Self-Managed Node Groups?

Managed → AWS manages lifecycle

Self-Managed → Customer manages lifecycle

---

# 🧠 Memory Map

```text id="memory1"
Amazon EKS
│
├── Control Plane
│      ├── API Server
│      ├── etcd
│      ├── Scheduler
│      └── Controller Manager
│
├── Worker Nodes
│      ├── EC2
│      ├── kubelet
│      ├── kube-proxy
│      └── Pods
│
├── Security
│      ├── IAM
│      ├── OIDC
│      ├── IRSA
│      └── STS
│
├── Networking
│      ├── VPC
│      ├── CNI
│      ├── Service
│      ├── Ingress
│      └── ALB
│
├── Storage
│      ├── PV
│      ├── PVC
│      ├── StorageClass
│      ├── EBS
│      └── EFS
│
├── Scaling
│      ├── HPA
│      ├── VPA
│      ├── KEDA
│      ├── Cluster Autoscaler
│      └── Karpenter
│
└── Production
       ├── Multi-AZ
       ├── Private Nodes
       ├── Terraform
       ├── CI/CD
       ├── Monitoring
       └── Logging
```

---

# ⚡ One-Line Revision

* **EKS** → Managed Kubernetes by AWS.
* **Control Plane** → Managed by AWS.
* **Worker Nodes** → Run Pods.
* **Node Group** → Group of EC2 Worker Nodes.
* **IRSA** → Pod → IAM Role.
* **OIDC** → AWS trusts Kubernetes identity.
* **VPC CNI** → Pods get VPC IPs.
* **Service** → Stable endpoint.
* **Ingress** → HTTP/HTTPS routing.
* **PV** → Storage.
* **PVC** → Storage request.
* **StorageClass** → Dynamic provisioning.
* **EBS** → Block storage.
* **EFS** → Shared storage.
* **HPA** → Scale Pods.
* **Cluster Autoscaler/Karpenter** → Scale Nodes.
* **CloudWatch/Prometheus** → Monitoring.
* **Grafana** → Dashboards.
* **Loki** → Logs.
