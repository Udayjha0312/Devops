# Git & GitHub for DevOps — Complete Revision Guide

## 1. Git Workflow

```text
Working Directory
      ↓ git add
Staging Area
      ↓ git commit
Local Repository
      ↓ git push
Remote Repository
```

### Working Directory

The actual project files and folders where we create, modify, and delete code.

### Staging Area

An intermediate area containing the exact changes selected for the next commit.

```bash
git add app.py
git add .
```

### Local Repository

The Git repository and committed history stored on the local computer.

### Remote Repository

A Git repository hosted on another server, commonly GitHub.

---

# 2. Git File States

```text
New file
   ↓
Untracked
   ↓ git add
Staged
   ↓ git commit
Committed
   ↓ edit
Modified
   ↓ git add
Staged
```

### Untracked

A new file Git has never tracked.

### Modified

An already tracked file changed since its last staged or committed version.

### Staged

Changes selected for the next commit.

### Committed

Changes saved in local Git history.

---

# 3. Core Git Commands

## Initialize Repository

```bash
git init
```

Creates the hidden `.git` directory.

Deleting `.git`:

```bash
rm -rf .git
```

Result:

```text
Project files → remain
Local Git history → lost
Git repository → no longer exists
```

## Check Repository State

```bash
git status
```

Shows:

```text
Current branch
Untracked files
Modified files
Staged files
Ahead/behind information
```

## Stage Changes

```bash
git add app.py
git add app.py Dockerfile
git add .
git add -A
```

Important:

```text
git add does not upload code.
git add selects the current version of changes for the next commit.
```

If a file is modified again after `git add`, the newer modification is unstaged.

## Commit

```bash
git commit -m "Add application health check"
```

A commit saves the staged snapshot in the local repository.

## Commit Tracked Files Directly

```bash
git commit -am "Fix application error"
```

Works only with already tracked files.

It does not include new untracked files.

---

# 4. Git Diff

## Show Unstaged Changes

```bash
git diff
```

Compares:

```text
Working Directory ↔ Staging Area
```

## Show Staged Changes

```bash
git diff --staged
```

or:

```bash
git diff --cached
```

Compares:

```text
Staging Area ↔ Last Commit
```

Example:

```bash
echo "Line A" >> app.py
git add app.py
echo "Line B" >> app.py
```

Result:

```text
git diff
→ Line B

git diff --staged
→ Line A

git commit
→ commits Line A only
```

---

# 5. Git Log and Commit Inspection

## Detailed History

```bash
git log
```

## Compact History

```bash
git log --oneline
```

## Visual Branch History

```bash
git log --oneline --graph --decorate --all
```

## Inspect Specific Commit

```bash
git show <commit-hash>
```

Example:

```bash
git show a71bc92
```

---

# 6. HEAD

`HEAD` identifies the current position in Git history.

Normally:

```text
HEAD → current branch → latest commit
```

Example:

```text
HEAD → feature-login → E
```

If a new commit `F` is created:

```text
HEAD → feature-login → F
```

---

# 7. .gitignore

Example:

```gitignore
.env
*.log
*.pem
node_modules/
.terraform/
*.tfstate
*.tfstate.*
```

Important:

```text
.gitignore affects untracked files.
It does not automatically stop tracking files already committed.
```

Stop tracking a file but keep the local copy:

```bash
git rm --cached .env
```

Then:

```bash
git commit -m "Stop tracking environment file"
```

Critical security rule:

```text
Adding a secret to .gitignore does not remove it from Git history.
```

---

# 8. Git Restore

## Discard Unstaged Changes

```bash
git restore app.py
```

Warning: the unstaged changes are discarded.

## Unstage Changes but Keep Them

```bash
git restore --staged app.py
```

Result:

```text
Staged → Modified and unstaged
```

## Completely Discard a Staged Change

```bash
git restore --staged app.py
git restore app.py
```

---

# 9. Git Reset

Suppose:

```text
A ← B ← C
        ↑
       HEAD
```

## Soft Reset

```bash
git reset --soft HEAD~1
```

Result:

```text
Commit undone
Changes remain staged
```

Use when:

```text
"I want to recommit the changes."
```

## Mixed Reset

```bash
git reset --mixed HEAD~1
```

or:

```bash
git reset HEAD~1
```

Result:

```text
Commit undone
Changes remain
Changes become unstaged
```

## Hard Reset

```bash
git reset --hard HEAD~1
```

Result:

```text
Commit undone
Changes discarded
```

## Memory Rule

