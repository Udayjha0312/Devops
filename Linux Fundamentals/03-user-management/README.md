# User Management in Linux

## Introduction to User Management in Linux
Linux is a multi-user operating system, meaning multiple users can operate on a system simultaneously. Proper user management ensures security, controlled access, and system integrity. 

Key files involved in user management:
- `/etc/passwd` – Stores user account details.
- `/etc/shadow` – Stores encrypted user passwords.
- `/etc/group` – Stores group information.
- `/etc/gshadow` – Stores secure group details.

## Creating Users in Linux
To create a new user in Linux, use:

### `useradd` Command (For most Linux distributions)
```bash
useradd username
```
This creates a user without a home directory.

To create a user with a home directory:
```bash
useradd -m username
```

To specify a shell:
```bash
useradd -s /bin/bash username
```

### `adduser` Command (For Debian-based systems)
```bash
adduser username
```
This is an interactive command that asks for a password and additional details.

## Managing User Passwords
To set or change a user’s password:
```bash
passwd username
```

### Enforcing Password Policies
- **Password expiration**: Set password expiry days
  ```bash
  chage -M 90 username
  ```
- **Lock a user account**
  ```bash
  passwd -l username
  ```
- **Unlock a user account**
  ```bash
  passwd -u username
  ```

## Modifying Users
Modify an existing user with `usermod`:
- Change the username:
  ```bash
  usermod -l new_username old_username
  ```
- Change the home directory:
  ```bash
  usermod -d /new/home/directory -m username
  ```
- Change the default shell:
  ```bash
  usermod -s /bin/zsh username
  ```

## Deleting Users
To remove a user but keep their home directory:
```bash
userdel username
```
To remove a user and their home directory:
```bash
userdel -r username
```

## Working with Groups
### Creating Groups
```bash
groupadd groupname
```

### Adding Users to Groups
```bash
usermod -aG groupname username
```

### Viewing Group Memberships
```bash
groups username
```

### Changing Primary Group
```bash
usermod -g new_primary_group username
```

## Sudo Access and Privilege Escalation
### Adding a User to Sudo Group
On Debian-based systems:
```bash
usermod -aG sudo username
```
On RHEL-based systems:
```bash
usermod -aG wheel username
```

### Granting Specific Commands with Sudo
Edit the sudoers file:
```bash
visudo
```
Then add:
```bash
username ALL=(ALL) NOPASSWD: /path/to/command
```


---

## 1. The Core User Files (The Identity Registry)

### `/etc/passwd` & `/etc/shadow`

* **Simple Explanation:** `/etc/passwd` is a public phonebook of everyone who has an account on the server. Because anyone can read it, Linux strips out the passwords and hides them in `/etc/shadow`, which is a highly encrypted, top-secret vault that only the System Administrator (root) can read.
* **Real Company Scenario:** A security auditor asks you to prove that no ex-employees still have access to your production servers. You check `/etc/passwd` to see the full list of active usernames.
* **Interview Edge:** If asked, *"Why separate passwd and shadow?"* -> Say: *"Historically, `/etc/passwd` had to be readable by all processes to map User IDs to names. To prevent hackers from stealing password hashes and cracking them offline, Linux moved the encrypted hashes to `/etc/shadow`, locking it down so only root can access it."*

### `/etc/group` & `/etc/gshadow`

* **Simple Explanation:** Just like `/etc/passwd`, `/etc/group` is the public list of teams/groups (like `developers`, `security`, `admins`), and `/etc/gshadow` holds the secure, encrypted passwords for those groups (rarely used manually today).

---

## 2. Creating Users: `useradd` vs `adduser`

### `useradd username` vs `useradd -m username`

* **Simple Explanation:** `useradd` is a raw, bare-bones command. By default, it just creates a username but **does not** give them a folder to store their files. Adding `-m` forces Linux to create their home directory (`/home/username`).
* **Real Company Scenario:** You are writing an automated Bash or Ansible script to onboard 50 new developers. You use `useradd -m -s /bin/bash` because scripts need silent, non-interactive commands that run instantly without asking questions.

