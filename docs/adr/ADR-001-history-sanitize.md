# ADR-001: Git-History Sanitization — Removal of KZBV/BEB Catalog Texts

## Status

PROPOSED — awaiting maintainer decision (Phase B requires explicit approval)

---

## Context

Between 2026-03-29 and 2026-04-04, a series of commits introduced full display strings from
three dental-billing catalogs into the fhir-dental-de repository:

- **BEMA** (Bewertungsmaßstab zahnärztlicher Leistungen) — KZBV/GKV-Spitzenverband
- **BEL-II** (Bewertungsliste für zahntechnische Leistungen) — KZBV
- **beb97** (BEB beb'97) — Bundesverband der Deutschen Zahntechniker-Innungen (BDZI)

The display strings were the catalog's verbatim German descriptions (e.g.
"Eingehende Untersuchung", "Vollgusskrone NEM") embedded as FSH `display` literals in
CodeSystem resources.

On 2026-04-27 (commit `69ba436`), all display strings were neutralized: every concept now
uses a code-derived label such as "BEMA-01" rather than the original catalog wording.
The current HEAD (`53a65bd`) therefore contains no copyrighted text in the working tree.

However, **the copyrighted strings remain present in the repository's Git history**
in at least nine commits. If the repository is ever made public — or if it is already
accessible to third parties — those historical objects are retrievable via
`git log -p`, `git show`, `git checkout <old-commit>`, or GitHub's commit browser.

A pre-push copyright guardrail was added in bead fdde-b1m
(`scripts/check-copyright.sh`, `.git/hooks/pre-push`, `scripts/copyright-blocklist.txt`)
to prevent future regressions, but it does not affect already-committed history.

---

## Audit Findings

### Affected Commits

| Commit | Date | Message |
|--------|------|---------|
| `9148aff` | 2026-03-29 09:51 | feat(fhir-dental-de-4hj): add complete CodeSystems for BEMA, GOZ, GOÄ-Zahn, BEL-II, beb97 — **first introduction** |
| `7fd8c74` | 2026-03-29 09:58 | fix iteration 1 (expanded code counts) |
| `e684561` | 2026-03-29 10:02 | fix iteration 2 |
| `26cff05` | 2026-03-29 10:10 | remove fabricated codes |
| `afa7f6a` | 2026-04-03 16:47 | set status active |
| `ce678f6` | 2026-04-03 22:21 | set experimental=false |
| `82aff3c` | 2026-04-04 09:29 | replace PAR codes |
| `2dd90da` | 2026-04-04 09:37 | review findings fix |
| `69ba436` | 2026-04-27 11:13 | feat(fdde-4wi): neutralize KZBV/BEB display strings — **neutralization** |

**Affected files (all three):**

- `input/fsh/codesystems/BemaCS.fsh`
- `input/fsh/codesystems/BelIICS.fsh`
- `input/fsh/codesystems/Beb97CS.fsh`

### Copyrighted Phrases Found in History

**BEMA (BemaCS.fsh):**
- "Eingehende Untersuchung"
- "Vitalitätsprüfung"
- "Notfallbehandlung"
- "Lokalanästhesie"
- (plus all other BEMA display strings from the full catalog)

**BEL-II (BelIICS.fsh):**
- "Vollgusskrone NEM"
- "Vollgusskrone NEM mit Schulter"
- "Vollgusskrone Edelmetall"
- (plus all other BEL-II display strings)

**beb97 (Beb97CS.fsh):**
- "Vollgusskrone NEM"
- "CAD/CAM-Krone NEM"
- "CAD/CAM-Krone Zirkonoxid"
- (plus all other beb97 display strings)

### Repository Exposure

| Dimension | Current State |
|-----------|--------------|
| GitHub forks | **0** — no external forks exist |
| Open pull requests | **0** — no open PRs will be broken by a rewrite |
| Open branches | 2 active: `chore/bump-praxis-0.38.0` (44 commits behind main, likely abandoned); `feat/fhir-dental-de-nfg/cross-repo-cleanup` (behind main, old branch) |
| Repository visibility | Not confirmed public; if private, risk is significantly lower |
| Remote | `dolt.cognovis.de` (internal Dolt remote, not DoltHub) — no public mirror known |

The absence of external forks is the single most favorable factor: a history rewrite
cannot break other people's clones if nobody has cloned the repo externally.

---

## Risk Assessment per Catalog