```text
SOFT  → keep changes STAGED
MIXED → keep changes UNSTAGED
HARD  → DISCARD changes
```

---

# 10. Git Revert

Use for undoing shared or pushed commits.

```bash
git revert <commit-hash>
```

Suppose:

```text
A ← B ← C
```

`C` is bad.

After revert:

```text
A ← B ← C ← D
```

Where:

```text
C → bad change
D → new commit reversing C
```

Important:

```text
Revert does not delete C.
Revert creates a new commit with the inverse changes.
```

If another commit `E` exists:

```text
A ← B ← C ← E
```

Reverting `C` gives:

```text
A ← B ← C ← E ← F
```

Only `C` is reversed.

Changes from `E` remain.

## Reset vs Revert

```text
Local unshared history → reset may be appropriate
Shared/pushed history  → prefer revert
```

---

# 11. Branches

A branch is a lightweight movable pointer to a commit.

Create branch:

```bash
git branch feature-login
```

Switch branch:

```bash
git switch feature-login
```

Create and switch:

```bash
git switch -c feature-login
```

Older syntax:

```bash
git checkout -b feature-login
```

List branches:

```bash
git branch
```

Example:

```text
HEAD → feature-login → E

main → C
```

---

# 12. Switching Branches with Uncommitted Changes

If switching would overwrite uncommitted changes:

```bash
git switch main
```

Git normally blocks the operation.

Possible solutions:

```text
Commit the changes
Stash the changes
Discard the changes
```

Git does not normally silently delete conflicting uncommitted work.

---

# 13. Git Stash

Temporarily save unfinished work:

```bash
git stash
```

With message:

```bash
git stash push -m "Unfinished payment work"
```

Include untracked files:

```bash
git stash -u
```

List stashes:

```bash
git stash list
```

Example:

```text
stash@{0}: login work
stash@{1}: terraform work
```

## Restore and Remove Stash

```bash
git stash pop
```

## Restore and Keep Stash

```bash
git stash apply
```

Specific stash:

```bash
git stash apply stash@{1}
```

Delete specific stash:

```bash
git stash drop stash@{1}
```

Delete all stashes:

```bash
git stash clear
```

Memory:

```text
pop   → restore + remove
apply → restore + keep
```

---

# 14. Git Merge

Rule:

```text
Switch to receiving branch
Then merge source branch
```

To merge `feature-payment` into `main`:

```bash
git switch main
git merge feature-payment
```

---

# 15. Fast-Forward Merge

Before:

```text
A ← B ← C ← D ← E
        ↑         ↑
      main      feature
```

`main` has not changed.

After:

```bash
git switch main
git merge feature
```

Result:

```text
A ← B ← C ← D ← E
                  ↑
           main + feature
```

Important:

```text
Fast-forward merge
→ moves branch pointer
→ creates NO new merge commit
```

---

# 16. Three-Way Merge

Before:

```text
          D ← E   feature
         /
A ← B ← C
         \
          F ← G   main
```

Both branches moved.

Run:

```bash
git switch main
git merge feature
```

Result:

```text
          D ← E
         /     \
A ← B ← C       H
         \     /
          F ← G
```

`H` is a merge commit.

Three points used:

```text
Common ancestor → C
Current branch  → G
Feature branch  → E
```

Important:

```text
Three-way merge does not automatically mean conflict.
```

---

# 17. Merge Conflicts

Example:

```text
<<<<<<< HEAD
replicas: 3
=======
replicas: 5
>>>>>>> feature-payment
```

Meaning:

```text
HEAD → current branch
feature-payment → branch being merged
```

Resolve manually, then:

```bash
git add <resolved-file>
git commit
```

Cancel merge:

```bash
git merge --abort
```

---

# 18. Git Rebase

Suppose:

```text
          D ← E   feature
         /
A ← B ← C ← F ← G   main
```

Run:

```bash
git switch feature
git rebase main
```

Result:

```text
A ← B ← C ← F ← G ← D' ← E'
                ↑           ↑
              main        feature
```

Rebase:

```text
Temporarily removes D and E
Moves feature to latest main
Replays D and E on top
```

`D'` and `E'` have new hashes.

Why?

```text
Original D parent → C
New D' parent     → G
```

Different history means different commit hash.

## Rebase Conflict

Fix file:

```bash
git add <resolved-file>
git rebase --continue
```

Repeat if more conflicts occur.

Cancel:

```bash
git rebase --abort
```

Memory:

```text
Merge conflict:
fix → git add → git commit

Rebase conflict:
fix → git add → git rebase --continue
```

