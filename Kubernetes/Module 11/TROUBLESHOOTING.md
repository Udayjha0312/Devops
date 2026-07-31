# 🛠️ Amazon EKS Troubleshooting Guide

## Module 13 – Elastic Kubernetes Service (EKS)

This guide covers common production issues encountered in Amazon EKS clusters and the recommended troubleshooting approach.

---

# 1. Pods Stuck in Pending

## Symptoms

* Pod never starts.
* Status remains `Pending`.

## Investigation

```bash
kubectl get pods

kubectl describe pod <pod-name>
```

Check:

* No available CPU
* No available Memory
* Node Selector mismatch
* Taints & Tolerations
* PVC not bound

## Resolution

* Add worker nodes.
* Increase node size.
* Fix scheduling constraints.
* Verify Storage.

---

# 2. Worker Nodes Not Joining Cluster

## Symptoms

```text
kubectl get nodes

No nodes found
```

## Investigation

Check:

* Node IAM Role
* Security Groups
* VPC
* Bootstrap process
* Node Group status

AWS:

* EC2 Console
* EKS Console

## Resolution

Correct IAM permissions.

Verify networking.

Restart failed nodes.

---

# 3. CrashLoopBackOff

## Investigation

```bash
kubectl logs <pod>

kubectl describe pod <pod>
```

Possible causes

* Application crash
* Wrong environment variables
* Missing Secret
* Missing ConfigMap
* Database unavailable

## Resolution

Fix application configuration or runtime errors.

---

# 4. ImagePullBackOff

## Investigation

```bash
kubectl describe pod
```

Check

* Wrong image
* Wrong tag
* ECR permissions
* Registry authentication

## Resolution

Correct image reference or IAM permissions.

---

# 5. Load Balancer Not Created

## Investigation

Check:

```bash
kubectl get ingress
```

Verify:

* AWS Load Balancer Controller
* IAM permissions
* Ingress annotations

## Resolution

Deploy or repair the AWS Load Balancer Controller and verify annotations.

---

# 6. ALB Returns 502

## Investigation

Check

* Pods Running
* Service
* Target Group
* Readiness Probe

Commands

```bash
kubectl get svc

kubectl get endpoints
```

## Resolution

Fix Service selectors or application health.

---

# 7. Pods Cannot Reach AWS Services

Example

S3

SQS

DynamoDB

## Investigation

Verify

* IRSA
* OIDC
* IAM Role
* Trust Policy

## Resolution

Correct IAM Role or Service Account configuration.

---

# 8. OIDC Authentication Failure

## Symptoms

```text
AccessDenied

Unauthorized
```

## Investigation

Verify

* OIDC Provider
* Trust Policy
* Service Account
* IAM Role

## Resolution

Repair the trust relationship and IAM configuration.

---

# 9. Worker Node NotReady

## Investigation

```bash
kubectl get nodes

kubectl describe node <node>
```

Check

* kubelet
* Disk pressure
* Memory pressure
* Network
* EC2 health

## Resolution

Restart kubelet or replace the node.

---

# 10. Pods Cannot Communicate

## Investigation

Check

* Network Policies
* Security Groups
* Services
* DNS

Commands

```bash
kubectl get networkpolicy

kubectl get svc
```

## Resolution

Correct networking policies or Service configuration.

---

# 11. PVC Pending

## Symptoms

Persistent Volume Claim never binds.

## Investigation

```bash
kubectl get pvc

kubectl describe pvc
```

Check

* StorageClass
* CSI Driver
* Available Storage

## Resolution

Install the CSI Driver or correct the StorageClass.

---

# 12. EBS Volume Not Attached

## Investigation

Verify

* EBS CSI Driver
* IAM permissions
* Availability Zone

## Resolution

Correct CSI configuration and ensure the node and volume are in compatible Availability Zones.

---

# 13. HPA Not Scaling

## Investigation

```bash
kubectl get hpa

kubectl describe hpa
```

Verify

* Metrics Server
* CPU requests
* Resource usage

## Resolution

Install or repair the Metrics Server and define resource requests.

---

# 14. KEDA Not Scaling

## Investigation

Check

```bash
kubectl get scaledobjects

kubectl get pods -n keda
```