| Catalog | Risk Level | Legal Basis | Reasoning |
|---------|-----------|-------------|-----------|
| **BEMA** | MEDIUM | KZBV/GKV-Spitzenverband Vertragsrecht; ggf. § 5 II UrhG (amtliche Veröffentlichung) | BEMA-Texte sind kollektiv von KZBV und GKV-Spitzenverband vereinbart und veröffentlicht. Ob § 5 UrhG greift (amtliche Werke), ist rechtlich streitig. Im Zweifel schutzfähig, Risiko aber geringer als bei rein privatrechtlichen Katalogen. |
| **BEL-II** | MEDIUM | KZBV-Vertragstexte; ggf. § 5 II UrhG analog | Ähnliche Situation wie BEMA: Vertragstext zwischen KZBV und GKV-Spitzenverband. Amtliche-Werk-Argument ist anwendbar, aber nicht gesichert. Mittelhohe Schätzung angemessen. |
| **beb97 (BEB beb'97)** | HIGH | Privatrechtlicher Verbandskatalog des BDZI (Bundesverband der Deutschen Zahntechniker-Innungen); kein § 5 UrhG-Bezug | Rein privatrechtlicher Katalog eines Berufsverbandes. Kein Argument für amtliches Werk. Volle urheberrechtliche Schutzwirkung nach § 2 UrhG wahrscheinlich. Reproduktion ohne Lizenz stellt erhöhtes Haftungsrisiko dar. |
| **GOZ / GOÄ-Zahn** | LOW / OUT OF SCOPE | Bundesrechtsverordnung — § 5 I UrhG-frei | Gebührenordnungen als Rechtsverordnungen sind gemeinfrei. Kein Handlungsbedarf. |

---

## Decision Drivers

1. **beb97 is HIGH risk** — a private trade-association catalog with no statutory-publication
   exemption. Retention in public history is indefensible if the repo becomes public.
2. **BEMA and BEL-II are MEDIUM risk** — the § 5 II UrhG argument may apply, but it is
   contested and cannot be relied upon without legal opinion.
3. **Zero external forks** — a forced-push history rewrite today has near-zero external
   blast radius. The window for a clean rewrite is open now; it narrows if the repo grows.
4. **Pre-push guardrail is already in place** — the root cause is fixed. History sanitization
   is the remaining remediation step.
5. **Working tree is already clean** — no copyrighted strings exist in the current HEAD;
   this is purely a historical-object cleanup task.
6. **Dolt remote quirk** — the Dolt remote has a known bug (dolthub/dolt#10807) that dirties
   the working set on every push. The execution plan must use `bd dolt pull && bd dolt push --force`
   via the beads wrapper (never raw `dolt push --force`) to work around this.

---

## Alternatives Considered

### Option 1: Accept History As-Is (No Rewrite)

**Description:** Leave the Git history unchanged. The copyrighted strings remain in historical
commits but are not present in the current working tree or any active branch tip. Accept the
legal risk as residual and monitor for enforcement.

**Pros:**
- Zero operational risk — no force-push, no branch coordination required.
- Preserves full commit history including bisect/blame utility.
- Appropriate if the repository remains strictly private and no public access is ever granted.
- Simplest path if legal counsel concludes the § 5 UrhG exemption covers BEMA and BEL-II
  and beb97 risk is accepted.

**Cons:**
- beb97 HIGH risk remains permanently embedded; exposure grows if the repo is published.
- Historical objects are retrievable via `git show <commit>` or any full clone.
- Any future public release would require this rewrite to happen anyway — delaying increases
  the rewrite's blast radius as the commit graph grows.
- Does not align with the "clean public IG" goal implicit in the GitHub-published IG
  (`cognovis.github.io/fhir-dental-de/`) — if the Git repo itself becomes public, risk
  materializes immediately.

**Verdict:** Acceptable only as a temporary deferral while legal opinion on beb97 is sought.
Not recommended as a permanent decision given the HIGH risk classification.

---

### Option 2: Execute git filter-repo History Rewrite (Recommended)

**Description:** Use `git filter-repo` to rewrite every affected commit, replacing the
copyrighted display strings with the neutralized code-derived labels that already appear
in the current working tree. The rewrite targets only the three FSH files across the nine
identified commits; all other files and commits are untouched.

**What it does:**

1. Creates a fresh clone of the repository (mandatory: `git filter-repo` requires a
   fresh clone to prevent accidental partial rewrites).
2. Applies blob-content substitutions for each of the three files in each of the nine
   commits, replacing catalog display strings with neutral `"BEMA-<code>"` / `"BEL-<code>"` /
   `"BEB-<code>"` labels (matching the pattern introduced in commit `69ba436`).
3. All commit SHAs from `9148aff` onward are rewritten (new SHAs); the commit *messages*
   and *metadata* (author, date) are preserved.
4. The rewritten history is force-pushed to origin (Git remote) and to the Dolt remote.
5. All local checkouts must be re-cloned or rebased onto the new history.

**Pros:**
- Fully eliminates all copyrighted text from every reachable Git object.
- Permanent remediation — no residual risk after successful execution.
- Zero external fork blast radius (0 forks confirmed).
- Two old branches (`chore/bump-praxis-0.38.0`, `feat/fhir-dental-de-nfg/cross-repo-cleanup`)
  are both behind main and likely abandoned; coordination burden is minimal.
- Positions the repository for safe public release in the future.

**Cons:**
- All existing local clones are invalidated; contributors must re-clone.
- Commit SHAs in CHANGELOG.md, ADR cross-references, and any external links to specific
  commits will be broken.
- Requires careful execution (fresh-clone discipline, pre-push hook disable during rewrite,
  Dolt quirk workaround).
- Irreversible without a pre-rewrite backup.

**Verdict:** Recommended. The operational cost is low (no external forks, two inactive
branches), and the legal risk reduction — especially for beb97 — justifies the one-time
rewrite effort.

---

## Recommendation

**Execute Option 2 (git filter-repo rewrite).**

Rationale:
- beb97 carries a HIGH copyright risk that cannot be mitigated by any working-tree-only fix.
- The repository currently has 0 external forks, making this the optimal moment for a
  force-push rewrite with minimal external impact.
- The two open branches are old and behind main; they will need rebasing onto the new
  history, which is a trivial operation.
- Deferring the rewrite increases future blast radius without reducing legal exposure.

The rewrite must be executed as a coordinated single-maintainer operation with a brief
repository freeze (no pushes during rewrite) and must follow the Dolt-remote workaround
documented in the Execution Plan below.

Phase B (the actual rewrite) requires explicit maintainer approval before execution.

---

## Execution Plan (Phase B — Requires Explicit Approval)

> DO NOT execute these steps without explicit written approval from the repository maintainer.

### Prerequisites

```bash
# Verify git-filter-repo is installed
git filter-repo --version

# Confirm no new forks or open PRs since this ADR was written
gh repo view cognovis/fhir-dental-de --json forks,openPullRequestsCount
```

### Step 1: Create a pre-rewrite backup

```bash
# Tag the current HEAD before any rewrite
git tag backup/pre-history-sanitize HEAD
git push origin backup/pre-history-sanitize
```

### Step 2: Clone into a fresh working directory

```bash
# git filter-repo requires a fresh clone (no local modifications)
cd /tmp
git clone --no-local /Users/malte/code/fhir-dental-de fhir-dental-de-rewrite
cd fhir-dental-de-rewrite
```

### Step 3: Prepare replacement expressions

Create a file `/tmp/replacements.txt` with literal → replacement pairs:

```text
# BEMA display strings (representative examples — expand to full list from 9148aff diff)
"Eingehende Untersuchung"==>"BEMA-01"
"Vitalitätsprüfung"==>"BEMA-07"
"Notfallbehandlung"==>"BEMA-41"
"Lokalanästhesie"==>"BEMA-40"
# BEL-II display strings
"Vollgusskrone NEM"==>"BEL-5010"
"Vollgusskrone NEM mit Schulter"==>"BEL-5011"
"Vollgusskrone Edelmetall"==>"BEL-5020"
# beb97 display strings
"CAD/CAM-Krone NEM"==>"BEB-5015"
"CAD/CAM-Krone Zirkonoxid"==>"BEB-5016"
# ... (complete list extracted from `git show 9148aff -- input/fsh/codesystems/`)
```

> The complete list must be extracted from the diff of commit `9148aff` before execution.

### Step 4: Execute the rewrite

```bash
cd /tmp/fhir-dental-de-rewrite

# Disable the pre-push hook during rewrite (it would reject force-push)
mv .git/hooks/pre-push .git/hooks/pre-push.disabled 2>/dev/null || true

git filter-repo \
  --replace-text /tmp/replacements.txt \
  --path input/fsh/codesystems/BemaCS.fsh \
  --path input/fsh/codesystems/BelIICS.fsh \
  --path input/fsh/codesystems/Beb97CS.fsh \
  --force
```

### Step 5: Verify the rewrite

```bash
# Confirm no copyrighted strings remain in any commit
git log --all -p -- input/fsh/codesystems/BemaCS.fsh \
  input/fsh/codesystems/BelIICS.fsh \
  input/fsh/codesystems/Beb97CS.fsh \
  | grep -E "Eingehende Untersuchung|Vollgusskrone|Vitalitätsprüfung|CAD/CAM-Krone" \
  && echo "FAIL: copyrighted strings still present" \
  || echo "PASS: no copyrighted strings found"
```

### Step 6: Push rewritten history — Git remote

```bash
# Force-push all branches and tags
git remote add origin git@github.com:cognovis/fhir-dental-de.git
git push --force --all origin
git push --force --tags origin
```

### Step 7: Push rewritten history — Dolt remote (beads wrapper mandatory)

```bash
# IMPORTANT: always use bd dolt pull first (Dolt bug dolthub/dolt#10807)
bd dolt pull
bd dolt push --force
```

### Step 8: Update local checkouts

All contributors must re-clone:

```bash
cd ..
rm -rf fhir-dental-de
git clone git@github.com:cognovis/fhir-dental-de.git
```

Or rebase existing clones:

```bash
git fetch origin
git rebase origin/main
```

### Step 9: Re-enable pre-push hook

```bash
# In the new local clone
cp scripts/check-copyright.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push
```

### Step 10: Remove the pre-rewrite backup tag (optional, after verification)

```bash
git push origin --delete backup/pre-history-sanitize
```

---

## Acceptance Verification

After Phase B execution, the following checks must all pass:

1. **No copyrighted strings in any reachable commit:**
   ```bash
   git log --all -p | grep -cE "Eingehende Untersuchung|Vollgusskrone NEM|CAD/CAM-Krone" | grep -q "^0$"
   ```

2. **Working tree matches expected neutralized form** (spot-check):
   ```bash
   grep -n 'display' input/fsh/codesystems/BemaCS.fsh | head -5
   # Expected pattern: display = "BEMA-XX" (not catalog wording)
   ```

3. **Pre-push copyright hook fires correctly on a test commit:**
   ```bash
   echo '* #display = "Eingehende Untersuchung"' >> input/fsh/codesystems/BemaCS.fsh
   git add -p && git commit -m "test" && git push
   # Expected: hook rejects push with copyright warning
   git reset HEAD~1 && git checkout -- input/fsh/codesystems/BemaCS.fsh
   ```

4. **Repository fork count still 0:**
   ```bash
   gh repo view cognovis/fhir-dental-de --json forks --jq '.forks'
   # Expected: 0
   ```

5. **CI passes on the rewritten main:**
   Check GitHub Actions for the forced-push-triggered workflow run.

---

## Consequences

**If Option 2 is approved and executed:**
- All commit SHAs from `9148aff` onward change. Any external reference (CHANGELOG links,
  external issue trackers, CI build logs) to those SHAs will point to objects that no
  longer exist on the default branch.
- CHANGELOG.md entries that reference affected SHAs should be updated to new SHAs or
  removed (minor editorial task, separate commit after rewrite).
- The two open branches (`chore/bump-praxis-0.38.0`, `feat/fhir-dental-de-nfg/cross-repo-cleanup`)
  must be rebased or abandoned after the rewrite.
- Future Git operations (bisect, blame) on the rewritten range will show the sanitized
  content; the original content will no longer be accessible via standard Git commands.

**If Option 1 is chosen (deferred):**
- Legal risk remains. A follow-up ADR will be required if the repository is made public
  or if a beb97 copyright notice is received.

---

## Related

- Bead `fdde-4hj` — original commit introducing copyrighted strings (`9148aff`)
- Bead `fdde-4wi` — neutralization of display strings in working tree (`69ba436`)
- Bead `fdde-b1m` — pre-push copyright guardrail (`scripts/check-copyright.sh`)
- Bead `fdde-4o7` — this ADR (Phase A audit and planning)
- `scripts/copyright-blocklist.txt` — blocklist used by the pre-push hook
- `scripts/check-copyright.sh` — pre-push hook script
- Dolt bug reference: https://github.com/dolthub/dolt/issues/10807