Golden rule:

```text
Own local feature commits → generally safe to rebase
Shared commits → avoid casually rebasing
```

---

# 19. Interactive Rebase

Clean recent commit history:

```bash
git rebase -i HEAD~3
```

Options:

```text
pick   → keep commit
reword → change commit message
squash → combine with previous commit
drop   → remove commit
```

Example:

```text
pick C Add login
squash D Fix typo
squash E Final fix
```

Three commits become one clean commit.

---

# 20. Git Commit Amend

Fix latest commit message:

```bash
git commit --amend -m "Correct commit message"
```

Add forgotten file to latest commit:

```bash
git add forgotten-file
git commit --amend
```

Important:

```text
Amend replaces the latest commit.
The commit hash changes.
Avoid casually amending shared commits.
```

---

# 21. Cherry-Pick

Copy the changes introduced by one commit onto the current branch.

```bash
git cherry-pick <commit-hash>
```

Example:

```text
Original commit D exists on feature branch.
```

Run from `main`:

```bash
git switch main
git cherry-pick <hash-of-D>
```

Result:

```text
main → D'
```

Important:

```text
Original D remains unchanged.
D' is a new commit with the same changes.
D' normally has a new hash.
```

Use case:

```text
One bug fix exists on develop.
Production main needs only that fix.
```

---

# 22. Clone and Remotes

Clone:

```bash
git clone <repository-url>
```

Usually:

```text
Downloads files and history
Creates local repository
Adds source remote as origin
```

List remotes:

```bash
git remote -v
```

Add remote:

```bash
git remote add origin <repository-url>
```

Important:

```text
origin is only a conventional remote name.
```

---

# 23. Fetch vs Pull vs Push

## Fetch

```bash
git fetch origin
```

```text
Downloads remote commits
Updates remote-tracking references
Does not integrate into current branch
Does not automatically change working directory
```

## Pull

```bash
git pull
```

Conceptually:

```text
git pull = fetch + integrate
```

Usually:

```text
fetch + merge
```

or configured as:

```text
fetch + rebase
```

## Push

```bash
git push origin main
```

Uploads local commits to the remote.

Memory:

```text
fetch → download only
pull  → download + integrate
push  → upload
diff  → compare
```

---

# 24. main vs origin/main

This distinction is critical.

```text
main
→ actual local branch

origin/main
→ local remote-tracking reference
→ local record of remote main from last fetch
```

Suppose:

```text
Local main → B
Remote main → C
```

After:

```bash
git fetch origin
```

Result:

```text
main        → B
origin/main → C
```

The working directory remains unchanged.

Inspect remote-only commits:

```bash
git log main..origin/main --oneline
```

Compare changes:

```bash
git diff main..origin/main
```

---

# 25. Git Push

```bash
git push origin main
```

Means:

```text
Push local main
to remote named origin
updating remote main
```

It does not mean:

```text
"Push my current work into main."
```

If currently on `feature-login`:

```text
local main → C
feature-login → E
```

Running:

```bash
git push origin main
```

pushes local `main`, not `feature-login`.

---

# 26. Upstream Tracking

First push:

```bash
git push -u origin feature-login
```

`-u` means:

```text
--set-upstream
```

Relationship:

```text
local feature-login ↔ origin/feature-login
```

Future commands:

```bash
git push
git pull
```

---

# 27. Non-Fast-Forward Push Rejection

Situation:

```text
Remote:
A ← B ← C

Local:
A ← B ← D
```

Your push is rejected because remote contains `C`.

Do not immediately run:

```bash
git push --force
```

Safe workflow:

```bash
git fetch origin
git rebase origin/main
git push origin main
```

Result:

```text
A ← B ← C ← D'
```

For a rebased personal feature branch, if force update is genuinely needed:

```bash
git push --force-with-lease
```

Prefer it over:

```bash
git push --force
```

---

# 28. GitHub Pull Request Workflow

```text
main
 ↓
Create feature branch
 ↓
Make changes
 ↓
Commit
 ↓
Push feature branch
 ↓
Open Pull Request
 ↓
CI checks
 ↓
Code review
 ↓
Approval
 ↓
Merge
```

Commands:

```bash
git switch -c feature-login

git add .
git commit -m "Add login feature"

git push -u origin feature-login
```

Then create the Pull Request.

---

# 29. GitHub Merge Strategies

## Merge Commit

```text
Keeps individual feature commits
Creates a merge commit
Preserves branch structure
```

## Squash and Merge

