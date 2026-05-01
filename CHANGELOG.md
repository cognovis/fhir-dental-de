# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added

- **DentalImagingDiagnosticReportDE** profile for structured dental X-ray and imaging reports (OPG, DVT, EZA) referencing imaging studies and clinical findings.
- **DentalCbctImagingStudyDE** subprofile specializing DentalImagingStudyDE for CBCT/DVT imaging studies.
- **BemaToGozSuggestion** ConceptMap linking BEMA dental billing codes to GOZ fee-schedule suggestions.
- **ProcedureToBemaSuggestion** ConceptMap mapping SNOMED radiology procedures to BEMA first-line billing suggestions.
- **KfoRoentgenLinkFromStudyExt** and **KfoRoentgenLinkFromCarePlanExt** extensions enabling bidirectional linking between KFO care plans and imaging studies.

### Changed

- Updated dependency: `de.cognovis.fhir.praxis` 0.40.3 → 0.43.1 (adds ReportSubstatusCS, ImagingDiagnosticReport pattern).

## [0.25.1] - 2026-04-30

### Bug Fixes

- CI publish pipeline fixes (registry config, dep-version validation step, dist/package path)
- Bump de.cognovis.fhir.praxis pin to 0.43.0

## [0.25.0] - 2026-04-30

### Public Root Release

- Public German Dental FHIR IG release with vendor-neutral canonical URLs.
- Includes copyright and vendor-leak guardrails for future changes.
- Publishes package `de.cognovis.fhir.dental#0.25.0`.