Verify

* Trigger
* Authentication
* Operator
* HPA

## Resolution

Repair the KEDA configuration.

---

# 15. Cluster Autoscaler Doesn't Add Nodes

## Investigation

Check

* Auto Scaling Group
* IAM Role
* Pending Pods

## Resolution

Correct ASG or Cluster Autoscaler configuration.

---

# 16. Karpenter Doesn't Launch Nodes

## Investigation

Verify

* IAM permissions
* Provisioner/NodePool configuration
* EC2 limits
* Available instance types

## Resolution

Correct Karpenter configuration and AWS quotas if necessary.

---

# 17. DNS Resolution Failure

## Symptoms

Pods cannot resolve services.

## Investigation

```bash
kubectl get pods -n kube-system
```

Check CoreDNS.

## Resolution

Restart CoreDNS or repair networking.

---

# 18. Deployment Stuck

## Investigation

```bash
kubectl rollout status deployment <deployment>

kubectl describe deployment
```

Check

* Readiness Probe
* Image
* Scheduling
* Resource limits

## Resolution

Correct deployment configuration.

---

# 19. High CPU Usage

## Investigation

```bash
kubectl top pods

kubectl top nodes
```

Check

* Traffic
* Infinite loops
* Resource requests

## Resolution

Scale using HPA or optimize the application.

---

# 20. High Memory Usage / OOMKilled

## Investigation

```bash
kubectl describe pod
```

Look for

```text
OOMKilled
```

## Resolution

Increase memory limits or fix memory leaks.

---

# 21. Worker Node Upgrade Failure

## Investigation

Verify

* Managed Node Group status
* Pod Disruption Budgets
* Draining process

## Resolution

Drain nodes correctly and resolve blocking workloads.

---

# 22. Security Group Misconfiguration

## Symptoms

* API unavailable
* Node registration failure
* ALB unreachable

## Investigation

Review inbound and outbound Security Group rules.

## Resolution

Allow the required communication between the control plane, nodes, and load balancers.

---

# 23. Terraform Deployment Failure

## Investigation

Check

* IAM permissions
* Existing resources
* Terraform state
* Provider configuration

## Resolution

Repair the state or infrastructure configuration before reapplying.

---

# Common kubectl Commands

```bash
kubectl get nodes

kubectl get pods -A

kubectl describe pod

kubectl describe node

kubectl logs

kubectl get svc

kubectl get ingress

kubectl get pvc

kubectl get events

kubectl rollout status deployment
```

---

# AWS Services to Check

* Amazon EC2
* Amazon EKS
* IAM
* VPC
* Security Groups
* Route Tables
* Auto Scaling Groups
* EBS
* EFS
* CloudWatch

---

# Production Troubleshooting Flow

```text
Application Problem
        │
        ▼
Pod Running?
        │
        ▼
Node Healthy?
        │
        ▼
Deployment
        │
        ▼
Service
        │
        ▼
Ingress
        │
        ▼
Load Balancer
        │
        ▼
Networking
        │
        ▼
IAM / IRSA
        │
        ▼
Storage
        │
        ▼
Application Logs
        │
        ▼
Root Cause
```

---

# Interview Strategy

When asked to troubleshoot an EKS issue:

1. Check the Pod.
2. Check the Node.
3. Check the Deployment.
4. Check the Service.
5. Check the Ingress.
6. Check the Load Balancer.
7. Verify IAM/IRSA if AWS access is involved.
8. Verify Storage if stateful workloads are affected.
9. Review Events and Logs.
10. Identify the root cause before making changes.

---

# ⭐ Production Tip

Never assume the issue is with EKS itself.

Many production incidents are caused by:

* Incorrect IAM permissions
* Security Group rules
* Readiness probe failures
* Missing resource requests
* Wrong Service selectors
* Misconfigured Ingress
* CSI Driver issues
* StorageClass errors
* DNS failures
* Application bugs

Always troubleshoot from the **outside in**:

```text
User
 ↓
DNS
 ↓
Load Balancer
 ↓
Ingress
 ↓
Service
 ↓
Pod
 ↓
Application
 ↓
Database
```

This structured approach is what interviewers look for because it mirrors how production incidents are investigated.