```text
Combines all feature commits into one commit
```

Best for:

```text
fix
typo
final fix
actually final
```

Main receives one clean commit.

## Rebase and Merge

```text
Replays feature commits onto main
Keeps linear history
No merge commit
```

---

# 30. Fork Workflow

Typical setup:

```text
origin   → your fork
upstream → original repository
```

Workflow:

```bash
git clone <your-fork-url>

git remote add upstream <original-repo-url>

git fetch upstream

git switch main

git merge upstream/main

git push origin main
```

Create feature:

```bash
git switch -c feature-login
```

Commit:

```bash
git add .
git commit -m "Add login feature"
```

Push to your fork:

```bash
git push -u origin feature-login
```

Create PR:

```text
your-fork:feature-login
        ↓
original-repository:main
```

You do not need to merge the feature into your fork's `main` before opening the PR.

---

# 31. Tags

Branch:

```text
Movable pointer
```

Tag:

```text
Fixed label for a specific commit
```

Lightweight tag:

```bash
git tag v1.0.0
```

Annotated tag:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
```

Push one tag:

```bash
git push origin v1.0.0
```

Push all tags:

```bash
git push origin --tags
```

List tags:

```bash
git tag
```

Tag old commit:

```bash
git tag -a v1.0.0 <commit-hash> -m "Release v1.0.0"
```

---

# 32. Semantic Versioning

```text
v2.5.3

2 → MAJOR
5 → MINOR
3 → PATCH
```

## Patch

Bug fix:

```text
v2.5.3 → v2.5.4
```

## Minor

Backward-compatible new feature:

```text
v2.5.3 → v2.6.0
```

## Major

Breaking change:

```text
v2.5.3 → v3.0.0
```

---

# 33. Git Reflog

Shows recent movements of HEAD and branch references.

```bash
git reflog
```

Useful for:

```text
Accidental hard reset
Deleted branch
Bad rebase
Lost commit
Wrong reset
```

Example recovery:

```bash
git reflog
```

Find:

```text
abc123
```

Create recovery branch:

```bash
git branch recovery abc123
```

---

# 34. Recover Deleted Branch

Find commit:

```bash
git reflog
```

Recreate branch:

```bash
git branch feature-login <commit-hash>
```

Create and immediately switch:

```bash
git switch -c feature-login <commit-hash>
```

Syntax to remember:

```text
git branch <branch-name> <commit-hash>
```

---

# 35. Git Bisect

Find the commit that introduced a bug.

Start:

```bash
git bisect start
```

Mark current broken version:

```bash
git bisect bad
```

Mark known working commit:

```bash
git bisect good <known-good-commit>
```

Git checks a commit in the middle.

Test it:

```bash
git bisect good
```

or:

```bash
git bisect bad
```

Repeat until Git identifies the first bad commit.

Finish:

```bash
git bisect reset
```

Use case:

```text
100 commits
Application worked before
Application is broken now
Need to find first bad commit
```

---

# 36. Other Useful Commands

## Remove Untracked Files

Preview first:

```bash
git clean -n
```

Delete untracked files:

```bash
git clean -f
```

Delete untracked files and directories:

```bash
git clean -fd
```

## Remove Tracked File

```bash
git rm old-file.txt
```

## Stop Tracking but Keep Local File

```bash
git rm --cached .env
```

## Rename File

```bash
git mv old.txt new.txt
```

## Inspect Line History

```bash
git blame app.py
```

---

# 37. GitHub Authentication

## HTTPS + PAT

Personal Access Tokens can authenticate Git operations over HTTPS.

PATs should have:

```text
Minimum required permissions
Expiration where appropriate
Secure storage
```

## SSH

```text
Private key → stays secret on local machine
Public key  → uploaded to GitHub
```

Critical:

```text
Never share the private key.
```

## Deploy Key

SSH key attached to one specific repository.

Useful for:

```text
Deployment servers
Automation
Repository-specific access
```

Prefer read-only access unless write access is necessary.

---

# 38. Branch Protection

Production branches such as `main` should commonly have:

```text
Direct pushes blocked
Force pushes blocked
Pull requests required
Required reviewers
CI checks required
```

Typical workflow:

```text
Feature branch
      ↓
Pull Request
      ↓
CI
      ↓
Review
      ↓
Approval
      ↓
Merge
```

---

# 39. CODEOWNERS

Maps repository paths to responsible reviewers.

Example concept:

```text
/terraform/  → infrastructure team
/kubernetes/ → platform team
/security/   → security team
```

Useful for requiring appropriate review of sensitive changes.

---

# 40. Webhooks

Without webhook:

```text
CI server repeatedly checks:
"Any changes?"
```

With webhook:

```text
GitHub event
      ↓
