# German Dental FHIR Profiles (R4)

FHIR R4 Implementation Guide for German dental practice data.

## Scope

Profiles, CodeSystems, and ValueSets for:
- **DentalProcedureDE** — dental procedures with BEMA/GOZ billing codes
- **DentalConditionDE** — dental conditions with ICD-10-GM and FDI tooth identification
- **DentalFindingDE** — clinical findings (Zahnschema, periodontal indices)
- **DentalCommunicationDE** — clinical communication and instructions

## Design Principles

- Based on **German base profiles** (`de.basisprofil.r4`, KBV) — not US Core
- Tooth numbering uses **FDI/ISO 3950** (FHIR's native system)
- Procedure codes bind to **BEMA** (GKV) and **GOZ** (PKV) — not CDT
- Diagnoses use **ICD-10-GM** — not ICD-10-CM
- Inspired by [HL7 Dental Data Exchange IG v2.0.0](https://build.fhir.org/ig/HL7/dental-data-exchange/) but adapted for the German healthcare system

## Build

```bash
npm install -g fsh-sushi
sushi .
```

## License Guardrails

To prevent accidental reintroduction of copyrighted catalog texts (KZBV BEMA, BEL II, beb'97),
this repo runs an automated copyright check on every push and PR.

### Local Setup

After cloning, install the pre-push hook so the copyright check runs locally before every push:

```bash
bd hooks install
```

### How it works

- `scripts/copyright-blocklist.txt` — list of blocked phrases with source references (133 BEMA + 193 BEL II + 201 beb'97 entries)
- `scripts/check-copyright.sh` — check script (runs locally via pre-push hook and in CI)
- `.github/workflows/copyright-check.yml` — CI job (blocking, no `--warn-only`)

### Adding a new blocked pattern

Add a line to `scripts/copyright-blocklist.txt`:

```
Mein geschützter Text|SOURCE-REFERENCE
```

### Allowlisting a legitimate mention

Option 1 — Path-based: files in `docs/`, `test/`, `.github/` are not scanned.

Option 2 — Inline marker: add `# copyright-allowlist: <reason>` at the end of the line:

```fsh
* #01 "Eingehende Untersuchung"  # copyright-allowlist: example in ADR discussion
```

### Bypassing (emergency only)

```bash
SKIP_COPYRIGHT_CHECK=1 git push
# or
git push --no-verify  # also skips sushi check — prefer the env var
```

Always document bypasses in the PR description.

## License

CC-BY-4.0 — see [LICENSE](LICENSE)
