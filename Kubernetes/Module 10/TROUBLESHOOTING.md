# 🛠️ KEDA Troubleshooting Guide

## Module 12 – Kubernetes Event-Driven Autoscaling (KEDA)

This guide covers common KEDA production issues, investigation steps, debugging commands, and resolutions frequently discussed in DevOps and SRE interviews.

---

# 1. Pods Never Scale

### Symptoms

* Queue has messages
* Deployment remains at 0 or 1 Pod

### Investigation

Check the ScaledObject:

```bash id="8g4h5m"
kubectl get scaledobjects

kubectl describe scaledobject <scaledobject-name>
```

Verify:

* `scaleTargetRef`
* Trigger type
* Queue/topic name
* Namespace

### Resolution

* Correct the trigger configuration.
* Ensure the target Deployment exists.
* Verify the ScaledObject is healthy.

---

# 2. HPA Is Not Created

### Investigation

```bash id="76ny0g"
kubectl get hpa
```

If no HPA exists:

```bash id="me6h4l"
kubectl get pods -n keda
```

Check the Operator logs:

```bash id="nljlwm"
kubectl logs deployment/keda-operator -n keda
```

### Resolution

* Restart the KEDA Operator if necessary.
* Fix any ScaledObject validation errors.
* Ensure the KEDA CRDs are installed.

---

# 3. Authentication Failure

### Symptoms

```text id="0ntxpn"
Access Denied
Authentication Failed
Unauthorized
```

### Investigation

```bash id="90gkj7"
kubectl get triggerauthentication

kubectl describe triggerauthentication <name>

kubectl get secrets
```

Verify:

* Secret name
* Secret keys
* Namespace
* IAM/Cloud permissions

### Resolution

* Correct the Secret or TriggerAuthentication.
* Grant the required cloud permissions.
* Ensure the credentials are valid.

---

# 4. RabbitMQ Trigger Doesn't Work

### Investigation

Verify:

* Queue exists.
* Queue name is correct.
* Queue contains messages.
* RabbitMQ is reachable.

Review the trigger configuration in the ScaledObject.

### Resolution

Correct the queue configuration or restore RabbitMQ connectivity.

---

# 5. Kafka Trigger Doesn't Scale

### Investigation

Check:

* Broker connectivity
* Topic name
* Consumer group
* Consumer lag

If lag is zero, scaling is not expected.

### Resolution

Fix broker connectivity or consumer configuration.

---

# 6. AWS SQS Trigger Doesn't Scale

### Investigation

Verify:

* Queue URL
* Queue region
* AWS credentials
* IAM Role/Policy
* Approximate message count

### Resolution

Correct AWS permissions or queue configuration.

---

# 7. Scale to Zero Doesn't Work

### Investigation

Review:

```yaml id="f8nvvz"
minReplicaCount:
```

If:

```yaml id="d2sk8v"
minReplicaCount: 1
```

The Deployment will never scale to zero.

### Resolution

Set:

```yaml id="e3m7uw"
minReplicaCount: 0
```

when scale-to-zero is desired.

---

# 8. Scaling Is Too Slow

### Investigation

Review:

```yaml id="h9ls7s"
pollingInterval:
```

Large polling intervals delay scaling decisions.

Also check:

* Cold starts
* Slow image pulls
* Node scheduling

### Resolution

Lower the polling interval if appropriate and optimize application startup.

---

# 9. Pods Scale Up and Down Repeatedly

### Symptoms

```text id="m9s6vm"
0

↓

5

↓

0

↓

5
```

### Investigation

Review:

```yaml id="mfgpvb"
cooldownPeriod:
```

### Resolution

Increase the cooldown period to reduce scaling thrashing.

---

# 10. Too Many Pods Are Created

### Investigation

Check:

```yaml id="6i34jn"
maxReplicaCount:
```

Also verify trigger thresholds.

### Resolution

Set a realistic maximum replica count based on:

* Cluster capacity
* Database limits
* External API limits

---

# 11. Pods Start but Crash

### Investigation

```bash id="9um5fq"
kubectl logs <pod>

kubectl describe pod <pod>
```

Possible causes:

* Missing Secret
* Invalid ConfigMap
* Database unavailable
* Application bug

### Resolution

Fix the application or Kubernetes configuration.

KEDA has already done its job by creating the Pods.

---

# 12. Queue Is Empty but Pods Continue Running

### Investigation

Check:

* `cooldownPeriod`
* Long-running requests
* Active processing

### Resolution

Wait for the cooldown period or reduce it if appropriate.

---

# 13. Metrics Adapter Issues

### Investigation