HTTP notification
      ↓
Jenkins/CI server
      ↓
Pipeline starts
```

Example:

```text
Developer pushes
      ↓
GitHub webhook
      ↓
Jenkins
      ↓
Pipeline
```

---

# 41. Git in CI/CD

Typical pipeline:

```text
Developer pushes code
        ↓
Git event/webhook
        ↓
CI starts
        ↓
Checkout exact commit
        ↓
Build
        ↓
Test
        ↓
Create artifact/image
        ↓
Deploy
```

Important DevOps principle:

```text
Git commit SHA
      ↓
Build artifact
      ↓
Docker image tag/digest
      ↓
Deployment
```

A deployment should be traceable to exact source code.

---

# PRODUCTION TROUBLESHOOTING

# Scenario 1: Bad Commit Pushed to Shared Main

Investigate:

```bash
git log --oneline
git show <bad-commit-hash>
```

Undo safely:

```bash
git revert <bad-commit-hash>
git push origin main
```

Why?

```text
Revert preserves shared history.
```

Do not casually use:

```bash
git reset --hard
git push --force
```

on shared `main`.

---

# Scenario 2: Bad Local Commit Not Pushed

Keep changes staged:

```bash
git reset --soft HEAD~1
```

Keep changes unstaged:

```bash
git reset --mixed HEAD~1
```

Discard changes:

```bash
git reset --hard HEAD~1
```

---

# Scenario 3: Secret Committed and Pushed

Examples:

```text
AWS access key
API key
Database password
Private token
Private key
```

Deleting it later is not enough.

These do not remove it from old history:

```bash
git rm secret-file
git rm --cached .env
```

Correct response:

```text
1. Revoke or rotate credential immediately
2. Investigate possible unauthorized use
3. Remove secret from current code
4. Add sensitive file/pattern to .gitignore
5. Clean secret from Git history if required
6. Coordinate history rewriting with team
7. Enable secret scanning/prevention
```

Golden rule:

```text
ROTATE FIRST.
CLEAN HISTORY AFTER.
```

---

# Scenario 4: Push Rejected — Non-Fast-Forward

Do not immediately:

```bash
git push --force
```

Inspect:

```bash
git fetch origin
git log main..origin/main --oneline
```

Integrate:

```bash
git rebase origin/main
git push origin main
```

Or follow the team's merge-based workflow.

---

# Scenario 5: Accidentally Deleted Branch

Find previous commit:

```bash
git reflog
```

Recover:

```bash
git branch feature-login <commit-hash>
```

---

# Scenario 6: Accidental Hard Reset

You ran:

```bash
git reset --hard HEAD~2
```

Find old position:

```bash
git reflog
```

Create recovery branch:

```bash
git branch recovery <old-commit-hash>
```

Verify before modifying important shared branches.

---

# Scenario 7: Force-Push Disaster

Someone force-pushed shared `main`.

Response:

```text
1. Stop additional pushes
2. Check reflog
3. Check teammates' local clones
4. Find last correct commit SHA
5. Create recovery branch
6. Verify history
7. Restore through controlled team process
8. Enable branch protection
9. Block force pushes
```

Commands:

```bash
git reflog
git branch recovery <good-commit>
```

---

# Scenario 8: CI/CD Deployed Old Code

Investigate:

```text
Which commit triggered the pipeline?
Which commit did CI checkout?
Which artifact was built?
Which Docker image was created?
Which tag/digest was deployed?
Did the deployment actually roll out?
```

Common causes:

```text
Wrong branch
Wrong commit SHA
Stale CI workspace
Old artifact
Mutable "latest" Docker tag
Wrong image tag
Wrong release tag
Deployment did not restart
```

Trace:

```text
Commit SHA
    ↓
Pipeline build
    ↓
Artifact
    ↓
Docker image tag/digest
    ↓
