# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### Bug Fixes

- Revert praxis dependency 0.40.3 → 0.38.0 (package not yet published)
- **deps**: Re-bump praxis 0.38.0 → 0.40.3 with local prefetch helper

### Features

- **fdde-zof**: Add PABefundType CodeSystem and update PeriodontalFindingCodesVS
- **fdde-3q3**: Add KfoDiagnoseRegion CodeSystem for kfo-diagnose-region

## [0.19.0] - 2026-04-27

### Features

- **fdde-rrl**: Add ZeVersorgungsteilCS and FestzuschussBefundCS CodeSystems

### Miscellaneous

- Bump de.cognovis.fhir.praxis 0.38.0 → 0.40.3
- Bump version to 0.19.0

## [0.18.0] - 2026-04-26

### Features

- **scripts**: Add pre-push sushi build check

### Miscellaneous

- Update repository_dispatch target mira-adapters → polaris
- **fdde-qzb**: Add dental imaging epic — DentalImagingDiagnosticReport, BemaGozMapping, reuse praxis-de CodeSystems
- Bump praxis dependency 0.32.5 → 0.38.0, version 0.17.0 → 0.18.0
- **gitignore**: Exclude session-close transient artifacts

## [0.17.0] - 2026-04-16

### Bug Fixes

- Update praxis dependency to 0.32.5 (fixes empty version-spec in Aidbox)
- **ci**: Switch Aidbox terminology engine from legacy to hybrid mode
- Migrate kzv-stempelnummer identifier URL to fhir.cognovis.de/dental canonical

## [0.16.0] - 2026-04-09

### Features

- Add update-package-list job to release workflow + bump to 0.16.0

### Miscellaneous

- Bump version to 0.15.1

## [0.15.1] - 2026-04-09

### Documentation

- **claude**: Require aidbox-ig-development and aidbox skills at session start

### Miscellaneous

- Update changelog

## [0.15.0] - 2026-04-08

### Bug Fixes

- Pin praxis dependency to 0.19.0 instead of 'current'
- **ci**: Install praxis package under versioned name for pinned deps
- **fdde-aji**: Add copy root files step to ig-ci.yml for Pages deployment
- **fdde-apw**: Build-package.sh robustness fixes
- **ci**: Install pinned praxis version from sushi-config.yaml instead of latest
- **ci**: Strip YAML comment from praxis version extraction
- **ci**: Auto-track latest praxis release + restore tail -5

### CI/CD

- Publish FHIR package to npm.cognovis.de on release

### Features

- **fdde-aji**: Split CI/CD into ig-ci.yml + ig-release.yml with Aidbox validation
- **fdde-apw**: Auto-tag + snapshot packages + mira-adapters dispatch

### Miscellaneous

- Add IHE dental white paper draft to gitignore
- **deps**: Bump fhir-praxis-de dependency 0.19.0 → 0.30.0
- Remove dental presentation slide deck
- **deps**: Bump fhir-praxis-de dependency 0.32.0 → 0.32.2
- Update changelog
- Bump version to 0.15.0

### Temp

- Show full SUSHI output for CI debugging

## [0.14.0] - 2026-04-04

### Features

- Add clinical dental lab order extensions, CodeSystems, and documentation

### Miscellaneous

- Bump version to 0.13.1
- Update changelog
- Bump version to 0.14.0

## [0.13.1] - 2026-04-04

### Bug Fixes

- **fdde-82z**: Address review findings iteration 1 — use planType: convention

### Documentation

- **fdde-82z**: Update pagecontent refs to DentalCarePlanDE

### Miscellaneous

- Bump version to 0.13.0
- Update changelog

### Merge

- Worktree-bead-fdde-82z

## [0.13.0] - 2026-04-04

### Features

- Add OralHealthScreeningDE profile, European IG comparison, and workshop presentation

### Miscellaneous

- Bump version to 0.12.1
- Update changelog

## [0.12.1] - 2026-04-04

### Bug Fixes

- **fdde-6qx**: Address cmux review findings — relax comments, full URL convention, meta.profile

### Miscellaneous

- Update changelog

## [0.12.0] - 2026-04-04

### Bug Fixes

- **fdde-6qx**: Address review findings iteration 1 — use Unicode in new example files

### Documentation

- **fdde-6qx**: Update sws-mapping with KBR/KGL entries and DentalCarePlanDE references
- Add SWS 2.0 research summary and quick reference

### Features

- **fdde-6qx**: Green — DentalCarePlanDE generic profile with 7 plan types

### Miscellaneous

- Bump version to 0.11.0
- Update changelog
- Bump version to 0.12.0

### Merge

- Worktree-bead-fdde-6qx

### Style

- **fdde-6qx**: Use DentalCategoryCS FSH name in new examples (consistency)

