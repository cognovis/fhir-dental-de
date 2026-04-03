# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### Bug Fixes

- **fdde-0wc**: Fix display names, ex-tooth URL, obs-7 constraint, and IG parameters
- **fdde-0wc**: Document display name rationale and obs-7 code change
- **fdde-0wc**: Add obs-7 rationale comment to AtfBundle example
- **fdde-0wc**: Obs-7 fix in ExamplePeriodontalObservation, add hl7 tools comment

## [0.8.0] - 2026-04-03

### Bug Fixes

- **fdde-rcf**: Address review findings iteration 1
- **fdde-rcf**: Address review findings iteration 2
- **fdde-rcf**: Address cmux review panel findings iteration 1

### Features

- **fdde-rcf**: Add missing FSH example instances for referenced resources

### Miscellaneous

- Bump version to 0.7.0
- Update changelog
- Bump version to 0.8.0

### Merge

- Worktree-bead-fdde-rcf

## [0.7.0] - 2026-04-03

### Features

- **fdde-j3p**: Set status active and releaseLabel trial-use for registry submission

### Miscellaneous

- Bump version to 0.6.1
- Update changelog

### Merge

- Worktree-bead-fdde-j3p

## [0.6.1] - 2026-04-03

### Bug Fixes

- **fdde-ea2**: Resolve IG Publisher warnings — experimental alignment, suppressions
- **fdde-ea2**: Address review findings iteration 1 — narrow ignoreWarnings suppressions
- **fdde-ea2**: Address review findings iteration 1 — org type bus, narrow suppressions, remove future clause

### Miscellaneous

- Bump version to 0.6.0
- Update changelog

### Merge

- Worktree-bead-fdde-ea2

## [0.6.0] - 2026-04-03

### Bug Fixes

- **fdde-as8**: Address review findings iteration 1
- **fdde-as8**: Correct Communication sender to role-uselmann-plaerrer per MIRA seed

### Features

- **fdde-as8**: Align all 20 examples with MIRA seed data patterns

### Miscellaneous

- Bump version to 0.5.1
- Switch beads to embedded Dolt mode for worktree compatibility
- Revert to shared-server Dolt mode (worktrees need shared DB access)
- Use shared-server Dolt mode (required for worktree bead access)
- Update changelog

### Merge

- Worktree-bead-fdde-as8

## [0.5.1] - 2026-04-03

### Bug Fixes

- **fdde-9e6**: Fix all 37 IG Publisher validation errors
- **fdde-9e6**: Address review findings iteration 1
- **fdde-9e6**: Address review findings iteration 2
- **fdde-9e6**: Use $icd10gm alias in ExampleParCarePlan (consistency)

### Miscellaneous

- Update changelog

### Merge

- Worktree-bead-fdde-9e6

## [0.5.0] - 2026-04-03

### Features

- Add ex-tooth CodeSystem + dental-finding examples, update test suite

### Miscellaneous

- Bump version to 0.4.0
- **deps**: Upgrade de.basisprofil.r4 1.5.0 → 1.6.0-ballot2, kbv.basis 1.7.0 → 1.8.0
- Update changelog
- Bump version to 0.5.0

## [0.4.0] - 2026-04-02

### Bug Fixes

- Strip internal praxis dependency from release tgz

### Miscellaneous

- Bump version to 0.3.1
- Update changelog

### Test

- Add Aidbox test suite (66 httpyac files) + decouple profiles from KBV

## [0.3.1] - 2026-03-30

### Bug Fixes

- Sync sushi-config.yaml version to 0.3.0 (matches VERSION file)

### CI/CD

- Resolve praxis dependency from GitHub Release + auto-release on push
- Use IG Publisher output for release package (includes snapshots)
- Fix multi-asset download — use last (newest) asset from release

### Miscellaneous

- Update changelog

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

- Switch to SemVer, VERSION file as single source of truth
- Update changelog

### Merge

- Feat/fhir-dental-de-axv/observation-profiles-and-semver

## [0.1.0] - 2026-03-29

### Miscellaneous

- Bump version to 2026.03.4

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


