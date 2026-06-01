# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

## [0.36.2] - 2026-06-01

### Changed

- Re-pin `de.cognovis.fhir.praxis` dependency to **0.75.0** (was 0.74.0) and
  rebuild — keeps dental current with the praxis release.

### Bug Fixes

- **fdde-dc9**: Remove IG-local BEMA and BEL-II CodeSystems; these catalogs are supplied by dedicated KZBV terminology packages.

## [0.36.0] - 2026-05-22

### Bug Fixes

- **clc-8gy**: Explicit empty worktree_bootstrap to prevent legacy .env fallback
- **fdde-o4n**: Address review findings iteration 1

### Features

- **clc-8gy**: Add orchestrator-config.yml for fhir-dental-de
- **clc-8gy**: Add orchestrator-config.yml (dev_server concurrency key rename)
- **clc-8gy**: Note no worktree_bootstrap needed (shared Aidbox)

### Miscellaneous

- **fdde-o4n**: Pin de.cognovis.fhir.praxis to 0.64.0
- **fdde-o4n**: Add changelog entry for praxis 0.64.0 pin
- **fdde-je1**: Pin de.cognovis.fhir.praxis to 0.66.1 and align private preload versions for release

## [0.35.0] - 2026-05-17

### Bug Fixes

- **ci**: Pre-load kbv.mio.impfpass.vocab@1.1.0-cognovis.1 from Verdaccio + show full SUSHI errors
- **ci**: Generate KBV Basis snapshots in CI (KBV publishes without snapshots)
- **ci**: Run snapshot generation before SUSHI in ig-release.yml

### Documentation

- **agents**: VS Code troubleshooting for gitignored .beads/issues.jsonl
- **fdde-qhy**: Reference cognovis-core ICD coding anchors standard

### Miscellaneous

- **beads**: Disable export.auto + import.auto — bd dolt is the only sync path
- **deps**: Bump fhir-praxis-de 0.61.0 → 0.62.1
- **release**: Bump to v0.35.0

### Merge

- Ci-fix-praxis-deps (kbv.mio.impfpass.vocab preload + SUSHI error visibility)
- Ci-snapshot-fix (generate-kbv-basis-snapshots composite action)

## [0.34.0] - 2026-05-12

### Features

- **fdde-8vf**: USt-Modellierung in dental ChargeItems via praxis@0.61.0 Tax-Pattern (v0.34.0)

### Merge

- Worktree-bead-fdde-8vf (USt-Modellierung in dental ChargeItems, v0.34.0)

## [0.33.0] - 2026-05-12

### Features

- **fdde-0pf**: Mark Verlangensleistung per § 1 Abs. 2 Satz 2 GOZ (v0.33.0)

### Merge

- Worktree-bead-fdde-0pf (Verlangensleistung-Markierung, v0.33.0)

## [0.32.0] - 2026-05-12

### Documentation

- Tag DentalBefundStatusCS as draft + add ADR-004 companion handover

### Features

- **fdde-n4q**: Migrate BemaChargeItemDE + GozChargeItemDE to ChargeItemPraxisDe parent (v0.32.0)

### Miscellaneous

- Remove ADR-004-companion-handover from public repo + gitignore it

### Merge

- Worktree-bead-fdde-n4q (ChargeItem -> ChargeItemPraxisDe migration, v0.32.0)

## [0.31.0] - 2026-05-12

### Bug Fixes

- **fdde-pax.2**: Address review findings iteration 1 — remove fabricated KZVSNR code, fix audit doc, CI fallback comment
- **fdde-pax.2**: Address codex adversarial findings — add identifier type discriminators to examples, fix changelog

### Documentation

- **fdde-ktj**: Add internal delegation matrix for PA-Befunde
- Document beads onboarding and JSONL-based sync workflow
- Clarify ZeBefundkuerzelCS + ZeTherapiekuerzelCS are cognovis-extended (not official KZBV DPF)

### Features

- **fdde-pax.2**: Migrate DentalConditionDE + DentalOrganizationDE to Praxis*DE parents (praxis@0.61.0)

### Miscellaneous

- Track .beads/ database for collaborator visibility
- **beads**: Rework PSI/FMPS beads after ProphylaxisObservation review
- **beads**: Add dental-finding specialization gaps from DGZMK leitlinien
- **beads**: Add GOZ § 2 / § 10 / Verlangensleistung / USt beads
- **beads**: Add DentalConditionDE modeling and compliance gaps
- **beads**: Add ZE Mischrechnung beads (BEMA/GOZ/Festzuschuss/ZZV)
- **beads**: Add tax compliance beads (Trennungsprinzip / § 19 / Abfärbung)
- **beads**: Migrate cross-IG concerns to praxis-de + add KBV-inheritance epic
- **beads**: Switch to Dolt-primary sync, gitignore JSONL exports
- Commit generated files before bead merge (worktree-bead-fdde-pax.2)

### Refactoring

- Slim ze-befund/therapiekuerzel to cognovis-internal-only + extensible binding

### Bd

- Update sync.remote

### Merge

- Worktree-bead-fdde-pax.2

## [0.30.0] - 2026-05-04

### Documentation

- **fdde-4qi**: Add changelog entry for ig-release.yml private package pre-load fix
- **fdde-9ah**: Add changelog entry for composite action extraction

### Miscellaneous

