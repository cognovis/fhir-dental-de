# fhir-dental-de — German Dental FHIR Profiles (R4)

## Session Start

Always load these skills at the beginning of every session:

- `/aidbox-ig-development` - FHIR IG development lifecycle (install, test, validate, publish)
- `/aidbox` - Aidbox FHIR platform (REST API, search, validation, terminology)
- `/aidbox-sql-on-fhir` - SQL on FHIR, ViewDefinitions, $materialize
- `/hs-search` - Search health-samurai.io docs, blog, examples
- `/atomic-generate-types` - FHIR type generation with @atomic-ehr/codegen
- `/fhir-validation` - FHIR Schema, $validate responses, and OperationOutcome debugging
- `/fhir-publish-ig` - trusted preflight, release tag handoff, and publish/watch workflows
- `/fhir-sync-versions` - downstream fhir-* version pin reconciliation

## Overview

FHIR R4 Implementation Guide for German dental practice — procedures (BEMA/GOZ),
conditions (ICD-10-GM), findings (Zahnschema/FDI), communication, and care plans
(HKP, KFO, PAR, ZE). Depends on fhir-praxis-de for shared extensions.

- **Package ID:** `de.cognovis.fhir.dental`
- **Canonical:** `https://fhir.cognovis.de/dental`
- **Published IG:** https://cognovis.github.io/fhir-dental-de/
- **QA Report:** https://cognovis.github.io/fhir-dental-de/qa.html
- **Dependency:** `de.cognovis.fhir.praxis` (loaded at build time from GitHub Release)

## Build

```bash
sushi .                    # Compile FSH → FHIR JSON
# IG Publisher runs in CI (GitHub Actions), not locally
```

## Branch Protection & Merge Workflow

`main` is protected. **Direct push is blocked.** All changes flow through pull requests.

### Branch-protection settings (`cognovis/fhir-dental-de`, `main`)

- `required_status_checks: ["check"]` — the `vendor-leak-check` workflow (`.github/workflows/vendor-leak-check.yml`) must pass before merge
- `enforce_admins: true` — repo admins (including the owner) cannot bypass the protection
- `allow_force_pushes: false` — no force-push to main outside temporary, audited rewrite windows
- `allow_deletions: false` — main cannot be deleted

### Vendor leak policy — **HARD FAIL, no bypass**

The `vendor-leak-check / check` workflow runs `scripts/vendor-leak-guard.sh`. The script scans `input/fsh/`, `input/pagecontent/`, `test/Profile/` (and other configured paths) for third-party PVS vendor names and cognovis-internal project codenames.

**A vendor-leak finding on any PR fails the check, which blocks the merge.** There is no override path:

- `SKIP_SUSHI_CHECK=1`, `SKIP_COPYRIGHT_CHECK=1`, `SKIP_VENDOR_LEAK_CHECK=1`, and `git push --no-verify` only suppress the LOCAL pre-push hook — they do not reach the server-side workflow.
- Admin bypass is disabled (`enforce_admins: true`).
- The branch protection rule cannot be temporarily relaxed without going through the documented rewrite-window procedure, which is reserved for coordinated history rewrites (see `fhir-term-ikl` in fhir-terminology-de), not for routine merges.

If the check fails on your PR:

1. Read the failure output and identify the leaked term and file.
2. **Fix** the leak in your branch — rename, redact, or move the reference out of the scanned scope per the guard's `SCAN_DIRS` list.
3. Push a new commit to the feature branch; CI re-runs automatically.
4. If the failure represents a **legitimate** reference that the guard should not catch (e.g. a new exempt path or a term that genuinely belongs on a public IG surface), open a **separate** PR that updates `scripts/vendor-leak-guard.sh` with rationale. Get that PR merged first, then rebase your original PR.

This policy exists because vendor leaks have happened before and required remediation commits on main (see the April 2026 `fdde-yb6` "vendor-clear" cleanup that renamed `de-platform-*` profile IDs and removed Pvs/Pvs references). The cost of one fix-forward commit is small; the cost of vendor refs sitting in published IG surfaces and indexed history is high.

### Standard PR workflow

**Self-merge is allowed and intended.** No human reviewer is required by branch protection (`required_pull_request_reviews: null`). The PR flow exists to gate on **CI checks**, not on human approval. The same person (or agent) creates the PR, waits for green CI, and runs `gh pr merge` — all in the same session. Total latency: ~30–90 seconds for CI, no human bottleneck.

