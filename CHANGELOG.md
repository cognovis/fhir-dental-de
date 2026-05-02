# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### Bug Fixes

- **ci**: Vendor de.cognovis.terminology.imaging for CI FHIR cache
- **ci**: Fetch terminology.imaging from Verdaccio with VERDACCIO_TOKEN
- **fdde-fi9**: Address review findings iteration 1 — R4 equivalence terminology in comments
- **fdde-r8r**: Correct equivalence comment from relatedto to equivalent in DVT/GOZ test

### Features

- **fdde-fi9**: Green — document ConceptMap $translate test setup and add DICOM test file

### Test

- **fdde-fi9**: Red — add httpyac $translate tests for DicomModalityToBemaSuggestion

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


