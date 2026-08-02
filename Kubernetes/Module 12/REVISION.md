# 📘 GitOps & Argo CD Revision Notes

## Module 14 – GitOps with Argo CD

---

# 🚀 What is GitOps?

GitOps is a deployment methodology where **Git acts as the Single Source of Truth**, and Kubernetes clusters are automatically synchronized with the desired state stored in Git.

Instead of manually deploying applications, Git defines what should be running.

---

# GitOps Workflow

```text id="gitops1"
Developer

↓

Git Commit

↓

Git Push

↓

Argo CD

↓

Kubernetes

↓

Application Running
```

---

# Traditional CI/CD vs GitOps

## Traditional (Push Model)

```text id="push1"
Developer

↓

Git

↓

Jenkins / GitHub Actions

↓

kubectl apply

↓

Kubernetes
```

Pipeline pushes changes.

---

## GitOps (Pull Model)

```text id="pull1"
Developer

↓

Git

↓

Argo CD

↓

Pull Changes

↓

Kubernetes
```

Cluster pulls desired state.

---

# Why GitOps?

Benefits:

* Git is the Source of Truth
* Automatic Deployments
* Drift Detection
* Rollback
* Audit Trail
* Version Control
* Better Security

---

# Configuration Drift

Git

```text id="drift1"
Replicas = 3
```

Cluster

```text id="drift2"
Replicas = 8
```

Difference =

```text id="drift3"
OutOfSync
```

Argo CD restores Git state.

---

# Argo CD Architecture

```text id="arch1"
Argo CD

├── API Server
├── Repository Server
├── Application Controller
└── Redis
```

---

# API Server

Responsibilities:

* Web UI
* CLI
* Authentication
* RBAC
* REST API

---

# Repository Server

Responsibilities:

* Clone Git
* Read YAML
* Read Helm
* Read Kustomize
* Generate Kubernetes Manifests

---

# Application Controller

Responsibilities:

* Watch Git
* Watch Cluster
* Compare States
* Detect Drift
* Synchronize

Most important Argo CD component.

---

# Redis

Purpose:

* Cache
* Improve Performance

---

# Kubernetes API Server

Argo CD applies changes through the Kubernetes API Server.

Never directly modifies Pods.

---

# Desired vs Actual State

Desired

↓

Git

Actual

↓

Kubernetes

Argo CD continuously compares both.

---

# Continuous Reconciliation

```text id="reconcile1"
Git

↓

Compare

↓

Cluster

↓

Repeat Forever
```

---

# Application

An Application tells Argo CD:

* What to deploy
* Where to find it
* Where to deploy it

---

# Application Components

```text id="app1"
Application

├── Source
├── Destination
├── Project
└── Sync Policy
```

---

# Source

Git Repository

Helm

Kustomize

YAML

---

# Destination

Target:

* Cluster
* Namespace

---

# Project

Provides:

* Organization
* RBAC
* Repository Restrictions
* Namespace Restrictions

---

# Sync Policy

Controls deployment behavior.

Types:

* Manual
* Automatic

---

# Sync

Purpose:

Make Kubernetes match Git.

---

# Sync States

## Synced

Git = Cluster

---

## OutOfSync

Git ≠ Cluster

---

# Manual Sync

Developer manually starts synchronization.

---

# Automatic Sync

Argo CD deploys automatically after Git changes.

---

# Self-Heal

Manual changes:

```bash id="heal1"
kubectl edit
```

↓

Argo CD restores Git configuration.

---

# Prune

Resource removed from Git.

↓

Argo CD removes it from Kubernetes.

---

# Rollback

Purpose:

Return to previous working version.

Flow:

```text id="rollback1"
Version 4

↓

Rollback

↓

Version 3
```

---

# Git History

Git provides deployment history.

Rollback becomes simple.

---

# Rolling Update vs Rollback

Rolling Update

Old → New

Rollback

New → Old

---

# ApplicationSets

Automatically generate multiple Applications.

---

# ApplicationSet Architecture

```text id="appset1"
Template

+

Generator

↓

Applications
```

---

# Generators

## List Generator

Development

Staging

Production

---

## Git Generator

Generate Applications from Git folders.

---

## Cluster Generator

Generate Applications for registered clusters.

---

# Production Use Cases

* Multi-Cluster Deployments
* Multi-Environment Deployments
* Platform Engineering
* SaaS Platforms
* Kubernetes Production

---

# Common Interview Questions

### What is GitOps?

Git-driven deployment methodology.

---

### What is Argo CD?

GitOps Continuous Delivery tool.

---

### Push vs Pull?

Push → CI/CD deploys.

Pull → Argo CD deploys.

---

### What is Configuration Drift?

Git and Kubernetes differ.

---

### What is Sync?

Synchronize Kubernetes with Git.

---

### What is Self-Heal?

Restore cluster to Git state.

---

### What is Prune?

Delete resources removed from Git.

---

### What is Rollback?

Restore previous deployment.

---

### What is an Application?

Deployment definition.

---

### What is an ApplicationSet?

Factory that creates multiple Applications.

---

### What does Repository Server do?

Reads Git and generates manifests.

---

### What does Application Controller do?

Detects drift and synchronizes the cluster.

---

### What is the Source of Truth?

Git Repository.

---

# 🧠 Memory Map

```text id="memory1"
GitOps
│
├── Git
│      ├── Source of Truth
│      ├── Version History
│      └── Desired State
│
├── Argo CD
│      ├── API Server
│      ├── Repository Server
│      ├── Application Controller
│      └── Redis
│
├── Applications
│      ├── Source
│      ├── Destination
│      ├── Project
│      └── Sync Policy
│
├── Synchronization
│      ├── Sync
│      ├── Auto Sync
│      ├── Self-Heal
│      ├── Prune
│      └── Drift Detection
│
├── Rollback
│      ├── Revision
│      └── Git History
│
└── ApplicationSets
       ├── Template
       ├── Generator
       ├── List
       ├── Git
       └── Cluster
```

---

# ⚡ One-Line Revision

* **GitOps** → Git controls deployments.
* **Git** → Single Source of Truth.
* **Argo CD** → GitOps CD tool.
* **Repository Server** → Reads Git.
* **Application Controller** → Detects drift & syncs.
* **API Server** → UI & API.
* **Redis** → Cache.
* **Application** → Deployment definition.
* **Source** → Git location.
* **Destination** → Cluster + Namespace.
* **Project** → Organization & RBAC.
* **Sync** → Match Kubernetes to Git.
* **Synced** → Git = Cluster.
* **OutOfSync** → Git ≠ Cluster.
* **Auto Sync** → Automatic deployment.
* **Self-Heal** → Restore Git state after manual changes.
* **Prune** → Delete resources removed from Git.
* **Rollback** → Restore previous version.
* **ApplicationSet** → Generate multiple Applications.
* **List Generator** → Multiple environments.
* **Git Generator** → Generate from Git structure.
* **Cluster Generator** → Generate across clusters.
