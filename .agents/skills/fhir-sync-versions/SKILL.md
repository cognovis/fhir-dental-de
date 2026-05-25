---
name: fhir-sync-versions
description: >-
  Reconcile fhir-* version pins across all locally-checked-out repos. Use when bumping a FHIR
  package version, after a publish, or when sushi-config.yaml or bundle package.json pins are
  out of sync. Triggers: /fhir-sync-versions, fhir version sync, reconcile fhir pins, sync fhir versions.
  NOT for SemVer bump decisions or running publish.sh.
---

# fhir-sync-versions

Reconcile fhir-* version pins across all locally-checked-out repos against the `fhir-versions.lock.yaml` manifest.

## Usage

```bash
python3 skills/fhir-sync-versions/scripts/sync.py [--dry-run] [--apply] [--manifest PATH] [--registry URL]
```

Run from the fhir-terminology-de repo root.

**Modes:**
- `--dry-run` (default): show drift table only, no file edits
- `--apply`: apply all edits and run the drift guard (`scripts/check-fhir-version-drift.sh`)

## What it does

1. Reads `fhir-versions.lock.yaml` from the fhir-terminology-de repo (searches CWD + parent dirs)
2. Queries `npm.cognovis.de` dist-tags for registry latest (requires `NODE_AUTH_TOKEN` or `~/.npmrc`)
3. Walks consumer files:
   - `~/code/fhir-praxis-de/sushi-config.yaml` — SUSHI IG, `dependencies:` section
   - `~/code/fhir-dental-de/sushi-config.yaml` — SUSHI IG, `dependencies:` section
   - `~/code/fhir-deidentification-de/sushi-config.yaml` — SUSHI IG, `dependencies:` section
   - `./packages/*/package.json` in the fhir-terminology-de repo — bundle `dependencies:`
   - `~/code/polaris/**/package.json` and `~/code/mira/**/package.json` — package pins in `dependencies`, `devDependencies`, `peerDependencies`, `optionalDependencies`, `overrides`, and `resolutions`
   - Generated/install directories are skipped: `.claude`, `.codegen-cache`, `.git`, `.next`, `dist`, `node_modules`, and similar build/cache folders
4. Checks Polaris `@polaris/fhir-de` generated provenance:
   - `~/code/polaris/packages/fhir-de/generated/**/*.ts` — `pkg: package#version` comments from `@atomic-ehr/codegen`
   - `~/code/polaris/packages/fhir-de/src/client/generated/*.ts` — `Source: package@version` comments from de-identification codegen
5. Computes transitive closure of drifted pins (manifest vs actual)
6. In `--apply` mode: edits structured pins and runs `scripts/check-fhir-version-drift.sh`; generated SDK drift remains `REGENERATE`
7. Reports packages where registry latest < manifest version (unpublished)

When a local SUSHI IG is not listed in `fhir-versions.lock.yaml`, its own top-level
`id`/`version` is treated as the expected version for downstream package.json
consumers. This lets `io.cognovis.de-identification.de` flow into Polaris without
requiring it to be owned by the fhir-terminology-de lock manifest.

## Out of Scope

- Does not make SemVer bump decisions (bump tier = MAJOR/MINOR/PATCH is caller's responsibility)
- Does not run `publish.sh` or push to the registry
- Does not edit `fhir-versions.lock.yaml` directly (the manifest; update it manually for MANIFEST-BEHIND items)
- Does not modify an IG's own top-level `version:` field — when the checkout is ahead of the manifest (`MANIFEST-BEHIND`), the user must update the manifest
- Does not rewrite package specs that are not direct version pins, such as `file:`, `workspace:`, Git, or URL dependencies
- Does not regenerate Polaris SDK files; `REGENERATE` rows mean run the Polaris generation command after updating pins

## Outputs

**Drift table** (columns: file | package | current | expected | action):
```
FILE                                      PACKAGE                        CURRENT   EXPECTED  ACTION
~/code/fhir-dental-de/sushi-config.yaml  de.cognovis.fhir.praxis        0.64.0    0.66.0    UPDATE
~/code/polaris/packages/fhir-de/generated de.cognovis.fhir.dental       0.30.0    0.35.0    REGENERATE
...
```

**Unpublished report**: packages not yet at their manifest version in the registry.

**Regeneration follow-up**: when `REGENERATE` rows exist, the script prints a
separate suggestion to create a Polaris bead/workstream, update pins, regenerate
`@polaris/fhir-de`, fix generation/type/test issues, run checks, commit, merge or
rebase, push beads data, and `git push`.
