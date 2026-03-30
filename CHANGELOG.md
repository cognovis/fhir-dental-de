# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### Bug Fixes

- Sync sushi-config.yaml version to 0.3.0 (matches VERSION file)

### CI/CD

- Resolve praxis dependency from GitHub Release + auto-release on push
- Use IG Publisher output for release package (includes snapshots)
- Fix multi-asset download — use last (newest) asset from release

## [0.3.0] - 2026-03-30

### Bug Fixes

- Correct version to SemVer 0.3.0 (not CalVer)

### Features

- Import AbrechnungsquartalExt + ScheintypExt from praxis-de, remove local duplicates

### Miscellaneous

- Use praxis-de current version for local dev dependency
- Update changelog
- Bump version to 2026.03.5

### Merge

- Feat/fhir-dental-de-nfg/cross-repo-cleanup

## [0.2.0] - 2026-03-30

### Features

- Add build-package.sh for FHIR npm package generation
- CI/CD auto-release — tag v* triggers SUSHI + npm pack + GitHub Release with tgz
- Add PeriodontalObservationDE and ProphylaxisObservationDE profiles

### Miscellaneous

- Bump version to 2026.03.4
- Switch to SemVer, VERSION file as single source of truth
- Update changelog

### Merge

- Feat/fhir-dental-de-axv/observation-profiles-and-semver

## [2026.03.4] - 2026-03-29

### Bug Fixes

- **fhir-dental-de-p1o**: Wire P2 extensions and add account to ChargeItem profiles
- **fhir-dental-de-edf**: Bind type to ScheintypVS, remove redundant ScheintypExt
- **fhir-dental-de-0zp**: Address review findings in ImagingStudy and ClinicalImpression
- **fhir-dental-de-tkw**: Address review findings in example instances
- **fhir-dental-de-5j0**: Address review findings in ATF profile and example

### CI/CD

- Add IG Publisher build + GitHub Pages deployment

### Documentation

- Add international interoperability page (HL7 Dental Data Exchange IG comparison)

### Features

- **fhir-dental-de-p1o**: Add BemaChargeItemDE + GozChargeItemDE profiles
- **fhir-dental-de-3yr**: P2-Extensions Billing, KFO, PAR, Labor, ZE
- **fhir-dental-de-edf**: Add DentalEncounterDE profile for SWS Satzart 2
- **fhir-dental-de-0zp**: Add ClinicalImpression, ImagingStudy, ServiceRequest, Organization profiles
- **fhir-dental-de-tkw**: Add FSH example instances for all 15 profiles
- Add IG Publisher build infrastructure and page content
- **fhir-dental-de-5j0**: ATF-Transport-Profil für Dental-Befundübermittlung

### Miscellaneous

- Add CHANGELOG, cliff.toml, and update .gitignore

## [2026.03.3] - 2026-03-29

### Miscellaneous

- Bump version to 2026.03.2
- Bump version to 2026.03.3

### Merge

- Worktree-bead-fhir-dental-de-8ay

## [2026.03.2] - 2026-03-29

### Bug Fixes

- **fhir-dental-de-8ay**: Address review findings iteration 2
- **fhir-dental-de-8ay**: Address review findings iteration 1
- **fhir-dental-de-4hj**: Address review findings iteration 1 - fix duplicates, expand code counts
- **fhir-dental-de-4hj**: Address review findings iteration 2 - remove duplicates, expand BEMA/BEL-II/beb97
- **fhir-dental-de-4hj**: Remove fabricated/non-standard BEMA codes, keep only official positions

### Features

- **fhir-dental-de-8ay**: Add P1-Extensions FDI, Zahnflächen, Befundklasse, HKP-Genehmigung
- **fhir-dental-de-8ay**: Add P1-Extensions FDI, Zahnflächen, Befundklasse, HKP-Genehmigung
- **fhir-dental-de-4hj**: Add complete CodeSystems for BEMA, GOZ, GOÄ-Zahn, BEL-II, beb97, KZV, Zahnflächen, ZE-Kürzel

### Miscellaneous

- Bump version to 2026.03.1
- Ignore Claude session logs directory
- Ignore Claude session logs directory

### Merge

- Worktree-bead-fhir-dental-de-4hj

## [2026.03.1] - 2026-03-29

### Miscellaneous

- Bump version to 2026.03.0

### Merge

- Worktree-bead-fhir-dental-de-82a

## [2026.03.0] - 2026-03-29

### Bug Fixes

- **fhir-dental-de-82a**: Address review findings iteration 1
- **fhir-dental-de-82a**: Address review findings iteration 2
- **fhir-dental-de-o4t**: Remove conflicting code binding, rely on KBV parent slice

### Documentation

- **fhir-dental-de-82a**: Add SWS 2.0 mapping documentation chapter

### Features

- Initial German Dental FHIR profiles (R4)
- **fhir-dental-de-o4t**: Activate KBV dependencies, use KBV_PR_Base_Condition_Diagnosis and KBV_PR_FOR_Patient

### Merge

- Worktree-bead-fhir-dental-de-o4t


