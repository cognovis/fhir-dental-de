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
5. **PUSH CODE TO GIT** - Only for code/doc changes. Beads changes do NOT need git commits (they live in Dolt):
   ```bash
   git pull --rebase
   git status                # If only .beads/ runtime files: nothing to commit
   git commit -m "..."       # Only for code/doc changes
   git push
   ```
6. **Clean up** - Clear stashes, prune remote branches
7. **Verify** - All changes pushed to BOTH remotes (Dolt + git)
8. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
<!-- END BEADS INTEGRATION -->
