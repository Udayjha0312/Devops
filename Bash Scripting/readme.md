

# Production Bash Scripting & Automation Laboratory

Welcome to my portfolio of **Production-Grade Shell Scripting and Systems Automation**. This repository contains a practical execution suite of advanced Bash scripts engineered to solve common infrastructure challenges, automate incident response, process API data, and orchestrate background lifecycles.

Each solution is built following enterprise standards, incorporating strict safety checks (`set -euo pipefail`), optimal string parsing handlers, and clean diagnostic outputs.

---

## 🛠️ Workspace Setup & Dataset Initialization

To simulate a live production runtime and instantly generate all test logs, directory trees, and mock JSON payloads, execute the setup block below in your local terminal environment:

```bash
# Clone and enter the repository
git clone [https://github.com/Udayjha0312/Devops.git](https://github.com/Uayjha0312/Devops.git)
cd Bash Scripting

# Generate testing matrices, unstructured files, and target datasets instantly
chmod +x init_lab_env.sh
./init_lab_env.sh

```

---

## 📂 Challenge Automation Suites & Script Details

### Phase 1: Dynamic Text Processing & Log Analysis

####  Script 1: High-Traffic Log Parsing Gateway (`analyzer.sh`)

* **Objective:** Isolate high-frequency malicious IP entries hitting an upstream Nginx proxy.
* **Architecture:** Skips loose global string filters in favor of strict column validation (`$9 == "404"`). It processes raw standard access text streams to extract the top 5 highest-frequency adversarial IP entries, sorted by frequency density.
* **Usage:**
```bash
./analyzer.sh

```



####  Script 2: Automated Storage Guardian & Log Truncator (`disk_guardian.sh`)

* **Objective:** Prevent system volume exhaustion by auditing, packing, and wiping active debug outputs.
* **Architecture:** Queries the block storage filesystem dynamically using positional string extractors. If volume utilization breaches **85%**, it loops through the target path, packages raw `*.log` files into timestamped `.tar.gz` bundles, and applies null redirection to truncate the active files to `0 bytes` without dropping active kernel descriptors.
* **Usage:**
```bash
./disk_guardian.sh

```



####  Script 3: Automated On-Call Trace Classifier (`responder.sh`)

* **Objective:** Parse application stack traces to identify critical service drops.
* **Architecture:** Evaluates log streams using Extended Regular Expressions (regex) to match fatal application states (`CRITICAL|FATAL`). It cleanly parses the text fields to output timestamped status alerts, returning `[OK] System healthy.` if no threats match.
* **Usage:**
```bash
./responder.sh

```



####  Script 4: Hanging Process Reaper (`reaper.sh`)

* **Objective:** Terminate lingering background applications consuming system memory tables.
* **Architecture:** Runs system process scans via programmatic token lookups while omitting the script's own operational footprint. It documents all matching target process IDs into a persistent tracking log and fires soft `SIGTERM (15)` termination signals to clean up system state.
* **Usage:**
```bash
./reaper.sh

```



---

### Phase 2: System Audit Mechanics & Security Hardening

####  Script 5: Interactive Shell Access Auditor (`audit_users.sh`)

* **Objective:** Audit system accounts to map out potential access vectors.
* **Architecture:** Parses the core identity layout (`/etc/passwd`). It filters out non-interactive system daemons and restricted access shells (`/sbin/nologin`, `/bin/false`) to build a clean report of human accounts along with their default shell configurations.
* **Usage:**
```bash
./audit_users.sh

```



####  Script 6: Recursive Configuration Privilege Scanner (`security_hardening.sh`)

* **Objective:** Audit and automatically harden loose permissions on configuration files containing secrets.
* **Architecture:** Crawls destination directory trees and screens the contents of all discovered files for high-risk strings (`PASSWORD|SECRET|TOKEN`). When a file contains sensitive data and exposes wide-open security flags, it strips public visibility and clamps the file down to owner read-and-write only (`chmod 600`).
* **Usage:**
```bash
./security_hardening.sh

```



---

### Phase 3: Live API & Infrastructure Data Marshalling

####  Script 7: Cloud Component Integrity Evaluator (`status_monitor.sh`)

* **Objective:** Ingest web payloads to check the real-time operational status of infrastructure components.
* **Architecture:** Queries third-party endpoints over standard network streams. It pipes raw payloads into `jq` to unpack complex JSON matrices, checks global operation keys, and maps out failing sub-components when the state changes to degraded.
* **Usage:**
```bash
./status_monitor.sh

```



####  Script 8: JSON Metadata Converter & Inventory Compiler (`inventory.sh`)

* **Objective:** Convert complex, multi-tiered cloud asset inventory metrics into flat files.
* **Architecture:** Ingests nested cloud configuration JSON structures. It streams individual record keys through unbuffered string formatting filters to generate a clean, comma-separated CSV matrix for documentation imports.
* **Usage:**
```bash
./inventory.sh

```



---

### Phase 4: Cron Orchestration & Lifecycle Automation

####  Script 9: Archive Compilation & Legacy Retention Suite (`backup_engine.sh`)

* **Objective:** Package active service directory content and purge stale historical data.
* **Architecture:** Bundles target source directories into compressed tape archive (`.tar.gz`) files appended with a precise date string. Once complete, it calls the `find` engine to clean out legacy backups older than 7 days to maintain optimal storage limits.
* **Usage:**
```bash
./backup_engine.sh

```



####  Script 10: Scheduled Cron Engine Configurations (`crontab`)

* **Objective:** Register automation scripts to run on persistent background schedules.
* **Architecture:** Integrates into the Linux background crontab manager. It schedules scripts to run on specific custom schedules, silences standard execution outputs, and pipes technical error diagnostics into dedicated tracking logs.
* **Configuration Schema:**

```text
# Execute the Storage Guardian every 15 minutes, Monday through Friday
*/15 * * * 1-5 /root/disk_guardian.sh >> /var/log/cron_guardian.log 2>&1

# Execute the Integrity Evaluator every single hour on Saturdays and Sundays
0 * * * 6,0 /root/status_monitor.sh >> /var/log/cron_status.log 2>&1

```

---

##  Applied Scripting Best Practices

Every script in this repository implements strict development guidelines to guarantee resilience in enterprise environments:

1. **Fail-Fast Error Handling (`set -euo pipefail`):**
* `-e`: Aborts execution immediately if any command returns a non-zero exit status.
* `-u`: Catches typos and bugs by treating uninitialized variables as a fatal error.
* `-o pipefail`: Forces pipelines to return the exit code of the *first* command that fails, rather than hiding errors behind subsequent pipes.


2. **Idempotency Checks:** Before taking action, scripts check if target folders exist (`[ -d ]`), files are present (`[ -f ]`), or third-party binaries (like `jq`) are installed.
3. **Low Overhead I/O Pipelines:** Avoids useless `cat` operations into `grep` or `awk`. Instead, it passes target files directly into processing commands to maintain minimal CPU usage.
4. **Safe File Truncation:** Clears system file logs via null redirects (`> file`) instead of dropping files outright (`rm`). This keeps active internal file descriptors open and operational.

---

*Maintained with absolute engineering discipline by Uday Jha

```

```