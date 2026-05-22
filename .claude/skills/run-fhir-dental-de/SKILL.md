---
name: run-fhir-dental-de
description: Build, compile, and smoke-test the German Dental FHIR Implementation Guide (fhir-dental-de). Use when asked to run the build, compile FSH, run sushi, validate the IG, regenerate kbv.basis snapshots, or check that the FHIR profiles still compile cleanly.
---

`fhir-dental-de` is a FHIR R4 Implementation Guide written in **FSH** (FHIR
Shorthand). There is no GUI and no server it starts itself — "running" it means
compiling `input/fsh/**` to FHIR JSON with **SUSHI**, which CI then feeds to the
HL7 IG Publisher. Drive the local build via
`.claude/skills/run-fhir-dental-de/driver.sh`: it prefetches the private
dependency, injects the kbv.basis snapshots SUSHI needs, runs `sushi .`, and
asserts a clean (0-error) build.

All paths below are relative to the repo root (`fhir-dental-de/`).

## Prerequisites (macOS, verified this session)

```bash
brew install openjdk          # keg-only; needed for the FHIR Validator snapshot step
# node (v25 here), jq, and gh were already present:
#   node  — runs `npx fsh-sushi`
#   jq    — used by scripts/prefetch-praxis.sh
#   gh    — auth for the private cognovis/fhir-praxis-de release download
```

SUSHI itself is **not** installed globally — the driver runs it via
`npx --yes fsh-sushi@latest`. Install it (`npm i -g fsh-sushi`) only if you want
the global `sushi` command; the driver prefers it when present.

## Run (agent path) — the driver

```bash
.claude/skills/run-fhir-dental-de/driver.sh
```

What it does, in order:

1. **Prefetch** `de.cognovis.fhir.praxis` into `~/.fhir/packages/` via
   `scripts/prefetch-praxis.sh` (idempotent; pinned to v0.64.0).
2. **Generate kbv.basis snapshots** with `gen-kbv-snapshots.py` (Java FHIR
   Validator). Idempotent — skips in ~0s once the 47 snapshots are present.
3. **`sushi .`** — compile FSH → `fsh-generated/resources/*.json`.
4. **Smoke check** — assert 0 errors, the `fsh-generated/resources/` dir exists,
   and `ImplementationGuide-de.cognovis.fhir.dental.json` was emitted.

Expected tail on success (verified this session):

```
    sushi: 0 errors, 0 warnings
    fsh-generated/resources: 182 JSON files
✓ Build clean: 182 resources, 0 errors, 0 warnings
```

Exit 0 = clean build. Exit 1 = SUSHI errors, a crash, or a missing prerequisite.
SUSHI's own scoreboard reads `19 Profiles · 33 Extensions · 35 ValueSets ·
40 CodeSystems · 59 Instances`. First run ~3–5 min (downloads sushi + FHIR deps +
the ~150MB validator jar); subsequent runs ~6s.

**Iterating on FSH:** after the deps/snapshots exist, re-run with
`SKIP_SNAPSHOTS=1 .claude/skills/run-fhir-dental-de/driver.sh` to skip step 2.
This is the test loop — there is no unit-test layer below SUSHI; a change to a
`.fsh` file is verified by recompiling.

## Human / CI path (not run here)

- **HTML IG:** `./_updatePublisher.sh` then `./_genonce.sh` runs the Java IG
  Publisher locally. CLAUDE.md designates this **CI-only** (`.github/workflows/ig-ci.yml`);
  it's slow (~10 min) and not part of the smoke loop. Not exercised this session.
- **Aidbox `$validate` + httpyac tests** (`test/`, `scripts/test.sh`,
  `docker-compose.yaml`) need **Docker**, which is not installed here — not run.

## Gotchas

- **The snapshot trap.** A bare `sushi .` on a fresh clone fails with **15
  errors**: `... KBV_PR_Base_Datatype_Contactpoint is missing a snapshot.
  Snapshot is required for import.` KBV ships `kbv.basis` *without* snapshots, but
  SUSHI needs them to import any profile/example inheriting from `KBV_PR_Base_*`.
  Step 2 of the driver injects them (it's the local mirror of the CI-only
  composite action `.github/actions/generate-kbv-basis-snapshots/action.yml`).
  If you ever see those 15 errors, you skipped/short-circuited step 2.
- **openjdk is keg-only.** `brew install openjdk` does *not* put `java` on PATH.
  The driver prepends `/opt/homebrew/opt/openjdk/bin` itself; outside the driver,
  `java -version` will say "Unable to locate a Java Runtime" until you add that.
- **The praxis dep can't auto-resolve.** `de.cognovis.fhir.praxis` lives on a
  private registry SUSHI doesn't know about; it's fetched from GitHub Releases by
  `prefetch-praxis.sh` (needs `gh`/network access to `cognovis/fhir-praxis-de`).
  SUSHI pulls every *other* dep (de.basisprofil.r4, kbv.basis, kbv.ita.for,
  de.gematik.fhir.atf, hl7.fhir.uv.tools.r4) from the public FHIR registry.
- **`182` vs `181`.** SUSHI logs "Exported 181 FHIR resources"; the directory
  holds 182 because the generated `ImplementationGuide-*.json` is written
  separately. Both numbers are normal.
- **The skill dir is gitignore-exempted.** `.gitignore` ignores `.claude/*`; an
  `!.claude/skills/` line keeps this skill tracked. Don't drop that line.
- **Committing changes goes through a PR.** `main` is branch-protected
  (`vendor-leak-check` required, no admin bypass). Never direct-push — see
  AGENTS.md / CLAUDE.md for the feature-branch + `gh pr merge` flow.

## Troubleshooting

| Symptom | Fix |
|---|---|
| 15× `... is missing a snapshot. Snapshot is required for import.` | Run the driver **without** `SKIP_SNAPSHOTS=1` so step 2 generates kbv.basis snapshots. |
| `java not found — install with: brew install openjdk` | `brew install openjdk` (keg-only; the driver handles PATH). |
| `prefetch-praxis.sh failed` | Check `gh auth status` and network access to the `cognovis/fhir-praxis-de` GitHub releases. |
| `Failed to download de.cognovis.fhir.praxis` from SUSHI | Same as above — the praxis dep isn't in `~/.fhir/packages/`; let step 1 run. |
| Snapshot step re-downloads the validator every run | It caches at `/tmp/validator_cli.jar`; a cleared `/tmp` forces a re-download (~150MB). |
