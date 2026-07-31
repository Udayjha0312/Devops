# ☸️ Module 13 – Amazon EKS (Elastic Kubernetes Service)

## 📖 Overview

This module covers **Amazon Elastic Kubernetes Service (EKS)**, AWS's fully managed Kubernetes service. It focuses on designing, deploying, securing, scaling, and operating Kubernetes clusters in production.

The module explains how AWS manages the Kubernetes control plane while engineers manage workloads, networking, security, storage, scaling, and production operations.

This module is designed for **DevOps, SRE, Platform Engineer, and Cloud Engineer interviews**.

---

# 📚 Topics Covered

## Chapter 13.1 – Introduction to Amazon EKS

* What is Amazon EKS
* Why EKS
* Self-Managed Kubernetes vs EKS
* Managed Control Plane
* Shared Responsibility Model
* Production Use Cases

---

## Chapter 13.2 – EKS Architecture

* Control Plane
* API Server
* etcd
* Scheduler
* Controller Manager
* Worker Nodes
* kubelet
* kube-proxy
* containerd
* Pod lifecycle
* High Availability

---

## Chapter 13.3 – EKS Cluster Creation

* AWS Console
* AWS CLI
* eksctl
* Terraform
* Cluster Endpoint
* Networking requirements
* IAM Roles
* Security Groups
* Production workflow

---

## Chapter 13.4 – Node Groups

* Managed Node Groups
* Self-Managed Node Groups
* AWS Fargate
* Auto Scaling Groups
* Spot Instances
* On-Demand Instances
* Labels & Taints
* Node lifecycle
* Production best practices

---

## Chapter 13.5 – IAM & Security

* Kubernetes Service Accounts
* IAM Roles
* OIDC
* IAM Roles for Service Accounts (IRSA)
* AWS STS
* Temporary Credentials
* Trust Policies
* Principle of Least Privilege

---

## Chapter 13.6 – Networking

* Amazon VPC
* Public & Private Subnets
* AWS VPC CNI
* Services
* Ingress
* AWS Load Balancer Controller
* Security Groups
* Network Policies
* Production traffic flow

---

## Chapter 13.7 – Storage

* Persistent Volumes (PV)
* Persistent Volume Claims (PVC)
* Storage Classes
* CSI Drivers
* Dynamic Provisioning
* Amazon EBS
* Amazon EFS
* StatefulSets
* Reclaim Policies

---

## Chapter 13.8 – Scaling

* Horizontal Pod Autoscaler (HPA)
* Vertical Pod Autoscaler (VPA)
* Cluster Autoscaler
* Karpenter
* KEDA Integration
* Node Scaling vs Pod Scaling
* Cost Optimization

---

## Chapter 13.9 – Monitoring & Logging (Overview)

* Amazon CloudWatch
* Prometheus
* Grafana
* Fluent Bit
* Loki
* Metrics vs Logs
* Observability Architecture

> **Note:** Prometheus, Grafana, and Loki are covered in detail in their dedicated modules.

---

## Chapter 13.10 – Production Best Practices

* Multi-AZ Architecture
* Private Worker Nodes
* Managed Node Groups
* IRSA
* Resource Requests & Limits
* Health Probes
* HTTPS
* Infrastructure as Code
* CI/CD
* Backup Strategy
* Production Checklist

---

# 🏗️ High-Level EKS Architecture

```text
                Internet
                    │
              Route53 (DNS)
                    │
                    ▼
     AWS Application Load Balancer
                    │
                    ▼
        Kubernetes Ingress Controller
                    │
                    ▼
          Kubernetes Services
                    │
                    ▼
                 Pods
                    │
                    ▼
        Amazon EKS Worker Nodes
                    │
                    ▼
      AWS Managed Control Plane
```

---

# 🔑 Key Concepts Learned

* Amazon EKS Architecture
* Managed Kubernetes
* Control Plane vs Worker Nodes
* Managed Node Groups
* OIDC
* IRSA
* IAM Roles
* Service Accounts
* VPC Networking
* AWS Load Balancer Controller
* Persistent Storage
* Dynamic Provisioning
* HPA
* VPA
* Cluster Autoscaler
* Karpenter
* Production Architecture

---

# 📂 Repository Structure

```text
13-amazon-eks/
│
├── README.md
├── Revision.md
├── Troubleshooting.md
├── Interview.md
│
├── Notes/
│
├── Diagrams/
│
└── Examples/
```

---

# ☁️ AWS Services Covered

* Amazon EKS
* Amazon EC2
* Amazon VPC
* IAM
* Security Groups
* Route53
* Elastic Load Balancer (ALB)
* Amazon EBS
* Amazon EFS
* CloudWatch

---

# 🚀 Production Concepts

* Highly Available Kubernetes Clusters
* Multi-AZ Deployments
* Private Networking
* Secure IAM Authentication
* Infrastructure as Code
* Autoscaling
* Persistent Storage
* Monitoring
* Logging
* Cost Optimization
* Disaster Recovery

---

# 🛠️ Common Production Use Cases

* Microservices
* REST APIs
* Event-Driven Applications
* Machine Learning Platforms
* CI/CD Platforms
* Internal Developer Platforms
* SaaS Applications
* Enterprise Kubernetes Clusters

---

# 🎯 Interview Topics

* What is Amazon EKS?
* Managed Kubernetes
* Control Plane vs Worker Nodes
* Managed Node Groups
* OIDC
* IRSA
* Service Accounts
* AWS STS
* VPC CNI
* Ingress
* ALB Controller
* EBS vs EFS
* PV/PVC
* HPA
* Cluster Autoscaler
* Karpenter
* Production Best Practices

---

# 📈 Skills Acquired

After completing this module, you will be able to:

* Explain Amazon EKS architecture.
* Deploy and manage Kubernetes clusters on AWS.
* Design secure IAM access using IRSA.
* Understand EKS networking and storage.
* Choose appropriate scaling strategies.
* Explain production EKS architecture.
* Discuss AWS-native Kubernetes best practices.
* Answer EKS interview questions confidently.

---

# 🎓 Learning Outcome

After completing this module, you should understand:

* Why organizations choose Amazon EKS.
* How AWS manages the Kubernetes control plane.
* How worker nodes integrate with EKS.
* How Pods securely access AWS services.
* How networking and storage work in EKS.
* How production clusters scale and remain highly available.
* Core architectural patterns used in enterprise Kubernetes deployments.

---

# 🏁 Module Status

**Status:** 🚧 In Progress

### Completed Chapters

* ✅ Introduction to Amazon EKS
* ✅ EKS Architecture
* ✅ EKS Cluster Creation
* ✅ Node Groups
* ✅ IAM & Security (OIDC + IRSA)
* ✅ Networking
* ✅ Storage
* ✅ Scaling
* ✅ Monitoring & Logging (Overview)
* ✅ Production Best Practices

### Remaining

* ⏳ Troubleshooting
* ⏳ Interview Questions

After completing these final chapters, the module will include **Revision.md**, **Troubleshooting.md**, and **Interview.md** for interview preparation and production-ready revision.