```bash id="ejb6ur"
kubectl get pods -n keda

kubectl logs deployment/keda-metrics-apiserver -n keda
```

Verify external metrics are available.

### Resolution

Restart or repair the Metrics Adapter and verify connectivity to the event source.

---

# 14. KEDA Operator CrashLoopBackOff

### Investigation

```bash id="cjlwm8"
kubectl get pods -n keda

kubectl logs deployment/keda-operator -n keda
```

Check:

* Image issues
* Configuration errors
* Missing permissions

### Resolution

Fix the underlying issue and restart the Operator.

---

# 15. Wrong Deployment Is Scaling

### Investigation

Review:

```yaml id="fphjvl"
scaleTargetRef:
```

Verify the Deployment name exactly matches the intended workload.

### Resolution

Update the `scaleTargetRef` to the correct resource.

---

# 16. TriggerAuthentication Not Found

### Investigation

```bash id="epcif4"
kubectl get triggerauthentication
```

Ensure the authentication resource exists in the correct namespace.

### Resolution

Create the missing TriggerAuthentication or reference the correct one.

---

# 17. ClusterTriggerAuthentication Doesn't Work

### Investigation

Check:

* Resource name
* RBAC permissions
* Cluster-wide access
* Namespace configuration

### Resolution

Correct RBAC or use a namespace-scoped TriggerAuthentication if appropriate.

---

# 18. External Service Is Unreachable

### Symptoms

* Queue unavailable
* Broker unavailable
* Database offline

### Investigation

Verify:

* Network connectivity
* DNS
* Firewall/Security Groups
* Service health

### Resolution

Restore connectivity to the external service.

---

# 19. Cold Starts Are Too Slow

### Investigation

Measure:

* Image pull time
* Application startup time
* Scheduling delay

### Resolution

* Reduce image size.
* Optimize startup logic.
* Pre-pull container images.
* Consider increasing `minReplicaCount`.

---

# 20. Scaling Works but Performance Is Still Poor

### Investigation

Monitor:

* Database
* Cache
* External APIs
* Network
* Application latency

Remember:

KEDA scales Pods—not databases or third-party services.

### Resolution

Identify and remove downstream bottlenecks.

---

# Common Debugging Commands

```bash id="l1m9mw"
kubectl get scaledobjects

kubectl describe scaledobject <name>

kubectl get hpa

kubectl describe hpa

kubectl get pods -n keda

kubectl logs deployment/keda-operator -n keda

kubectl logs deployment/keda-metrics-apiserver -n keda

kubectl get triggerauthentication

kubectl describe triggerauthentication <name>

kubectl get events

kubectl describe pod <pod>

kubectl logs <pod>
```

---

# Production Troubleshooting Flow

```text id="jlwmgc"
Application Not Scaling
        │
        ▼
Check Event Source
        │
        ▼
Check Trigger
        │
        ▼
Check Authentication
        │
        ▼
Check ScaledObject
        │
        ▼
Check KEDA Operator
        │
        ▼
Check Metrics Adapter
        │
        ▼
Check HPA
        │
        ▼
Check Kubernetes Pods
        │
        ▼
Check Application Logs
        │
        ▼
Identify Root Cause
        │
        ├── Trigger Issue
        ├── Authentication Issue
        ├── Operator Issue
        ├── Metrics Issue
        ├── Kubernetes Issue
        └── Application Issue
```

---

# Interview Troubleshooting Strategy

When asked to troubleshoot KEDA in an interview, follow this sequence:

1. Verify the external event source (RabbitMQ, Kafka, SQS, etc.).
2. Inspect the `ScaledObject`.
3. Validate Trigger configuration.
4. Verify `TriggerAuthentication`.
5. Ensure the KEDA Operator is healthy.
6. Check the Metrics Adapter.
7. Confirm the HPA has been created.
8. Inspect Pods and Events.
9. Review application logs.
10. If Pods are running but the application fails, investigate the application rather than KEDA.

---

# ⭐ Production Tip

One of the biggest mistakes is assuming **"KEDA isn't working."**

In production, KEDA is often functioning correctly, but the actual problem lies elsewhere, such as:

* RabbitMQ queue unavailable
* Kafka consumer lag is zero
* AWS IAM permissions missing
* Invalid TriggerAuthentication
* Database unavailable
* Application crashing
* Kubernetes scheduling issues

Always troubleshoot in this order:

```text id="go4s5m"
Event Source
      ↓
Trigger
      ↓
Authentication
      ↓
KEDA
      ↓
HPA
      ↓
Pods
      ↓
Application
```

Following this systematic workflow helps you quickly identify the real root cause and demonstrates strong production debugging skills during DevOps and SRE interviews.