## [0.11.0] - 2026-04-04

### Miscellaneous

- Bump version to 0.10.0
- Update changelog

### Merge

- Worktree-bead-fdde-yku

## [0.10.0] - 2026-04-04

### Bug Fixes

- **fdde-yku**: Address review findings iteration 1

### Features

- **fdde-yku**: Replace PAR1-PAR10 with official KZBV codes (ATG/MHU/AIT/BEV/CPT/UPT)
- **fdde-cf0**: Add SNOMED bone resorption codes to PeriodontalFindingCodesVS
- **fdde-cf0**: Add ExampleDentalFindingKnochenresorption with derivedFrom ImagingStudy

### Miscellaneous

- Bump version to 0.9.0
- Update changelog

### Merge

- Worktree-bead-fdde-cf0

## [0.9.0] - 2026-04-04

### Bug Fixes

- Copy package-list.json and publication-request.json to output for GitHub Pages
- Resolve QA report errors in publication metadata
- Suppress praxis dependency canonical URL warnings in QA report
- Suppress IG_DEPENDENCY_DIRECT error for praxis dependency
- Revert praxis dependency to current (not yet published on registry)

### Features

- Prepare IG for FHIR registry publication

### Miscellaneous

- Bump version to 0.8.7
- Update changelog

## [0.8.7] - 2026-04-04

### Bug Fixes

- Set experimental=false on all resources, pin ICD-10-GM version, suppress external binding warning

### Miscellaneous

- Bump version to 0.8.6
- Update changelog

## [0.8.6] - 2026-04-03

### Bug Fixes

- **fdde-b9n**: Reduce IG Publisher warnings via special-url, CS fixes, and ignoreWarnings
- **fdde-b9n**: Fix pin-canonicals error and add ICD-10-GM version warning to ignoreWarnings
- **fdde-b9n**: Fix display names and expand ignoreWarnings for localization
- **fdde-b9n**: Fix ignoreWarnings.txt suppression patterns for German-localized warnings
- **fdde-b9n**: Convert ignoreWarnings.txt suppressions to %text% contains-match format
- **fdde-b9n**: Address review findings iteration 1 - fix example inconsistencies
- **fdde-b9n**: Address review findings iteration 2 - document ATF entry index
- **fdde-b9n**: Remove redundant exact-match suppressions covered by %text% patterns

### Miscellaneous

- Bump version to 0.8.5
- Update changelog

### Merge

- Worktree-bead-fdde-b9n

## [0.8.5] - 2026-04-03

### Miscellaneous

- Bump version to 0.8.4
- Update changelog

### Merge

- Worktree-bead-fdde-792

## [0.8.4] - 2026-04-03

### Bug Fixes

- **fdde-792**: Switch ATF MessageHeader.event to eventUri to avoid service-identifier-vs binding
- **fdde-792**: Upgrade tools.r4 to 1.1.2 and suppress ATF/ig-param errors
- **fdde-792**: Address review findings iteration 1
- **fdde-792**: Address review findings iteration 2

### Miscellaneous

- Bump version to 0.8.3
- Update changelog

### Refactoring

- **fdde-13o**: Centralize FSH aliases — remove duplicates from ExampleDentalCondition and DentalProcedureDE

## [0.8.3] - 2026-04-03

### Bug Fixes

- **fdde-5up**: Fix hl7 tools r4 dep, ATF Bundle refs, LOINC displays
- **fdde-5up**: Correct LOINC 8704-9 display to official terminology
- **fdde-5up**: Update truncated LOINC comments with full display and CSIRO evidence

### Miscellaneous

- Bump version to 0.8.2
- Update changelog

### Merge

- Worktree-bead-fdde-5up

## [0.8.2] - 2026-04-03

### Miscellaneous

- Update changelog

### Merge

- Worktree-bead-fdde-1dh

## [0.8.1] - 2026-04-03

### Bug Fixes

- **fdde-1dh**: Replace invalid SNOMED/LOINC codes with verified valid alternatives
- **fdde-1dh**: Address review findings iteration 1
- **fdde-1dh**: Address review findings iteration 2
- **fdde-1dh**: Replace periapical finding code with verified 718052004 (asymptomatic periapical periodontitis)
- **fdde-0wc**: Fix display names, ex-tooth URL, obs-7 constraint, and IG parameters
- **fdde-0wc**: Document display name rationale and obs-7 code change
- **fdde-0wc**: Add obs-7 rationale comment to AtfBundle example
- **fdde-0wc**: Obs-7 fix in ExamplePeriodontalObservation, add hl7 tools comment

### Miscellaneous

- Update changelog
- Bump version to 0.8.1

### Merge

- Worktree-bead-fdde-0wc

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


