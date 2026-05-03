# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### Bug Fixes

- **fdde-4qi**: Fix ig-release.yml missing private FHIR package pre-load; unblocks releases from v0.26.0+ (all green on CI run 25279193047, de.cognovis.fhir.dental@0.29.1 live on npm.cognovis.de)
- **fdde-wzv**: Add copyright-allowlist markers to BemaCS display texts
- **fdde-o84**: Correct BEMA-Z mapping numbers from official 2026 catalog

### Documentation

- **fdde-o84**: Add BEMA-Z mapping hints to BemaCS surgical code comments for clarity
- **fdde-a5j**: Document pre-push copyright hook setup in CLAUDE.md

### Miscellaneous

- **fdde-9ah**: Extract private FHIR package preload into composite GitHub Action; replace 38-line duplicated inline step in ig-ci.yml and ig-release.yml with 3-line uses: reference (76 lines removed, structural parity enforced)
- **deps**: Bump de.cognovis.fhir.praxis to 0.45.1
- **fdde-a5j**: Add changelog entry for pre-push copyright hook documentation

### Refactoring

- **fdde-o84**: Expand BemaCS surgical codes comment with BEMA-Z mapping hints

### Merge

- Resolve CHANGELOG conflict from concurrent worktree sessions
- Worktree-bead-fdde-511

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