### `adduser username`

* **Simple Explanation:** This is a friendly, interactive wizard (mostly on Ubuntu/Debian). It asks you step-by-step: *"What password do you want? What is their phone number? What is their room number?"*
* **Real Company Scenario:** You are manually onboarding a single junior engineer onto a server, and you want Linux to guide you through setting up their password and home directory effortlessly.

---

## 3. Managing & Modifying Users (Security & Lifecycle)

### `passwd username` & `chage -M 90 username`

* **Simple Explanation:** `passwd` sets or changes a password. `chage -M 90` sets an expiration date, forcing the user to change their password every 90 days.
* **Real Company Scenario:** Your company needs to pass a **SOC2 or PCI-DSS compliance audit**. The compliance rules state passwords must expire every 3 months. You run `chage` on all user accounts to enforce this rule automatically.

### `passwd -l username` & `passwd -u username`

* **Simple Explanation:** `-l` locks an account (freezes it instantly), and `-u` unlocks it.
* **Real Company Scenario:** A developer suddenly leaves the company or is terminated. Before you figure out what to do with their files, you instantly run `passwd -l` to freeze their account so they can no longer log in.

### `usermod` (The Modifier)

* **Simple Explanation:** The tool used to edit an existing user's setup (like changing their default terminal shell from `bash` to `zsh`, or changing their username).

---

## 4. Deleting Users (The Offboarding Protocol)

### `userdel username` vs `userdel -r username`

* **Simple Explanation:** `userdel` deletes *just* the login account but leaves their files behind. Adding `-r` (recursive) deletes the account **and obliterates** their home directory and files.
* **Real Company Scenario:** A developer leaves, but they wrote critical scripts inside `/home/developer/scripts`. You use regular `userdel` so they can't log in anymore, but their work is saved. If it's a temporary contractor and you don't need their data, you use `userdel -r` to clean up disk space.

---

## 5. Working with Groups (Team Permissions)

### `groupadd` & `usermod -aG groupname username`

* **Simple Explanation:** `groupadd` creates a team folder/permissions group. `usermod -aG` adds a user to that group.
* **Crucial Interview Note:** **Always emphasize the `-a` (append)**. If you run `usermod -G` without the `-a`, it will **wipe out** all the other groups that user belonged to, potentially locking them out of vital systems.
* **Real Company Scenario:** You create a group called `deployers`. You add the CI/CD pipeline user to this group so it has permission to push code to the webserver directory.

---

## 6. Sudo Access & Privilege Escalation (The Keys to the Kingdom)

### `sudo` vs `wheel` groups

* **Simple Explanation:** To give a user admin (root) powers, you add them to a special group. On Ubuntu/Debian, that group is called `sudo`. On CentOS/RHEL, it is called `wheel`.

### `visudo` and `NOPASSWD`

* **Simple Explanation:** `visudo` is a safe, protected editor used to modify the `/etc/sudoers` file (the file that dictates who gets admin powers). If you make a typo in this file using a regular editor, you can permanently lock everyone out of the server. `visudo` checks for errors before saving.
* **Real Company Scenario (`NOPASSWD`):** Your company uses an automated monitoring tool (like Datadog) that needs to run a specific system command (like checking disk health) every 60 seconds. Because it's an automated robot, it cannot type in a password. You use `visudo` to grant that specific user `NOPASSWD` **only** for that specific health command.

---

### How to nail this in an Interview:

> *"When it comes to user management, my focus is always on the Principle of Least Privilege and automation. For automated user onboarding, I use `useradd` with specific flags inside scripts to ensure home directories and default shells are set up uniformly. For security compliance, I utilize `chage` to enforce password rotation policies. Most importantly, when granting admin rights, I never edit the sudoers file directly; I always use `visudo` to prevent syntax errors that could lock us out of the system, and I leverage specific group assignments like `sudo` or `wheel` depending on whether we are running Debian or RHEL environments."*
