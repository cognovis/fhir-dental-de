# fhir-dental-de — German Dental FHIR Profiles (R4)

## Session Start

Always load these skills at the beginning of every session:

- `/samurai-skills:aidbox-ig-development` — FHIR IG development lifecycle (install, test, validate, publish)
- `/samurai-skills:aidbox` — Aidbox FHIR platform (REST API, search, validation, terminology)

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