Deployment
```

---

# Scenario 9: Wrong Release Tag

First determine:

```text
Was the tag pushed?
Was it published?
Did CI/CD use it?
Was it deployed?
```

For a published release, it is often safer to create a corrected version:

```text
v2.0.0 → bad release
v2.0.1 → corrected release
```

instead of silently moving a public tag.

---

# Scenario 10: Find Which Commit Broke Production

Use:

```bash
git bisect start
git bisect bad
git bisect good <known-good-commit>
```

Then repeatedly:

```bash
git bisect good
```

or:

```bash
git bisect bad
```

Finish:

```bash
git bisect reset
```

---

# Scenario 11: Merge Conflict

Check:

```bash
git status
```

Resolve markers:

```text
<<<<<<< HEAD
current branch version
=======
incoming branch version
>>>>>>> feature
```

Then:

```bash
git add <resolved-file>
git commit
```

Cancel:

```bash
git merge --abort
```

---

# Scenario 12: Rebase Conflict

Resolve manually:

```bash
git add <resolved-file>
git rebase --continue
```

Repeat if needed.

Cancel:

```bash
git rebase --abort
```

Do not use a normal `git commit` as the standard continuation step.

---

# Scenario 13: Unfinished Work Blocks Branch Switch

Save:

```bash
git stash push -m "Unfinished work"
```

Switch:

```bash
git switch main
```

Return:

```bash
git switch feature-branch
```

Restore and remove stash:

```bash
git stash pop
```

Restore and keep stash:

```bash
git stash apply
```

---

# Scenario 14: Need One Fix from Another Branch

Do not merge the entire branch.

Use:

```bash
git cherry-pick <bugfix-commit-hash>
```

This creates a new commit with the same changes on the current branch.

---

# Scenario 15: Feature Branch Is Behind Main

Situation:

```text
          D ← E   feature
         /
A ← B ← C ← F ← G   main
```

Update feature with linear history:

```bash
git switch feature
git rebase main
```

Result:

```text
A ← B ← C ← F ← G ← D' ← E'
```

If the branch was already pushed and is your own feature branch:

```bash
git push --force-with-lease
```

Use carefully.

---

# MOST IMPORTANT INTERVIEW DIFFERENCES

## Fetch vs Pull

```text
fetch → download only
pull  → download + integrate
```

## Reset vs Revert

```text
reset  → moves branch pointer / can rewrite history
revert → new commit reversing old changes
```

## Merge vs Rebase

```text
merge  → preserves branch history
rebase → rewrites commits onto a new base
```

## Pop vs Apply

```text
pop   → restore + remove stash
apply → restore + keep stash
```

## Main vs Origin/Main

```text
main        → local branch
origin/main → local record of remote main
```

## Branch vs Tag

```text
branch → movable pointer
tag    → fixed label
```

## Fast-Forward vs Three-Way Merge

```text
Only feature moved
→ fast-forward
→ no new merge commit

Both branches moved
→ three-way merge
→ usually creates merge commit
```

## Merge Conflict vs Rebase Conflict

```text
Merge:
fix → git add → git commit

Rebase:
fix → git add → git rebase --continue
```

---

# FINAL COMMAND CHEAT SHEET

```bash
# Repository
git init
git status

# Stage and commit
git add .
git commit -m "message"
git commit --amend

# Inspect
git diff
git diff --staged
git log --oneline
git show <hash>

# Undo
git restore <file>
git restore --staged <file>
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1
git revert <hash>

# Branch
git branch
git switch <branch>
git switch -c <branch>

# Merge
git merge <branch>
git merge --abort

# Stash
git stash
git stash -u
git stash list
git stash apply
git stash pop
git stash drop

# Rebase
git rebase main
git rebase --continue
git rebase --abort
git rebase -i HEAD~3

# Cherry-pick
git cherry-pick <hash>

# Remote
git clone <url>
git remote -v
git remote add origin <url>
git fetch origin
git pull
git push origin main
git push -u origin feature-login

# Recovery
git reflog
git branch recovery <hash>

# Debugging
git bisect start
git bisect bad
git bisect good <hash>
git bisect reset

# Files
git clean -n
git clean -f
git rm <file>
git rm --cached <file>
git mv old new
git blame <file>

# Tags
git tag
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
git push origin --tags
```

# FINAL DEVOPS MENTAL MODEL

```text
Developer creates feature branch
        ↓
Makes small meaningful commits
        ↓
Pushes feature branch
        ↓
Pull Request
        ↓
CI checks
        ↓
Code review
        ↓
Merge
        ↓
Tag release
        ↓
CI/CD builds exact commit
        ↓
Immutable artifact/image
        ↓
Deployment
        ↓
Production is traceable back to Git SHA
```

# Five Golden Rules

```text
1. Never casually force-push shared main.

2. Use revert for bad shared commits.

3. Rotate exposed secrets immediately.

4. Run git status before and after risky operations.

5. Every production deployment should be traceable to an exact commit SHA or immutable release.
```
