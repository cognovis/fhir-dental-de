# Agent Instructions

This project uses **bd** (beads) for issue tracking. Run `bd onboard` to get started.

## Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work atomically
bd close <id>         # Complete work
bd dolt push          # Push beads data to remote
```

## Non-Interactive Shell Commands

**ALWAYS use non-interactive flags** with file operations to avoid hanging on confirmation prompts.

Shell commands like `cp`, `mv`, and `rm` may be aliased to include `-i` (interactive) mode on some systems, causing the agent to hang indefinitely waiting for y/n input.

**Use these forms instead:**
```bash
# Force overwrite without prompting
cp -f source dest           # NOT: cp source dest
mv -f source dest           # NOT: mv source dest
rm -f file                  # NOT: rm file

# For recursive operations
rm -rf directory            # NOT: rm -r directory
cp -rf source dest          # NOT: cp -r source dest
```

**Other commands that may prompt:**
- `scp` - use `-o BatchMode=yes` for non-interactive
- `ssh` - use `-o BatchMode=yes` to fail instead of prompting
- `apt-get` - use `-y` flag
- `brew` - use `HOMEBREW_NO_AUTO_UPDATE=1` env var

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:ca08a54f -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

## Beads Sync Setup (one-time per machine)

**Beads sync uses Dolt as the primary source of truth.** The JSONL exports are derivative artifacts (gitignored). Issues are pulled/pushed via the SQL protocol from `https://dolt.cognovis.de/fhir_dental_de`.

### One-time setup for a fresh clone

```bash
# 1. Ensure brew-managed Dolt is running on localhost:3306
brew services start dolt
brew services info dolt   # Running: true

# 2. Get credentials for dolt.cognovis.de from 1Password (vault "API Keys" → "Dolt Remote - <user>")
#    Make sure DOLT_REMOTE_PASSWORD is set in your shell env (~/.zshenv) and via launchd.
#    See ~/.claude/plugins/core/skills/dolt/references/team-onboarding.md for full instructions.

# 3. Clone the database (DOLT_CLONE ignores DOLT_REMOTE_USER — pass --user explicitly)
dolt --host 127.0.0.1 --port 3306 --no-tls sql -q \
  "CALL DOLT_CLONE('--user', 'malte', 'https://dolt.cognovis.de/fhir_dental_de')"
brew services restart dolt

# 4. Verify
cd ~/code/fhir-dental-de
bd dolt show     # Shows remote: https://dolt.cognovis.de/fhir_dental_de [SQL only]
bd list          # Shows all issues
```

If `bd dolt pull/push` fails with "Access denied for user 'root'", the bd CLI doesn't pass `--user`. Workaround — use the raw SQL push:

```bash
dolt --host 127.0.0.1 --port 3306 --no-tls sql \
  -q "USE fhir_dental_de; CALL DOLT_PUSH('--user', 'malte', '--force', 'origin', 'main')"
```

### Troubleshooting: `.beads/issues.jsonl` shows up in VS Code / git

Since commit `c75ca16` (2026-05-10) `issues.jsonl` and `interactions.jsonl` are **gitignored** — Dolt is the source of truth, and as of 2026-05-12 the JSONL auto-export is also disabled in `.beads/config.yaml` (`backup.enabled: false`). The local jsonl stays as a stale snapshot from the last manual `bd export -o`; sync state via `bd dolt pull/push` only.

If VS Code's Source Control panel keeps flagging `.beads/issues.jsonl` as modified or untracked, or `git push` tries to ship it:

```bash
# 1. Untrack any stale copy left over from before the migration
git rm --cached .beads/issues.jsonl .beads/interactions.jsonl 2>/dev/null || true

# 2. Confirm gitignore is taking effect (should print nothing)
git status --porcelain .beads/issues.jsonl .beads/interactions.jsonl

# 3. (Optional) Hide the noise in VS Code — add to .vscode/settings.json:
#    "files.exclude": { ".beads/issues.jsonl": true, ".beads/interactions.jsonl": true }
```

Reminder: **do NOT `git add .beads/issues.jsonl`** and do NOT try to resolve "conflicts" in it by hand. The file is regenerated from Dolt — sync via `bd dolt pull && bd dolt push` instead. New beads created locally (`bd create ...`) only reach the team after `bd dolt push`.

## Session Completion

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until both `bd dolt push` and `git push` succeed.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH BEADS TO DOLT** - This is the primary sync mechanism:
   ```bash
   bd dolt pull && bd dolt push --force
   # If "Access denied for user 'root'": use the raw SQL push above.
   ```
5. **OPEN PR + MERGE** — `main` is protected; **direct push is blocked**. Required status check: `vendor-leak-check / check`. `enforce_admins: true` — no admin bypass. Workflow (only for code/doc changes; beads changes do NOT need git commits — they live in Dolt):
   ```bash
   git pull --rebase origin main
   git status                                         # If only .beads/ runtime files: nothing to commit
   git checkout -b <feature-branch>                   # create feature branch from main
   git commit -m "..."                                # Only for code/doc changes
   git push -u origin <feature-branch>                # push to feature branch, NOT main
   gh pr create --base main --head <feature-branch> \
     --title "<conventional commit subject>" --body "..."
   gh pr checks --watch                               # block until required checks complete
   gh pr merge <pr-number> --merge --delete-branch    # only proceeds if all required checks green
   ```
6. **Clean up** - Clear stashes, prune remote branches
7. **Verify** - PR merged, branch deleted, beads pushed to Dolt
8. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until **the PR is merged to main**
- NEVER attempt direct push to main — it will be rejected by branch protection
- NEVER bypass the `vendor-leak-check` or any other required check — see CLAUDE.md "Branch Protection & Merge Workflow"
- NEVER say "ready to push when you are" — YOU must create the PR and merge it
- If checks fail, fix the underlying issue and push a new commit to the feature branch; do not request a bypass
<!-- END BEADS INTEGRATION -->