```bash
git pull --rebase origin main
git checkout -b <feature-branch>
# ... make changes ...
git commit -m "..."
git push -u origin <feature-branch>
gh pr create --base main --head <feature-branch> --title "..." --body "..."
gh pr checks --watch                              # wait for vendor-leak-check + other required checks
gh pr merge <pr-number> --merge --delete-branch   # merges once all required checks are green
```

`bd dolt push` still goes direct to the Dolt remote — beads are not subject to git branch protection.

## Local Testing with Aidbox

Uses the local Aidbox instance on localhost:8080.
After IG migration: fresh Aidbox with strict validation enabled globally.
Use `$validate` with an explicit profile parameter.
**Important:** Always install fhir-praxis-de IG first (dependency).

### IG Testing

All IG testing (install, test-cs, test-vs, test-profile, review-qa) is handled by the global `/aidbox` skill (`references/ig-testing.md`).
Always invoke `/aidbox` before manually curl-debugging — it contains learnings that prevent common errors.

### ConceptMap $translate Tests

Integration tests for ConceptMap $translate operations live in `test/CM/`.

**Prerequisites:**
1. Aidbox running at localhost:8080 (see docker-compose.yaml)
2. Run SUSHI: `npx sushi .` (generates `fsh-generated/resources/`)
3. Upload ConceptMaps to Aidbox:
   ```bash
   curl -s -u basic:secret -X PUT "http://localhost:8080/fhir/ConceptMap/DicomModalityToBemaSuggestion" \
     -H "Content-Type: application/fhir+json" \
     -d @fsh-generated/resources/ConceptMap-DicomModalityToBemaSuggestion.json
   curl -s -u basic:secret -X PUT "http://localhost:8080/fhir/ConceptMap/SidexisLogicalNameToBemaGoz" \
     -H "Content-Type: application/fhir+json" \
     -d @fsh-generated/resources/ConceptMap-SidexisLogicalNameToBemaGoz.json
   ```
4. Run tests:
   ```bash
   httpyac run test/CM/dicom-modality-to-bema-suggestion.http --all
   httpyac run test/CM/sidexis-logical-name-to-bema-goz.http --all
   ```

**Note:** The `basic` client (`basic:secret`) must be registered in Aidbox with `grant_types: ["basic"]` and an allow-all AccessPolicy. This is handled by `init-bundle.json` when running the project-local docker-compose. If using a shared Aidbox instance, register the client manually or use Bearer token auth.

**ConceptMaps tested:**
- `dicom-modality-to-bema-suggestion.http` — 5 DICOM modality → BEMA mappings (DX, IO, PX, CT, RG)
- `sidexis-logical-name-to-bema-goz.http` — 8 Sidexis → BEMA+GOZ mappings (DVT, OPG, Ceph, Intraoral)

### Aidbox Access

- **URL:** http://localhost:8080
- **FHIR Base:** http://localhost:8080/fhir
- **Auth:** `Basic basic:secret`
- **Admin Auth:** Use local environment variables or a private env file outside this repository
- **Validation:** `POST /fhir/{ResourceType}/$validate`
- **ValueSet Expand:** `GET /fhir/ValueSet/$expand?url=...`

## Conventions

- All profiles are written in FSH (FHIR Shorthand) in `input/fsh/`
- Generated JSON goes to `fsh-generated/` (by SUSHI) and `output/` (by IG Publisher)
- Do NOT edit files in `fsh-generated/` or `output/` — they are auto-generated
- Test files use `.http` format (httpyac compatible)
- On test errors: report first, don't auto-fix immediately

## ICD Coding Anchors (GM vs CM vs ICD-11)

When binding ConditionDE or related profiles to ICD codes, follow
`cognovis-core/standards/healthcare/icd-coding-anchors.md` — verify against
ICD-10-GM (BfArM) before use, treat F-/G-/R-chapter codes as high-risk for
ICD-10-CM contamination, and apply the ICD-11-as-clinical-anchor /
ICD-10-GM-as-billing-bridge hybrid when ICD-10-GM is too coarse or missing.
Auto-loaded via standards triggers (`ICD-10`, `ICD-11`, `BfArM`,
`rechtfertigende Indikation`, ...).

## License Guardrails

The pre-push hook blocks accidental commits of copyrighted KZBV/BEB catalog texts (BEMA, BEL II, beb'97).

**Fresh clone setup:** run `bd hooks install` to install the pre-push hook locally.

**Bypass (emergency only):** `SKIP_COPYRIGHT_CHECK=1 git push`

See `scripts/check-copyright.sh` and the README "License Guardrails" section for full details on the blocklist, allowlist marker (`# copyright-allowlist: <reason>`), and CI workflow.