- **fdde-9ah**: Extract private FHIR preload into composite action
- Bump de.cognovis.fhir.praxis to 0.48.0 and release 0.30.0

## [0.29.1] - 2026-05-03

### Bug Fixes

- **fdde-o84**: Correct BEMA-Z mapping numbers from official 2026 catalog
- **fdde-4qi**: Add private FHIR package pre-load to ig-release.yml

### Documentation

- **fdde-o84**: Update changelog for BEMA-Z surgical codes refactor

### Miscellaneous

- **fdde-o84**: Pre-merge changelog update from second merge step
- **fdde-o84**: Bump version to 0.29.1

### Refactoring

- **fdde-o84**: Expand BemaCS surgical codes comment with BEMA-Z mapping hints

### Merge

- Worktree-bead-fdde-o84

## [0.29.0] - 2026-05-02

### Bug Fixes

- **fdde-wzv**: Add copyright-allowlist markers to BemaCS display texts

### Documentation

- **fdde-a5j**: Document pre-push copyright hook setup in CLAUDE.md

### Miscellaneous

- **deps**: Bump de.cognovis.fhir.praxis to 0.45.1
- **fdde-a5j**: Add changelog entry for pre-push copyright hook documentation
- **fdde-a5j**: Bump version to 0.29.0 and update changelog

### Merge

- Resolve CHANGELOG conflict from concurrent worktree sessions
- Worktree-bead-fdde-511
- Worktree-bead-fdde-a5j
- Worktree-bead-fdde-a5j

## [0.28.0] - 2026-05-02

### Miscellaneous

- Bump version to 0.28.0

### Merge

- Origin/main into worktree-bead-fdde-fi9 (resolve CHANGELOG conflict)
- Worktree-bead-fdde-fi9

## [0.27.1] - 2026-05-02

### Bug Fixes

- **ci**: Vendor de.cognovis.terminology.imaging for CI FHIR cache
- **ci**: Fetch terminology.imaging from Verdaccio with VERDACCIO_TOKEN
- **fdde-511**: Address review findings — correct BemaCS descriptions from BEMA-Z catalog
- **fdde-511**: Address codex adversarial findings — correct BEMA descriptions from catalog
- **fdde-fi9**: Address review findings iteration 1 — R4 equivalence terminology in comments
- **fdde-r8r**: Correct equivalence comment from relatedto to equivalent in DVT/GOZ test

### Features

- **fdde-511**: Add meaningful descriptions to BemaCS and GozCS CodeSystems
- **fdde-fi9**: Green — document ConceptMap $translate test setup and add DICOM test file

### Miscellaneous

- **fdde-511**: Update changelog for BemaCS/GozCS description refactor
- Update changelog for fdde-r8r fix
- Bump version to 0.27.1

### Merge

- Worktree-bead-fdde-r8r

### Test

- **fdde-fi9**: Red — add httpyac $translate tests for DicomModalityToBemaSuggestion
- **fdde-fi9**: Add httpyac integration tests for ConceptMap $translate against live Aidbox

## [0.27.0] - 2026-05-02

### Bug Fixes

- **fdde-6rt**: Address review findings iteration 1
- **fdde-6rt**: Address codex adversarial findings
- **fdde-6rt**: Remove vendor string references from ConceptMap

### Documentation

- **fdde-4kk**: Add changelog entry for DicomModalityToBemaSuggestion ConceptMap
- **fdde-6rt**: Add changelog entry for SidexisLogicalNameToBemaGoz ConceptMap

### Features

- **fdde-4kk**: Add DicomModalityToBemaSuggestion ConceptMap and DX example
- **fdde-6rt**: Green — SidexisLogicalNameToBemaGoz ConceptMap + RadiationRelevantBillingCodeVS + SidexisLogicalNameCS
- **fdde-6rt**: Add SidexisLogicalNameToBemaGoz ConceptMap

### Miscellaneous

- **fdde-4kk**: Session close — DicomModalityToBemaSuggestion ConceptMap
- Bump version to 0.27.0

### Merge

- Worktree-bead-fdde-4kk
- Worktree-bead-fdde-6rt

### Test

- **fdde-6rt**: Red — stub FSH and test files for Sidexis ConceptMap

## [0.26.0] - 2026-05-01

### Bug Fixes

- **fdde-qzb**: Address review findings iteration 1

### Documentation

- Add Unreleased section for fdde-qzb imaging profile additions
- **fdde-qzb**: Update CHANGELOG with Unreleased section for imaging profile + ConceptMaps

### Features

- **fdde-qzb**: Add DentalImagingDiagnosticReportDE, BemaToGozSuggestion, ProcedureToBemaSuggestion, KfoRoentgenLink

### Miscellaneous

- **fdde-qzb**: Update praxis dep 0.41.1 → 0.43.1, remove duplicate ReportSubstatus from dental IG
- **fdde-qzb**: Update changelog via git-cliff
- Bump version to 0.26.0

## [0.25.1] - 2026-05-01

### Bug Fixes

- **fdde-2fg**: CI registry config and dep-version validation step
- **fdde-2fg**: Correct dist/package/package.json path in validation step
- **fdde-2fg**: Merge CI publish pipeline fixes into main

### Miscellaneous

- Bump de.cognovis.fhir.praxis pin to 0.43.0
- Bump version to 0.25.1

## [0.25.0] - 2026-04-30

### Miscellaneous

- Public root release 0.25.0
