# 🚀 Module 02 — MINI_PROJECT.md

> **Project:** Deploy a Production-Ready FastAPI Application Using Kubernetes Pods

**Difficulty:** ⭐⭐☆☆☆ (Beginner)

**Concepts Covered:**

- Pod Creation
- Resource Requests & Limits
- Health Checks (Probes)
- Container Ports
- YAML Manifests
- kubectl Commands
- Pod Inspection
- Logs
- Troubleshooting

---

# 🎯 Project Objective

In this project, we will deploy a simple FastAPI application inside a Kubernetes Pod and configure it using production best practices.

The goal is **not** high availability yet.

That comes in **Module 3 (Deployments).**

Here we'll focus on understanding how a production Pod should be configured.

---

# 🏢 Production Scenario

Your company has developed a new internal API.

Requirements:

- Run a FastAPI application
- Reserve CPU and Memory
- Prevent resource abuse
- Detect unhealthy applications
- Restart automatically if the application hangs
- Verify the application before sending traffic

At this stage, the company only needs **one instance**.

---

# 🏗 Architecture

```text
                    Kubernetes Cluster
                           │
                           ▼
                 +----------------------+
                 |      Worker Node     |
                 |                      |
                 |   +--------------+   |
                 |   | FastAPI Pod  |   |
                 |   |--------------|   |
                 |   | FastAPI App  |   |
                 |   +--------------+   |
                 |                      |
                 +----------------------+
```

---

# 📂 Project Structure

```text
mini-project/

├── fastapi-pod.yaml
├── app.py
├── requirements.txt
├── Dockerfile
└── README.md
```

---

# Step 1 — FastAPI Application

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Hello Kubernetes"}
```

---

# Step 2 — requirements.txt

```text
fastapi
uvicorn
```

---

# Step 3 — Dockerfile

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn","app:app","--host","0.0.0.0","--port","8000"]
```

Build the image:

```bash
docker build -t fastapi-demo:v1 .
```

If using Minikube:

```bash
minikube image load fastapi-demo:v1
```

---

# Step 4 — Pod Manifest

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: fastapi-pod
  labels:
    app: fastapi

spec:
  containers:
    - name: fastapi

      image: fastapi-demo:v1

      imagePullPolicy: IfNotPresent

      ports:
        - containerPort: 8000

      resources:
        requests:
          cpu: "250m"
          memory: "256Mi"

        limits:
          cpu: "500m"
          memory: "512Mi"

      livenessProbe:
        httpGet:
          path: /
          port: 8000

        initialDelaySeconds: 15
        periodSeconds: 10

      readinessProbe:
        httpGet:
          path: /
          port: 8000

        initialDelaySeconds: 5
        periodSeconds: 5
```

Save as:

```
fastapi-pod.yaml
```

---

# Step 5 — Deploy

```bash
kubectl apply -f fastapi-pod.yaml
```

---

# Step 6 — Verify

List Pods:

```bash
kubectl get pods
```

Expected:

```text
NAME            READY   STATUS
fastapi-pod     1/1     Running
```

---

Describe the Pod:

```bash
kubectl describe pod fastapi-pod
```

Verify:

- Pod IP
- Node
- Requests
- Limits
- Events
- Probes

---

# Step 7 — View Logs

```bash
kubectl logs fastapi-pod
```

You should see Uvicorn startup logs.

---

# Step 8 — Enter the Container

```bash
kubectl exec -it fastapi-pod -- sh
```

Inside:

```bash
pwd

ls

ps aux
```

Exit:

```bash
exit
```

---

# Step 9 — Port Forward

Pods are not directly accessible from your laptop.

Forward the Pod port:

```bash
kubectl port-forward fastapi-pod 8000:8000
```

Open:

```
http://localhost:8000
```

Expected response:

```json
{
  "message": "Hello Kubernetes"
}
```

---

# Validation Checklist

Your project is complete if you can:

- [ ] Build Docker image
- [ ] Create Pod
- [ ] Pod reaches Running state
- [ ] Requests & Limits configured
- [ ] Readiness Probe configured
- [ ] Liveness Probe configured
- [ ] View logs
- [ ] Enter container
- [ ] Access application via port-forward

---

# Failure Simulation

## Scenario 1 — Wrong Image

```yaml
image: fastapi-demo:v999
```

Expected:

```text
ImagePullBackOff
```

---

## Scenario 2 — Wrong Probe Port

```yaml
port: 9999
```

Expected:

```text
Readiness Probe Failed
```

The Pod remains running but does not become ready to receive traffic.

---

## Scenario 3 — Insufficient Resources

```yaml
requests:
  cpu: "64"
```

Expected:

```text
Pending
```

Reason:

No node has enough available CPU to satisfy the request.

---

## Scenario 4 — Memory Limit Too Low

```yaml
limits:
  memory: "32Mi"
```

A memory-hungry application may eventually result in:

```text
OOMKilled
```

---

# Commands Used

```bash
kubectl apply -f fastapi-pod.yaml

kubectl get pods

kubectl describe pod fastapi-pod

kubectl logs fastapi-pod

kubectl exec -it fastapi-pod -- sh

kubectl port-forward fastapi-pod 8000:8000

kubectl delete pod fastapi-pod
```

---

# Skills Gained

After completing this project you can:

- Deploy an application as a Pod
- Configure production resource requests and limits
- Configure health probes
- Inspect Pod details
- View logs
- Access a running container
- Forward traffic locally
- Diagnose common Pod failures

---

# Project Limitations

This project intentionally uses **only a single Pod**.

It does **not** provide:

- High availability
- Auto-healing after Pod deletion
- Scaling
- Rolling updates
- Rollbacks
- Load balancing

These capabilities are introduced in **Module 03 — ReplicaSets & Deployments**.

---

# 🎓 Key Learning Outcome

This project teaches how to configure a **production-ready Pod**, not a **production-ready application**.

In real Kubernetes environments, Pods are usually managed by higher-level controllers such as **Deployments**, which add scaling, self-healing, and rolling updates while still creating and managing Pods underneath.